public class OrderItemList {
    @AuraEnabled(cacheable=true)
    public static List<Order_Detail__c> getOrders(String orderName) {
        String keySearch = '%' +  orderName + '%';
        return [
            SELECT Id, Name, Customer_Detail__r.Name, Product_Detail__r.Name, Order_Status__c, Quantity__c, Amount__c, Total_Amount__c 
            FROM Order_Detail__c 
            WHERE Name LIKE :keySearch
        ];
    }
}