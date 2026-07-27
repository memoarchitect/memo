package memo_samd_starter {
    private import memo::*;

    part samdDevice : SoftwareSystem;
    requirement clinicalPurpose : Requirement {
        attribute redefines statement = "Define the clinical purpose and intended user";
    }
}
