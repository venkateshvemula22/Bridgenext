({
	doInit : function(component, event, helper) {
        debugger;
        var acclist = component.get('c.fetchAccounts');  //Step-1:: Apex Method calling 
        acclist.setCallback(this,function(resp){        //Step-3:: Response Capturing
            if(resp.getState() == 'SUCCESS'){
                debugger;
                var acl = resp.getReturnValue();     //Original response from apex method
                component.set('v.acobjList',acl);   //Moving data from js to aura component
            }else if(resp.getState() == 'ERROR'){
                debugger;
            }
            
        });
        $A.enqueueAction(acclist);  //Step-2:: Event firing  
	}
})