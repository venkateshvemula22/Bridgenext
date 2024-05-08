import { LightningElement, wire } from 'lwc';
import getAccount from '@salesforce/apex/WireFetchAccoutRecords.getaccountrecord';

export default class WireFetchAccoutRecords extends LightningElement {

    accounts;
    errortext;
    accNameStr;
   

   /* @wire(getAccount,{str : '$accNameStr'})
    myaccount({data,error}){   //myaccount() is a Function/method type variable
        debugger
        if(data){
            this.accounts = data;
        } else if(error){
            this.errortext = error.body.message;
        }
    }   */

    @wire(getAccount,{str : '$accNameStr'}) //It is same as above commented code
    myaccount; //myaccount is a property type variable
        debugger

    invokeJS(event){
        if(event.target.value.length >=4){
            this.accNameStr = event.target.value;
        }
    }


}