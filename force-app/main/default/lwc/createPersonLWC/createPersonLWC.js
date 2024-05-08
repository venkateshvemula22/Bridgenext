import { LightningElement } from 'lwc';
import createPerson from '@salesforce/apex/CreatePersonController.createPerson';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CreatePersonLWC extends LightningElement {

    name;
    adhar;
    pan;
    phone;
    message;
    email;
    dob;
    myMap = new Map();

    handleClick() {
        debugger
        this.name = this.template.querySelector('[data-inp="1"]').value;
        this.adhar = this.template.querySelector('[data-inp="2"]').value;
        this.pan = this.template.querySelector('[data-inp="3"]').value;
        this.phone = this.template.querySelector('[data-inp="4"]').value;
        this.email = this.template.querySelector('[data-inp="5"]').value;
        this.dob = this.template.querySelector('[data-inp="6"]').value;

        if(!this.dob) {
            alert('Please Enter the Date Of Birth..!');
        }

        let personWrap = {
            Name : this.name,
            AdharNumber : this.adhar,
            PanNumber : this.pan,
            Phone : this.phone,
            Email : this.email,
            DOB : this.dob
        }
        // For string return type
        // createPerson({payload : JSON.stringify(personWrap)})
        //             .then(result => {
        //                 if(result.includes('Error => '))
        //                 {
        //                     this.showToastMessage('Error!', result, 'error', 'dismissable');
        //                 }else {
        //                     this.showToastMessage('Success!', result, 'success', 'dismissable');
        //                 }
        //             })  
        //             .catch(err => {
        //                 this.showToastMessage('Error!', err.getMessage(), 'error', 'dismissable');
        //              })

        // for Map return type
        createPerson({payload : JSON.stringify(personWrap)})
                    .then(result => {
                        debugger
                        if(result.Error)
                        {
                            this.showToastMessage('Error!', result.Error, 'error', 'dismissable');
                        }else if(result.Success) {
                            this.showToastMessage('Success!', result.Success, 'success', 'dismissable');
                        }
                    })  
                    .catch(err => {
                        debugger
                        this.showToastMessage('Error!', err.getMessage(), 'error', 'dismissable');
                     })
    }

    showToastMessage(title, message, variant, mode){
        const toastEvent = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
            mode: mode

        });
        this.dispatchEvent(toastEvent);
    }

}