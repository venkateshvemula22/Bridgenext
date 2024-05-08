import { LightningElement, track } from 'lwc';
import currencyConversion from '@salesforce/apex/CurrencyLayerIntegration.convertCurrency';


export default class CurrencyConverter extends LightningElement {

    @track fromCurrecy;
    @track toCurrecy;
    @track amount;
    @track amount_converted;
    errormsg;
    
    handleClick(){
        debugger
        var fc = this.template.querySelector('[data-inp="fc"]').value;
        var tc = this.template.querySelector('[data-inp2="tc"]').value;
        var amt = this.template.querySelector('[data-inp3="amt"]').value;

        currencyConversion({'fromC' : fc, 'toC' : tc, 'amount' : amt})
                          .then((response) =>{
                            debugger
                            this.amount_converted = response.convertedAmount;
                          })
                          .catch((err) => {
                            this.errormsg = err.result.error.info;
                          })

        
                 }
}