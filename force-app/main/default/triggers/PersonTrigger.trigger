trigger PersonTrigger on Person__c (before insert, after insert, before update, after update, before delete, after delete, after undelete) {
    
    SWITCH ON Trigger.operationType 
    {
        WHEN BEFORE_INSERT 
        {
            PersonTriggerHandler.handleBeforeInsert(trigger.new);
        }
        WHEN AFTER_INSERT 
        {
            PersonTriggerHandler.handleAfterInsert(trigger.new);
        }
        WHEN AFTER_UPDATE 
        {
            PersonTriggerHandler.handleAfterUpdate(trigger.newMap, trigger.oldMap);
        }
        WHEN AFTER_DELETE 
        {
            PersonTriggerHandler.handleAfterDelete(trigger.old);
        }
        WHEN AFTER_UNDELETE 
        {
            PersonTriggerHandler.handleAfterUnDelete(trigger.new);
        }
    }
    
    }