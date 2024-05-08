({
	auradisplayaction : function(cmp, event, helper) {
		cmp.set('v.isDisplay',true);
        cmp.set('v.aurabtn',true);
        cmp.set('v.sfdcbtn',false);
        
	},
    sfdcdisplayaction : function(cmp, event, helper) {
		cmp.set('v.isDisplay',false);
        cmp.set('v.aurabtn',false);
        cmp.set('v.sfdcbtn',true);
        
	}
})