public Without Sharing class OpportunityStageController {
    @AuraEnabled
    public static void ReopenDealtoNew(String ReopenReason, String OppId){
        List<Deal__c> d = [select id,Reopen_Counter__c from Deal__c where Id=: OppId];
        if(d != null && d.size() > 0){
            Deal__c d1 = new Deal__c(Id= d[0].Id);
            if(d[0].Reopen_Counter__c == null)
                d[0].Reopen_Counter__c = 0;
            d1.Reopen_Counter__c = d[0].Reopen_Counter__c + 1;
            d1.Reopen_Reason__c = ReopenReason;
            d1.Stage__c = 'New';
            update d1;
            system.debug('@@@@d1===='+d1);
        }
        //return null; 
    }
    @AuraEnabled
    public static Boolean GetAccessOfDeal(String OppId){
        system.debug('@@@@@@@OppId==>>>>>>'+OppId);
        List<Deal__Share> d = [SELECT Id, ParentId, UserOrGroupId,UserOrGroup.name, AccessLevel FROM Deal__Share where ParentId =: OppId and UserOrGroupId =: UserInfo.getUserId()];
        system.debug('@@@@@@@dddddd==>>>>>>'+d);
        if(d != null && d.size() > 0 ){
            if(d[0].AccessLevel == 'Read'){
                return true;
            }
        }
        return false; 
    }
    @AuraEnabled
    public static String getDealOwnerName(String DealId){
        List<Deal__c> d = [select id,Owner.Name from Deal__c where Id=: DealId];
        if(d != null && d.size() > 0){
            return d[0].Owner.Name;
        }
        return null; 
    }
    @AuraEnabled
    public static Boolean getGSTINValue(String OppId){
        List<Deal__c> d = [select Account__c,Account__r.GSTIN__c from Deal__c where Id=: oppId];
        if(d != null && d.size() > 0){
            if(d[0].Account__c != null && d[0].Account__r.GSTIN__c != null && d[0].Account__r.GSTIN__c != '')
                return false;
            else
                return True;
        }
        return true; 
    }
    @AuraEnabled
    public static Boolean setGSTINValue(String OppId, String GSTIN){
        List<Deal__c> d = [select Account__c,Account__r.GSTIN__c from Deal__c where Id=: oppId];
        if(d != null && d.size() > 0){
            if(d[0].Account__c != null ){
                Account a = new Account(id = d[0].Account__c);
                a.GSTIN__c = GSTIN;
                update a;
            }
        }
        return false; 
    }
    @AuraEnabled
    public static void createDealContactRole(String DealId, String contactId){
        Set<String>contactIdSet = new Set<String>();
        for(Deal_contact_role__c DCR : [select id,Contact__c from Deal_contact_role__c where Deal__c =: DealId]){
            contactIdSet.add(DCR.Contact__c);
        }
        if(!(contactIdSet.size() > 0 && contactIdSet.contains(contactId))){
            Deal_contact_role__c dcr1 = new Deal_contact_role__c();
            dcr1.Contact__c = contactId;
            dcr1.Deal__c = DealId;
            dcr1.Role__c = 'Decision Maker';
            Insert dcr1;
        }
    }
    @AuraEnabled
    public static Boolean checkDealContactRole(String DealId){
        List<Deal_contact_role__c> DCR = [select id,Contact__c from Deal_contact_role__c where Deal__c =: DealId and Role__c = 'Decision Maker'];
        if(DCR != null && DCR.size() > 0 )
            return false;
        else
            return true;
    }
    
    @AuraEnabled
    public static Task getLatestActivity(String StageName ,String DealId){
        List<Task> taskList = [SELECT id,Description__c,ActivityDate FROM Task WHERE subject =: StageName AND WhatId=:DealId order by lastmodifieddate desc limit 1];
        if(taskList.size() > 0){
            return taskList[0];
        }
        return null;
    }
    @AuraEnabled
    public static void createActivity(String StageName ,String DealId, String NextStep, date DueDate){ 
        system.debug('StageName===>>>'+StageName + 'DealId===>'+DealId +'NextStep===>'+NextStep+'DueDate===>'+DueDate);
        List<Task> taskList = [SELECT id FROM Task WHERE subject =: StageName AND WhatId=:DealId];
        system.debug('taskList===>>>'+taskList);
        if(taskList.size() <= 0){
            Task taskObject = new Task();
            taskObject.subject = StageName;
            taskObject.WhatId = DealId;
            taskObject.ActivityDate = DueDate;
            taskObject.Description__c = NextStep;
            taskObject.Status = 'In Progress';
            taskObject.Priority = 'Normal';
            INSERT taskObject;
            system.debug('taskObject===>>>'+taskObject);
        }else{
            Task taskObject = new Task(Id = taskList[0].Id);
            taskObject.ActivityDate = DueDate;
            taskObject.Description__c = NextStep;
            update taskObject;
        }
    }
    @AuraEnabled
    public static List<String> getCategoryPicklistVal(String OppId){
        List<String> CategoryList = new List<String>();
        Schema.DescribeFieldResult fieldResult = Deal__c.Category__c.getDescribe();
        List<Schema.PicklistEntry> pList = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pList) {
            CategoryList.add(p.getLabel());
        }
        system.debug('@@@@@@wrapperClassList==='+CategoryList);
        return CategoryList;
    }
    
    @AuraEnabled
    public static String getDealStageValue(String OppId){
        List<Deal__c> d = [select Stage__c from Deal__c where Id=: oppId];
        if(d != null && d.size() > 0)
            return d[0].Stage__c;
        else
            return null;
    }
    
    @AuraEnabled
    public static List<wrapperClassNew> getNegotitaionExpectVal(String OppId){
        Deal__c d = [select id,Negotiation_Expectation__c from Deal__c where Id=: oppId];
        List<wrapperClassNew> wrapperClassList = new List<wrapperClassNew>();
        Schema.DescribeFieldResult fieldResult = Deal__c.Negotiation_Expectation__c.getDescribe();
        List<Schema.PicklistEntry> pList = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pList) {
            wrapperClassNew returnwrapperClass = new  wrapperClassNew ();        
            returnwrapperClass.NegotiateVal = p.getLabel();
            returnwrapperClass.isexist = (d.Negotiation_Expectation__c!= null && d.Negotiation_Expectation__c.contains(p.getLabel()) ) ? true : false; 
            wrapperClassList.add(returnwrapperClass);
        }
        system.debug('@@@@@@wrapperClassList==='+wrapperClassList);
        return wrapperClassList;
    }
    @AuraEnabled
    public static List<String> getLossReasonPicklistVals(){
        List<String> solCatValueList = new List<String>();
        Schema.DescribeFieldResult fieldResult = Deal__c.Reason_for_Loss__c.getDescribe();
        List<Schema.PicklistEntry> pList = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pList) {
            solCatValueList.add(p.getLabel());
        }
        system.debug('@@@@@@solCatValueList==='+solCatValueList);
        return solCatValueList;
    }
    @AuraEnabled
    public static List<String> getSelectedReasonValue(String OppId){
        Deal__c dl = [select Reason_for_Loss__c from Deal__c where Id =: OppId];
            if(dl != null && dl.Reason_for_Loss__c != null){
                List<String> reason = dl.Reason_for_Loss__c.split(';');
                return reason;
            }else
                return null;
    }
    @AuraEnabled
    public static String updateReasonForLoss(String OppId, List<String> selectedValues,String otherReason){
        system.debug('selectedValues====>>>>>'+selectedValues);
        system.debug('selectedValues.size() ====>>>>>'+selectedValues.size() );
        try{
            if(selectedValues.size() > 0){
                String selectedValuesasString = '';
                for(String s : selectedValues){
                    selectedValuesasString += s + ';';
                }
                selectedValuesasString = selectedValuesasString.removeEnd(';');
                Deal__c dl = new Deal__c(Id=OppId);
                dl.Reason_for_Loss__c = selectedValuesasString;
                dl.Reopen_Reason__c = '';
                dl.Other_Reason__c = otherReason;
                dl.Stage__c = 'Closed Lost';
                system.debug('selectedValuesasString====>>>>>'+selectedValuesasString);
                system.debug('dl====>>>>>'+dl);
                update dl;
                system.debug('dl after update====>>>>>'+dl);
                return selectedValuesasString;
            }
        }catch(exception e){
            system.debug('error====>>>>>'+ e.getMessage());
            return null;
        }
       return null; 
    }
    @AuraEnabled
    public static List<ContentDocument> getAttachmentList(String ParentId){
        set<String> contentDocLink = new Set<String>();
        for(ContentDocumentLink at : [SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId =:ParentId]){
            contentDocLink.add(at.ContentDocumentId);
        }
        List<ContentDocument> attList = new List<ContentDocument>();
        if(contentDocLink.size() > 0 ){
            attList = [Select Id, Title, FileType from ContentDocument Where ID In : contentDocLink];
        }
        return attList;
    }
    @AuraEnabled
    public static List<ContentDocument> deleteAttachmentapex(String AttId, String ParentId, List<String>attLists){
        if(AttId != ''){
            DELETE [Select Id, Title, FileType from ContentDocument Where ID =: AttId];
        }
        else{
            if(attLists != null)
                DELETE [Select Id, Title, FileType from ContentDocument Where ID IN:attLists]; 
        }
        //system.debug('@@@@@@@@@@'+AttId+'.....'+[Select Id, Title, FileType from ContentDocument Where ID IN:attLists]);
        set<String> contentDocLink = new Set<String>();
        for(ContentDocumentLink at : [SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId =:ParentId]){
            contentDocLink.add(at.ContentDocumentId);
        }
        List<ContentDocument> attList = new List<ContentDocument>();
        if(contentDocLink.size() > 0 ){
            attList = [Select Id, Title, FileType from ContentDocument Where ID In : contentDocLink];
        }
        return attList;
    }
    
    @AuraEnabled
    public static Contact SaveNewContact(String fname, String lname, String email, String phone, String RecordId){
        try{
            Deal__c d = [select id,Account__c from deal__c where id =: RecordId];
        
            Contact c = New Contact();
            c.Firstname = fname;
            c.Lastname = lname;
            c.Email = email;
            c.Phone = phone;
            c.AccountId = d != null && d.Account__c != null ? d.Account__c : '';
            system.debug('.............'+c);
            Insert c;
            
            return [select id,Name from Contact where Id =: c.Id limit 1];
        }catch(exception e){
            throw e;
        }
    }
    @AuraEnabled
    public static Account SaveNewAccount(String name, String GSTIN, String RecordId){
        Account a = new Account();
        a.name = name;
        a.GSTIN__c = GSTIN;
        insert a;
        /*deal__c d = new Deal(id= RecordId);
        d.Account__c = a.Id;
        update d;*/
        return [select id,Name from Account where Id =: a.Id limit 1];
    }
    
    @AuraEnabled
    public static List<Deal_Line_Items__c> addDealLineItems(List<Deal_Line_Items__c>dlIList ,String dealId, String SolCat, String Category, String SubCategory, Decimal Price, Decimal Quantity ,String OtherSubCat , String Comment){
        
        Deal_Line_Items__c dl = new Deal_Line_Items__c();
        dl.Category__c = Category;
        dl.Solution_Sub_Category__c = SubCategory;
        dl.Price__c = Price;
        dl.Quantity__c = Quantity;
        dl.Total_Price__c = Quantity * Price;
        dl.Deal__c = dealId;
        dl.Comment__c = Comment;
        //dl.Close_Date__c = closeDate;
        dl.Other_Sub_Category__c = OtherSubCat;
        system.debug('@@@@@@@'+OtherSubCat);
        system.debug('@@@@@@@'+dl);
        insert dl;
        dlIList.add(dl);
        return dlIList;
    }
    @AuraEnabled
    public static void updateDealLineItems(String lineId, String SolCat, String Category, String SubCategory, Decimal Price, Decimal Quantity,String OtherSubCat , String Comment){
        Deal_Line_Items__c dl = new Deal_Line_Items__c(Id = lineId);
        dl.Category__c = Category;
        dl.Solution_Sub_Category__c = SubCategory;
        dl.Price__c = Price;
        dl.Quantity__c = Quantity;
        dl.Comment__c = Comment;
        dl.Other_Sub_Category__c = OtherSubCat;
        dl.Total_Price__c = Quantity * Price;
        update dl;
    }
    /*@AuraEnabled
    public static void revertChangesInDLI(List<Deal_Line_Items__c> dlIList){
        system.debug('dlIList==='+dlIList);
        update dlIList;
    }
    */
    @AuraEnabled
    public static void deleteDealLineItem(String DLIID,List<Deal_Line_Items__c>DLIList){
        List<Deal_Line_Items__c> dl;
        if(DLIID !='')
            dl = [select Id from Deal_Line_Items__c where id =: DLIID];
        else
            dl = [select Id from Deal_Line_Items__c where id IN: DLIList];
        delete dl;
        system.debug('di.....'+dl);
    }
    
    @AuraEnabled
    public static Decimal getTotalLineItemValue(String DLIID){
        Decimal total = 0;
        if(DLIID !=''){
            for(Deal_Line_Items__c dl: [select Total_Price__c from Deal_Line_Items__c where deal__c =: DLIID]){
                total += dl.Total_Price__c;
            }
        }
        return total;
    }
    @AuraEnabled
    public static List<Task> getActivityHisotyList(String DealId){
        List<Task> TaskList = [SELECT Id, Subject, Description__c,ActivityDate, status,Priority FROM Task WHERE WhatId =:DealId order by lastmodifieddate desc limit 2];
        if(TaskList != null && TaskList.size() > 0 )
            return TaskList;
        else 
            return null;
    }
    
    @AuraEnabled
    public static Integer getOpenActivityList(String DealId){
        List<Task> TaskList = [SELECT Id FROM Task WHERE WhatId =:DealId and status !='Completed' limit 5];
        if(TaskList != null && TaskList.size() > 0 )
            return TaskList.size();
        else 
            return 0;
    }
    @AuraEnabled
    public static LineItemwrapper getLineItemList(String dealId, Decimal pageNumber, Decimal pageSize){
        Integer pSize = (Integer)pageSize;
        Integer pNumber = (Integer)pageNumber;
        Integer offset = (pNumber - 1) * pSize;
         
        //Total Records
        Decimal total = 0;
        Decimal totalHardwareProposedAmount = 0;
        Decimal totalSoftwareProposedAmount = 0;
        Decimal totalServiceProposedAmount = 0;
        Integer totalRecords = 0;
        for(Deal_Line_Items__c dl : [SELECT id,Category__c, Total_Price__c FROM Deal_Line_Items__c where Deal__c =:DealId ]){
            total += dl.Total_Price__c;
            totalRecords++;
            if(dl.Category__c == 'Server' || dl.Category__c == 'HCI Solution' || dl.Category__c == 'HPC' || dl.Category__c == 'Networking' || dl.Category__c == 'Others' || dl.Category__c == 'Storage'  ){
                totalHardwareProposedAmount += dl.Total_Price__c;
            }
            else if(dl.Category__c == 'Software & License' || dl.Category__c == 'Infra Software' || dl.Category__c == 'Cloud Infra Solutions' || dl.Category__c == 'Converged Services'){
                totalSoftwareProposedAmount += dl.Total_Price__c;
            }
            else if(dl.Category__c == 'ESG Professional Services' || dl.Category__c == 'SSG Professional Services'){
                totalServiceProposedAmount += dl.Total_Price__c;
            }
        }
        if(totalRecords == offset && offset != 0){
            offset = offset-(Integer)pageSize;
            pNumber = pNumber-1;
        }
        Integer recordEnd = pSize * pNumber;
        LineItemwrapper wrp = new LineItemwrapper();
        wrp.pageSize = pSize;
        wrp.pageNumber = pNumber;
        wrp.recordStart = offset + 1;
        wrp.indexStart = (Integer)offset+1;
        wrp.totalPrice = total;
        wrp.totalHardwareProposedAmount = totalHardwareProposedAmount;
        wrp.totalSoftwareProposedAmount = totalSoftwareProposedAmount;
        wrp.totalServiceProposedAmount = totalServiceProposedAmount;
        wrp.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
        wrp.totalRecords = totalRecords;
        List<Deal_Line_Items__c> dl = [select Id,Deal__c,Close_Date__c,Comment__c, Category__c,Other_Sub_Category__c, Solution_Sub_Category__c,Price__c, Quantity__c, Total_Price__c from Deal_Line_Items__c where Deal__c =:DealId order by lastmodifieddate LIMIT :pSize OFFSET :offset];
        wrp.DealLineItemList = dl != null && dl.size() > 0 ? dl : new List<Deal_Line_Items__c>();
        system.debug('@@@@@@@@'+ wrp);
        return wrp;
    } 
    
    //Start...
    @AuraEnabled 
    public static List<String> getDependentMap(sObject objDetail, string contrfieldApiName,string depfieldApiName,String controlFieldVal) {
        String controllingField = contrfieldApiName.toLowerCase();
        String dependentField = depfieldApiName.toLowerCase();
        
        Map<String,List<String>> objResults = new Map<String,List<String>>();
        
        Schema.sObjectType objType = objDetail.getSObjectType();
        if (objType==null){
            return null;
        }
        
        Map<String, Schema.SObjectField> objFieldMap = objType.getDescribe().fields.getMap();
        system.debug('objFieldMap===>'+objFieldMap);
        system.debug('controllingField===>'+controllingField);
        system.debug('dependentField===>'+dependentField);
        system.debug('objFieldMap.get(dependentField)===>'+objFieldMap.get(dependentField));
        system.debug('objFieldMap.get(controllingField)===>'+objFieldMap.get(controllingField));
        
        if (!objFieldMap.containsKey(controllingField) || !objFieldMap.containsKey(dependentField)){
            return null;     
        }
        
        Schema.SObjectField theField = objFieldMap.get(dependentField);
        Schema.SObjectField ctrlField = objFieldMap.get(controllingField);
        
        List<Schema.PicklistEntry> contrEntries = ctrlField.getDescribe().getPicklistValues();
        List<PicklistEntryWrapper> depEntries = wrapPicklistEntries(theField.getDescribe().getPicklistValues());
        List<String> controllingValues = new List<String>();
        
        for (Schema.PicklistEntry ple : contrEntries) {
            String label = ple.getLabel();
            objResults.put(label, new List<String>());
            controllingValues.add(label);
        }
        
        for (PicklistEntryWrapper plew : depEntries) {
            String label = plew.label;
            String validForBits = base64ToBits(plew.validFor);
            for (Integer i = 0; i < validForBits.length(); i++) {
                String bit = validForBits.mid(i, 1);
                if (bit == '1') {
                    if(controllingValues.get(i) == controlFieldVal)
                        objResults.get(controllingValues.get(i)).add(label);
                }
            }
        }
        system.debug('@@@@@@'+objResults.get(controlFieldVal));
        return objResults.get(controlFieldVal);
    }
    
    public static String decimalToBinary(Integer val) {
        String bits = '';
        while (val > 0) {
            Integer remainder = Math.mod(val, 2);
            val = Integer.valueOf(Math.floor(val / 2));
            bits = String.valueOf(remainder) + bits;
        }
        return bits;
    }
    
    public static String base64ToBits(String validFor) {
        if (String.isEmpty(validFor)) return '';
        
        String validForBits = '';
        
        for (Integer i = 0; i < validFor.length(); i++) {
            String thisChar = validFor.mid(i, 1);
            Integer val = base64Chars.indexOf(thisChar);
            String bits = decimalToBinary(val).leftPad(6, '0');
            validForBits += bits;
        }
        
        return validForBits;
    }
    
    private static final String base64Chars = '' +
        'ABCDEFGHIJKLMNOPQRSTUVWXYZ' +
        'abcdefghijklmnopqrstuvwxyz' +
        '0123456789+/';
    
    
    private static List<PicklistEntryWrapper> wrapPicklistEntries(List<Schema.PicklistEntry> PLEs) {
        return (List<PicklistEntryWrapper>)
            JSON.deserialize(JSON.serialize(PLEs), List<PicklistEntryWrapper>.class);
    }
    @AuraEnabled
    public static sObject getLookupObject(String OppId,String apiName){
        if(apiName == 'Contact'){
            Deal__c d = [select id,Contact__c from Deal__c where Id=: OppId];
            if(d != null && d.Contact__c != null){
                String sQuery =  'select id, Name from Contact where Id=: searchKey order by createdDate DESC limit 5';
                List < sObject > sobjectRecords =[select Id,Name,FirstName,LastName from Contact where Id =: d.Contact__c];
                if(sobjectRecords.size() > 0 )
                    return sobjectRecords[0];
            }
        }
        else if(apiName == 'Account'){
            Deal__c d = [select id,Account__c from Deal__c where Id=: OppId];
            if(d != null && d.Account__c != null){
                String sQuery =  'select id, Name from Contact where Id=: searchKey order by createdDate DESC limit 5';
                List < sObject > sobjectRecords =[select Id,Name from Account where Id =: d.Account__c];
                if(sobjectRecords.size() > 0 )
                    return sobjectRecords[0];
            }
        }
        return null;
    }
    @AuraEnabled
    public static List < sObject > fetchLookUpValues(String searchKeyWord, String RecordId,String ObjectName) {
        system.debug('ObjectName-->' + ObjectName);
        List < sObject > returnList = new List < sObject > ();
        String searchKey = searchKeyWord + '%';
        if(ObjectName == 'Contact'){
            Deal__c d = [select id,Account__c from Deal__c where Id=: RecordId];
            if(d != null && d.Account__c != null){
                String AccountId = d.Account__c;
                String sQuery =  'select id, Name from ' +ObjectName + ' where Name LIKE: searchKey and accountId=:AccountId order by createdDate DESC limit 5';
                system.debug('@@@@@@@@@sQuery='+sQuery);
                List < sObject > lstOfRecords = Database.query(sQuery);
                for (sObject obj: lstOfRecords) {
                    returnList.add(obj);
                }
            }
        }
        else if(ObjectName == 'Account'){
            String sQuery =  'select id, Name from ' +ObjectName + ' where Name LIKE: searchKey order by createdDate DESC limit 5';
            system.debug('@@@@@@@@@sQuery='+sQuery);
            List < sObject > lstOfRecords = Database.query(sQuery);
            for (sObject obj: lstOfRecords) {
                returnList.add(obj);
            }
        }
        return returnList;
    }
    
    @AuraEnabled
    public static Id convertAttachmentToFile(String attachmentId) {
        Attachment attach = [SELECT Id, Name, Body, ContentType, ParentId,OwnerId,description From Attachment where id =: attachmentId LIMIT 1];
        system.debug('@@@@@@attach==='+attach);
        List<String>descriptionList = attach.Description != null ? attach.Description.split('-') : new List<String>();
        //Insert ContentVersion
        ContentVersion cVersion = new ContentVersion();
        cVersion.ContentLocation = 'S'; //S-Document is in Salesforce. E-Document is outside of Salesforce. L-Document is on a Social Netork.
        cVersion.PathOnClient = attach.Name;//File name with extention
        cVersion.Origin = 'H';//C-Content Origin. H-Chatter Origin.
        cVersion.OwnerId = attach.OwnerId;//Owner of the file
        cVersion.Title = attach.Name;//Name of the file
        cVersion.VersionData = attach.Body;//File content
        cVersion.Description = attach.Id;
        cVersion.Stage__c = descriptionList.size() > 0 ? descriptionList[0] : '';
        cVersion.Reference_Number__c = descriptionList.size() >= 3 ? descriptionList[2] : '';
        cVersion.Document_Type__c = descriptionList.size() >= 2 ? descriptionList[1] : '';
        Insert cVersion;
         
        //After saved the Content Verison, get the ContentDocumentId
        Id conDocument = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cVersion.Id].ContentDocumentId;
         
        //Insert ContentDocumentLink
        ContentDocumentLink cDocLink = new ContentDocumentLink();
        cDocLink.ContentDocumentId = conDocument;//Add ContentDocumentId
        cDocLink.LinkedEntityId = attach.ParentId;//Add attachment parentId
        cDocLink.ShareType = 'I'; //V - Viewer permission. C - Collaborator permission. I - Inferred permission.
        cDocLink.Visibility = 'AllUsers';//AllUsers, InternalUsers, SharedUsers
        Insert cDocLink;
        system.debug('@@@@@@cDocLink==='+cDocLink);
        return cDocLink.Id;
    }
    
    @AuraEnabled
    public static Id saveChunk(Id parentId, String fileName, String base64Data, String contentType, String fileId, String mode, String stagename, String RefNumber) {
        if (fileId == '') {
            fileId = saveTheFile(parentId, fileName, base64Data, contentType,mode,stagename,RefNumber);
        } else {
            appendToFile(fileId, base64Data);
        }
        return Id.valueOf(fileId);
    }
 
    public static Id saveTheFile(Id parentId, String fileName, String base64Data, String contentType, String mode, String stagename, String RefNumber) {
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
 
        Attachment oAttachment = new Attachment();
        oAttachment.parentId = parentId;
 
        oAttachment.Body = EncodingUtil.base64Decode(base64Data);
        oAttachment.Name = fileName;
        oAttachment.ContentType = contentType;
        oAttachment.Description = stagename +'-'+ mode+'-'+RefNumber;
        insert oAttachment;
        return oAttachment.Id;
    }
    
    private static void appendToFile(Id fileId, String base64Data) {
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        Attachment a = [
            SELECT Id, Body
            FROM Attachment
            WHERE Id =: fileId
        ];
        String existingBody = EncodingUtil.base64Encode(a.Body); 
        a.Body = EncodingUtil.base64Decode(existingBody + base64Data);
        update a;
    }
    
    //add fro practice ankita goyal
   /* @AuraEnabled
    public static Id saveFiles(String ContentDocId, String mode, String stagename) {
        system.debug('--------stagename-------------'+stagename);
        system.debug('--------mode-------------'+mode);
        system.debug('--------ContentDocId-------------'+ContentDocId);
        ContentDocument cd = [SELECT Id, Description FROM ContentDocument where id=: ContentDocId limit 1];
        cd.Description = stagename +'-'+ mode;
        update cd;
        system.debug('--------cd-------------'+cd);
        return cd.Id;
    }*/
    //public static Attachmentwrapper FileList(String parentId, String stagename, Decimal pageNumber, Decimal pageSize)
    @AuraEnabled
    public static Attachmentwrapper AttachmentList(String parentId, String stagename, Decimal pageNumber, Decimal pageSize){
        List<ContentVersion> attachmentList = new List<ContentVersion>();
        Attachmentwrapper wrp = new Attachmentwrapper();
        Integer pSize = (Integer)pageSize;
        Integer pNumber = (Integer)pageNumber;
        Integer offset = (pNumber - 1) * pSize;
        Integer totalRecords = 0;
        String DescriptionFilter = stagename + '-%';
        set<String>cdSet = new Set<String>();
        for(ContentDocumentLink cdl : [select id,ContentDocumentId from ContentDocumentLink where LinkedEntityId =: parentId]){
            cdSet.add(cdl.ContentDocumentId);
        }
        
        for(ContentVersion at : [SELECT Id,Description FROM ContentVersion WHERE ContentDocumentId In :cdSet and Description like :DescriptionFilter]){
            List<String>descriptionList = at.Description != null ? at.Description.split('-') : new List<String>();
            if(descriptionList.size() > 0 && descriptionList[0] == stagename){
                totalRecords++;
            }
        }
        if(totalRecords == offset && offset != 0){
            offset = offset-(Integer)pageSize;
            pNumber = pNumber-1;
        }
        Integer recordEnd = pSize * pNumber;
        wrp.pageSize = pSize;
        wrp.pageNumber = pNumber;
        wrp.recordStart = offset + 1;
        wrp.indexStart = (Integer)offset+1;
        wrp.totalRecords = totalRecords;
        wrp.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
        for(ContentVersion at : [SELECT Id, Title, FileType, Description,Reference_Number__c,Document_Type__c,Stage__c FROM ContentVersion where ContentDocumentId In :cdSet and Stage__c=:stagename order by lastmodifieddate LIMIT :pSize OFFSET :offset]){
            if(at.Stage__c == stagename){
                attachmentList.add(at);
            }
        }
        wrp.AttachmentList = attachmentList;
        system.debug('....................'+pSize);
        system.debug('....................'+pNumber);
        system.debug('....................'+pNumber*pSize);
        system.debug('....................'+wrp);
        return wrp;
    }
    //end practice section..
    
    /*@AuraEnabled
    public static Attachmentwrapper AttachmentList(String parentId, String stagename, Decimal pageNumber, Decimal pageSize){
        Attachmentwrapper wrp = new Attachmentwrapper();
        Integer pSize = (Integer)pageSize;
        Integer pNumber = (Integer)pageNumber;
        Integer offset = (pNumber - 1) * pSize;
        Integer totalRecords = 0;
        String DescriptionFilter = stagename + '-%';
        for(Attachment at : [SELECT Id, ParentId, Name, ContentType, Description FROM Attachment where ParentId =:parentId and Description like :DescriptionFilter]){
            List<String>descriptionList = at.Description != null ? at.Description.split('-') : new List<String>();
            if(descriptionList.size() > 0 && descriptionList[0] == stagename){
                totalRecords++;
            }
        }
        if(totalRecords == offset && offset != 0){
            offset = offset-(Integer)pageSize;
            pNumber = pNumber-1;
        }
        Integer recordEnd = pSize * pNumber;
        wrp.pageSize = pSize;
        wrp.pageNumber = pNumber;
        wrp.recordStart = offset + 1;
        wrp.indexStart = (Integer)offset+1;
        wrp.totalRecords = totalRecords;
        wrp.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
        List<ChildAttachmentwrp>attachmentList = new List<ChildAttachmentwrp>();
        for(Attachment at : [SELECT Id, ParentId, Name, ContentType, Description FROM Attachment where ParentId =:parentId and Description like :DescriptionFilter order by lastmodifieddate LIMIT :pSize OFFSET :offset]){
            List<String>descriptionList = at.Description != null ? at.Description.split('-') : new List<String>();
            if(descriptionList.size() > 0 && descriptionList[0] == stagename){
                ChildAttachmentwrp chw = new ChildAttachmentwrp();
                chw.Id = at.Id;
                chw.Name = at.Name;
                chw.ContentType = at.ContentType;
                chw.mode = descriptionList.size() > 0 && descriptionList.size() >= 2 ? descriptionList[1] : '';
                chw.refnum = descriptionList.size() > 0 && descriptionList.size() >= 3 ? descriptionList[2] : '';
                attachmentList.add(chw);
            }
        }
        wrp.AttachmentList = attachmentList;
        system.debug('....................'+pSize);
        system.debug('....................'+pNumber);
        system.debug('....................'+pNumber*pSize);
        system.debug('....................'+wrp);
        return wrp;
    }*/
    @AuraEnabled
    public static void deleteAttachment(String AttachmentID){
        if(AttachmentID != '' ){
            //DELETE [select Id from Attachment where Id=:AttachmentID];
            List<contentversion> cv = [select id,title,description,contentdocumentId from contentversion where id=:AttachmentID limit 1];
            
            if(cv.size() > 0 ){
                ContentDocument cd = [select id from ContentDocument where id =: cv[0].contentdocumentId limit 1];
                delete cd;
            }
        }
    }
    public class PicklistEntryWrapper{
        public String active {get;set;}
        public String defaultValue {get;set;}
        public String label {get;set;}
        public String value {get;set;}
        public String validFor {get;set;}
        public PicklistEntryWrapper(){            
        }
        
    }
    //End
    public class wrapperClass{
       @AuraEnabled public String SolutionCategoryVal{get;set;}
       @AuraEnabled public boolean isexist{get;set;} 
    }
    public class wrapperClassNew{
       @AuraEnabled public String NegotiateVal{get;set;}
       @AuraEnabled public boolean isexist{get;set;} 
    }
    
    public class ChildAttachmentwrp{
       @AuraEnabled public String Id {get;set;}
       @AuraEnabled public String Name {get;set;}
       @AuraEnabled public String ContentType {get;set;}
       @AuraEnabled public String mode {get;set;}
       @AuraEnabled public String refnum {get;set;}
       @AuraEnabled public String Stagename {get;set;}
    }
    public class Attachmentwrapper{
       @AuraEnabled public List<ChildAttachmentwrp> AttachmentListOld{get;set;}
       @AuraEnabled public List<ContentVersion> ContentVersionList{get;set;}
       @AuraEnabled public List<ContentVersion> AttachmentList{get;set;}
       @AuraEnabled public Integer pageSize {get;set;}
       @AuraEnabled public Integer pageNumber {get;set;}
       @AuraEnabled public Integer totalRecords {get;set;}
       @AuraEnabled public Integer recordStart {get;set;}
       @AuraEnabled public Integer indexStart {get;set;}
       @AuraEnabled public Integer recordEnd {get;set;}
    }
    public class LineItemwrapper{
       @AuraEnabled public List<Deal_Line_Items__c> DealLineItemList{get;set;}
       @AuraEnabled public Integer pageSize {get;set;}
       @AuraEnabled public Integer pageNumber {get;set;}
       @AuraEnabled public Integer totalRecords {get;set;}
       @AuraEnabled public Integer recordStart {get;set;}
       @AuraEnabled public Integer indexStart {get;set;}
       @AuraEnabled public Integer recordEnd {get;set;}
       @AuraEnabled public Decimal totalPrice{get;set;}
       @AuraEnabled public Decimal totalHardwareProposedAmount{get;set;}
       @AuraEnabled public Decimal totalSoftwareProposedAmount{get;set;}
       @AuraEnabled public Decimal totalServiceProposedAmount{get;set;}
    }
}