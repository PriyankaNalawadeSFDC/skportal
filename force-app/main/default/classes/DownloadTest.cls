@isTest
public class DownloadTest{
    static testMethod void Test(){
        User__c use = new User__c();
        use.Employee_Id__c = 1234;
        use.First_Name__c = 'Test1';
        use.Last_Name__c = 'Test2';
        use.DOB__c = System.Today();
        use.Password__c = 'Y1234';
        use.Key__c = 'Test';
        insert use;
        
        Month__c mon = new Month__c();
        mon.Month_Key__c = 3;
        mon.Month_Value__c = 'March';
        mon.Year__c = 2015;
        insert mon;
        
        Attendance__c att = new Attendance__c();
        att.User__c = use.Id;
        att.Month__c = mon.Id;
        att.Is_Submitted__c = 1;
        insert att;
        
        ApexPages.currentPage().getParameters().put('monthid',mon.Id);
        ApexPages.StandardController sc = new ApexPages.StandardController(use);
        Download down = new Download(sc);
    }
}