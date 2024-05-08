import { LightningElement,api,track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getAccounts from '@salesforce/apex/ManageStudentsController.getAccounts';
import saveOppStations from '@salesforce/apex/ManageStudentsController.saveStudents';
import { CloseActionScreenEvent } from 'lightning/actions';
export default class ManageStudents extends LightningElement {
    @api recordId;
    @track studentList = [] ;
    @track isSpinner = false;
    @track deleteOppStationIds=[];
    connectedCallback(){
        getAccounts({ accId : this.recordId})
        .then(result=>{
            this.studentList = result;
            console.log("GET stations",JSON.stringify(result));
        })
        .catch(error=>{
            console.log("GET ERROR",error);
        })

    }
    handleAddRow(){
        this.studentList.push({ Account__c:this.recordId, Contact__c : '', Country__c:'', course_fees__c:'', Is_Fee_Paid__c:'' });
    }
    handleChange(event){
        this.studentList[event.currentTarget.dataset.index][event.target.name] = event.target.value;
    }  
    saveRows(){
        console.log(JSON.stringify(this.oppStationList));
        this.isSpinner = true;
        saveOppStations({oppStationList:JSON.stringify(this.oppStationList), deleteOppStationIds: this.deleteOppStationIds})
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
        console.log("Id",this.oppStationList[event.currentTarget.dataset.index].Id); 
        if(this.oppStationList[event.currentTarget.dataset.index].Id){
            this.deleteOppStationIds.push(this.oppStationList[event.currentTarget.dataset.index].Id);
        }
        this.oppStationList.splice(event.currentTarget.dataset.index,1);
     }
}