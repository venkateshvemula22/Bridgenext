import { LightningElement } from 'lwc';

export default class StandardLookupFieldDemo extends LightningElement {

    // filter = {
    //     criteria: [
    //         {
    //             fieldPath: 'Rating',
    //             operator: 'eq',
    //             value: 'Warm'
    //         },
    //         {
    //             fieldPath: 'Rating',
    //             operator: 'eq',
    //             value: 'Cold'
    //         }
    //     ],
    //     filterLogic: '1 OR 2'
    // };

    displayInfo = {
        additionalFields: ['Rating']
    }

    matchingInfo = {
        primaryField: { fieldPath: 'Rating' },
        additionalFields: [ { fieldPath: 'Phone' } ]
    }

    recordId = '0015g00000XBPFdAAP';
    
    handleChane(event){
        this.recordId = event.detail.recordId
        console.log('recordId => ', this.recordId)
    }
}