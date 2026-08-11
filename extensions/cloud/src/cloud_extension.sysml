// Networked services and managed data stores — the runtime families a
// software-only medical device (SaMD) deploys onto infrastructure the
// manufacturer does not control.
//
// This is where `serviceContract`, `discoveryMechanism`, `storageKind`, and
// `retentionPolicy` live now. All four were optional attributes on
// `SoftwareComponent` documented "set only for the relevant runtimeKind";
// here each is unconditional on the type that owns it.
package memo_extension_cloud {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_architecture_implementation_software_runtime::*;

    // How a store keeps what it is given. A String said nothing a query could
    // group by, and the retention argument in a records-retention assessment
    // turns on which of these it is.
    enum def CloudStorageKind {
        enum relational;
        enum document;
        enum keyValue;
        enum objectStore;
        enum timeSeries;
        enum blockVolume;
    }

    part def CloudService specializes SoftwareComponent {
        attribute :>> runtimeKind = RuntimeKind::service;
        // The externally visible contract: protocol, endpoint, request and
        // response. This is the boundary a verification case exercises.
        attribute serviceContract : String;
        // How callers find it — DNS, service registry, mesh, static endpoint.
        attribute discoveryMechanism : String;
    }

    part def CloudDataStore specializes SoftwareComponent {
        attribute :>> runtimeKind = RuntimeKind::dataStore;
        attribute storageKind : CloudStorageKind;
        // How long records are kept and what ends them. Regulated content:
        // a device record has a retention obligation, and the store is where
        // that obligation is either met or not.
        attribute retentionPolicy : String;
    }
}
