public with sharing class AccountController {
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunities(Id accountId) {
        return [SELECT Id, Name, CloseDate, Amount FROM Opportunity WHERE AccountId = :accountId ORDER BY CloseDate DESC];
    }
}
