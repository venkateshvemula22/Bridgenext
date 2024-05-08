trigger AccountAddressTrigger on Account (before insert, before update) {
    if(trigger.isinsert){
        if(trigger.isbefore){
             for(account a : trigger.new){
                if(a.Match_Billing_Address__c == TRUE){
                    a.ShippingPostalCode = a.BillingPostalCode; 
                }
            } 
        }    
    }
    else if(trigger.isupdate){
        if(trigger.isbefore){
            List<account> accountList1 = new List<Account>();
            for(account ac : trigger.new){
                if(ac.Match_Billing_Address__c == TRUE){
                    ac.ShippingPostalCode = ac.BillingPostalCode;
                 }
            } 
        }
    }
}