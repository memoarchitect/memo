// Runnable standard SysML v2 action-flow sample.
package activity_example {
    item def Order;
    item def Receipt;
    part def Customer;
    action def ProcessOrder;

    action def FulfillOrder {
        part customer : Customer;
        action receiveOrder accept order : Order;
        action validateOrder { in order : Order; }
        decide routeOrder;
        action processOrder : ProcessOrder;
        action rejectOrder;
        merge afterDecision;
        fork parallelWork;
        action prepareShipment;
        action createInvoice;
        join readyToNotify;
        action notifyCustomer { out receipt : Receipt; }
        then action sendReceipt send notifyCustomer.receipt to customer;
        then terminate;

        succession first start then receiveOrder;
        succession first receiveOrder then validateOrder;
        flow of Order from receiveOrder.order to validateOrder.order;
        succession first validateOrder then routeOrder;
        succession first routeOrder if true then processOrder;
        succession first routeOrder if false then rejectOrder;
        succession first processOrder then afterDecision;
        succession first rejectOrder then afterDecision;
        succession first afterDecision then parallelWork;
        succession first parallelWork then prepareShipment;
        succession first parallelWork then createInvoice;
        succession first prepareShipment then readyToNotify;
        succession first createInvoice then readyToNotify;
        succession first readyToNotify then notifyCustomer;
    }
}
