/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class AccountTriggerHandlerTest {

    @isTest
    static void testAfterInsert() {
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        Map<Id, SObject> newAccountMap = new Map<Id, SObject>{
            testAccount.Id => testAccount
        };

        List<Account> newAccounts = new List<Account>{ testAccount };
        AccountTriggerHandler handler = new AccountTriggerHandler(false, 1);

        Test.startTest();
        handler.afterInsert(newAccounts, newAccountMap);
        Test.stopTest();

        // Querying the created opportunities for the test account
        List<Opportunity> createdOpportunities = [SELECT Id, Name, StageName, CloseDate, Amount, AccountId
                                                  FROM Opportunity
                                                  WHERE AccountId = :testAccount.Id];

        // Call the getOpportunities method from the controller
        List<Opportunity> gotOpportunities = AccountController.getOpportunities(testAccount.Id);

        System.assertEquals('Opportunity 1', createdOpportunities[0].Name);
        System.assertEquals('Prospect', createdOpportunities[0].StageName);
        System.assertEquals(Date.today(), createdOpportunities[0].CloseDate);
        System.assertEquals(2000, createdOpportunities[0].Amount);
        System.assertEquals(testAccount.Id, createdOpportunities[0].AccountId);

        System.assertEquals('Opportunity 2', createdOpportunities[1].Name);
        System.assertEquals('Prospect', createdOpportunities[1].StageName);
        System.assertEquals(Date.today().addDays(30), createdOpportunities[1].CloseDate);
        System.assertEquals(3000, createdOpportunities[1].Amount);
        System.assertEquals(testAccount.Id, createdOpportunities[1].AccountId);
    }

    @isTest
    static void testBeforeInsert() {
        Account testAccount = new Account(Name = 'Test Account');
        List<Account> newAccounts = new List<Account>{ testAccount };

        AccountTriggerHandler handler = new AccountTriggerHandler(false, 1);

        Test.startTest();
        handler.beforeInsert(newAccounts);
        Test.stopTest();
    }

    @isTest
    static void testBeforeUpdate() {
        Account testAccount = new Account(Name = 'Test Account');
        List<Account> oldAccounts = new List<Account>{ testAccount.clone() };
        List<Account> newAccounts = new List<Account>{ testAccount };

        Map<Id, SObject> oldAccountMap = new Map<Id, SObject>{
            testAccount.Id => testAccount.clone()
        };
        Map<Id, SObject> newAccountMap = new Map<Id, SObject>{
            testAccount.Id => testAccount
        };

        AccountTriggerHandler handler = new AccountTriggerHandler(false, 1);

        Test.startTest();
        handler.beforeUpdate(oldAccounts, newAccounts, oldAccountMap, newAccountMap);
        Test.stopTest();
    }

    @isTest
    static void testBeforeDelete() {
        Account testAccount = new Account(Name = 'Test Account');
        List<Account> oldAccounts = new List<Account>{ testAccount.clone() };

        Map<Id, SObject> oldAccountMap = new Map<Id, SObject>{
            testAccount.Id => testAccount.clone()
        };

        AccountTriggerHandler handler = new AccountTriggerHandler(false, 1);

        Test.startTest();
        handler.beforeDelete(oldAccounts, oldAccountMap);
        Test.stopTest();
    }

    @isTest
    static void testAfterUpdate() {
        Account testAccount = new Account(Name = 'Test Account');
        List<Account> oldAccounts = new List<Account>{ testAccount.clone() };
        List<Account> newAccounts = new List<Account>{ testAccount };

        Map<Id, SObject> oldAccountMap = new Map<Id, SObject>{
            testAccount.Id => testAccount.clone()
        };
        Map<Id, SObject> newAccountMap = new Map<Id, SObject>{
            testAccount.Id => testAccount
        };

        AccountTriggerHandler handler = new AccountTriggerHandler(false, 1);

        Test.startTest();
        handler.afterUpdate(oldAccounts, newAccounts, oldAccountMap, newAccountMap);
        Test.stopTest();
    }

    @isTest
    static void testAfterDelete() {
        Account testAccount = new Account(Name = 'Test Account');
        List<Account> oldAccounts = new List<Account>{ testAccount.clone() };

        Map<Id, SObject> oldAccountMap = new Map<Id, SObject>{
            testAccount.Id => testAccount.clone()
        };

        AccountTriggerHandler handler = new AccountTriggerHandler(false, 1);

        Test.startTest();
        handler.afterDelete(oldAccounts, oldAccountMap);
        Test.stopTest();
    }

    @isTest
    static void testAfterUndelete() {
        Account testAccount = new Account(Name = 'Test Account');
        List<Account> newAccounts = new List<Account>{ testAccount };

        Map<Id, SObject> newAccountMap = new Map<Id, SObject>{
            testAccount.Id => testAccount
        };

        AccountTriggerHandler handler = new AccountTriggerHandler(false, 1);

        Test.startTest();
        handler.afterUndelete(newAccounts, newAccountMap);
        Test.stopTest();
    }
}
