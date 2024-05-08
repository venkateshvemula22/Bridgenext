import { LightningElement, wire, api, track } from 'lwc';
import getAccountsFollowedByCurrentUser from '@salesforce/apex/megacorpAccountController.getAccountsFollowedByCurrentUser';
import setAccountOwner from '@salesforce/apex/megacorpAccountController.setAccountOwner';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const columns = [
    {
        type: 'button',
        fixedWidth: 100,
        typeAttributes: {
            label: 'Select',
            name: 'select_account',
            title: 'Select Account',
            variant: 'base'
        }
    },
    { label: 'Account Name', fieldName: 'Name', type: 'text', sortable: true },
    { label: 'Industry', fieldName: 'Industry', type: 'text', sortable: true },
    { label: 'Phone', fieldName: 'Phone', type: 'phone', sortable: true },
    { label: 'Account Owner', fieldName: 'OwnerName', type: 'text', sortable: true },
    { label: 'Last Modified By', fieldName: 'LastModifiedByName', type: 'text', sortable: true },
    
];


export default class AccountFollowedTable extends LightningElement {
    @track data = [];
    @track columns = columns;
    @track sortedBy;
    @track sortedDirection = 'asc';
    @track selectedRows = [];
    @track isButtonDisabled = true;

    @wire(getAccountsFollowedByCurrentUser)
    wiredAccounts({ error, data }) {
        if (data) {
            this.data = data.map(account => ({
                ...account,
                OwnerName: account.Owner ? account.Owner.Name : '',
                LastModifiedByName: account.LastModifiedBy ? account.LastModifiedBy.Name : ''
            }));

        }else if (error) {
            console.error('Error fetching accounts:', error);
        }
    }

    handleSort(event) {
        this.sortedBy = event.detail.fieldName;
        this.sortedDirection = event.detail.sortDirection;
        this.sortData();
    }

    sortData() {
        const sortedData = [...this.data];
        sortedData.sort((a, b) => {
            let aValue = a[this.sortedBy] || '';
            let bValue = b[this.sortedBy] || '';
            return this.sortedDirection === 'asc'
                ? aValue.localeCompare(bValue, undefined, { numeric: true })
                : bValue.localeCompare(aValue, undefined, { numeric: true });
        });
        this.data = sortedData;
    }

    // handleRowAction(event) {
    //     debugger
    //     const action = event.detail.action;
    //     const row = event.detail.row;
    //     debugger
    //     console.log('row => ' + JSON.stringify(row));
    //     switch (action.name) {
    //         case 'select_account':
    //             this.handleSelection(row);
    //             break;
    //         default:
    //             break;
    //     }
    // }

    // handleSelection(row) {
    //     debugger
    //     const selectedRowIds = new Set(this.selectedRows);
    //     if (selectedRowIds.has(row.Id)) {
    //         selectedRowIds.delete(row.Id);
    //     } else {
    //         selectedRowIds.add(row.Id);
    //     }
    //     this.selectedRows = Array.from(selectedRowIds);
    //     this.isButtonDisabled = this.selectedRows.length === 0;
    // }

     handleRowAction(event) {
    //     //const row = this.template.querySelector("lightning-datatable").getSelectedRows();
    //     debugger
    //     const row = event.target.selectedRows;
    //     alert('handleRowSelection is called...' + JSON.stringify(row));
    //     console.log('row => ' + JSON.stringify(row));
    //     this.handleSelection(row);
        debugger
        const action = event.detail.action;
        const row = event.detail.row;
        debugger
        console.log('row => ' + JSON.stringify(row));
        this.handleSelection(row);
        
     }

    handleSelection(row) {
        debugger
        alert('handleSelection is called...' + JSON.stringify(row));
        const selectedRowIds = new Set(this.selectedRows);
        if (selectedRowIds.has(row.Id)) {
            selectedRowIds.delete(row.Id);
        } else {
            selectedRowIds.add(row.Id);
        }
        debugger
        this.selectedRows = Array.from(selectedRowIds);
        alert('selectedRowIds ==> ' + JSON.stringify(selectedRowIds));
        console.log('selectedRowIds == ' + selectedRowIds);
        console.log('selectedRows == ' , this.selectedRows);
        alert('selectedRows ==> ' + this.selectedRows);
        this.isButtonDisabled = this.selectedRows.length === 0;
        alert('isButtonDisabled ==> ' + this.isButtonDisabled);
        console.log('isButtonDisabled == ' + this.isButtonDisabled);
    }

    // handleRowAction(event) {
    //     alert('handleRowAction called....');
    //     const action = event.detail.action;
    //     alert('handleRowAction called....' + action.name);
    //     const row = event.detail.row;
    //     if (action.name === 'select_account') {
    //         this.handleSelection(row);
    //     }
    // }

    // handleSelection(row) {
    //     if (this.selectedRows.includes(row.Id)) {
    //         this.selectedRows = this.selectedRows.filter(id => id !== row.Id);
    //     } else {
    //         this.selectedRows.push(row.Id);
    //     }
    //     this.isButtonDisabled = this.selectedRows.length === 0;  
    // }

    handleSetAccountOwner() {
        // Call the Apex method to set the account owner
        setAccountOwner({ accountIds: this.selectedRows })
            .then(result => {
                // Handle successful response, if needed
                const successmsg = new ShowToastEvent({
                    title: 'Success!',
                    message: 'Owner updated successfully.....',
                    variant: 'success',
                    mode: 'dismissable'
                });
                this.dispatchEvent(successmsg);
            })
            .catch(error => {
                console.error('Error setting account owner:', error);
            });
            this.selectedRows = [];
    }
}