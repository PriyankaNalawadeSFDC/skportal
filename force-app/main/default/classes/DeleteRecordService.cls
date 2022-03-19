public class DeleteRecordService{
    public List<Attendance__c> attendances {get;set;}
    public List<Approval__c> approvals {get;set;}
    public List<Month__c> months {get;set;}
    public List<Holiday__c> holidays {get;set;}
    
    
    public DeleteRecordService(){
        attendances=new List<Attendance__c>();
        approvals=new List<Approval__c>();
        months=new List<Month__c>();
        holidays=new List<Holiday__c>();
    
    }
    
    public void startDeletingRecord(){
        attendances=[select id,name from Attendance__c where allow_to_delete__c=true limit 1000];
        approvals=[select id,name from Approval__c where allow_to_delete__c=true limit 1000];
        months=[select id,name from Month__c where allow_to_delete__c=true limit 1000];
        holidays=[select id,name from Holiday__c where allow_to_delete__c=true limit 1000];
        
        if(attendances.size()>0){
            delete attendances;
        }
        
        if(approvals.size()>0){
            delete approvals;
        }
        
        if(months.size()>0){
            delete months;
        }
        
        if(holidays.size()>0){
            delete holidays;
        }
    
    }
    



}