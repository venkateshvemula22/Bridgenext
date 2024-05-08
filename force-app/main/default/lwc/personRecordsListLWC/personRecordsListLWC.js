import { LightningElement, track, wire } from 'lwc';
import  getpersonsList from '@salesforce/apex/PersonRecordsListCntrl.getPersonsList';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { updateRecord } from "lightning/uiRecordApi";
import { NavigationMixin } from 'lightning/navigation';
import { subscribe, unsubscribe, onError } from 'lightning/empApi';

import PERSON_OBJECT from '@salesforce/schema/Person__c';
import ID_FIELD from '@salesforce/schema/Person__c.Id';
import NAME_FIELD from '@salesforce/schema/Person__c.Name';
import ADHAR_FIELD from '@salesforce/schema/Person__c.Adhar_Number__c';
import PAN_FIELD from '@salesforce/schema/Person__c.PAN_Card_Number__c';
import PHONE_FIELD from '@salesforce/schema/Person__c.Phone__c';
import EMAIL_FIELD from '@salesforce/schema/Person__c.Email__c';
import DOB_FIELD from '@salesforce/schema/Person__c.Date_Of_Birth__c';
import AGE_FIELD from '@salesforce/schema/Person__c.Age__c';


const COLUMNS = [
             {label:'Name', fieldName: 'Name', editable: true, sortable: true, type: 'button',     //we can also use : 'fieldName: NAME_FIELD.fieldApiName'
             typeAttributes: {label: {fieldName: 'Name'}, name: 'urlredirect', variant: 'base'}},

             {label:'Account Name',fieldName: 'AccountName', type: 'button',
             typeAttributes: {label: {fieldName: 'AccountName'}, name: 'accounturlredirect', variant: 'base'}},
                   
             {label:'Adhar Number', fieldName: 'Adhar_Number__c', editable: true, sortable: true, type: 'text' },   //we can also use : 'fieldName: ADHAR_FIELD.fieldApiName'
             {label:'PAN Number', fieldName: 'PAN_Card_Number__c', editable: true, sortable: true, type: 'text' },  //we can also use : 'fieldName: PAN_FIELD.fieldApiName'
             {label:'Phone Number', fieldName: 'Phone__c', editable: true, sortable: true, type: 'phone' },         //we can also use : 'fieldName: PHONE_FIELD.fieldApiName'
             {label:'Email', fieldName: 'Email__c', editable: true, sortable: true, type: 'email' },                //we can also use : 'fieldName: EMAIL_FIELD.fieldApiName'
             {label:'Date of Birth', fieldName: 'Date_Of_Birth__c', editable: true, sortable: true, type: 'date' }, //we can also use : 'fieldName: DOB_FIELD.fieldApiName'
             {label:'Age', fieldName: 'Age__c', sortable: true}                                                     //we can also use : 'fieldName: AGE_FIELD.fieldApiName'
         ]

export default class PersonRecordsListLWC extends NavigationMixin(LightningElement) {

    @track columns = COLUMNS;
    @track draftValues = [];
    @track sortDirection = 'asc';
    @track sortedBy = 'Name';
    @track record;
    @track personsList =[];
    @track result;
    @track error;

    @track subscription ={};

    // Auto refresh component when a person record is created, updated and deleted using platform event.
    connectedCallback() {
        const messageCallback = (response) => {
            refreshApex(this.result);
        };

        subscribe('/event/personCreatedEvent__e', -1, messageCallback).then(response => {
            this.subscription = response;
        });
    }

    @wire (getpersonsList, { field : '$sortedBy', sortOrder : '$sortDirection' })
    wiredRecords(result) {
        this.result = result;
        if(result.data) {

            let currentData = [];

            result.data.forEach((row) => {

                /* 
                * Creating the an empty object
                * To reslove "TypeError: 'set' on proxy: trap returned falsish for property"
                */

                let rowData = {};

                rowData.Id = row.Id;
                rowData.Name = row.Name;
                rowData.Adhar_Number__c = row.Adhar_Number__c;
				rowData.PAN_Card_Number__c = row.PAN_Card_Number__c;
				rowData.Phone__c = row.Phone__c;
				rowData.Email__c = row.Email__c;
				rowData.Date_Of_Birth__c = row.Date_Of_Birth__c;
				rowData.Age__c = row.Age__c;


                // Account related data
                if (row.Account__r) {
                    rowData.AccountName = row.Account__r.Name;
                    rowData.AccountId = row.Account__r.Id;
                }

                currentData.push(rowData);
            });

            this.personsList = currentData;
        }
        
        else if (result.error) {
            this.error = result.error;
        }
    }


    handleclick() {

        return refreshApex(this.result);
    }
    //////////////////////////////////////// Handle Inline Editing and Save records from here ///////////////////////////////////////////////
    handleInlineEditSave(event) {
        this.draftValues = event.detail.draftValues;
        const records = this.draftValues.slice().map(draftValue => {
            const fields = Object.assign({}, draftValue);
            return { fields };
        });
 
 
        const promises = records.map(record => updateRecord(record));
        Promise.all(promises).then(res => {
            this.showToast('Success!', 'Records Updated Successfully!!', 'success');
            this.fldsItemdraftValuesValues = [];
            return refreshApex(this.result);
        }).catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        }).finally(() => {
            this.draftValues = [];
        });

    }


    /////////////////////////////////////////////////////////////// Navigate to record page /////////////////////////////////////////////////

    handleRowAction(event){
                const actionname = event.detail.action.name;
                const row = event.detail.row;

                alert('actionname => '+ actionname);
                alert('row => ' + JSON.stringify(row));

                switch (actionname) {
                    case 'urlredirect':
                        this.showRowDetails(row, 'Person__c');
                        break;
                    case 'accounturlredirect':
                            this.showRowDetails(row, 'Account');
                            break;
                    default:
                }
    }
    //navigate to person/account record page
    showRowDetails(row, objName) {
            const recordId = objName == 'Person__c' ? row.Id : row.AccountId;
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes:{
                    recordId: recordId,
                    objectApiName: objName,
                    actionName: 'view'

                }
            });
    }



    ////////////////////////////////////////////////////////////////  showToastEvent  ///////////////////////////////////////////////////////
    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(event);
    }
    

    //////////////////////////////////////////////////////////////// handle sorting from here ////////////////////////////////////////////////

    /////////////// Local Sorting ////////////////
    /*
    onHandleSort(event) {
        debugger
        this.sortedBy = event.detail.fieldName;
        this.sortDirection = event.detail.sortDirection;
        this.sortData(this.sortedBy, this.sortDirection);
    }

    sortData(fieldname, direction) {
        debugger
        let parseData = JSON.parse(JSON.stringify(this.personsList));
        // Return the value stored in the field
        let keyValue = (a) => {
            return a[fieldname];
        };
        // cheking reverse direction
        let isReverse = direction === 'asc' ? 1: -1;
        // sorting data
        parseData.sort((x, y) => {
            x = keyValue(x) ? keyValue(x) : ''; // handling null values
            y = keyValue(y) ? keyValue(y) : '';
            // sorting values based on direction
            return isReverse * ((x > y) - (y > x));
        });
        this.personsList = parseData;
    }  
    */

    ///////////////////////////  Apex class sorting  ////////////////////////////////////


    onHandleSort(event) {
        this.sortedBy = event.detail.fieldName;
        this.sortDirection = event.detail.sortDirection;
    }

    /////////////////////////////////////////////////////////////////////////////////////
}