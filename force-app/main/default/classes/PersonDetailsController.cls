public with sharing class PersonDetailsController {
    
    @AuraEnabled(cacheable=true)
    public static Person__c personDetails(String personName) {
        
        Person__c person = new Person__c();
        String QueryString = '%' + personName + '%';        
        try
        {
            person = [SELECT Id, Name, Phone__c, Adhar_Number__c, PAN_Card_Number__c, Email__c, Date_Of_Birth__c, Age__c FROM Person__c WHERE Name LIKE : QueryString LIMIT 1];
        } 
        catch (exception ex) {
            system.debug('error => ' + ex.getMessage());
            if(ex.getMessage() == 'List has no rows for assignment to SObject')
            {
                person.name = 'No Record Found';
            }
        }
        return person;
    }

}