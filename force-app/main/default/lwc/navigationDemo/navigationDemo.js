import { LightningElement } from 'lwc';
import {NavigationMixin} from 'lightning/navigation';
import {encodeDefaultFieldValues} from 'lightning/pageReferenceUtils';

export default class NavigationDemo extends NavigationMixin(LightningElement) {

    value = '';

    get options() {
        return [
            { label: 'Home', value: 'home' },
            { label: 'Chatter', value: 'chatter' },
            { label: 'Files', value: 'ContentDocument' },
            { label: 'New Record', value: 'new' },
            { label: 'New Record With Default Values', value: 'newDefault' },
            { label: 'listview', value: 'list' }
        ];
    }

    handleChange(event) {
        this.value = event.detail.value;
        if(this.value == 'chatter' || this.value == 'home'){
                this[NavigationMixin.Navigate]({
                    type: 'standard__namedPage',
                    attributes: {
                        pageName: this.value
                    }
                })
        }
        if(this.value == 'newDefault'){
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

            if(this.value == 'new'){
            
                this[NavigationMixin.Navigate]({
                    type: 'standard__objectPage',
                    attributes: {
                        objectApiName: 'Contact',
                        actionName: 'new'
                    }
                });
            }
    }
}