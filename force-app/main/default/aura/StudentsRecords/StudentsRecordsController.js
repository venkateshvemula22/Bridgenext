({
    doinit : function(component, event, helper) {
        
        var stdlist = component.get('c.DisplayStdRecords');
        stdlist.setCallback(this,function(response){
            if(response.getState() == 'SUCCESS'){
                var st = response.getReturnValue();
                component.set('v.StudentList', st);
            }
            else if(response.getState() == 'ERROR'){
                debugger;
            }
        });
        $A.enqueueAction(stdlist);
    }
})