trigger StudentFeeTrigger on student__c (after insert, after update) {
    
    Student__C std = New Student__C();
    
    if(trigger.isafter){
        if(trigger.isinsert){
            std.Is_fee_more_than_30000__c = True;
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
        }else{
            system.debug('trigger undelete== ');
        }
    }
}