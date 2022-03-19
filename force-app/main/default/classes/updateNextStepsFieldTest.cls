@isTest
public class updateNextStepsFieldTest{
    static testMethod void Test(){
        Lead led = new Lead();
        led.lastName = 'testLead';
        led.Company = 'sk';
        insert led;
        
        task tsk = new task();
        tsk.Subject = 'Not Started';
        tsk.Status = 'Not Started';
        tsk.Description__c = 'test des';
        tsk.WhoId = led.Id;
        insert tsk;
        tsk.Description__c = 'test description';
        update tsk;
        
        task tsk1 = new task();
        tsk1.Subject = 'In Progress';
        tsk1.Status = 'In Progress';
        tsk1.Description__c = 'test des';
        tsk1.WhoId = led.Id;
        insert tsk1;
         tsk1.Description__c = 'test description';
        update tsk1;
        
    }
}