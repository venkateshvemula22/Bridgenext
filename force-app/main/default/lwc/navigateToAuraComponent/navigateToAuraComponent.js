import { LightningElement } from 'lwc';
import {NavigationMixin} from 'lightning/navigation';

export default class NavigateToAuraComponent extends NavigationMixin(LightningElement) {

    // Navigate To Aura Component
    navigateToAuraComponent(){
        this[NavigationMixin.Navigate]({
            type: "standard__component",
            attributes: {
                componentName: 'c__NavigationAuraTargetComponent'
            },
            state: {
                c__id: '00002469974414'
            }
        })
    }
}