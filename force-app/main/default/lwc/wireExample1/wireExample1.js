import { LightningElement, api, wire } from 'lwc';
import samplefirstmethod from '@salesforce/apex/WireExampleApex1.getstdName';

export default class WireExample1 extends LightningElement {

    sonNamedata = '';
    sonNameerror = '';
    nameText = '';
    errorText = '';

@wire(samplefirstmethod) 
mySonName({data,error}){
    debugger
    if(data){
        this.sonNamedata = data;
        this.nameText = 'Son Name : ';
    }else if(error){
        this.sonNameerror = error.body.message;
        this.errorText = 'Error : ';
    }
    
}

connectedCallback(){

        debugger
        alert('connectedCallback is called on load.' + this.mySonName.data + ' ' + this.mySonName.error);

}

myFun(){
    debugger
    alert('myFun Called...!')
    this.sonNamedata = this.mySonName.data;
    this.sonNameerror = this.mySonName.error.body.message;

    console.log('sonNamedata == ' + this.sonNamedata);
    console.log('sonNameerror == ' + this.sonNameerror);

}



}