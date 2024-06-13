import { LightningElement, wire } from 'lwc';
import {IsConsoleNavigation, openTab} from 'lightning/platformWorkspaceApi'

export default class OpenNewConsoleTab extends LightningElement {
    
    @wire(IsConsoleNavigation)
    isConsoleNavigation


    openNewConsoleTabWithRecordId(){
        if(this.isConsoleNavigation){
            openTab({
                recordId : '0015g00000PFC2aAAH',
                label : 'Account Record',
                focus : true

            }).catch(error =>{
                console.error('can not open the tab => ', error)
            })
        }
    }

    openNewConsoleTabWithURL(){
        if(this.isConsoleNavigation){
            openTab({
                url : 'lightning/r/Account/0015g00000PFC2aAAH/view',
                label : 'Account Record URL',
                focus : true

            }).catch(error =>{
                console.error('can not open the tab => ', error)
            })
        }
    }

    openNewConsoleTabWithPageRef(){
        if(this.isConsoleNavigation){
            openTab({
                pageReference:{
                    type:'standard__objectPage',
                    attributes:{
                         objectApiName:'Account',
                         actionName:'list'
                    }
                },
                label : 'Accounts List',
                focus : true

            }).catch(error =>{
                console.error('can not open the tab => ', error)
            })
        }
    }



}