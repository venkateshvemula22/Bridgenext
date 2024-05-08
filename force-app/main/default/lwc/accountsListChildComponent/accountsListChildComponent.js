import { LightningElement, api, track } from 'lwc';


const COLUMNS = [
    {label:'Id', fieldName: 'Id', type: 'text' },          
    {label:'Account Name', fieldName: 'Name', type: 'text', editable: true, sortable: true }, 
    {label:'Industry', fieldName: 'Industry', type: 'text',  editable: true, sortable: true} 
]

export default class AccountsListChildComponent extends LightningElement {
    @api accountData
    @track columns = COLUMNS;

    }