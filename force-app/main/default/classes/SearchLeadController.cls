public class SearchLeadController {
    @AuraEnabled
    public static List<Lead> FetchLeadList(String LeadName, String companyname, String Email) {
        system.debug('LeadName===='+LeadName);
        system.debug('companyname===='+companyname);
        system.debug('Email===='+Email);
        String Querystr ='';
        if( (LeadName != null && LeadName != '') || (companyname != null && companyname != '') || (Email != null && Email != '') )
        Querystr = 'select Id,Name,Company,Status,Email,MobilePhone from Lead where (Status = \'Invited\' or status = \'Registered\')';
        
        if(LeadName != null && LeadName != '' ){
           String LeadName1 = '%'+LeadName+'%';
           Querystr += ' and name like \''+ LeadName1+'\'';
           //Querystr += ' where name like \''+ LeadName1+'\'';
        }
        if(companyname != null && companyname != ''){
            /*if(LeadName != null && LeadName != '' ){
                Querystr += ' and ';
            }else{
                Querystr += ' where ';
            }*/
            String companyName1 = '%'+companyname+'%';
            Querystr += 'and company like \''+companyName1+'\'';
        }
        if(Email != null && Email != '' ){
            /*if( (LeadName != null && LeadName != '') || (companyname != null && companyname != '') ){
                Querystr += ' and ';
            }else{
                Querystr += ' where ';
            }*/
            Querystr += 'and Email = \''+Email+'\'';
        }
        
        system.debug('@@@@@@@@Querystr==='+Querystr);
        List<Lead> LeadList = Database.query(Querystr);
        return LeadList;
    }
    @AuraEnabled
    public static Boolean registerAndCheckInLead(String LeadId,String actionType) {
        try{
            Lead l = new Lead(Id = LeadId);
            /*if(actionType == 'Checkin'){
                l.Status = 'Check In Completed';
            }else{
                l.Status = 'Registered';
            }*/
            l.Status = 'Check-In Complete';
            update l;
            List<Lead> LeadList = [SELECT FirstName,LastName,Company,SK_Account_Mgr_Mobile__c,SK_Account_Manager__c,SK_Account_Manager__r.MobilePhone FROM Lead WHERE Id =: l.Id limit 1];
            system.debug('leadList====????????='+leadList);
            if(leadList.size() > 0){
                    sendMsgToAccountManager(leadList[0].FirstName, leadList[0].LastName, leadList[0].Company,leadList[0].SK_Account_Mgr_Mobile__c);
             
            }
            return true;
        }catch(exception e){
            return false;
        }
    }
    @AuraEnabled
    public static List<Lead> updatePhoneNumerInLead(String LeadId,String phoneNumber) {
        Lead l = new Lead(Id = LeadId);
        
        l.MobilePhone = phoneNumber;
        update l;
        return null;
    }
    
    @future(callout=true)
    public static void sendMsgToAccountManager(String FirstName, String Lastname, String ComapanyName, String mobileNo){
        String mobiles = '+91'+mobileNo;
        //Send SMS API
        system.debug('@@@@@@@mobileNo==='+mobileNo);
        String mainUrl= 'https://2factor.in/API/R1/?module=TRANS_SMS&apikey=7eea10e2-ceaf-11e7-94da-0200cd936042&to='+ mobileNo + '&from=SKINTL&templatename=Notify+AE+for+Event+Check-In&var1='+ FirstName +'&var2=' + Lastname +'&var3=' + ComapanyName;
        //Timeout set to 120 seconds (Max Limit)
        Integer timeOut = 120000;
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();        
        
        // Set time out in milliseconds
        request.setTimeout(timeOut);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        
        //Set endpoint url of service
        request.setEndpoint(mainUrl); 
        httpresponse response;
        if(!Test.isRunningTest()){
            system.debug('request=========>>>>>>>>>'+request);
            response = http.send(request);
        }
        else{
            response = new HttpResponse();
            response.setBody('{"Status":"Success","Details":"9658802c-d3fd-11e7-94da-0200cd936042"}');
            response.setStatusCode(200);
        }
    }
}