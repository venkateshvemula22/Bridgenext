import { LightningElement, wire } from 'lwc';
import { getRecord, getFieldValue } from "lightning/uiRecordApi";
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import ID_FIELD from '@salesforce/schema/Account.Id'
import NAME_FIELD from "@salesforce/schema/Account.Name";
import OWNER_NAME_FIELD from "@salesforce/schema/Account.Owner.Name";
import RATING_FIELD from "@salesforce/schema/Account.Rating";
import INDUSTRY_FIELD from "@salesforce/schema/Account.Industry";
import { NavigationMixin } from 'lightning/navigation';
export default class StandardLookupFieldDemo extends NavigationMixin(LightningElement) {
    accountRecord
    
    // filter = {
    //     criteria: [
    //         {
    //             fieldPath: 'Rating',
    //             operator: 'eq',
    //             value: 'Warm'
    //         },
    //         {
    //             fieldPath: 'Rating',
    //             operator: 'eq',
    //             value: 'Cold'
    //         }
    //     ],
    //     filterLogic: '1 OR 2'
    // };

    displayInfo = {
        additionalFields: ['Rating']
    }

    matchingInfo = {
        primaryField: { fieldPath: 'Rating' },
        additionalFields: [ { fieldPath: 'Phone' } ]
    }

    recordId = '0015g00000XBPFdAAP';
    
    handleChane(event){
        this.recordId = event.detail.recordId
        console.log('recordId => ', this.recordId)
    }

    @wire(getRecord, {recordId : '$recordId', fields : [ID_FIELD, NAME_FIELD, OWNER_NAME_FIELD, RATING_FIELD, INDUSTRY_FIELD]})
    account({data, error}){
        if(data){
            console.log("data", data)
            this.accountRecord = data
        }
        if(error){
            console.error(error)
        }
    }

    get accountId() {
        return getFieldValue(this.accountRecord, ID_FIELD);
      }

    get name() {
        return getFieldValue(this.accountRecord, NAME_FIELD);
      }
    
      get rating() {
        return getFieldValue(this.accountRecord, RATING_FIELD);
      }
    
      get industry() {
        return getFieldValue(this.accountRecord, INDUSTRY_FIELD);
      }
    
      get owner() {
        return getFieldValue(this.accountRecord, OWNER_NAME_FIELD);
      }

      navigateToRecord(){
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.accountId,
                objectApiName: ACCOUNT_OBJECT.objectApiName,
                actionName: 'view'
            }
        })
    }
}