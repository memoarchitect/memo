// Terminology and identification kernel. MEMO stays
// terminology-neutral: any concept may carry several TerminologyCodes binding
// it to SNOMED CT, GMDN, EMDN, UDI/GUDID, ISO/IEEE 11073 nomenclature, or a
// local catalog — never a single ambiguous `code : String`.
package memo_core_terminology {
    private import ScalarValues::*;

    // One coding of a concept in one code system. Mirrors the FHIR Coding
    // datatype (system/version/code/display) so FHIR mappings stay lossless.
    attribute def TerminologyCode {
        attribute systemUri : String;
        attribute code : String;
        attribute display : String;
        attribute codeSystemVersion : String;
        attribute designation : String;
    }

    // A device-identity carrier per IMDRF UDI guidance: the DI portion
    // belongs to the device definition, PI portions to the instance.
    attribute def UdiCarrier {
        attribute issuingAgency : String;
        attribute deviceIdentifier : String;
        attribute carrierHRF : String;
        attribute carrierAIDC : String;
    }

    // A reference into an external registry or document (regulatory listing,
    // standard clause, catalog page) with enough context to resolve it.
    attribute def ExternalReference {
        attribute referenceKind : String;
        attribute identifier : String;
        attribute uri : String;
        attribute section : String;
    }
}
