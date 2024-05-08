import { LightningElement, track } from 'lwc';
import insertAcc from '@salesforce/apex/CreateNewAccountRecord.saveAccountRecord';
import insertAccts from '@salesforce/apex/CreateNewAccountRecord.saveAccountRecords';

export default class CreateNewAccountRecord extends LightningElement {

    @track showMessage = [];
    errorMessage;
    accountRecord =[];

    addAccountRecord(){
        debugger
        let accName = this.template.querySelector('[data-inp1="accName"]').value;
        let site = this.template.querySelector('[data-inp2="site"]').value;
        let Industry = this.template.querySelector('[data-inp3="industry"]').value;

        this.accountRecord.push({
            Name : accName,
            Site : site,
            Industry : Industry
        })
        this.template.querySelector('[data-inp1="accName"]').value = '';
        this.template.querySelector('[data-inp2="site"]').value = '';
        this.template.querySelector('[data-inp3="industry"]').value = '';
    }

    saveAccountRecords(){
        debugger
       /* let accName = this.template.querySelector('[data-inp1="accName"]').value;
        let site = this.template.querySelector('[data-inp2="site"]').value;
        let Industry = this.template.querySelector('[data-inp3="industry"]').value;
        let accountRecord ={
            Name: accName,
            Site : site,
            Industry : Industry
        } 

        this.accountRecord.Name = accName;
        this.accountRecord.Site = site;
        this.accountRecord.Industry = Industry;  */
        

        insertAccts({'accts' : this.accountRecord})
                                        .then( resp => {
                                            debugger
                                            for(var i=0;i<resp.length;i++){
                                                this.showMessage.push(resp[i].Id + ' ' + resp[i].Name +'\n');
                                            }
                                            this.errorMessage = undefined;

                                        }).catch( err => {
                                            debugger
                                            this.errorMessage = err;
                                            this.showMessage = undefined;

                                        })

    }


}