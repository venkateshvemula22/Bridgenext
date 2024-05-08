({
    doInit : function(cmp, event, helper) {
        var ob = cmp.get('c.fetchconts');
        var AccCount = cmp.set('v.AcCount',ob.length);
        ob.setCallback(this,function(resp){
            if(resp.getState() == 'SUCCESS'){
                debugger;
                var orgList = resp.getReturnValue();
                cmp.set('v.orgresp',orgList);
                
            }
        });
        $A.enqueueAction(ob);
    },
    
    Savedfunc : function(comp, event, helper){
        var some = comp.get('v.orgresp');
        var act = comp.get('c.AccList');
        act.setParams({
            'acc' : some
        });
        $A.enqueueAction(act);
        act.setCallback(this,function(respo){
            if(respo.getState() == 'SUCCESS'){
                debugger;
                var reslt = respo.getReturnValue();
                comp.set('v.resultstatus',reslt);
            }else if(respo.getState() == 'ERROR'){
                debugger;
                var reslt = respo.getReturnValue();
                comp.set('v.resultstatus',reslt);
            }
            
        });
        
    }
})