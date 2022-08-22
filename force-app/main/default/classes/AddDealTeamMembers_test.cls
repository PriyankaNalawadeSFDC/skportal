@isTest
public class AddDealTeamMembers_test{
    // New Feature Added
    @isTest
    public static void test1(){
        Account acc = new Account();
        acc.Name = 'test Ankita Goyal';
        Insert acc;
        
        Contact con = new Contact();
        con.Lastname = 'test contact';
        con.accountId = acc.Id;
        insert con; 
        User u  = [select id from user where Profile.name = 'Sk Sales Team' and isActive=true order by name Asc limit 1 ];
       
        Deal__c d = new Deal__c();
        d.Name = 'Test Deal record';
        d.account__c = acc.Id;
        d.Contact__c = con.Id;
        d.Reason_for_Loss__c = 'Other';
        Insert d;
        Deal_Team__c dt = new Deal_Team__c ();
            dt.Team_Role__c = 'Account Manager';
            dt.Deal_Access__c = 'Read Only';
            dt.deal__c = d.Id;
            dt.User__c = u.Id;
            Insert dt;
            
            dt.Team_Role__c = 'Sales Manager';
            update dt;
            
            Delete dt;
    
    }
}
