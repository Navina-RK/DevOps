public class EmailJobPosterBatch implements Database.Batchable<SObject> {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Id, Job_Vacancy__r.Contact__r.Email, Candidate__r.LastName FROM Job_Application__c WHERE CreatedDate < :Date.Today().addDays(-1)';
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext bc, List<Job_Application__c> scope) {
        List<Job_Application__c> applist = new List<Job_Application__c>();
        
        for (Job_Application__c app : scope) {
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new List<String>{ app.Job_Vacancy__r.Contact__r.Email });
        email.setSubject('Alert Email');
        email.setPlainTextBody('Candidate: ' + app.Candidate__r.Contact__r.LastName + ' opened the application before 24 hours');
        Messaging.sendEmail(New Messaging.SingleEmailMessage[] {email});
        }
    }
    
    public void finish(Database.BatchableContext bc) {
    }
}