@isTest
public class blockUpdateWhenDealClosed_test{
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
        d.stage__c = 'New';
        Insert d;
        
        try{
        Task t = new Task();
        t.subject = 'Call';
        t.Status = 'Completed';
        t.Priority = 'High';
        t.whatId = d.Id;
        insert t;
        d.stage__c = 'Closed Won';
        update d;
        t.subject = 'Email';
        update t;
        }catch(exception e){
            
        }
    }
}