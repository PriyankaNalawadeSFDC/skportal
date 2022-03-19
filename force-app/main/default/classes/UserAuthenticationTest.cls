@isTest
public class UserAuthenticationTest{

    static testmethod void test1(){
    User__c use = new User__c();
    use.Employee_Id__c = 1234;
    use.First_Name__c = 'Test1';
    use.Last_Name__c = 'Test2';
    use.DOB__c = System.Today();
    use.Password__c = 'Y1234';
    use.Key__c = 'hThyjuIx6IvQHmuUI5UZbw==';
    insert use;
    
    Holiday__c hol = new Holiday__c();
    hol.Name__c = 'Diwali';
    hol.Date__c = System.Today();
    hol.Year__c = 2015;
    hol.Wish_Line__c = 'This is Wish line';
    insert hol;
    
    Notification__c noti = new Notification__c();
    noti.Name = 'testNoti';
    noti.Description__c = 'This is the test Notification';
    insert noti;
    
    
    Month__c mon = new Month__c();
    mon.Month_Key__c = 3;
    mon.Month_Value__c = 'March';
    mon.Year__c = 2015;
    insert mon;
    
    Approval__c apr = new Approval__c();
    apr.Name = 'TestApr';
    apr.Is_Submitted__c = 0;
    apr.Month__c = mon.Id;
    apr.User__c = use.Id;
    insert apr;
    
    ApexPages.StandardController sc = new ApexPages.StandardController(use);
    UserAuthentication obj = new UserAuthentication(sc);
    obj.testFlag=true;
    obj.npassword='data';
    obj.cpassword='data';
    obj.username = String.ValueOf(use.Employee_Id__c);
    obj.doAuthentication();
    obj.setNotification();
    obj.forceLogin();
    obj.newRecord1();
    obj.back();
    obj.saveEmployee();
    obj.changePassword();
    apexpages.currentpage().getparameters().put('code','1234');
    obj.resetPassword();
    obj.getResetMonth();
    obj.getActiveMonth();
    mon = new Month__c();
    mon.Month_Key__c = 2;
    mon.Month_Value__c = 'February';
    mon.Year__c = 2015;
    insert mon;
    apr = new Approval__c();
    apr.Name = 'TestApr';
    apr.Is_Submitted__c = 1;
    apr.Month__c = mon.Id;
    apr.User__c = use.Id;
    insert apr;
    obj.getReport();
    mon = new Month__c();
    mon.Month_Key__c = 12;
    mon.Month_Value__c = 'Dec';
    mon.Year__c = 2014;
    insert mon;
    apr = new Approval__c();
    apr.Name = 'TestApr';
    apr.Is_Submitted__c = 1;
    apr.Month__c = mon.Id;
    apr.User__c = use.Id;
    insert apr;
    obj.getReport();
    mon = new Month__c();
    mon.Month_Key__c = 3;
    mon.Month_Value__c = 'March';
    mon.Year__c = 2015;
    insert mon;
    apr = new Approval__c();
    apr.Name = 'TestApr';
    apr.Is_Submitted__c = 0;
    apr.Month__c = mon.Id;
    apr.User__c = use.Id;
    insert apr;
    Attendance__c att=new Attendance__c();
    att.Month__c = mon.Id;
    att.User__c = use.Id;
    insert att;
    obj.submitAttendance();
    obj.yearSet='2015';
    obj.setActiveMonth();
    obj.getEmployees();
    obj.getMonths();
    obj.getYears();
    obj.getHours();
    obj.getMinutes();
  
    ApexPages.currentPage().getParameters().put('clientdate','01/03/2015');
    ApexPages.currentPage().getParameters().put('startHour','13');
    ApexPages.currentPage().getParameters().put('startMinute','20');
    ApexPages.currentPage().getParameters().put('endHour','16');
    ApexPages.currentPage().getParameters().put('endMinute','20');
    obj.addIntoAttendance();
    obj.logout();
    
    //obj.doAuthentication();
    //obj.setHoliday();
   
    
    
    }
    static testmethod void test2(){
        Attendancy a=new Attendancy();
        a.clientdate=null;

        a.startTime=null;

        a.endTime=null;

        a.client=null;

        a.explaination=null;


        /*User u=new User();
        u.id=null;
        u.employeeID=null;
        u.username =null;
        u.firstName=null;
        u.lastName=null;
        u.password=null;
        u.role=null;
        u.status =null;*/
        User__c use = new User__c();
        use.Employee_Id__c = 1234;
        use.First_Name__c = 'Test1';
        use.Last_Name__c = 'Test2';
        use.DOB__c = System.Today();
        insert use;
        
        ApexPages.StandardController sc = new ApexPages.StandardController(use);
        UserAuthentication obj = new UserAuthentication(sc);
        obj.testFlag=true;
        obj.setNotification(); 
        obj.newRecord();   
        obj.newRecord1(); 
        obj.back();
        obj.removeFromAttendance();
        obj.removeFromHolidays();
        obj.searchUser();
        obj.showMonthWiseDetail();
        obj.autoSubmit();
        obj.autoSubmitUser();
    }
}