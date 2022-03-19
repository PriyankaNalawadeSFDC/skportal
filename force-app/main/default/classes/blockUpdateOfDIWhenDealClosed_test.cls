@isTest
public class blockUpdateOfDIWhenDealClosed_test{
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
            Deal_Line_Items__c di = new Deal_Line_Items__c();
            di.Deal__c = d.Id;
            insert di;
            
            d.stage__c = 'Closed won';
            update d;
            di.Quantity__c = 3;
            update di;
        }catch(exception e){
            
        }
    }
}