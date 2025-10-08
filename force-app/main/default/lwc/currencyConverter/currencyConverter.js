import { LightningElement } from 'lwc';
import currencyConversion from '@salesforce/apex/CurrencyLayerIntegration.convertCurrency';

const INPUT_SELECTORS = {
    from: '[data-inp="fc"]',
    to: '[data-inp2="tc"]',
    amount: '[data-inp3="amt"]'
};

export default class CurrencyConverter extends LightningElement {
    fromCurrecy = '';
    toCurrecy = '';
    amount = '';
    convertedAmount;
    errormsg;

    async handleClick() {
        const fromInput = this.template.querySelector(INPUT_SELECTORS.from);
        const toInput = this.template.querySelector(INPUT_SELECTORS.to);
        const amountInput = this.template.querySelector(INPUT_SELECTORS.amount);

        if (!fromInput || !toInput || !amountInput) {
            return;
        }

        this.fromCurrecy = fromInput.value;
        this.toCurrecy = toInput.value;
        this.amount = amountInput.value;

        try {
            this.convertedAmount = await currencyConversion({
                fromC: this.fromCurrecy,
                toC: this.toCurrecy,
                amount: this.amount
            });
        } catch (error) {
            this.errormsg =
                error?.result?.error?.info || error?.body?.message || error?.message;
        }

        //test
    }
}
