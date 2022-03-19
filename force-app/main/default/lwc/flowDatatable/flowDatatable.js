import { LightningElement,api,track } from 'lwc';
import getTicketComment from '@salesforce/apex/CaseRaiseVerificationCode.getTicketComment';
import getTicket from '@salesforce/apex/CaseRaiseVerificationCode.getTicket';
export default class FlowDatatable extends LightningElement {
    @api records = [];
    @track ticket = {};
    @api fieldColumns = [
        { label: 'Ticket No', fieldName: 'Name' },
        { label: 'Created Date', fieldName: 'CreatedDate'},
        { label: 'Subject', fieldName: 'Subject__c' },
        { label: 'Service Category', fieldName: 'Service_Category__c' },
        { label: 'Asset', fieldName: 'Asset__c'},
        { label: 'Status', fieldName: 'Status__c' },
        { label: 'Ticket Logged by Contact', fieldName: 'Ticket_Logged_by_Contact__c' }
    ];

    @track paginatedRecord =[];
    viewRecord = false;
    recId = '';
    lstComments = [];
    commentsColumns = [{ label: 'Ticket Comment No', fieldName: 'Name' , hideDefaultActions: "true"},
                      { label: 'Comment', fieldName: 'Comment__c' , hideDefaultActions: "true"},
                      { label: 'Comment Date', fieldName: 'CreatedDate' ,hideDefaultActions: "true"}];
    connectedCallback(){
        this.records = JSON.parse(JSON.stringify(this.records));
        console.log('reocrd Print' , this.records);
    }

    handleViewRecord(event){
        this.viewRecord = true;
        console.log('event.target.key ',event.target);
        this.recId = event.target.id.split('-')[0];

        getTicket({ticketId:this.recId}).then(ticket=>{
            this.ticket = JSON.parse(JSON.stringify(ticket));
            if(ticket){
            this.ticket.CreatedDate = this.formatAMPM(this.ticket.CreatedDate);
            }
            console.log('ticket ',this.ticket);
        }).catch(err=>console.log('error getTicket',err));
            

        getTicketComment({ticketId:this.recId}).then(data=>{
           
            data.forEach(element => {
               element.CreatedDate =  this.formatAMPM(element.CreatedDate)
            });
            this.lstComments = data;
            console.log('DATA Comments' , data);  
        }).catch(error=>{
            console.log(error , 'Error Comments');
        })
    }

    handleCancleRecord(event){
        this.viewRecord = false;
    }
    handlePaginationAction(event){
        setTimeout(() => {
         this.paginatedRecord = event.detail.values;
         this.hasRendered = false;
      }, 200);
    }

    formatAMPM(date) {
        date = new Date(date);
       const monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun","Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
       let day = date.getDate();
       let month = date.getMonth();
       let year = date.getFullYear();
       let hours = date.getHours();
       let minutes = date.getMinutes();
       let ampm = hours >= 12 ? 'pm' : 'am';
       hours = hours % 12;
       hours = hours ? hours : 12; // the hour '0' should be '12' 17/3/2022, 08:51 pm
       minutes = minutes < 10 ? '0'+minutes : minutes;
       let strTime = hours + ':' + minutes + ' ' + ampm;
       let  strDateTime =  day+'/'+ month +'/'+year+' '+strTime
       return strDateTime;
     }
}