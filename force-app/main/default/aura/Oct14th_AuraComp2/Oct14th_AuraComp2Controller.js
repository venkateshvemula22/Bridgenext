({
	myAction : function(component, event, helper) {
        debugger;
		var acrec = component.get('v.accRec');
        var obj = component.get('c.saveaccount');
        obj.setParams({     //This method can accept only json object
            'ac' : acrec,
            'str':'hello world',
            'ie': 500
        });
        obj.setCallback(this,function(result){
            if(result.getState() == 'SUCCESS'){
                debugger;
                var represt = result.getReturnValue();
                component.set('v.resp',represt);
            }
            
        });
        $A.enqueueAction(obj);
	},
    
    resetme : function(comp,event,helper){
        debugger;
          comp.set('v.accRec',"");
}
})