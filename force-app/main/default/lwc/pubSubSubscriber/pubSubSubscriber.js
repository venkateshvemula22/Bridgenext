import { LightningElement } from 'lwc';
import pubsub from 'c/pubsub';
export default class PubSubSubscriber extends LightningElement 
{

    stdList;
    RecordType;
    length;
    connectedCallback() {
        debugger
                pubsub.register('studList', (response) => {
                    this.stdList = response;
                    if(this.stdList[0].RecordType.Name) {
                        this.RecordType = this.stdList[0].RecordType.Name;
                        this.length = this.stdList.length;
                    }
                });
            }
        




//     Message;

//     connectedCallback() {
//         pubsub.register('MyDetails', (response) => {
//             this.Message = response ? JSON.stringify(response,null,'\t') : 'Error getting message';
//         });
// }

}