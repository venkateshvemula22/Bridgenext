import { LightningElement, wire, track } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import ChatGPTResponse from '@salesforce/apex/ChatGPTService.callChatGPTService';

export default class ChatGPTBot extends LightningElement {

   @track result;
   @track  question;


   handleSubmit(event) {

            if(event) {
                this.myResponseMethod();
            }
    }

    handleEnter(event) { 
        if(event.keyCode === 13){ 
            this.myResponseMethod(); 
        } 
    }

    myResponseMethod() {
        const prompt = this.template.querySelector('lightning-input').value;
        this.question = prompt;
            
                ChatGPTResponse({'prompt' : prompt})
                                .then(response =>{
                                    this.result = response;
                                })
    }


}