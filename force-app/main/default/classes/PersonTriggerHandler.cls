public class PersonTriggerHandler {
    
    public static void handleBeforeInsert(list<Person__c> personsBI )
    {
        system.debug('before insert called... ' + personsBI[0].Name);
        list<account> accList;
        map<string, Person__c> PersonMAP = new map<string, Person__c>();
        map<string, account> accountMAP = new map<string, account>();
        set<string> accNameKeys = new set<string>();
        for(person__c p : personsBI)
        {
            if(p.PAN_Card_Number__c != null){
                accNameKeys.add(p.PAN_Card_Number__c);
                system.debug('accNameKeys => ' + accNameKeys);
            }
        }
        if(accNameKeys.size()>0){
            system.debug('accNameKeys size => ' + accNameKeys.size());
            list<account> accountList = [SELECT Id, Name FROM Account WHERE Name IN: accNameKeys];
            accList = accountList.size() > 0 ?  accountList : new list<account>();
            system.debug('accList => ' + accList);
            for(Person__c per : personsBI) 
            {
                if(accList.size()>0){
                    for(account ac : accList)
                    {
                        if(per.PAN_Card_Number__c == ac.Name){
                            PersonMAP.put(ac.Name, per);
                            system.debug('acname: ' + ac.Name);
                        }
                    }
                }
                else {
                    account acc = new account();
                    acc.Name = per.PAN_Card_Number__c;
                    acc.Phone = per.Phone__c;
                    acc.Description = string.valueOf(per.Adhar_Number__c);
                    accList.add(acc);
                    PersonMAP.put(per.PAN_Card_Number__c, per);
                }
            }
        }
        
        if(!accList.isEmpty()) {
            upsert accList;
            
            for(account ac : accList) 
            {
                accountMAP.put(ac.Name,ac);
            }
            for(Person__c person : PersonMAP.values()) 
            {
                If(accountMAP.containsKey(person.PAN_Card_Number__c)) 
                {
                    person.Account__c = accountMAP.get(person.PAN_Card_Number__c).Id;
                    
                }
            }
        }
    }
    
    public static void handleBeforeUpdate(list<Person__c> personsBU )
    {
        
    }
    
    public static void handleAfterInsert(list<Person__c> personsAI )
    {
        set<Id> accIds = new set<Id>();
        for(person__c p : personsAI) {
            accIds.add(p.account__c);
            publishPlatformEvent(p.Id, 'Created', p.CreatedById);
        }
        list<contact> conlist = new list<contact>();
        List<Account> acclist = [select Id, Name from account where Id =:accIds];
        for(Person__c person : personsAI) {
            contact con = new contact();
            con.LastName = person.Name;
            con.FirstName = ' Contact';
            con.Phone = person.Phone__c;
            con.Person__c = person.Id;
            for(account acc : acclist) {
                if(person.Account__c == acc.id)
                    con.AccountId = acc.Id;
            }
            conlist.add(con);
        }
        if(!conlist.isEmpty()) {
            insert conlist;
        }
    }
    
    public static void handleAfterUpdate(Map<Id,Person__c> personsNewMap, Map<Id,Person__c> personsOldMap)
    {
        list<contact> cons = new list<contact>();
        set<Id> personIds = new set<Id>();
        
        personIds.addAll(personsNewMap.keySet());
        list<contact> conlist = [select Id, FirstName, LastName,Phone, Person__c from contact where Person__c =: personIds];
        for(person__c per : personsNewMap.values()) {
            
            publishPlatformEvent(per.Id, 'Updated', per.CreatedById);
            
            for(person__c person : personsOldMap.values()) {
                if(per.Phone__c != person.Phone__c) {
                    for(contact cont : conlist) {
                        if(cont.Person__c == per.Id){
                            cont.Phone = per.Phone__c;
                            cons.add(cont);
                        }
                    }
                }
            }
        }
        update cons;
    }
    
    public static void handleAfterDelete(list<Person__c> personsOld) 
    {
        for(person__c per : personsOld) {
            
            publishPlatformEvent(per.Id, 'Deleted', per.CreatedById);
            
        }
    }
    
    public static void handleAfterUnDelete(list<Person__c> personsNew) 
    {
        for(person__c per : personsNew) {
            
            publishPlatformEvent(per.Id, 'UnDeleted', per.CreatedById);
            
        }
    }
    
    
    public static void publishPlatformEvent(string recordId,string action, string currentUserId) 
    {
        List<personCreatedEvent__e> eventsToPublish = new List<personCreatedEvent__e>();
        personCreatedEvent__e event = new personCreatedEvent__e(
                                                                    eSub_recordId__c = recordId,
                                                                    Action__c = action,
                                                                    sObject_Type__c = 'Person__c',
                                                                    UserId__c = currentUserId,
                                                                    Timestamp__c = System.now()
                                                                );
        system.debug('event => ' + event);
        eventsToPublish.add(event);
        
        if (!eventsToPublish.isEmpty()) {
            List<Database.SaveResult> results = EventBus.publish(eventsToPublish);
            
            for (Database.SaveResult sr : results) {
                if (sr.isSuccess()) {
                    System.debug('Successfully published event.');
                } else {
                    for(Database.Error err : sr.getErrors()) {
                        System.debug('Error returned: ' + err.getStatusCode() );
                    }
                }
            }
        }
    }
    
}