import { LightningElement, track, wire } from 'lwc'
import  getObjects from '@salesforce/apex/SobjectRecordsCntrl.getObjects'
import  getRecords from '@salesforce/apex/SobjectRecordsCntrl.getObjectRecords'
import  deleteRecord from '@salesforce/apex/SobjectRecordsCntrl.deleteSobjectRecord'
//import  getRecords from '@salesforce/apex/SobjectRecordsCntrl.getObjectRecords'
import Id from '@salesforce/user/Id'
import {getObjectInfo} from 'lightning/uiObjectInfoApi'
import { refreshApex } from '@salesforce/apex'
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
import { updateRecord } from "lightning/uiRecordApi"
import {getRecord} from 'lightning/uiRecordApi'
import { NavigationMixin } from 'lightning/navigation'
import { subscribe, unsubscribe, onError } from 'lightning/empApi'
import NAME_FIELD from '@salesforce/schema/User.Name'
import USERNAME_FIELD from '@salesforce/schema/User.Username'
import PROFILE_NAME_FIELD from '@salesforce/schema/User.Profile.Name'

const fields = [NAME_FIELD, USERNAME_FIELD, PROFILE_NAME_FIELD]

export default class DisplayListOfRecordsLWC extends NavigationMixin(LightningElement) {


    @track selectedObject=''        
    @track objects=[]               
    @track error;                  
    @track selectedFields           
    @track recordsCount   
    @track objlabels;          
    
    //Lightning data table variables
    @track cardTitle = 'Records' 
    @track columns=[]         
    @track recordsList = []       
    @track draftValues = [];       
    @track spinner = false
    //User details
    userId = Id            
    @track isAdmin = false
    @track userName 

    // To make selected object fields available to the system administrator to add to the data table. 
    @wire(getRecord, {recordId : '$userId', fields})
    currentUserInfo({error, data}) {
        if(data){
            console.log('Profile Name => ', data.fields.Profile.displayValue)
            if(data.fields.Profile.displayValue == 'System Administrator') {
                this.isAdmin = true
                this.userName = data.fields.Name.value
            }
        }
    }

    // Get the list of Object using LDS uiObjectInfoApi
    @wire (getObjects)
    NamesOfObjects({data, error}) {
        if(data) {
            
            console.log('data=> ', data)
            this.objects = Object.entries(data).map(([key, value]) => {
                return { 'label': value, 'value': key }
            })
            console.log('objects => ', this.objects)
        }
        
        else if (error) {
            this.error = error;
        }
    }

    // Get the list of Fielda related to the selected object and make those fields available to select.
    @wire(getObjectInfo, {objectApiName: '$selectedObject'})
    objectInformation

    get fieldsList(){
        if(this.objectInformation.data){
            console.log(this.objectInformation.data)
            const obj = Object.entries(this.objectInformation.data.fields).map(([key,value]) =>{
                return {
                          'label': value.label.replace(/ID/, ''),
                          'value' : value.apiName == 'OwnerId' ? 'Owner.Name' :  value.apiName == 'AccountId' ? 'Account.Name' : value.apiName == 'CreatedById' ? 'CreatedBy.Name' : value.apiName == 'Account__c' ? 'Account__r.Name' : value.apiName,
                          'type': value.dataType == 'DateTime' ? 'date' : value.dataType,
                          'sortable': value.updateable || value.dataType != 'Reference' ? true : false
                        }
            })
            // console.log('obj 83 ==> ',JSON.stringify(obj));
            this.objlabels = obj;
            return  obj
        }
    }
        
    
    // Handle selected object
    handleObjectChange(event){
        this.columns=[]
        this.selectedFields = null
        this.selectedObject = event.detail.value
        this.cardTitle = event.detail.value.replace(/__c/, '') + ' Records'
        this.getObjectRecords()
    }

    // Handle Records Limit change
    handleLimitChange(event){
        this.recordsCount = event.target.value
        console.log('recordsCount => ', this.recordsCount)
        const timer = setTimeout(()=>{
            this.getObjectRecords()
        },1000)
    }

    // Handle selected fields and get all records from database.
    handleFieldsChange(event){
        this.columns=[]
        this.selectedFields = event.detail.value
        console.log('selectedFields => ', this.selectedFields)
        this.fieldsList.filter((row) => {
            console.log('row => ',JSON.stringify(row))
            if(this.selectedFields.includes(row.value)){
                this.columns.push({
                                    label:row.label, 
                                    fieldName: row.value == 'CreatedBy.Name' ? 'CreatedByName' : row.value == 'Account.Name' ? 'AccountName' : row.value == 'Owner.Name' ? 'OwnerName' : row.value,
                                    type:row.type,
                                    sortable:row.sortable
                                })
            }
        })
        this.columns.push({type: "button", label: 'Edit', initialWidth: 100, typeAttributes: {
                                                                                                        label: 'Edit',
                                                                                                        name: 'Edit',
                                                                                                        title: 'Edit',
                                                                                                        disabled: {fieldName: 'iseditible'},
                                                                                                        value: 'edit',
                                                                                                        iconPosition: 'center',
                                                                                                        iconName:'utility:edit',
                                                                                                        variant:'Brand'
                                                                                                    }
                        },
                        {type: "button", label: 'Delete', initialWidth: 100, typeAttributes: {
                                                                                                        label: 'Delete',
                                                                                                        name: 'Delete',
                                                                                                        title: 'Delete',
                                                                                                        value: 'Delete',
                                                                                                        iconPosition: 'left',
                                                                                                        iconName:'utility:delete',
                                                                                                        variant:'destructive'
                                                                                                    }
                        })
        
        console.log('columns => ', this.columns)
        this.getObjectRecords()
        
    }

