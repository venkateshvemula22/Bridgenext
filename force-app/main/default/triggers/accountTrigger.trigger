trigger accountTrigger on Account (after insert,after update) { 
    
    system.debug('Operation Type => ' + trigger.operationType);
    
    switch on trigger.operationType {
        when AFTER_INSERT {
            AccountSequenceClass.afterinsret(trigger.new,trigger.newmap);
        }
        when AFTER_UPDATE {
            AccountSequenceClass.afterUpdate(trigger.new,trigger.newmap,trigger.old,trigger.oldmap);
        }
        
    }
    
}