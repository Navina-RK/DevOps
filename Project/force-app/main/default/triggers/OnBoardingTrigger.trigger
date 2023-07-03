trigger OnBoardingTrigger on Employee_On_boarding__e (after insert) {
    List<Account> acc = new List<Account>();
    for(Employee_On_boarding__e oBording :trigger.new){
        acc.add(new Account(Name =oBording.Name__c , Phone =oBording.Phone__c , AnnualRevenue = oBording.Salary__c));
    }
    if(acc.size() >0){
        insert acc ;
    }
}