    getObjectRecords(){
        this.spinner = true
        this.recordsList = []
        if(this.selectedFields == undefined || this.selectedFields == null){
            this.selectedFields = ['Name', 'CreatedDate', 'CreatedBy.Name', 'Owner.Name']
            this.columns = [
                                {label:'Name', fieldName:'Name',type:'text', sortable:true },
                                {label:'Created Date', fieldName:'CreatedDate', type:'date'},
                                {label:'Created By', fieldName:'CreatedByName',type:'text'},
                                {label:'Owner', fieldName:'OwnerName',type:'text'},
                                {type: "button", label: 'Edit', initialWidth: 100, typeAttributes: {
                                                                                                        label: 'Edit',
                                                                                                        name: 'Edit',
                                                                                                        title: 'Edit',
                                                                                                        disabled: {fieldName: 'iseditible'},
                                                                                                        value: 'edit',
                                                                                                        iconPosition: 'left',
                                                                                                        iconName:'utility:edit',
                                                                                                        variant:'Brand'
                                                                                                    }
                                },
                                {type: "button", label: 'Delete', initialWidth: 100, typeAttributes: {
                                                                                                        label: 'Delete',
                                                                                                        name: 'Delete',
                                                                                                        title: 'Delete',
                                                                                                        value: 'Delete',
                                                                                                        iconPosition: 'left',
                                                                                                        iconName:'utility:delete',
                                                                                                        variant:'destructive'
                                                                                                    }
}    
                           ]
        }
        getRecords({
            'objectName': this.selectedObject, 
            'fieldsList' : this.selectedFields, 
            'recordsLimit' : this.recordsCount ? this.recordsCount : 10
        }).then(result =>{
                if(result.length > 0){
                    // this.recordsList = result;
                    //console.log('result===>'+JSON.stringify(result));
                    let rows = [];
                    for(let i=0; i<result.length;i++){
                        //console.log('resp => ', i);
                        let obj = result[i].Rec;
                        //console.log('resp => ', JSON.stringify(obj));
                        if('CreatedBy'in obj){
                            console.log('CreatedBy yes');
                            obj.CreatedByName = obj.CreatedBy.Name;
                        }
                        if('Owner'in obj){
                            console.log('Owner yes');
                            obj.OwnerName = obj.Owner.Name;
                        }
                        
                        obj.OwnerName = obj.Owner.Name;
                        if(result[i].editable == true){
                            obj.iseditible =  false;
                        }else{
                            obj.iseditible =  true;
                        }
                        
                        rows.push(obj);    
                    }
                    console.log('rows===>'+JSON.stringify(rows));
                    this.recordsList = rows;
                    // console.log('resp => ', resp)
                    // this.recordsList = result.map(record => ({
                        
                    //         ...record,
                    //         CreatedByName : record.CreatedBy.Name,
                    //         OwnerName : record.Owner.Name
                    // }))
                    // console.log('recordsList ==> ', this.recordsList)
                    this.spinner = false
                }
                if(result.length == 0){
                    this.recordsList = null
                    this.spinner = false
                }
            }).catch(error => {
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error',
                            message: error.body.message,
                            variant: 'error'
                        })
                    )
                    this.spinner = false
                }).finally(() => {
                        this.spinner = false
                    })
    }



    // handleInlineEditSave(event){
    //     this.draftValues = event.detail.draftValues;
    //     const records = this.draftValues.slice().map(draftValue => {
    //         const fields = Object.assign({}, draftValue);
    //         return { fields };
    //     });
 
 
    //     const promises = records.map(record => updateRecord(record));
    //     Promise.all(promises).then(res => {
    //         this.draftValues = []
    //     }).catch(error => {
    //         this.dispatchEvent(
    //             new ShowToastEvent({
    //                 title: 'Error',
    //                 message: error.body.message,
    //                 variant: 'error'
    //             })
    //         );
    //     }).finally(() => {
    //         this.draftValues = []
    //     });
    // }

     ////////////////////////////////////////////////////////////////  showToastEvent  ///////////////////////////////////////////////////////
     showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(event);
    }

    callRowAction(event) {
        const recId = event.detail.row.Id;
        const actionName = event.detail.action.name;
        if (actionName === 'Edit') {
            this.handleAction(recId, this.selectedObject, 'edit');
        }
        if (actionName === 'Delete') {
            this.deleteSobjectRecord(recId, this.selectedObject);
        }
    }

    handleAction(recordId, objApiName, mode) {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: recordId,
                objectApiName: objApiName,
                actionName: mode
            }
        })
    }

    deleteSobjectRecord(recordId, objApiName){

        deleteRecord({'recId' : recordId, 'objectName' : objApiName}).then(
            result => {
                if(result.includes('Error : ')){
                    this.showToast('Error', result , 'error')
                }else {
                    this.showToast('Success', result, 'success')
                    this.getObjectRecords()
                }
                
            }
        ).catch(
            error => {
                this.showToast('Error', error.body.message, 'error')
            })

    }
}