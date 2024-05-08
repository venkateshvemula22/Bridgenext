public with sharing class PersonRecordsListCntrl 
{

    @AuraEnabled(cacheable=true)
    public static list<Person__c> getPersonsList(String field, String sortOrder)
    {
        String query;
        query  = 'select Id, Name, Account__r.Id, Account__r.Name, Adhar_Number__c, PAN_Card_Number__c, Phone__c, Email__c, Date_Of_Birth__c, Age__c from Person__c';
        if(field != null && sortOrder !=null){
            query += ' ORDER BY ' + field + ' ' + sortOrder;
        }
        system.debug('query => ' + query);
        return Database.query(query);
    }
}