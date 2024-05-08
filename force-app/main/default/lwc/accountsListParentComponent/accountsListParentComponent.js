import { LightningElement, wire } from 'lwc';
import getAccRecords from '@salesforce/apex/WireFetchAccoutRecords.accountsListLWCPtoC';
import { refreshApex } from '@salesforce/apex';

export default class AccountsListParentComponent extends LightningElement {

    accounts=[]

    @wire(getAccRecords)
    accountrecords({data, error}){
        this.accounts = data
    }
    /*
    @wire(getAccRecords)
    accountrecords({data, error}){
        if(data){ 
            console.log('data =>', JSON.stringify(data))
            let currentData = [];

            data.forEach((row) => {

                /* 
                * Creating the an empty object
                * To reslove "TypeError: 'set' on proxy: trap returned falsish for property"
                

                let rowData = {};

                rowData.Id = row.Id;
                rowData.Name = row.Name;
                rowData.Industry = row.Industry;
                currentData.push(rowData);
            });

            this.accounts = currentData;
            console.log('this.accounts =>', JSON.stringify(this.accounts))
        }
        }  */

        handleclick(){
            return refreshApex(this.accounts);
        }
}