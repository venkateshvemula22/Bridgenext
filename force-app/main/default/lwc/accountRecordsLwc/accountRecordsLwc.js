import {LightningElement, api} from 'lwc';
//import  getAccounts from '@salesforce/apex/AccountRecordsCntrl.fetchAccounts';
import { NavigationMixin } from 'lightning/navigation';

export default class PersonRecordsLwc extends NavigationMixin(LightningElement) {
    
    // JS Properties 
    pageSizeOptions = [5, 10, 25, 50, 75, 100]; 
    @api records = []; 
    columns = []; 
    totalRecords = 0; 
    pageSize;
    totalPages;
    pageNumber = 1;
    recordsToDisplay = [];
    isLastPage = false;
    
    

    get bDisableFirst() {
        return this.pageNumber == 1;
    }

    get bDisableLast() {
        return this.pageNumber == this.totalPages;
        
    }

    // connectedCallback method called when the element is inserted into a document
    connectedCallback() {
        // set datatable columns info
        this.columns = [{
                label: 'Name',
                fieldName: 'Name',
                type: 'button',
                typeAttributes: {label: {fieldName: 'Name'}, name: 'urlredirect', variant: 'base'}
            },
            {
                label: 'Industry',
                fieldName: 'Industry'
            },
            {
                label: 'Rating',
                fieldName: 'Rating'
            },
            {
                label: 'Annual Revenue',
                fieldName: 'AnnualRevenue'
            },
            {
                label: 'Phone',
                fieldName: 'Phone'
            },
            {
                label: 'Parent Account',
                fieldName: 'parentName'
            }
            
        ];
        if(this.records){
                    this.totalRecords = this.records.length;                 
                    this.pageSize = this.pageSizeOptions[0]; 
                    this.paginationHelper(); 
        }
    }

    handleRecordsPerPage(event) {
        this.pageSize = event.target.value;
        if(this.pageSize >= this.records.length){
            this.isLastPage = true;
        }
        this.paginationHelper();
    }

    previousPage() {
        this.pageNumber = this.pageNumber - 1;
        this.paginationHelper();
    }

    nextPage() {
        this.pageNumber = this.pageNumber + 1;
        this.paginationHelper();
        if(this.pageNumber == this.totalPages){
            this.isLastPage = true;
        }
    }

    firstPage() {
        this.pageNumber = 1;
        this.paginationHelper();
    }

    lastPage() {
        this.pageNumber = this.totalPages;
        this.paginationHelper();
        this.isLastPage = true;
    }

    // JS function to handel pagination logic 
    paginationHelper() {
        this.recordsToDisplay = [];
        // calculate total pages
        this.totalPages = Math.ceil(this.totalRecords / this.pageSize);
        // set page number 
        if (this.pageNumber <= 1) {
            this.pageNumber = 1;
        } else if (this.pageNumber >= this.totalPages) {
            this.pageNumber = this.totalPages;
        }

        // set records to display on current page 
        for (let i = (this.pageNumber - 1) * this.pageSize; i < this.pageNumber * this.pageSize; i++) {
            if (i === this.totalRecords) {
                break;
            }
            this.recordsToDisplay.push(this.records[i]);
        }
    }

    handleRowAction(event){
        const actionname = event.detail.action.name;
        const row = event.detail.row;

        switch (actionname) {
            case 'urlredirect':
                this.showRowDetails(row, 'Account');
                break;
            default:
        }
    }

    //navigate to account record page
    showRowDetails(row, objName) {
        const recordId = row.Id
        this[NavigationMixin.GenerateUrl]({
            type: 'standard__recordPage',
            attributes:{
                recordId: recordId,
                objectApiName: objName,
                actionName: 'view'

            }
        }).then(url => {
            window.open(url, '_blank');
        });
    }

    hideModalBox(){
        this.isLastPage = false;
    }
}