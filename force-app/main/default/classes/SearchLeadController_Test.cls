@isTest
public class SearchLeadController_Test{
    @isTest
    public static void test1(){
        Lead l =new Lead();
        l.Lastname = 'Ankita goyal';
        l.Status = 'Registered';
        l.Company = 'Sk International';
        l.Email = 'test@gmail.com';
        l.MobilePhone = '9530490273';
        insert l;
        SearchLeadController.FetchLeadList('Ankita','Sk International','test@gmail.com');
        SearchLeadController.registerAndCheckInLead(l.Id,'Checkin');
        SearchLeadController.updatePhoneNumerInLead(l.Id,l.MobilePhone);
        SearchLeadController.sendMsgToAccountManager(l.firstname,l.lastname,l.company,l.MobilePhone);
    }
}