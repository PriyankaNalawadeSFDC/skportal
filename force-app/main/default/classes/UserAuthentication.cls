public class UserAuthentication {

    
    public String unSelect {get;set;}
    public String employeeId {get;set;}
    public String unselectholiday {get;set;}
    public String username {get;set;}
    public String password {get;set;}
    public String wish {get;set;}
    public String preSubmitStyle {get;set;}
    public String reportDes {get;set;}
    public String startHour{get;set;}
    public String monthMSG {get;set;}
    public String startMinute{get;set;}
    public String endHour{get;set;}
    public String endMinute{get;set;}
    public String month {get;set;}
    public String year1 {get;set;}
    public String monthSet {get;set;}
    public String yearSet {get;set;}
    public String employee {get;set;}
    public String submitStyle {get;set;}
    public String userMessage {get;set;}
    public String passwordMessage {get;set;}
    public String resetMessage {get;set;}
    public Map<Integer,String> monthMap {get;set;}
    public Map<String,String> timeMap {get;set;}
    public User u {get;set;}
    public List<User> uList {get;set;}
    public String login {get;set;}
    public String detail {get;set;}
    public User__c user {get;set;}
    public User__c nuser {get;set;}
    public List<User__c> userList {get;set;}
    public List<User__c> alluserList {get;set;}
    public String employeeStyle {get;set;}
    public String adminStyle {get;set;}
    public String view {get;set;}
    public String newRecord {get;set;}
    public String editRecord {get;set;}
    public Date today {get;set;}
    public List<selectOption> dates {get;set;}
    public String clientDate {get;set;}
    public Map<String,String> session {get;set;}
    public List<Attendancy> attList {get;set;}
    public List<Attendance__C> aList {get;set;}
    public List<Attendance__C> pList {get;set;}
    public List<Approval__C> approvals {get;set;}
    public Month__c monthObj {get;set;}
    public Holiday__c holiday {get;set;}
    public List<Holiday__c> holidays {get;set;}
    public String rmonth {get;set;}
    public String opassword {get;set;}
    public String npassword {get;set;}
    public String cpassword {get;set;}
    public Boolean pd {get;set;}
    public Boolean pd1 {get;set;}
    public Boolean pd2 {get;set;}
    public Boolean pd3 {get;set;}
    public Boolean pd4 {get;set;}
    public Boolean Instructionpb {get;set;}
    public String selected {get;set;}
    public List<selectOption> rmonths {get;set;}
    public Notification__c notification {get;set;}
    public List<User__c> birthdays {get;set;}
    public Boolean testFlag=false;
    public String filtersearch {get;set;}
    public List<Attendance__C> submittedList {get;set;}
    public List<Attendance__C> notSubmittedList {get;set;}
    public Decimal subper {get;set;}
    public Decimal notsubper {get;set;}
    public Maintenance__c Maintenance {get;set;}
    public Map<Id,NotSubmittedUser> NotSubmittedUserMap {get;set;}
    public Integer NotSubmittedUserMapSize {get;set;}
    public String nsMonth {get;set;}
    public UserAuthentication(ApexPages.StandardController controller) {
        String userAgent = System.currentPageReference().getHeaders().get('User-Agent');
        String device = System.currentPageReference().getParameters().get('device');
        
        
        System.debug(userAgent +' device --'+device );
        employeeId='';
        nuser=new User__c();
        notification=new Notification__c();
        birthdays =new  List<User__c>();
        submittedList =new List<Attendance__C>();
        notsubmittedList =new List<Attendance__C>();
        Maintenance =new Maintenance__c();
        NotSubmittedUserMap =new Map<id,NotSubmittedUser>();
        NotSubmittedUserMapSize =0;
        try{
        Maintenance =[select id,name,description__c,active__c from Maintenance__c limit 1 ];
        }
        catch(Exception e){
        }
        Integer count=[select count() from Notification__c ];
        if(count==1){
            notification =[select id, description__c from Notification__c limit 1 ];
            }
        holiday =new Holiday__c();
        today=Date.today();
        holidays = new List<Holiday__c>();
        holidays =[select date__c,name__c,wish_line__c from Holiday__c where year__c=:today.year() order by date__c ];
        for(Holiday__c h:holidays ){
            if(h.date__c.day()==today.day() && h.date__c.month()==today.month()){
                wish=h.wish_line__c;
                break;
            }
        }
        birthdays=[select id,day__c,dob__c,first_name__c,last_name__c from user__c where CALENDAR_MONTH(dob__c)=:today.month() and DAY_IN_MONTH(dob__c)>=:today.day() order by day__c   limit 5];
        pList=new List<Attendance__C>();
        aList=new List<Attendance__C>();
        approvals =new List<Approval__C>();
        preSubmitStyle='display:none';
        attList=new List<Attendancy>();
        monthObj =new Month__c();
        monthMap=new Map<Integer,String>();
        monthMap.put(1,'January');
        monthMap.put(2,'February');
        monthMap.put(3,'March');
        monthMap.put(4,'April');
        monthMap.put(5,'May');
        monthMap.put(6,'June');
        monthMap.put(7,'July');
        monthMap.put(8,'August');
        monthMap.put(9,'September');
        monthMap.put(10,'October');
        monthMap.put(11,'November');
        monthMap.put(12,'December');
        
        
        timeMap =new Map<String,String>();
        timeMap.put('00','12:00 AM');
        timeMap.put('01','01:00 AM');
        timeMap.put('02','02:00 AM');
        timeMap.put('03','03:00 AM');
        timeMap.put('04','04:00 AM');
        timeMap.put('05','05:00 AM');
        timeMap.put('06','06:00 AM');
        timeMap.put('07','07:00 AM');
        timeMap.put('08','08:00 AM');
        timeMap.put('09','09:00 AM');
        timeMap.put('10','10:00 AM');
        timeMap.put('11','11:00 AM');
        timeMap.put('12','12:00 PM');
        timeMap.put('13','01:00 PM');
        timeMap.put('14','02:00 PM');
        timeMap.put('15','03:00 PM');
        timeMap.put('16','04:00 PM');
        timeMap.put('17','05:00 PM');
        timeMap.put('18','06:00 PM');
        timeMap.put('19','07:00 PM');
        timeMap.put('20','08:00 PM');
        timeMap.put('21','09:00 PM');
        timeMap.put('22','10:00 PM');
        timeMap.put('23','11:00 PM');
        
        user=new User__c();
        userList =new List<User__c>();
        alluserList =new List<User__c>();
        uList =new List<User>();
        u=new User();
        login ='true';
        detail='false';
        employeeStyle='display:none';
        adminStyle ='display:none';
        view ='display:none';
        newRecord ='display:none';
        editRecord ='display:none';
        session=new Map<String,String>();
    }
    public void forceLogin(){
         login ='true';
        detail='false';
        employeeStyle='display:none';
        adminStyle ='display:none';
        view ='display:none';
        newRecord ='display:none';
        editRecord ='display:none';
    }
    public void Rendered(){
    System.debug('selected ----'+selected);
    /*
    if(selected == 'Standard Price Book Entry'){
        pd1 = TRUE;
        pd2 = False;
        pd3 = True;
        pd4 = False;
         pd=False;
              }
    else{
        pd1 = False;
        pd2 = TRUE;
         pd = False;
         pd3 = False;
        pd4 = True;          
    }
    */
    }
    public void Rendered1(){
    System.debug('selected ----'+selected);
    /*
    if(selected == 'Standard Price Book Entry'){
        pd1 = False;
        pd2 = False;
        pd3 = True;
        pd4 = False;
         pd=False;
              }
    else{
        pd1 = False;
        pd2 = False;
         pd = False;
         pd3 = False;
        pd4 = True;          
    } */
    }
    public void setNotification(){
        Integer count=[select count() from Notification__c ];
        if(count==1){
            Notification__c  no =[select id, description__c from Notification__c limit 1 ];
            no.description__c =notification.description__c ;
            update no;
        }
        else{
            notification.description__c=notification.description__c;
            insert notification;
        }
    }
    public void doAuthentication(){
        
        //user.password__c=password;
        //Decimal empId=Decimal.ValueOf(u.employeeID);
        user.Employee_Id__c=Decimal.valueOf(username);
        user.password__c=password;
        
        String decryptedClearText='';
        Integer count =[select count() from User__c where Employee_Id__c=:user.Employee_Id__c ];
        try{
        if(count>0){
        User__c  temp=[select password__c,key__c from User__c where Employee_Id__c=:user.Employee_Id__c ];
        // encrypted blob key
        Blob cryptoKey =EncodingUtil.base64Decode(temp.key__c );
        //encrypted blob password
        Blob encodedEncryptedBlob = EncodingUtil.base64Decode(temp.password__c);
        if(!testFlag){
        //decrypted blob
        Blob decryptedBlob = Crypto.decryptWithManagedIV('AES128',cryptoKey, encodedEncryptedBlob);
        //decrypted string
        decryptedClearText = decryptedBlob.toString();
        }
        
        
        system.debug('username decryptedClearText : '+decryptedClearText );
        }
        }catch(Exception e){
        }
        if(testFlag){
            decryptedClearText=user.password__c;
        }
        //PageReference p=new PageReference('/My_Account');
        if(decryptedClearText==user.password__c){
            login ='false';
            detail='true';
            alluserList =[select id,email__c,day__c,First_name__c,Last_Name__c,Employee_Id__c,Role__c,status__c  from User__c  order by Employee_Id__c limit 15];
            
            userList =[select id,email__c,day__c,First_name__c,Last_Name__c,Employee_Id__c,Role__c,status__c  from User__c where status__c=:'Active' order by Employee_Id__c ];
            for(User__c x:userList ){
                
                if(x.Employee_Id__c==user.Employee_Id__c){
                    session.put(x.id,x.id);
                    
                    user=x;
                    Integer birthDayCount=[select count() from user__c where CALENDAR_MONTH(dob__c)=:today.month() and DAY_IN_MONTH(dob__c)=:today.day() and id=:user.id];
                    if(birthDayCount==1){
                        wish='Happy Birthday';
                    }
                    if(user.role__c=='Admin'){
                        adminStyle='';
                        view='';
                    }
                    else{
                        employeeStyle='';
                    }
                   
                }
                
            }
               
        }
        /*
        PageReference p=new PageReference('/apex/My_Account');
        p.setRedirect(true);
        */
        
    }
    public void setHoliday(){
        Holiday__c h =new Holiday__c();
        h.name__c=holiday.name__c;
        h.date__c=holiday.date__c;
        h.wish_line__c=holiday.wish_line__c;
        h.year__c=h.date__c.year();
        insert h;
        if(h.year__c==today.year()){
        holidays.add(h);
        }
    }
    public void newRecord(){}
    public void newRecord1(){
        nuser=new User__c();
        userMessage='';
        view='display:none';
        newRecord='';
        editRecord ='display:none';
        System.debug('calling to employee');
        
    }
    public void back(){
        
        view='';
        newRecord='display:none';
        editRecord ='display:none';
        System.debug('calling to employee list');
        alluserList =new List<User__c>();
        alluserList =[select id,email__c,day__c,First_name__c,Last_Name__c,Employee_Id__c,Role__c,status__c  from User__c  order by Employee_Id__c limit 15 ];
            
        
    }
    public void getResetMonth(){
        monthSet='';
        yearSet='';
        employee='';
        monthMSG='';
        approvals=[select id,user__r.id,User__r.employee_id__c, user__r.first_name__c, user__r.last_name__c, month__r.month_value__c, is_submitted__c from Approval__c where is_submitted__c=0 order by User__r.employee_id__c];
    }
    public void getActiveMonth(){
        submitStyle='';
        preSubmitStyle='display:none';
        Integer monthKey=0;
        System.debug('get month : '+month+' year : '+year1);
        Approval__c app=new Approval__c();
        Integer approvalCount=[select count() from Approval__c where is_submitted__c=0  and User__c=:user.id];
        if(approvalCount==1){
            app=[select id,is_submitted__c,Month__r.Month_Key__c,Month__r.Month_Value__c,Month__r.Year__c from Approval__c where is_submitted__c=0 and User__c=:user.id];
            month=app.Month__r.Month_Value__c;
            year1=String.ValueOf(app.Month__r.Year__c);
        }
        Integer yy=today.day();
        if(month==null || year1==null ){
          month=monthMap.get(today.month());
          //month='January';
          year1=String.valueOf(today.year());
          yy=today.day();
        }
        String MM='0';
        for (Integer key : monthMap.keySet()) {
            if(month==monthMap.get(key)){
                monthKey=key;
                if(key<=9){
                  MM='0'+key;
                }
                else{
                  MM=String.valueOf(key);
                }
            }
        }
        if(Integer.ValueOf(year1)<=today.year()){
            if(Date.isLeapYear(Integer.ValueOf(year1)) && Integer.ValueOf(MM)==2){
                yy=29;
            }
            else{
                if(Integer.ValueOf(MM)==4 || Integer.ValueOf(MM)==6 || Integer.ValueOf(MM)==9 || Integer.ValueOf(MM)==11){
                    yy=30;
                }
                else if(Integer.ValueOf(MM)==2 && Integer.ValueOf(year1)<=today.year()){
                    yy=28;
                }
                else if(Integer.ValueOf(MM)!=2){
                    yy=31;
                }
            }
        }
        if(Integer.ValueOf(MM)==today.month()){
            if(today.day()>3){
                yy=today.day();
            }
            else{
                if(today.month()==1){
                    monthKey =12;
                    year1=String.valueOf(today.year()-1);
                }
                else{
                    monthKey =today.month()-1;
                }
                month=monthMap.get(monthKey);
                if(monthKey <=9){
                  MM='0'+monthKey ;
                }
                else{
                  MM=String.valueOf(monthKey);
                }
                 if(Date.isLeapYear(Integer.ValueOf(year1)) && Integer.ValueOf(MM)==2){
                    yy=29;
                }
                else{
                     if(Integer.ValueOf(MM)==4 || Integer.ValueOf(MM)==6 || Integer.ValueOf(MM)==9 || Integer.ValueOf(MM)==11){
                        yy=30;
                    }
                    else if(Integer.ValueOf(MM)==2 && Integer.ValueOf(year1)<=today.year()){
                    yy=28;
                    }
                     else if(Integer.ValueOf(MM)!=2){
                        yy=31;
                    }
            }
            }
        }
        dates= new List<selectOption>();
        for(Integer i=1;i<=yy;i++){
            String dd=null;
            if(i<10){
                dd='0'+i;
            }
            else{
                dd=''+i;
            }
            dates.add(new selectOption(dd+'/'+MM+'/'+year1,dd+'/'+MM+'/'+year1)); 
        }
        Integer monthCount=[select count() from Month__c where Month_Key__c=:monthKey and Year__c=:Integer.ValueOf(year1)];
        if(monthCount==1){
            monthObj=[select id from Month__c where Month_Key__c=:monthKey and Year__c=:Integer.ValueOf(year1)];
        }
        else{
            monthObj.Month_Key__c=monthKey;
            monthObj.Year__c=Integer.ValueOf(year1);
            monthObj.Month_Value__c=month;
            insert monthObj;
        }
        Integer temp=[select count() from Attendance__c where Month__c=:monthObj.id and  User__c=:user.id and is_submitted__c=1  ];
        if(temp>0){
             submitStyle='display:none';
             preSubmitStyle='';
        }
        aList=[select id,Client__c,Date__c,Start_Time__c,End_Date__c,Explaination__c,Month__c,User__c,Is_Submitted__c from Attendance__c where Month__c=:monthObj.id and  User__c=:user.id order by Date__c limit 100 ];
       
    
    }
    // generate report for previous month attendance
    public void getReport(){
        Month__c m=new Month__c();
        reportDes='';
        List<Month__c> monthList=new List<Month__c>();
        if((today.month()-1)==0){
        Integer monthCount=[select count() from Month__c where Month_Key__c=:(12) and Year__c=:(today.year()-1)];
        
        if(monthCount==1){
            m=[select id,Month_Value__c,Year__c from Month__c where Month_Key__c=:(12) and Year__c=:(today.year()-1)];
            reportDes=m.Month_Value__c+' '+m.Year__c;
            monthList=[select id,month_value__c from Month__c where Year__c=:(today.year()-1) ];
    
        }
        }
        else{
         Integer monthCount=[select count() from Month__c where Month_Key__c=:(today.month()-1) and Year__c=:(today.year())];
        
        if(monthCount==1){
            m=[select id,Month_Value__c,Year__c from Month__c where Month_Key__c=:(today.month()-1) and Year__c=:today.year()];
            reportDes=m.Month_Value__c+' '+m.Year__c;
            monthList=[select id,month_value__c from Month__c where Year__c=:(today.year()) ];
        }
        }
        pList=[select id,user__r.employee_id__c,user__r.First_name__c,user__r.Last_name__c,Date__c,Start_Time__c,End_Date__c,Client__c,Explaination__c from Attendance__c where Month__c=:m.id and  User__c=:user.id order by date__c limit 100];
        rmonths= new List<selectOption>();
        rmonths.add(new selectOption('','--None--'));
        for(Month__c ux:monthList){
                rmonths.add(new selectOption(ux.id,ux.Month_Value__c));
            
        }
       
    
    }
    public void saveEmployee(){
        userMessage='';
        User__c se=new User__c();
       // system.debug('generated employee : '+Decimal.valueOf(employeeid));
        se.employee_id__c= nuser.employee_id__c;
        System.debug('employee id  : '+se.employee_id__c);
        se.first_name__c=nuser.first_name__c;
        se.last_name__c=nuser.last_name__c;
        se.dob__c=nuser.dob__c;
        se.email__c=nuser.email__c;
        se.role__c=nuser.role__c;
        se.status__c=nuser.status__c;
        Blob cryptoKey = Crypto.generateAesKey(128);
        String Key = EncodingUtil.base64Encode(cryptoKey);
        Blob data = Blob.valueOf('12345');
        Blob encryptedData = Crypto.encryptWithManagedIV('AES128', cryptoKey, data);
        String encodedCipherText = EncodingUtil.base64Encode(encryptedData);
        se.key__c=Key;
        se.password__c=encodedCipherText;
        insert se;
        nuser=new User__C();
        userMessage='User successfully created';
    }
    public void updateEmployee(){
        update nuser;
        userMessage='User successfully updated';
    }
    public void editEmployee(){
        
        String code=apexpages.currentpage().getparameters().get('code');
        
        nuser=new User__C();
        
        nuser=[select id,email__c,dob__c,day__c,First_name__c,Last_Name__c,Employee_Id__c,Role__c,status__c  from User__c where Employee_Id__c=:Decimal.ValueOf(code) ];
        view='display:none';
        editRecord='';   
        newRecord ='';
            
        
        
    }
    public void changePassword(){
        passwordMessage='';
        String decryptedClearText='';
        Integer count =[select count() from User__c where Employee_Id__c=:user.Employee_Id__c ];
        User__c  temp=null;
        if(count>0){
            temp=[select password__c,key__c from User__c where Employee_Id__c=:user.Employee_Id__c ];
            // encrypted blob key
            Blob cryptoKey =EncodingUtil.base64Decode(temp.key__c );
            //encrypted blob password
            Blob encodedEncryptedBlob = EncodingUtil.base64Decode(temp.password__c);
            if(!testFlag){
            //decrypted blob
            Blob decryptedBlob = Crypto.decryptWithManagedIV('AES128',cryptoKey, encodedEncryptedBlob);
            //decrypted string
            decryptedClearText = decryptedBlob.toString();
            }
            
            
            system.debug('username decryptedClearText : '+decryptedClearText );
        }
        if(testFlag){
            decryptedClearText=opassword;
        }
        //PageReference p=new PageReference('/My_Account');
        if(decryptedClearText==opassword){
            if(npassword==cpassword){
                Blob cryptoKey = Crypto.generateAesKey(128);
                String Key = EncodingUtil.base64Encode(cryptoKey);
                Blob data = Blob.valueOf(npassword);
                Blob encryptedData = Crypto.encryptWithManagedIV('AES128', cryptoKey, data);
                String encodedCipherText = EncodingUtil.base64Encode(encryptedData);
                temp.key__c=Key;
                temp.password__c=encodedCipherText;
                update temp;
                passwordMessage='Password successfully changed';
            }
            else{
                passwordMessage='New and confirm password are not matched ';
            }
        }
        else{
                passwordMessage='old password is wrong ';
            }
    }
    public void submitAttendance(){
        Approval__c app=new Approval__c();
        Integer approvalCount=[select count() from Approval__c where Month__c=:monthObj.id and  User__c=:user.id];
        if(approvalCount==1){
        
            app=[select id,is_submitted__c from Approval__c where Month__c=:monthObj.id and User__c=:user.id];
            app.is_submitted__c =1;
            app.Month__c=monthObj.id;
            app.User__c=user.id;
            update app;
        
        }
        else{
            app.is_submitted__c =1;
            app.Month__c=monthObj.id;
            app.User__c=user.id;
            insert app;
        }
        for(Attendance__c a:aList){
            a.Is_Submitted__c=1;
        }
        update aList;
        submitStyle='display:none';
        preSubmitStyle='';
    }
    public void setActiveMonth(){
        Month__c monthObj=null;
        Integer yyyy=Integer.ValueOf(yearSet);
        Integer monthCount=[select count() from Month__c where Month_Value__c=:monthSet and Year__c=:yyyy];
        if(monthCount==1){
            monthObj=[select id,Month_Value__c from Month__c where Month_Value__c=:monthSet  and Year__c=:yyyy];
            Integer approvalCount=[select count() from Approval__c where Month__c=:monthObj.id and User__c=:employee];
            if(approvalCount==1){
                Approval__c app=[select id,is_submitted__c from Approval__c where Month__c=:monthObj.id and User__c=:employee];
                app.is_submitted__c =0;
                update app;
                approvals.add(app);
                List<Attendance__c> attendances=[select Is_Submitted__c  from Attendance__c  where Month__c=:monthObj.id and User__c=:employee];
                for(Attendance__c x:attendances){
                    x.Is_Submitted__c=0;
                }
                update attendances;
                monthMSG='Activated Month is '+monthObj.Month_Value__c;
            }
            else{
                Approval__c app=new Approval__c();
                app.Month__c=monthObj.id;
                app.User__c=employee;
                app.is_submitted__c =0;
                upsert app;
                approvals.add(app);
                List<Attendance__c> attendances=[select Is_Submitted__c  from Attendance__c  where Month__c=:monthObj.id and User__c=:employee];
                for(Attendance__c x:attendances){
                    x.Is_Submitted__c=0;
                }
                update attendances;
                monthMSG='Activated Month is '+monthObj.Month_Value__c;
        }
            
        }
        else{
            monthMSG='Data not present';
        }
        System.debug('set month : '+month+' year : '+year1);
    }
   public List<selectOption> getMonths(){
        List<selectOption> options = new List<selectOption>();
        options.add(new selectOption('Select','Select'));  
        
        for (Integer key : monthMap.keySet()) {
        // The "key" variable is also available inside the loop
           options.add(new selectOption(monthMap.get(key),monthMap.get(key))); 
        // ... emailing logic
        }
        return options;
    }
    public List<selectOption> getYears(){
        String year='';
        List<selectOption> options = new List<selectOption>();
        options.add(new selectOption('Select','Select')); 
         
        year=String.valueOf(today.year()-1);
        options.add(new selectOption(year,year)); 
        year=String.valueOf(today.year());
        options.add(new selectOption(year,year));
      
        return options;
    }
    
    public List<selectOption> getHours(){
        String Hour='';
        List<selectOption> options = new List<selectOption>();
        for(integer i=0;i<24;i++){
            if(i<10){
                Hour='0'+i;
                options.add(new selectOption(Hour,Hour));
            }
            else{
                Hour=i+'';
                options.add(new selectOption(Hour,Hour));
            }
        }
        return options;
        
    }
    public List<selectOption> getEmployees(){
        String Hour='';
        List<selectOption> options = new List<selectOption>();
        List<User__c> empList=[select id,First_name__c,Last_name__c from User__c where status__c=:'Active'];
        for(User__c ux:empList){
                options.add(new selectOption(ux.id,ux.First_name__c+' '+ux.Last_name__c ));
            
        }
        return options;
        
    }
    
    public List<selectOption> getMinutes(){
        String Minute='';
        List<selectOption> options = new List<selectOption>();
        for(integer i=0;i<60;i++){
            if(i<10){
                Minute='0'+i;
                options.add(new selectOption(Minute,Minute));
            }
            else{
                Minute=i+'';
                options.add(new selectOption(Minute,Minute));
            }
            i=i+4;
        }
        return options;
    }
    // logout function
    public PageReference logout(){
    
        session.remove(u.id);
        login ='true';
        detail='false';
        employeeStyle='display:none';
        adminStyle ='display:none';
        view ='display:none';
        newRecord ='display:none';
        session=null;
        PageReference p=new PageReference('/#no-back-button');
        p.setRedirect(true);
        return p;
    
    }
    
    public void addIntoAttendance(){
        System.debug('enter into addIntoAttendance');
        String clientdate=ApexPages.currentPage().getParameters().get('clientdate');
        String startHour=ApexPages.currentPage().getParameters().get('startHour');
        String startMinute=ApexPages.currentPage().getParameters().get('startMinute');
        String endHour=ApexPages.currentPage().getParameters().get('endHour');
        String endMinute=ApexPages.currentPage().getParameters().get('endMinute');
        String client=ApexPages.currentPage().getParameters().get('client');
        String explaination=ApexPages.currentPage().getParameters().get('explaination');
        System.debug('enter into addIntoAttendance'+clientdate);
        startHour=timeMap.get(startHour).replace('00',startMinute);
        endHour=timeMap.get(endHour).replace('00',endMinute);
        String[] sdate=clientdate.split('/');
        Date myDate = Date.newInstance(Integer.ValueOf(sdate[2]),Integer.ValueOf(sdate[1]),Integer.ValueOf(sdate[0]));
        Attendance__c attendance=new Attendance__c(Report_Date__c=myDate,Client__c=client,Date__c=clientdate,Start_Time__c=startHour,End_Date__c=endHour,Explaination__c=explaination,Month__c=monthObj.id,User__c=user.id,Is_Submitted__c=0);
        aList.add(attendance);
        insert attendance;
        System.debug('enter into addIntoAttendance'+attList);
    
    }
    
    public void removeFromAttendance(){
        System.debug('inside remove : '+unSelect);
        if(unSelect!=''){
            for(Integer i=0;i<aList.size();i++){
                if(aList[i].id==unSelect){
                    delete aList[i];
                    aList.remove(i);
                }
            }
        }
    }
     public void removeFromHolidays(){
        System.debug('inside remove : '+unSelect);
        if(unSelectHoliday!=''){
            for(Integer i=0;i<holidays.size();i++){
                if(holidays[i].id==unSelectHoliday){
                    delete holidays[i];
                    holidays.remove(i);
                }
            }
        }
    }
    

     public void resetPassword(){
        resetMessage='';
        String code=apexpages.currentpage().getparameters().get('code');
        String decryptedClearText='';
        Integer count =[select count() from User__c where Employee_Id__c=:Decimal.ValueOf(code) ];
        User__c  temp=null;
        if(count>0){
            temp=[select password__c,key__c,Employee_Id__c from User__c where Employee_Id__c=:Decimal.ValueOf(code) ];
           
            Blob cryptoKey = Crypto.generateAesKey(128);
            String Key = EncodingUtil.base64Encode(cryptoKey);
            Blob data = Blob.valueOf('12345');
            Blob encryptedData = Crypto.encryptWithManagedIV('AES128', cryptoKey, data);
            String encodedCipherText = EncodingUtil.base64Encode(encryptedData);
            temp.key__c=Key;
            temp.password__c=encodedCipherText;
            update temp;
            resetMessage='Password successfully reset for employee id '+temp.Employee_Id__c;
            
            system.debug('username decryptedClearText : '+decryptedClearText );
        }
        
    
       
    }
    
    public void searchUser(){
        filtersearch=apexpages.currentpage().getparameters().get('filtersearch');
        String s1 = '%'+filtersearch+'%';
        alluserList =new List<User__c>();
        System.debug('filtersearch value : '+filtersearch);
        Decimal ecode=0;
        try{
        ecode=Decimal.ValueOf(filtersearch);
        }
        catch(Exception e){
        ecode=0;
        }
        if(filtersearch=='' || filtersearch==null){
            alluserList =[select id,email__c,day__c,First_name__c,Last_Name__c,Employee_Id__c,Role__c,status__c  from User__c order by Employee_Id__c limit 15 ];
        }
        else{
            alluserList =[select id,email__c,day__c,First_name__c,Last_Name__c,Employee_Id__c,Role__c,status__c  from User__c where First_name__c like:s1 or last_name__c like:s1 or Employee_Id__c =:ecode order by Employee_Id__c limit 15 ];
      
        } 
    }
    
     public void showMonthWiseDetail(){
        NotSubmittedUserMap =new Map<Id,NotSubmittedUser>();
        String mid=ApexPages.currentPage().getParameters().get('monthid');
        Month__c mo;
        try{
        mo=[select Month_Value__c from month__c where id=:mid];
        nsMonth=mo.Month_Value__c;
        }catch(Exception e){
        }
        submittedList=new List<Attendance__c>();
        notSubmittedList=new List<Attendance__c>();
        submittedList=[select id,Client__c,Date__c,Start_Time__c,End_Date__c,Explaination__c,Month__c,User__c,Is_Submitted__c from Attendance__c where Is_Submitted__c=1 and  Month__c=:mid ];
        notSubmittedList=[select id,Client__c,Date__c,Start_Time__c,End_Date__c,Explaination__c,Month__c,User__c,User__r.First_Name__c,User__r.Last_Name__c,Is_Submitted__c from Attendance__c where Is_Submitted__c=0 and  Month__c=:mid ];
        for(Attendance__c x:notSubmittedList){
            NotSubmittedUser nsu=new NotSubmittedUser();
            nsu.name=x.User__r.First_Name__c+' '+x.User__r.Last_Name__c;
            nsu.user=x.user__c;
            nsu.month=x.month__c;
            NotSubmittedUserMap.put(x.user__c,nsu);
        }
        NotSubmittedUserMapSize=NotSubmittedUserMap.size();
        try{
        subper=(submittedList.size()/(submittedList.size()+notSubmittedList.size()))*100;
        }
        catch(Exception e){
            subper=0;
        }
        try{
        notsubper=(notsubmittedList.size()/(submittedList.size()+notSubmittedList.size()))*100;
        }
        catch(Exception e){
            notsubper=0;
        }
    }
    public void autoSubmitUser(){
        NotSubmittedUserMap =new Map<Id,NotSubmittedUser>();
        String mid=ApexPages.currentPage().getParameters().get('monthid');
        String usid=ApexPages.currentPage().getParameters().get('userid');
        Set<STring> asUsers=new Set<String>();
        
        Set<String> asMonths=new Set<String>();
        notSubmittedList=[select id,Client__c,Date__c,Start_Time__c,End_Date__c,Explaination__c,Month__c,User__c,Is_Submitted__c from Attendance__c where Is_Submitted__c=0 and  Month__c=:mid and user__c=:usid ];
    
        for(Attendance__c x:notSubmittedList){
            x.Is_Submitted__c =1;
            asUsers.add(x.user__c);
            asMonths.add(x.month__c);
        }
        update notSubmittedList;
        List<Approval__c> appList=new List<Approval__c>();
        Map<String,Approval__c> appMap=new Map<String,Approval__c>();
        appList=[select id,User__c,month__c,is_submitted__c from Approval__c where Month__c in:asMonths and User__c in:asUsers];
        for(Approval__c x:appList){
            appMap.put(x.user__c,x);
            x.is_submitted__c =1;
        }
        for(String x:asUsers){
            if(!appMap.containsKey(x)){
                Approval__c  app=new Approval__c ();
                app.is_submitted__c =1;
                app.Month__c=mid;
                app.User__c=x;
                appList.add(app);
            }
        }
        upsert appList;
        submittedList=new List<Attendance__c>();
        notSubmittedList=new List<Attendance__c>();
        submittedList=[select id,Client__c,Date__c,Start_Time__c,End_Date__c,Explaination__c,Month__c,User__c,Is_Submitted__c from Attendance__c where Is_Submitted__c=1 and  Month__c=:mid ];
        notSubmittedList=[select id,Client__c,Date__c,Start_Time__c,End_Date__c,Explaination__c,Month__c,User__c,User__r.First_Name__c,User__r.Last_Name__c,Is_Submitted__c from Attendance__c where Is_Submitted__c=0 and  Month__c=:mid ];
        for(Attendance__c x:notSubmittedList){
            NotSubmittedUser nsu=new NotSubmittedUser();
            nsu.name=x.User__r.First_Name__c+' '+x.User__r.Last_Name__c;
            nsu.user=x.user__c;
            nsu.month=x.month__c;
            NotSubmittedUserMap.put(x.user__c,nsu);
        }
        NotSubmittedUserMapSize=NotSubmittedUserMap.size();
        try{
        subper=(submittedList.size()/(submittedList.size()+notSubmittedList.size()))*100;
        }
        catch(Exception e){
            subper=0;
        }
        try{
        notsubper=(notsubmittedList.size()/(submittedList.size()+notSubmittedList.size()))*100;
        }
        catch(Exception e){
            notsubper=0;
        }
    }
    public void autoSubmit(){
        NotSubmittedUserMap =new Map<Id,NotSubmittedUser>();
        String mid=ApexPages.currentPage().getParameters().get('monthid');
        Set<STring> asUsers=new Set<String>();
        
        Set<String> asMonths=new Set<String>();
        notSubmittedList=[select id,Client__c,Date__c,Start_Time__c,End_Date__c,Explaination__c,Month__c,User__c,Is_Submitted__c from Attendance__c where Is_Submitted__c=0 and  Month__c=:mid ];
    
        for(Attendance__c x:notSubmittedList){
            x.Is_Submitted__c =1;
            asUsers.add(x.user__c);
            asMonths.add(x.month__c);
        }
        update notSubmittedList;
        List<Approval__c> appList=new List<Approval__c>();
        Map<String,Approval__c> appMap=new Map<String,Approval__c>();
        appList=[select id,User__c,month__c,is_submitted__c from Approval__c where Month__c in:asMonths and User__c in:asUsers];
        for(Approval__c x:appList){
            appMap.put(x.user__c,x);
            x.is_submitted__c =1;
        }
        for(String x:asUsers){
            if(!appMap.containsKey(x)){
                Approval__c  app=new Approval__c ();
                app.is_submitted__c =1;
                app.Month__c=mid;
                app.User__c=x;
                appList.add(app);
            }
        }
        upsert appList;
        submittedList=new List<Attendance__c>();
        notSubmittedList=new List<Attendance__c>();
        submittedList=[select id,Client__c,Date__c,Start_Time__c,End_Date__c,Explaination__c,Month__c,User__c,Is_Submitted__c from Attendance__c where Is_Submitted__c=1 and  Month__c=:mid ];
        notSubmittedList=[select id,Client__c,Date__c,Start_Time__c,End_Date__c,Explaination__c,Month__c,User__c,User__r.First_Name__c,User__r.Last_Name__c,Is_Submitted__c from Attendance__c where Is_Submitted__c=0 and  Month__c=:mid ];
        for(Attendance__c x:notSubmittedList){
            NotSubmittedUser nsu=new NotSubmittedUser();
            nsu.name=x.User__r.First_Name__c+' '+x.User__r.Last_Name__c;
            nsu.user=x.user__c;
            nsu.month=x.month__c;
            NotSubmittedUserMap.put(x.user__c,nsu);
        }
        NotSubmittedUserMapSize=NotSubmittedUserMap.size();
        try{
        subper=(submittedList.size()/(submittedList.size()+notSubmittedList.size()))*100;
        }
        catch(Exception e){
            subper=0;
        }
        try{
        notsubper=(notsubmittedList.size()/(submittedList.size()+notSubmittedList.size()))*100;
        }
        catch(Exception e){
            notsubper=0;
        }
    }
}