import { LightningElement } from 'lwc';
import  personData  from '@salesforce/apex/PersonDetailsController.personDetails';


export default class PersonDetailsLWC extends LightningElement {
    name;
    result;
    errorMessage;

    handleClick() {
        const personName = this.template.querySelector('lightning-input').value;
        console.log('personName == ', personName)
        personData({personName : personName})
                    .then((response) => {
                        if(response.Name === 'No Record Found') 
                        {
                            this.errorMessage = 'No Record Found With This Name. Please Try To Enter The Name Correctly....!';
                            this.result = undefined;
                        }else{
                            this.result = response;
                            this.errorMessage =undefined;
                        }
                        
                    }).catch((error) =>{
                        this.errorMessage = error.getMessage();
                        console.log('hi');
                        console.error('error getting Details : ', this.errorMessage);
                    })
    }
    
}