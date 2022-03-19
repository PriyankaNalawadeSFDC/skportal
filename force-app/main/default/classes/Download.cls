public class Download {
    public List<Attendance__c> download{get;set;}
    //public Month__c monthObj {get;set;}
    public String monthid {get;set;}
    public Date date1 {get;set;}
    public Download(ApexPages.StandardController controller) {
             /*
             Date today=Date.Today();
             monthObj=[select id from Month__c where Month_Key__c=:today.month() and Year__c=:today.year()];
             */
             date1 =Date.today();
             monthid=ApexPages.currentPage().getParameters().get('monthid');
             if(monthid!=''){
             download=[select Report_Date__c,user__r.employee_id__c,user__r.First_name__c,user__r.Last_name__c,Date__c,Start_Time__c,End_Date__c,Client__c,Explaination__c from Attendance__c where is_submitted__c=1 and month__c=:monthid order by user__r.employee_id__c,Report_Date__c,Start_Time__c];
             /*
             for(Attendance__c x:download){
                 String y=x.Date__c;
                 String[] str=y.split('/');
                 x.Date__c=str[1]+'/'+str[0]+'/'+str[2];
             }
             */
             }
    }
}