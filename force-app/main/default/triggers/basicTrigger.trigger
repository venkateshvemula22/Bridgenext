trigger basicTrigger on student__c (before insert,before update,after insert,after update) {
    
    if(trigger.isbefore){
        system.debug('before trigger== ');
    }else{
        list<student__c> stdList = [select id from student__c where name like '%trigger%'] ;
        system.debug('after trigger== ' + stdList);
    }

}