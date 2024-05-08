import { LightningElement } from 'lwc';
import getAccRecords from '@salesforce/apex/WireFetchAccoutRecords.accountsListimperative';

export default class AccListImperativeMethod extends LightningElement {

    accdatalen;
    accdata;
    errormsg;
    noDatamsg;

    handleChange(event){

        let searchKey = event.target.value;
        if(searchKey.length >= 3){
            getAccRecords({'str' : searchKey})
                          .then((response) =>{
                            this.accdatalen = response.length > 0 ? true : false; 
                            this.accdata = response;
                            this.noDatamsg = response.length == 0 ? 'There is No data found with the search key. Please try giving different key.' : undefined;
                            this.errormsg = undefined;
                          })
                          .catch((err) => {
                            this.errormsg = err;
                            this.accdata = undefined;
                          })

        }

        



    }
}