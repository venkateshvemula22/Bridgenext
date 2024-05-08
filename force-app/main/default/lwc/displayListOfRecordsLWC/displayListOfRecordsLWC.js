import { LightningElement, track, wire } from 'lwc';
import  getObjects from '@salesforce/apex/SobjectList.getObjects';
import  getRecords from '@salesforce/apex/SobjectRecordsCntrl.getObjectRecords';
import Id from '@salesforce/user/Id';
import {getObjectInfo} from 'lightning/uiObjectInfoApi';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { updateRecord } from "lightning/uiRecordApi";
import {getRecord} from 'lightning/uiRecordApi';
import { NavigationMixin } from 'lightning/navigation';
import { subscribe, unsubscribe, onError } from 'lightning/empApi';
import NAME_FIELD from '@salesforce/schema/User.Name'
import USERNAME_FIELD from '@salesforce/schema/User.Username'
import PROFILE_NAME_FIELD from '@salesforce/schema/User.Profile.Name'

const fields = [NAME_FIELD, USERNAME_FIELD, PROFILE_NAME_FIELD]

export default class DisplayListOfRecordsLWC extends NavigationMixin(LightningElement) {


    @track objectNamesList
    @track selectedObject=''
    @track objects=[]
    @track error;
    @track selectedFields
    @track recordsCount
    
    //Lightning data table variables
    @track columns=[]
    @track recordsList=[]
    @track draftValues = [];

    //User details
      userId = Id
     @track isAdmin = false

    // To make selected object fields available to the system administrator to add to the data table. 
    @wire(getRecord, {recordId : '$userId', fields})
    currentUserInfo({error, data}) {
        if(data){
            console.log('Profile Name => ', data.fields.Profile.displayValue)
            if(data.fields.Profile.displayValue == 'System Administrator') {
                this.isAdmin = true
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
                          'label': value.label, 
                          'value' : value.apiName, 
                          'type': value.dataType,
                          'editable': value.updateable,
                          'sortable': value.updateable || value.dataType != 'Reference' ? true : false
                        }
            })
            console.log('obj ==> ', obj)
            return  obj
        }
    }
        
    
    // Handle selected object
    handleObjectChange(event){
        this.columns=[]
        this.selectedFields = null
        this.selectedObject = event.detail.value
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
                console.log('row.label : ', row.label)
                console.log('row.value : ',row.value)
                this.columns.push({
                                    label:row.label, 
                                    fieldName: row.value,
                                    type:row.type,
                                    editable:row.editable,
                                    sortable:row.sortable
                                });
            }
        })
        
        console.log('columns => ', this.columns)
        debugger
        this.getObjectRecords()
    }

    getObjectRecords(){
        this.recordsList = []
        if(this.selectedFields == undefined || this.selectedFields == null){
            this.selectedFields = ['Name', 'CreatedDate', 'CreatedById']
            this.columns = [
                                {label:'Name', fieldName:'Name',type:'text', editable:true, sortable:true },
                                {label:'Created Date', fieldName:'CreatedDate', type:'date', editable:false, sortable:true },
                                {label:'Created By', fieldName:'CreatedById',type:'text', editable:false, sortable:true }
                           ]
        }
        getRecords({
            'objectName': this.selectedObject, 
            'fieldsList' : this.selectedFields, 
            'recordsLimit' : this.recordsCount ? this.recordsCount : 10
        }).then(result =>{
            if(result.length > 0){
                this.recordsList = result
                this.showToast('Success!', 'Records Found..!', 'success')
                const resp =JSON.stringify(result)
                console.log('recordsList => ', this.recordsList)
                console.log('resp => ', resp)
            }
            if(result.length == 0){
                this.recordsList=null
                this.showToast('No Data', 'No Records Found', 'Informational')
            }
            })
    }

    handleInlineEditSave(event){
        this.draftValues = event.detail.draftValues;
        const records = this.draftValues.slice().map(draftValue => {
            const fields = Object.assign({}, draftValue);
            return { fields };
        });
 
 
        const promises = records.map(record => updateRecord(record));
        Promise.all(promises).then(res => {
            this.showToast('Success!', 'Records Updated Successfully!!', 'success')
            this.draftValues = []
            return refreshApex(this.getObjectRecords())
        }).catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        }).finally(() => {
            this.draftValues = []
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
    

}