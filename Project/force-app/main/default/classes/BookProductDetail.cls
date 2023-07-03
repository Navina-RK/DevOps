public class BookProductDetail {
    @AuraEnabled(cacheable=true)
    public static List<Product2> getName(String name) {
        if (String.isBlank(name)) {
            return [SELECT Id, Name, ProductCode, Description, ImageUrl__c, Unit_Cost__c, Total_Cost__c, Quantity__c
                    FROM Product2 
                    WHERE ProductCode LIKE 'Book-%'];
        } else {
            String keySearch = '%' + name + '%';
            return [SELECT Id, Name, ProductCode, Description, ImageUrl__c, (SELECT Id, UnitPrice FROM PricebookEntries)
                    FROM Product2 
                    WHERE Name LIKE :keySearch AND ProductCode LIKE 'Book-%'];
        }
    }
}