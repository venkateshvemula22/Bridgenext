import { LightningElement, track } from 'lwc';
import  getAccounts from '@salesforce/apex/AccountRecordsCntrl.fetchAccounts';

export default class GetAccountsBtnLwc extends LightningElement {

    accountrecords;
    @track isShowModal = false;

    handleClick() {
        // fetch contact records from apex method 
        getAccounts()
            .then((result) => {
                if (result != null) {
                    //console.log('RESULT--> ' + JSON.stringify(result));
                    this.accountrecords = result;
                    
                    for(let i=0; i < result.length ; i++){
                                result[i].parentName = result[i].Parent.Name;
                                this.accountrecords.push(result[i]);
                    }
                    console.log('records==>' + JSON.stringify(this.accountrecords));
                }
                if(result.length == 0){
                    this.accountrecords = undefined;
                    this.isShowModal = true;
                }
            })
            .catch((error) => {
                console.log('error while fetch Accounts --> ' + JSON.stringify(error));
            });
    }


    hideModalBox(){
        this.isShowModal = false;
    }
}