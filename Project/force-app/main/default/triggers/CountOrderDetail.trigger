trigger CountOrderDetail on Order_Detail__c (after insert, after update) {
    Set<Id> custIds = new Set<Id>();
 for (Order_Detail__c order : Trigger.new) {
 custIds.add(order.Customer_Detail__c);
    }
List<Customer_Detail__c> CustToUpdate1 = [SELECT Id, (SELECT Id FROM Order_Details__r WHERE Order_Status__c='Open') FROM Customer_Detail__c WHERE Id IN :custIds];
    for (Customer_Detail__c cust : CustToUpdate1) {
        cust.Open_Record__c = cust.Order_Details__r.size();
        update cust;
    } 
 List<Customer_Detail__c> CustToUpdate2 = [SELECT Id, (SELECT Id FROM Order_Details__r WHERE Order_Status__c='Completed') FROM Customer_Detail__c WHERE Id IN :custIds];
  for (Customer_Detail__c cust : CustToUpdate2) {
        cust.Completed_Record__c = cust.Order_Details__r.size();
        update cust;
    }
    List<Customer_Detail__c> CustToUpdate3 = [SELECT Id, (SELECT Id FROM Order_Details__r WHERE Order_Status__c='Cancelled') FROM Customer_Detail__c WHERE Id IN :custIds];
  for (Customer_Detail__c cust : CustToUpdate3) {
        cust.Cancelled__c = cust.Order_Details__r.size();
        update cust;
    }
 List<Customer_Detail__c> CustToUpdate4 = [SELECT Id, (SELECT Id, Total_Amount__c FROM Order_Details__r) FROM Customer_Detail__c WHERE Id IN :custIds];
   for (Customer_Detail__c cust : CustToUpdate4) {
        cust.Total_Amount_of_Order__c = 0;
        for (Order_Detail__c order : cust.Order_Details__r) {
            cust.Total_Amount_of_Order__c += order.Total_Amount__c;
        }
        update cust;
    }
}