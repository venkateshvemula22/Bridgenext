import { LightningElement } from 'lwc';
import {NavigationMixin} from 'lightning/navigation';
import {encodeDefaultFieldValues} from 'lightning/pageReferenceUtils';

export default class NavigateToNewRecord extends NavigationMixin(LightningElement) {

    // Navigate to New Record
    NaviagteToNewRecord(){
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Contact',
                actionName: 'new'
            }
        });
    }

    // Navigate to New Record with default values
    NaviagteToNewRecordWithDefaults(){
        let defaultValues = encodeDefaultFieldValues({
            FirstName: 'Reyaansh',
            LastName: 'Vemula',
            LeadSource: 'Other',
            MobilePhone: 8106267957
        });
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Contact',
                actionName: 'new'
            },
            state: {
                defaultFieldValues: defaultValues
            }
        });
    }

    // Navigate to Listview
    NaviagteToListView(){
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Account',
                actionName: 'list'
            },
            state: {
                filterName: 'Recent'
            }
        });
    }

    // Navigate to Record Relationship Page
    NaviagteToRecordRelationshipPage(){
        this[NavigationMixin.Navigate]({
            type: 'standard__recordRelationshipPage',
            attributes: {
                recordId: '0015g00000L4wKwAAJ',
                objectApiName: 'Account',
                relationshipApiName: 'Contacts',
                actionName: 'view'
            }
        });
    }
    
    // Navigate to External Web Page
    NaviagteToWebPage(){
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: 'https://www.bridgenext.com'
            }
        });
    }

    // Navigate to LWC
    NaviagteToLwc(){
        var defination = {
            componentDef: 'c:lwcTargetComponent',
            attributes: {
                recordId: '0015g00000L4wKwAAJ'
            }
        }
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: '/one/one.app#'+btoa(JSON.stringify(defination))
            }
        });
    }
}