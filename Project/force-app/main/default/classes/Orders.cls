public class Orders {
@AuraEnabled(cacheable=true)
    public static List<Order_Detail__c> getOrders()
    {
        return [Select Id ,Name,Customer_Detail__r.Name,Product_Detail__r.Name,Order_Status__c,Quantity__c,Amount__c,Total_Amount__c from Order_Detail__c];
    }
}