// Runnable standard SysML v2 action-flow sample.
package activity_example {
    private import ScalarValues::*;

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

    // Customer purchase behavior encoded from the reference activity diagram.
    // The source picture draws two outgoing paths directly from
    // viewShoppingBasket. In the semantic model that choice is made explicit
    // with shoppingDecision; browseCatalog is the merge required to re-enter
    // the browsing loop without making viewBookStore wait for both inputs.
    action def CustomerProcess {
        attribute validUser : Boolean;
        attribute continueShopping : Boolean;
        attribute creditOK : Boolean;

        action customerLogsIn;
        decide validUserDecision;
        action rejected terminate;

        merge browseCatalog;
        action viewBookStore;
        action selectBookForPurchase;
        action addToShoppingBasket;
        action viewShoppingBasket;
        decide shoppingDecision;

        action commitOrder;
        action supplyCreditCardDetails;
        decide creditDecision;
        action rejectCreditCard;
        action closeOrder terminate;
        action confirmPurchase;
        action itemsDelivered;
        action orderComplete terminate;

        succession first start then customerLogsIn;
        succession first customerLogsIn then validUserDecision;
        succession first validUserDecision if validUser == true then browseCatalog;
        succession first validUserDecision if validUser == false then rejected;

        succession first browseCatalog then viewBookStore;
        succession first viewBookStore then selectBookForPurchase;
        succession first selectBookForPurchase then addToShoppingBasket;
        succession first addToShoppingBasket then viewShoppingBasket;
        succession first viewShoppingBasket then shoppingDecision;
        succession first shoppingDecision if continueShopping == true then browseCatalog;
        succession first shoppingDecision if continueShopping == false then commitOrder;

        succession first commitOrder then supplyCreditCardDetails;
        succession first supplyCreditCardDetails then creditDecision;
        succession first creditDecision if creditOK == false then rejectCreditCard;
        succession first rejectCreditCard then closeOrder;
        succession first creditDecision if creditOK == true then confirmPurchase;
        succession first confirmPurchase then itemsDelivered;
        succession first itemsDelivered then orderComplete;
    }
}
