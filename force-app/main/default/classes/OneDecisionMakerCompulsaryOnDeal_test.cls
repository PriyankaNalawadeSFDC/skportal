@isTest
public class OneDecisionMakerCompulsaryOnDeal_test{
    @isTest
    public static void test1(){
        
        Account acc = new Account();
        acc.Name = 'test Ankita Goyal';
        Insert acc;
        
        Contact con = new Contact();
        con.Lastname = 'test contact';
        con.accountId = acc.Id;
        insert con;
        
        Deal__c d = new Deal__c();
        d.Name = 'Test Deal record';
        d.account__c = acc.Id;
        d.Contact__c = con.Id;
        d.Reason_for_Loss__c = 'Other';
        Insert d;
        
        Deal_Contact_Role__c dcr = new Deal_Contact_Role__c ();
        dcr.Contact__c = con.Id;
        dcr.Role__c = 'Decision Maker';
        dcr.deal__c = d.Id;
        Insert dcr;
        
        Deal_Contact_Role__c dcr1 = new Deal_Contact_Role__c ();
        dcr1.Contact__c = con.Id;
        dcr1.Role__c = 'Decision Maker';
        dcr1.deal__c = d.Id;
        Insert dcr1;
        
        delete dcr;
    }
}