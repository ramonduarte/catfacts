public without sharing class AccountTriggerHandler implements TriggerHandler {
    private boolean triggerIsExecuting;
    private integer triggerSize;
    public AccountTriggerHelper helper;

    public AccountTriggerHandler(boolean triggerIsExecuting, integer triggerSize) {
        this.triggerIsExecuting = triggerIsExecuting;
        this.triggerSize = triggerSize;
        this.helper = new AccountTriggerHelper();
    }
    public void beforeInsert(List<Account> newAccounts) {
    }
    public void beforeUpdate(List<Account> oldAccounts, List<Account> newAccounts, Map<ID, SObject> oldAccountMap, Map<ID, SObject> newAccountMap) {
    }
    public void beforeDelete(List<Account> oldAccounts, Map<ID, SObject> oldAccountMap) {
    }
    public void afterInsert(List<Account> newAccounts, Map<ID, SObject> newAccountMap) {
        helper.createNewProspects(newAccounts, newAccountMap);
    }
    public void afterUpdate(List<Account> oldAccounts, List<Account> newAccounts, Map<ID, SObject> oldAccountMap, Map<ID, SObject> newAccountMap) {
    }
    public void afterDelete(List<Account> oldAccounts, Map<ID, SObject> oldAccountMap) {
    }
    public void afterUndelete(List<Account> newAccounts, Map<ID, SObject> newAccountMap) {
    }
}

