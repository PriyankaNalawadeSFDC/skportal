global class DeleteRecordSchedular implements Schedulable{
     
    global DeleteRecordSchedular(){
    }    
    global void execute(SchedulableContext ctx) {    
        DeleteRecordService cv = new DeleteRecordService();
        cv.startDeletingRecord();
    }     
}