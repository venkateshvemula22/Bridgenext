import { LightningElement, api } from 'lwc';

export default class DecParentComp extends LightningElement {

    connectedCallback(){

        debugger
        alert('Parent connectedCallback...!')
    }

    methfromparent(){
        debugger
        alert('onclick method from parent is called......');
        let childcomp = this.template.querySelector('c-dec-child-comp');
        childcomp.childfunc();
    }


}