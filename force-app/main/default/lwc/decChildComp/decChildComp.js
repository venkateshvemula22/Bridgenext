import { LightningElement,api } from 'lwc';

export default class DecoratorsLWC extends LightningElement {

    @api childName = 'venkatesh';
    @api wifeName = 'Chikkiee';

    constructor(){

        super();
        debugger

        console.log('constructor childname == ' + this.childName);
        alert('constructor executed......! ' + this.childName);
    }

    connectedCallback(){
        debugger
        console.log('connectedCallback childname == ' + this.childName);
        alert('connectedCallback executed......! ' + this.childName);

    }

    @api childfunc(){
        alert('child function is called......!');
        console.log('wifeName == ' + this.wifeName);
    }



}