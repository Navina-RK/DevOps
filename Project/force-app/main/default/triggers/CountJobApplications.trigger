trigger CountJobApplications on Job_Application__c (after insert, after update ,after delete) {
Set<Id> custIds = new Set<Id>();
 for (Job_Application__c app : Trigger.new) {
 custIds.add(app.Job_Vacancy__c);
    }
List<Job_Vacancy__c> CustToUpdate1 = [SELECT Id, (SELECT Id FROM Job_Applications__r WHERE Status__c='Open') FROM Job_Vacancy__c  WHERE Id IN :custIds];
    for (Job_Vacancy__c vacancy : CustToUpdate1) {
        vacancy.Open_Record__c = vacancy.Job_Applications__r.size();
        CustToUpdate1.add(vacancy);
    } 
    update CustToUpdate1;
    
List<Job_Vacancy__c> CustToUpdate2 = [SELECT Id, (SELECT Id FROM Job_Applications__r WHERE Status__c='Accepted') FROM Job_Vacancy__c  WHERE Id IN :custIds];
    for (Job_Vacancy__c vacancy : CustToUpdate2) {
        vacancy.Accepted_Record__c = vacancy.Job_Applications__r.size();
        CustToUpdate2.add(vacancy);
    } 
    update CustToUpdate2;

List<Job_Vacancy__c> CustToUpdate3 = [SELECT Id, (SELECT Id FROM Job_Applications__r WHERE Status__c='Rejected') FROM Job_Vacancy__c  WHERE Id IN :custIds];
    for (Job_Vacancy__c vacancy : CustToUpdate3) {
        vacancy.Rejected_Record__c = vacancy.Job_Applications__r.size();
        CustToUpdate3.add(vacancy);
    } 
    update CustToUpdate3;
}