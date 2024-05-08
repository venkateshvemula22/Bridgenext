/*({
    init: function (cmp, event, helper) {
        cmp.set('v.columns', [
            {label: 'STUDENT NAME', fieldName: 'STUDENTNAME', type: 'text'},
            {label: 'PENDING FEE', fieldName: 'PENDINGFEE', type: 'currency'}
           
        ]);

        var fetchData = {
            opportunityName: "company.companyName",
            accountName : "name.findName",
            closeDate : "date.future",
            amount : "finance.amount",
            contact: "internet.email",
            phone : "phone.phoneNumber",
            website : "internet.url",
            status : {type : "helpers.randomize", values : [ 'Pending', 'Approved', 'Complete', 'Closed' ] },
            actionLabel : {type : "helpers.randomize", values : [ 'Approve', 'Complete', 'Close', 'Closed' ]},
            confidenceDeltaIcon : {type : "helpers.randomize", values : [ 'utility:up', 'utility:down' ]}
        };


        helper.fetchData(cmp, fetchData, 10);
    }
});  */

({
	doInit : function(component, event, helper) {
        debugger;
        var indstdlist = component.get('c.listofIndianStudents');  //Step-1:: Apex Method calling 
        indstdlist.setCallback(this,function(resp){        //Step-3:: Response Capturing
            if(resp.getState() == 'SUCCESS'){
                debugger;
                var stdlist = resp.getReturnValue();     //Original response from apex method
                component.set('v.indianStudentsList',stdlist);   //Moving data from js to aura component
            }else if(resp.getState() == 'ERROR'){
                debugger;
            }
            
        });
        $A.enqueueAction(indstdlist);  //Step-2:: Event firing  
	}
})