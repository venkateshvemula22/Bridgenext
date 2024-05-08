import { LightningElement, wire } from 'lwc';
import getAccRecords from '@salesforce/apex/WireFetchAccoutRecords.accountsList';

export default class WireAccountRecordsList extends LightningElement {

    searchKey;
    errormsg;
    noDatamsg;
    accdata;
    accdatalen;
    @wire(getAccRecords,{str : '$searchKey'}) 
    accounts({data, error}){  //Function type variable
        debugger
          if (data) {
           this.accdatalen =  data.length > 0 ? true : false;
            this.accdata = data;
            this.noDatamsg  = data.length == 0 ? 'There is No data found with the search key. Please try giving different key.' : undefined;
          }else if(error){
            this.errormsg = error.body.message;
          }
    };  

       /* @wire(getAccRecords,{str : '$searchKey'}) 
    accounts;  //property type variable
    
    
    
handleClik(){
        var keyis = this.template.querySelector('[data-inp="search"]');
        if(keyis.value.length >= 3){
            this.searchKey = keyis.value;
        }

    }  */

    handleChange(event){
        
        if(event.target.value.length >= 4){

            this.searchKey = event.target.value; 

        }
        

    }
}