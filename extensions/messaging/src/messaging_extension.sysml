// Messaging vocabulary, technology-neutral across DDS, MQTT, AMQP and Kafka.
// It specializes native item, port, and interface families; publication and
// subscription are expressed by port direction plus native flows/messages.
//
// This is where `deliverySemantics` and `topicStructure` live now, and moving
// them fixed a metaclass error as well as a layering one. Both were attributes
// on `SoftwareComponent`, and neither is a property of a component: a
// component does not have a topic, a publication does; a component does not
// have delivery semantics, the channel it publishes over does.
package memo_extension_messaging {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_architecture_logical_interfaces::*;
    private import memo_architecture_implementation_software_structure::*;
    private import memo_architecture_implementation_software_runtime::*;

    // What a broker guarantees about each message. Safety-relevant: an alarm
    // published at-most-once can be silently dropped, and an at-least-once
    // command can be applied twice.
    enum def MessagingDeliveryKind {
        enum atMostOnce;
        enum atLeastOnce;
        enum exactlyOnce;
    }

    // Message/payload definition. A named topic is an item usage of a concrete
    // message definition; the definition states the schema, while the usage
    // supplies the deployed topic identity.
    item def MessagingMessage specializes SoftwareItem {
        attribute messageSchema : String;
    }

    // Endpoint roles. Direction is native on both the port's payload feature
    // and the port usage placed on a component. The shared `topic` reference
    // points every endpoint at the same named item usage.
    port def MessagingPublisher specializes SoftwarePort {
        out item message : MessagingMessage;
        ref item topic : MessagingMessage;
        attribute deliverySemantics : MessagingDeliveryKind;
        attribute publishRateHz : Real;
    }

    port def MessagingSubscriber specializes SoftwarePort {
        in item message : MessagingMessage;
        ref item topic : MessagingMessage;
        attribute deliverySemantics : MessagingDeliveryKind;
        attribute lossBehaviour : String;
    }

    interface def MessagingTopicInterface specializes SoftwareInterface {
        end publisher : MessagingPublisher :>> source;
        end subscriber : MessagingSubscriber :>> target;
        flow of MessagingMessage from publisher.message to subscriber.message;
    }

    part def MessagingBroker specializes SoftwareComponent {
        attribute :>> runtimeKind = RuntimeKind::messageBroker;
        attribute brokerProduct : String;
        attribute persistenceEnabled : Boolean;
    }

}
