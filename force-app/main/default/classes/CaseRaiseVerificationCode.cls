public without sharing class  CaseRaiseVerificationCode {
    @InvocableMethod(label='Raise Verification Code' description='Send Verification Code to register email')
  public static void sendOTP(List<String> emails){
        String email = emails[0];
        String rand = string.valueof(Math.abs(Crypto.getRandomInteger()));
        String otp = rand.substring(0,5);
        List<Contact> VerificationCodelst = [select Id,Email,VerificationCode__c from Contact where Email=:email];
      	 VerificationCodelst[0].VerificationCode__c = otp;
      update VerificationCodelst;
        
        
        sendOTPEmail(email,otp);
        //return otp;
    }
    
    public static void sendOTPEmail(String email,String OTP){
        String mailbody = '<br><img src="" alt="Company Logo" height="68" width="85"/><div style="font-family: Helvetica,Arial,sans-serif;min-width:1000px;overflow:auto;line-height:2"><div style="margin:50px auto;width:70%;padding:20px 0"><div style="border-bottom:1px solid #eee"><a href="" style="font-size:1.4em;color: #00466a;text-decoration:none;font-weight:600">SK International</a></div><p style="font-size:1.1em">Hi,</p><p>Use the following Verification Code to complete your procedures.</p><h2 style="background: #00466a;margin: 0 auto;width: max-content;padding: 0 10px;color: #fff;border-radius: 4px;">'+OTP+'</h2><p style="font-size:0.9em;">Regards,<br />SK International Team</p><hr style="border:none;border-top:1px solid #eee" /><div style="float:right;padding:8px 0;color:#aaa;font-size:0.8em;line-height:1;font-weight:300"></div></div></div>';
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        List<String> lst_email = new List<String>{email};
        mail.setToAddresses(lst_email);
        mail.setSubject('Verification Code');
        mail.setHtmlBody(mailbody);
        mail.setBccSender(false); 
        mail.setUseSignature(false); 
        mail.setSenderDisplayName('Sk International'); 
        mail.setSaveAsActivity(false); 
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
    @AuraEnabled
    public static List<Ticket_Comment__c> getTicketComment(String ticketId){
		List<Ticket_Comment__c> ticketComments = new List<Ticket_Comment__c>();
         System.debug('ticketId' + ticketId);
		ticketComments = [select Id,Name,Comment__c,CreatedDate,Visible_to_Customer__c from Ticket_Comment__c where Ticket__c=:ticketId AND Visible_to_Customer__c = TRUE];
		return ticketComments;
       
	}
    @AuraEnabled
	public static Ticket__c getTicket(String ticketId){
	Ticket__c ticket = new Ticket__c();
	ticket = [select Id,Name,CreatedDate,Account__c,AccountName__c,Ticket_Logged_by_Contact__c,ContactName__c,Subject__c,Status__c,Description__c,Service_Category__c,SubCategory__c,Asset__c,AssetName__c,Location__c from Ticket__c where Id=:ticketId];
	return ticket;
	}


}