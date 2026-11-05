// Stakeholder needs.
package memo_examples_ui_screen_regions_assurance_requirements_needs {
    private import memo::*;
    private import ScalarValues::*;



    requirement needReadableProgramming : Need {
        @MemoIdentity { :>> providedId = "UIR-NEED-001"; :>> label = "Readable and confirmable programming"; }
        attribute :>> needKind = NeedKind::'stakeholder';
        doc /* Clinicians need infusion programming to be readable and explicitly confirmed before therapy changes. */
        attribute :>> priority = "high";
    }

}
