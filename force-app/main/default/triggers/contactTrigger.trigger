trigger contactTrigger on Contact (before insert, after insert,after update,after delete,after undelete) {
    
   
    if(trigger.isafter){
        if(trigger.isinsert){
            contactSequenceController.afterinsert(trigger.new);
            }
        else if(trigger.isupdate){
            contactSequenceController.afterupdate(trigger.new,trigger.oldmap);
            }
        else if(trigger.isdelete){
            contactSequenceController.afterdelete(trigger.old);
        }else{//Undelete
            contactSequenceController.afterundelete(trigger.new);
        }
    }
}