import { LightningElement, wire } from 'lwc';
import Id from '@salesforce/user/Id';
import {getRecord} from 'lightning/uiRecordApi'
import NAME_FIELD from '@salesforce/schema/User.Name'
import USERNAME_FIELD from '@salesforce/schema/User.Username'
import USER_PROFILE_FIELD from '@salesforce/schema/User.Profile.Name'

const fields = [NAME_FIELD, USERNAME_FIELD, USER_PROFILE_FIELD]
export default class UserDetailsUsingWireUiApi extends LightningElement {
    userId = Id
    userdetails

    //wire service response received as a function
    @wire(getRecord,{recordId:'0055g00000BWaEYAA1', fields})
    userDetailsHandler(response){
        if(response.data){
            console.log(response.data)
            this.userdetails = response.data.fields
        }
        if(response.error){
            console.error(error)
        }
    }

    //wire service response received as a property.
    @wire(getRecord,{recordId:'$userId', fields})
    userdetailsprop
}