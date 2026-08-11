// Publish/subscribe messaging, technology-neutral across DDS, MQTT, AMQP and
// Kafka. `memo_extension_ros` specializes these rather than restating them.
//
// This is where `deliverySemantics` and `topicStructure` live now, and moving
// them fixed a metaclass error as well as a layering one. Both were attributes
// on `SoftwareComponent`, and neither is a property of a component: a
// component does not have a topic, a publication does; a component does not
// have delivery semantics, the channel it publishes over does.
package memo_extension_messaging {
    private import Metaobjects::SemanticMetadata;
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_implementation_software_runtime::*;

    // What a broker guarantees about each message. Safety-relevant: an alarm
    // published at-most-once can be silently dropped, and an at-least-once
    // command can be applied twice.
    enum def MessagingDeliveryKind {
        enum atMostOnce;
        enum atLeastOnce;
        enum exactlyOnce;
    }

    // A named channel. It is an item, not a part: what flows is the message,
    // and a topic is the addressed content rather than a thing that executes.
    // `MemoExchangeItem` already carries encoding, semantics, and units.
    item def MessagingTopic specializes MemoExchangeItem {
        // The naming scheme and hierarchy a project has agreed —
        // "/{robot}/{subsystem}/{signal}", "device/+/telemetry". This is the
        // `topicStructure` that used to sit on SoftwareComponent.
        attribute topicStructure : String;
        attribute messageSchema : String;
    }

    part def MessagingBroker specializes SoftwareComponent {
        attribute :>> runtimeKind = RuntimeKind::messageBroker;
        attribute brokerProduct : String;
        attribute persistenceEnabled : Boolean;
    }

    // Publication and subscription are relations, and this is why an extension
    // must be allowed to declare `connection def`s (extensions/README.md, rule
    // 1): publish and subscribe are connector concepts. There is no way to say
    // "this node publishes that topic" with attributes on the node.
    //
    // They root on `MemoLink` and NOT on `ComponentConnects`, and that is a
    // finding about the base rather than a preference — see §22 of
    // plans/memo-arcadia-native-coverage.md. `ComponentConnects` types BOTH
    // ends `SoftwareComponent`, so it cannot be the base for a relation whose
    // target is an item. `MemoLink` is the base's general link: it carries the
    // identification core and both ends are untyped, so the ends below narrow
    // them rather than contradicting them.
    connection def MessagingPublishesTo :> MemoLink {
        attribute deliverySemantics : MessagingDeliveryKind;
        attribute publishRateHz : Real;
        end publisher : SoftwareComponent :>> linkSource;
        end publishedTopic : MessagingTopic :>> linkTarget;
    }
    abstract connection messagingPublishesToLinks : MessagingPublishesTo[*];
    metadata def <messagingPublishesTo> MessagingPublishesToMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = messagingPublishesToLinks meta SysML::Usage;
    }

    connection def MessagingSubscribesTo :> MemoLink {
        attribute deliverySemantics : MessagingDeliveryKind;
        // What the subscriber does when it stops receiving — the half of a
        // pub/sub design a safety case actually argues about.
        attribute lossBehaviour : String;
        end subscriber : SoftwareComponent :>> linkSource;
        end subscribedTopic : MessagingTopic :>> linkTarget;
    }
    abstract connection messagingSubscribesToLinks : MessagingSubscribesTo[*];
    metadata def <messagingSubscribesTo> MessagingSubscribesToMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = messagingSubscribesToLinks meta SysML::Usage;
    }
}
