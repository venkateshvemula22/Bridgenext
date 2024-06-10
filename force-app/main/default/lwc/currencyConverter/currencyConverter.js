import { LightningElement, track } from 'lwc';
import currencyConversion from '@salesforce/apex/CurrencyLayerIntegration.convertCurrency';


export default class CurrencyConverter extends LightningElement {

    @track fromCurrecy;
    @track toCurrecy;
    @track amount;
    @track convertedAmount;
    errormsg;
    
    handleClick(){
        debugger
        this.fromCurrecy = this.template.querySelector('[data-inp="fc"]').value;
        this.toCurrecy = this.template.querySelector('[data-inp2="tc"]').value;
        this.amount = this.template.querySelector('[data-inp3="amt"]').value;

        currencyConversion({'fromC' : this.fromCurrecy, 'toC' : this.toCurrecy, 'amount' : this.amount})
                          .then((response) =>{
                            debugger
                            this.convertedAmount = response;
                          })
                          .catch((err) => {
                            this.errormsg = err.result.error.info;
                          })

        //test
                 }
}