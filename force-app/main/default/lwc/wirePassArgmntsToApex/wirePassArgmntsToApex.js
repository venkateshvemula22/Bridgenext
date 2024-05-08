import { LightningElement, wire,api} from 'lwc';
import getdata from '@salesforce/apex/WirePassArgmntsToApex.getstringfromLWC';

export default class WirePassArgmntsToApex extends LightningElement {

    datatext;
    errortext;
    nameText;
    errorTxt;
    strg;
    numb;

    @wire(getdata,{str : '$strg', num : '$numb'}) 
    mydatafromApex({data, error}){
        debugger
        if(data){
            this.datatext = data;
            this.nameText = 'Data == ';
            console.log('data is == ' + data);
        }else if(error){
            this.errortext = error.body.message;
            this.errorTxt = 'Error == ';
            console.log('error msg is == ' + this.errortext);
        }
    }

    /* invokeJS(){
        debugger
        var strr = this.template.querySelector('[data-inp="searchKey"]');
            this.strg = strr.value;
    }   */

    invokeJSC(event){   // This is same as above commented method.
        var strr = event.target;
        this.strg = strr.value;
    }

    invokeJSCt(event){   // This is same as above commented method.
       
        this.numb = event.target.value;
    }
}