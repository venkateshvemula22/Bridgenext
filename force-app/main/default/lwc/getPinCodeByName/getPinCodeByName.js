import { LightningElement } from 'lwc';
import  getpincode  from '@salesforce/apex/GetPinCodeByNameCntrl.getPincode';

export default class GetPinCodeByName extends LightningElement {
    message;
    cityName;
    result;
    errorMessage;
    postOfficeList = [];

    handleClick() {
        const pincode = this.template.querySelector('lightning-input').value;
        console.log('pincode == ', pincode)
        getpincode({pincode : pincode})
                    .then((response) => {
                        this.result = response;
                        this.postOfficeList = response[0].PostOffice;
                        this.message = response[0].Message;
                        
                    }).catch((error) =>{
                        this.errorMessage = error.getMessage();
                        console.log('hi');
                        console.error('error getting Pincode : ', this.errorMessage);
                    })



    }


}