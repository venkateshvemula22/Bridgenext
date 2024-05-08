import { LightningElement } from 'lwc';
import getOptyList from '@salesforce/apex/ImperativeAccController.getOptyList';

export default class ImperativeService extends LightningElement {

opptys;
errormsg;

handleChange(event){

    let searchkey = event.target.value;
    if(searchkey.length >= 3){

        getOptyList({'stg' : searchkey})
                    .then((response) => {
                        this.opptys = response;
                        this.errormsg = undefined;

                    })
                    .catch((err) => {
                          this.errormsg = err;
                          this.opptys = undefined;
                    });


    }
   

}




/*
handleClick(){
    debugger;
    getOptyList()   // Promise response from salesforce
                .then((result) => {
                    this.opptys = result;

                })
                .catch((error) => {
                    this.errormsg = error;

                })
} */


}