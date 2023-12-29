public without sharing class AccountTriggerHelper {
    public AccountTriggerHelper() {
    }

    public void createNewProspects(List<Account> newAccounts, Map<Id, SObject> newAccountMap) {
        List<Opportunity> opportunities = new List<Opportunity>();

        for (Account newAccount : newAccounts) {
            Id accountId = newAccount.Id;

            // Creating Opportunity 1
            Opportunity opportunity1 = new Opportunity();
            opportunity1.Name = 'Opportunity 1';
            opportunity1.StageName = 'Prospect';
            opportunity1.CloseDate = Date.today();
            opportunity1.Amount = 2000;
            opportunity1.AccountId = accountId;
            opportunities.add(opportunity1);

            // Creating Opportunity 2
            Opportunity opportunity2 = new Opportunity();
            opportunity2.Name = 'Opportunity 2';
            opportunity2.StageName = 'Prospect';
            opportunity2.CloseDate = Date.today().addDays(30);
            opportunity2.Amount = 3000;
            opportunity2.AccountId = accountId;
            opportunities.add(opportunity2);
        }

        insert opportunities;
    }
}