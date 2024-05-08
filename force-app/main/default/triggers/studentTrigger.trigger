trigger studentTrigger on student__c (before insert,after insert,before update,after update,before delete,after delete, after undelete) {
    if(trigger.isbefore){
        if(trigger.isinsert){
            system.debug('trigger insert== ' + trigger.new);
        }else if(trigger.isupdate){
            system.debug('trigger update== ' );
        }else{
            system.debug('trigger delete== ');
        }
    }else{
        if(trigger.isinsert){
            system.debug('trigger insert== ' + trigger.new);
        }else if(trigger.isupdate){
            system.debug('trigger update== ' );
        }else if(trigger.isdelete){
            system.debug('trigger delete== ');
        }else{
            system.debug('trigger undelete== ');
        }
    }
    
}