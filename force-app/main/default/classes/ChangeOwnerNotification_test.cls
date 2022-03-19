@isTest
public class ChangeOwnerNotification_test{
    @isTest
    public static void test1(){
        List<User> u1  = [select id from user where Profile.name = 'System Administrator'  order by name desc limit 1];
        //User u1 = new User();
        /*u1.ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id;
            u1.LastName = 'Sanket Gupta';
            u1.Email = 'SanketGupta0@amamama.com';
            u1.Username = 'SanketGupta0@amamama.com' + System.currentTimeMillis();
            u1.CompanyName = 'TEST';
            u1.Title = 'title';
            u1.Alias = 'alias';
            u1.TimeZoneSidKey = 'America/Los_Angeles';
            u1.EmailEncodingKey = 'UTF-8';
            u1.LanguageLocaleKey = 'en_US';
            u1.LocaleSidKey = 'en_US';
       insert u1;*/
       system.debug('@@@@@sanket gupte id = '+ u1[0].Id);
       System.runAs(u1[0]) {
            Account acc = new Account();
            acc.Name = 'test Ankita Goyal';
            acc.ownerId = u1[0].id;
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
            d.ownerId = u1[0].id;
            Insert d;
            system.debug('@@@@@deal owner id = '+ d.ownerId);
       }
       
       /*User u = new User();
             u.ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id;
             u.LastName = 'Mohini gupte';
             u.Email = 'puser000@amamama.com';
             u.Username = 'puser000@amamama.com' + System.currentTimeMillis();
             u.CompanyName = 'TEST';
             u.Title = 'title';
             u.Alias = 'alias';
             u.TimeZoneSidKey = 'America/Los_Angeles';
             u.EmailEncodingKey = 'UTF-8';
             u.LanguageLocaleKey = 'en_US';
             u.LocaleSidKey = 'en_US';
       insert u;*/
       List<User> u  = [select id from user where Profile.name = 'System Administrator' order by name Asc limit 1 ];
       system.debug('@@@@@mohini id = '+ u[0].Id);
       System.runAs(u1[0]) {
           Deal__c d = [select id,name,ownerId from deal__c limit 1];
           d.ownerId = u[0].Id;
           update d;
           
           Account acc = [select id,name,ownerId from Account  limit 1];
           acc.ownerId = u[0].Id;
           update acc;
           system.debug('@@@@@deal owner id ater update= '+ d.ownerId);
       }
    }
}