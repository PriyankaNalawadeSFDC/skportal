@IsTest 
public class DeleteRecordSchedularTest {
      
     static testMethod void test1() {
         DeleteRecordSchedular p = new DeleteRecordSchedular();
         String sch = '0 40 16 * * ?';
         system.schedule('One Time Pro', sch, p);
         DeleteRecordService cv = new DeleteRecordService();
         cv.startDeletingRecord();
     }
}