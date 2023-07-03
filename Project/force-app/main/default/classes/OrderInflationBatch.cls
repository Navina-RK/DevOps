public class OrderInflationBatch implements Database.Batchable<SObject> {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        Date oneYearAgo = Date.today().addYears(-1);
        String query = 'SELECT Id,Total_Amount__c FROM Order_Detail__c WHERE CreatedDate < :oneYearAgo';
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext bc, List<Order_Detail__c> scope) {
        List<Order_Detail__c> ordersToUpdate = new List<Order_Detail__c>();
        for (Order_Detail__c order : scope) {
            Decimal inflatedTotalAmount = order.Total_Amount__c+ (order.Total_Amount__c * 0.1);
            order.Inflation_Price__c = inflatedTotalAmount; 
            ordersToUpdate.add(order);
        }
        update ordersToUpdate;
    }

    public void finish(Database.BatchableContext bc) {
        
    }
}