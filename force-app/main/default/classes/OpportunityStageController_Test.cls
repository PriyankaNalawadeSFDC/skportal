@isTest
public class OpportunityStageController_Test{
    @isTest
    public static void test1(){
    
        Account acc = new Account();
        acc.Name = 'test Ankita Goyal';
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
        Insert d;
        
        Attachment att = new Attachment();
        att.Name = 'Test Image';
        att.body = blob.valueOf('test');
        att.Description = 'Qualification-PO';
        att.parentid = d.Id;
        insert att;
        
        List<String> reasons = new List<String>();
        reasons.add('Other');
        List<Deal_Line_Items__c> dl = new List<Deal_Line_Items__c>();
        dl = OpportunityStageController.addDealLineItems(dl,string.valueOf(d.Id),null,'Networking','WIRELESS - NETWORKING',decimal.valueOf(2100),decimal.valueOf(2),'Other','Test Comment');
        dl = OpportunityStageController.addDealLineItems(dl,string.valueOf(d.Id),null,'Software & License','Subscription - Citrix',decimal.valueOf(2100),decimal.valueOf(2),'Other','Test Comment');
        dl = OpportunityStageController.addDealLineItems(dl,string.valueOf(d.Id),null,'HPC','NETWORKING HPC SWITCH',decimal.valueOf(2100),decimal.valueOf(2),'Other','Test Comment');
        OpportunityStageController.updateDealLineItems(dl[0].Id,null,'Networking','NETWORKING - BLADE CHASSIS SWITCH',decimal.valueOf(2100),decimal.valueOf(2),'Other','Test Comment');
        OpportunityStageController.getGSTINValue(d.Id);
        OpportunityStageController.setGSTINValue(d.Id,'ABCD12345');
        OpportunityStageController.createActivity('New',d.Id,'Test Next Step',system.today());
        OpportunityStageController.getCategoryPicklistVal(d.Id);
        OpportunityStageController.getDealStageValue(d.Id);
        OpportunityStageController.getNegotitaionExpectVal(d.Id);
        OpportunityStageController.getLossReasonPicklistVals();
        OpportunityStageController.getSelectedReasonValue(d.Id);
        OpportunityStageController.updateReasonForLoss(d.Id,reasons, 'otherReason');
        OpportunityStageController.getAttachmentList(d.Id);
        OpportunityStageController.SaveNewContact('Test fname', 'Test lname','test@gmail.com', '9586743210',d.Id);
        OpportunityStageController.SaveNewAccount('Test Account','ABCD1234',d.Id);
        
        OpportunityStageController.getLineItemList(d.Id,1,5);
        OpportunityStageController.deleteDealLineItem(dl[0].Id,dl);
        OpportunityStageController.deleteDealLineItem('',dl);
        OpportunityStageController.getTotalLineItemValue(dl[0].Id);
        
        OpportunityStageController.getActivityHisotyList(d.Id);
        OpportunityStageController.getOpenActivityList(d.Id);
        //OpportunityStageController.deleteAttachment(dl[0].Id);
        
        Deal__c dNew = new Deal__c();
        OpportunityStageController.getDependentMap(dNew ,'Category__c','Sub_Category__c','Networking');
        OpportunityStageController.decimalToBinary(1000);
        OpportunityStageController.base64ToBits('ABCd1234');
        OpportunityStageController.getLookupObject(d.Id,'Contact');
        OpportunityStageController.getLookupObject(d.Id,'Account');
        OpportunityStageController.fetchLookUpValues('tets',d.Id,'Contact');
        OpportunityStageController.fetchLookUpValues('tets',d.Id,'Account');
        OpportunityStageController.ReopenDealtoNew('test reason',d.Id);
        OpportunityStageController.getDealOwnerName(d.Id);
        OpportunityStageController.createDealContactRole(d.Id,con.Id);
        OpportunityStageController.checkDealContactRole(d.Id);
        OpportunityStageController.getLatestActivity('Qualification',d.Id);
        OpportunityStageController.convertAttachmentToFile(att.Id);
        OpportunityStageController.deleteAttachmentapex(att.Id,d.Id,null);
        OpportunityStageController.AttachmentList(d.Id,'Qualification',1,5);
        OpportunityStageController.deleteAttachment(att.id);
        Id attachId = OpportunityStageController.saveChunk(d.Id,'Test Attached File','test Attachment body','jpeg','','PO','Qualification','4324');
        OpportunityStageController.saveChunk(d.Id,'Test Attached File','test Attachment body','jpeg',attachId,'PO','Qualification','6565');
    }
}