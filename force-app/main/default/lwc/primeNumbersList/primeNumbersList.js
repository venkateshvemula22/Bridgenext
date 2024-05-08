import { LightningElement,track } from 'lwc';

export default class PrimeNumbersList extends LightningElement {

    
    @track primeNumbersList = [];
    @track primeNumbers_count;

    handleClick() {
        let start_number = this.template.querySelector('[data-inp="startn"]').value;
        let end_number = this.template.querySelector('[data-inp2="endn"]').value;
            this.calculate(start_number,end_number);
        }
        

    calculate(snumb,enumb) {
        let plist = [];
        for(let i=snumb ; i<=enumb ; i++){
            let count = 0;
            for(var j=1 ; j<=i ; j++){

                if(i%j == 0)
                    count++;
            }

            if(count == 2) {
                plist.push(i);
            }
                
        }
        this.primeNumbersList = plist;
        this.primeNumbers_count = this.primeNumbersList.length;
    }


}