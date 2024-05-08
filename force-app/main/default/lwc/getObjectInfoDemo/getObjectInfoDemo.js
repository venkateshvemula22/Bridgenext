import { LightningElement, wire } from 'lwc';
import {getObjectInfo} from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
const COLUMNS = [
                    {label:'Field Name', fieldName:'label'},
                    {label:'Field Api Name', fieldName:'apiName'},
                    {label:'DataType', fieldName:'dataType'}
                ]
export default class GetObjectInfoDemo extends LightningElement {

    objInfo
    objectName = 'Account'
    columns = COLUMNS
    @wire(getObjectInfo, {objectApiName:ACCOUNT_OBJECT})
    accountInfo({data, error}){
        if(data){
            console.log(data)
            this.objInfo = {
                defaultRecordTypeId : data.defaultRecordTypeId,
                apiName : data.apiName,
                labelPlural : data.labelPlural
            }
        }
        if(error){
            console.error(error)
        }
    }

////////////////////////////////////////////*******************************////////////////////////////////////////////////

    @wire(getObjectInfo, {objectApiName:'$objectName'})
    objectInformation

    get fields() {
        if (this.objectInformation.data) {
            console.log(this.objectInformation.data)
            const obj = Object.values(this.objectInformation.data.fields)
            console.log('obj ==> ', obj)
            return Object.values(this.objectInformation.data.fields);
        }
        return [];
    }

    handleInput(){
        setTimeout(() => {
            this.objectName = this.template.querySelector('lightning-input').value
        }, 2000)
    }
}