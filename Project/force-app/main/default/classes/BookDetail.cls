public class BookDetail {
    @AuraEnabled(cacheable=true)
public static List<Product2> getName(String Name) {
        if (String.isBlank(Name)) {
        return [SELECT Id, Name, ProductCode, Description,ImageUrl__c,Unit_Cost__c,Total_Cost__c,Quantity__c
        FROM Product2 
        WHERE ProductCode LIKE 'Book-%'
        ];
        } else {
        String keySearch = '%' + Name + '%';
        return [SELECT Id, Name, ProductCode, Description,ImageUrl__c, (SELECT Id, UnitPrice FROM PricebookEntries)
        FROM Product2 
        WHERE Name LIKE :keySearch AND ProductCode LIKE 'Book-%'
        ];
        }
    }
   /* @AuraEnabled(cacheable=true)
    public static void getLeadConversionData(String leadId) {
    Lead leadRecord = [SELECT Id FROM Lead WHERE Id = :leadId];
    
    Database.LeadConvert lc = new Database.LeadConvert();
    lc.setLeadId(leadRecord.Id);
    
    // Set the converted record information
    lc.setConvertedStatus('Open - Not Contacted');
    
    // Perform the lead conversion
    Database.LeadConvertResult result = Database.convertLead(lc);
    
    // Check if the conversion was successful
    if (result.isSuccess()) {
        // Get the converted record IDs
        Id accountId = result.getAccountId();
        Id contactId = result.getContactId();
        Id opportunityId = result.getOpportunityId();
        
        // Perform any additional operations with the converted record IDs
        
        System.debug('Lead converted successfully. Account ID: ' + accountId + ', Contact ID: ' + contactId + ', Opportunity ID: ' + opportunityId);
    } /*else {
        // Handle conversion errors
        List<Database.LeadConvertError> errors = result.getErrors();
        for (Database.LeadConvertError error : errors) {
            System.debug('Lead conversion error: ' + error.getMessage());
        }
        }*/


}