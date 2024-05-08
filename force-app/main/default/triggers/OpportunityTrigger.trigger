trigger OpportunityTrigger on Opportunity (before insert, after insert, before update, after update, before delete, after delete, after undelete) {
    
    Switch On Trigger.operationType {
        
        when AFTER_INSERT 
        {
            OpportunityTriggerHandler.handleAfterInsert(Trigger.new);
        }
        
        when AFTER_UPDATE 
        {
           OpportunityTriggerHandler.handleAfterUpdate(Trigger.newMap, Trigger.oldMap);
        }
    }
}