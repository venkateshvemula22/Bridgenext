import { LightningElement } from 'lwc';
import pubsub from 'c/pubsub';
import students from '@salesforce/apex/StudentsList.listofStudents';
export default class PubSubPublisher extends LightningElement 
{
    studentlist=[];
    errMsg;
    recordValue;


    handleClick() {
        const name = this.template.querySelector('lightning-input').value

        students({recordType : name})
                                    .then(result => {
                                        this.studentlist = result;
                                        debugger
                                        pubsub.fire('studList',this.studentlist);
                                    })
                                    .catch(err => {
                                        this.errMsg = err.getMessage();
                                     })

    }
  
//      message =   { 
//                         "Name" : "Venkatesh",
//                         "Surname" : "Vemula",
//                         "From" : "Hyderabad",
//                         "Phone" : "8106267957"
//                     };
// handleClick() {
//     pubsub.fire('MyDetails',this.message);
//               }
       

}