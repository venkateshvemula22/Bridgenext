import { LightningElement,api,track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getOppStations from '@salesforce/apex/ManageOpportunityPersonsCntrl.getOppPersons';
import saveOppStations from '@salesforce/apex/ManageOpportunityPersonsCntrl.saveOppPersons';
import { CloseActionScreenEvent } from 'lightning/actions';

export default class OpportunityPersonLWC extends LightningElement {

    @api recordId;
    @track oppPersonsList = [];
    @track isSpinner = false;
    @track deleteOppStationIds=[];

    connectedCallback(){
        getOppStations({ oppId : this.recordId})
        .then(result=>{
            this.oppPersonsList=result;
            console.log("GET Persons",JSON.stringify(result));
        })
        .catch(error=>{
            console.log("GET ERROR",error);
        })
    }

    handleAddRow(){
        this.oppPersonsList.push({ Opportunity__c:this.recordId, Name : '', Adhar_Number__c:'', PAN_Card_Number__c:'', Date_Of_Birth__c:'', Phone__c :'', Email__c :'' });
    }

    handleChange(event){
        this.oppPersonsList[event.currentTarget.dataset.index][event.target.name] = event.target.value;
    }

    saveRows(){
        console.log(JSON.stringify(this.oppPersonsList));
        this.isSpinner = true;
        saveOppStations({oppPersonsList:JSON.stringify(this.oppPersonsList), deleteOppPersonsIds: this.deleteOppStationIds})
        .then(result=>{
            this.isSpinner = false;
            this.showToastMessage('success', 'Opportunity Stations Saved Successfully!!', 'Success');
            this.oppStationList=result;
            this.updateRecordView();
            this.dispatchEvent(new CloseActionScreenEvent());
        })
        .catch(error=>{
            this.isSpinner = false;
            this.showToastMessage('error', error, 'Error!');
        })

    }

    showToastMessage(variant, message, title) {
        this.dispatchEvent(
            new ShowToastEvent({
                title: title,
                message: message,
                variant: variant
            })
        );
    }

    updateRecordView() {
        setTimeout(() => {
             eval("$A.get('e.force:refreshView').fire();");
        }, 100); 
     }

     handleRemoveRow(event){
        console.log("Id",this.oppPersonsList[event.currentTarget.dataset.index].Id); 
        if(this.oppPersonsList[event.currentTarget.dataset.index].Id){
            this.deleteOppStationIds.push(this.oppPersonsList[event.currentTarget.dataset.index].Id);
        }
        this.oppPersonsList.splice(event.currentTarget.dataset.index,1);
     }

}