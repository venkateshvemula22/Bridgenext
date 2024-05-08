import { LightningElement } from 'lwc';
import { NavigationMixin} from 'lightning/navigation';

export default class NavigateToChatter extends NavigationMixin(LightningElement) {

    //// Navigate to Chatter
    navigateToChatter(){
        this[NavigationMixin.Navigate]({
            type: 'standard__namedPage',
            attributes: {
                pageName: 'chatter'
            }
        });
    }

    //// Navigate to Files
    navigateToFiles(){
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'ContentDocument',
                actionName: 'home'
            }
        });
    }

    // Navigate to Record Page View Mode
    navigateTorecordPageViewMode(){
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: 'a1z5g000000QEG3AAO', // Hard coded the value for time being. We should pass it dynamically as per your requirement.
                objectApiName: 'Person__c',
                actionName: 'view'
            }
        })
    }

    // Navigate to Record Page Edit Mode
    navigateTorecordPageEditMode(){
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: 'a1z5g000000QEG3AAO', // Hard coded the value for time being. We should pass it dynamically as per your requirement.
                objectApiName: 'Person__c',
                actionName: 'edit'
            }
        })
    }

    // Navigate to Tab
    navigateToTab(){
        this[NavigationMixin.Navigate]({
            type: 'standard__navItemPage',
            attributes: {
                apiName: 'Persons_List'
            }
        });
    }
}