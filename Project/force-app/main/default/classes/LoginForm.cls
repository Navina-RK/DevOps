public class LoginForm {
    @AuraEnabled(cacheable=true)
    public static Id getLeadConversionData(String leadId) {
        try {
            Lead leadRecord = [SELECT Id, Name, Email, Company, Phone, Status FROM Lead WHERE Id = :leadId];
            if (leadRecord != null) {
                // Update the Lead status to 'Open - Converted'
                leadRecord.Status = 'Open - Converted';
                update leadRecord;

                Account newAccount = new Account();
                newAccount.Name = leadRecord.Company; 

                // Check for existing account with the same name
                List<Account> existingAccounts = [SELECT Id FROM Account WHERE Name = :newAccount.Name LIMIT 1];
                if (!existingAccounts.isEmpty()) {
                    newAccount = existingAccounts[0];
                } else {
                    insert newAccount;
                }

                Contact newContact = new Contact();
                newContact.FirstName = leadRecord.Name.split(' ')[0]; 
                newContact.LastName = leadRecord.Name.split(' ')[1];
                newContact.Email = leadRecord.Email;
                newContact.AccountId = newAccount.Id;

                Opportunity newOpportunity = new Opportunity();
                newOpportunity.Name = leadRecord.Name; 
                newOpportunity.StageName = 'Prospecting'; 
                newOpportunity.CloseDate = System.today().addMonths(1); 
                newOpportunity.AccountId = newAccount.Id; 

                // Insert the newContact record
                insert newContact;

                // Insert the newOpportunity record
                insert newOpportunity;

                return newOpportunity.Id;
            } else {
                System.debug('Lead record not found.');
                return null;
            }
        } catch (Exception e) {
            // Handle the exception here
            System.debug('An error occurred while converting the lead: ' + e.getMessage());
            return null;
        }
    }
}