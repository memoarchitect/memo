import { existsSync, readFileSync, readdirSync, statSync } from "node:fs";
import { join, relative } from "node:path";
import { fileURLToPath } from "node:url";

const root = fileURLToPath(new URL("../", import.meta.url));

function walk(directory, suffix) {
  return readdirSync(directory)
    .flatMap((name) => {
      const path = join(directory, name);
      return statSync(path).isDirectory() ? walk(path, suffix) : [path];
    })
    .filter((path) => path.endsWith(suffix));
}

const sourceFiles = walk(join(root, "src"), ".sysml");
const apiRoot = join(root, "docs", "sysml-api");

const declarationPattern =
  /^\s*(?:abstract\s+)?(?:part|item|action|requirement|verification|constraint|connection|interface|port|attribute|view|viewpoint|metadata|enum|state)\s+def\s+([A-Za-z_][A-Za-z0-9_]*)/gm;

const missingPages = [];
const missingDeclarations = [];

for (const path of sourceFiles) {
  const source = readFileSync(path, "utf8");
  const relativeSource = relative(join(root, "src"), path);
  const apiPage = join(apiRoot, relativeSource.replace(/\.sysml$/, ".md"));
  if (!existsSync(apiPage)) {
    missingPages.push(relative(root, apiPage));
    continue;
  }

  const page = readFileSync(apiPage, "utf8");
  for (const match of source.matchAll(declarationPattern)) {
    if (!new RegExp(`\\b${match[1]}\\b`).test(page)) {
      missingDeclarations.push({ name: match[1], path: relative(root, path) });
    }
  }
}

for (const page of missingPages) console.error(`Missing API page: ${page}`);
if (missingDeclarations.length) {
  for (const declaration of missingDeclarations) {
    console.error(`Missing from API page: ${declaration.name} (${declaration.path})`);
  }
}

if (missingPages.length || missingDeclarations.length) process.exitCode = 1;
else {
  console.log("Reference declaration coverage check passed.");
}
