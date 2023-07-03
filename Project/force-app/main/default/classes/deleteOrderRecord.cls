public class deleteOrderRecord {
    @AuraEnabled
    public static void deleteOrder(Id orderDetailId) {
        try {   
            Order_Detail__c ord=[Select Id,Name from Order_Detail__c where Id=: orderDetailId][0];
            System.debug(ord);
            delete ord;
        } catch(Exception e) {
            throw new AuraHandledException('Error');
        }
    }
}