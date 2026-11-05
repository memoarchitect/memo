// Temperature Alarm — model identity and method binding.
//
// The native entrypoint. The imports name what this project contains and the
// binding names the methodology it is governed by. No YAML file participates.
package memo_examples_temperature_alarm_project {
    private import memo::*;
    private import ScalarValues::*;


    // The project's own content, imported so the catalog is one reachable
    // closure from a single entrypoint.
    private import memo_examples_temperature_alarm_viewpoints_logical_views_temperature_alarm_overview::*;

    part projectBinding : ModelMethodBinding {
        @MemoIdentity { :>> providedId = "PMB-TEMPERATURE-ALARM-001"; :>> label = "Temperature alarm model method binding"; }
        attribute :>> modelName = "Temperature Alarm";
        ref :>> selectedMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
    }
}
