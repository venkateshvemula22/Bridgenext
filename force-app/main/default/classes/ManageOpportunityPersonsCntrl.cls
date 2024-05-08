public class ManageOpportunityPersonsCntrl {
    
    @AuraEnabled
    public static list<Person__c> getOppPersons(String oppId)
    {
        return [SELECT Id, Opportunity__c, Name, Adhar_Number__c, Date_Of_Birth__c, Email__c, Phone__c, PAN_Card_Number__c FROM Person__c  WHERE Opportunity__c =: oppId];
    }
    
    @AuraEnabled
    public static void saveOppPersons(String oppPersonsList,List<String> deleteOppPersonsIds)
    {
        List<Person__c> oppPersonsListToUpsert = (List<Person__c>) JSON.deserialize(oppPersonsList, List<Person__c>.class);
        List<Person__c> oppPersonsListToDelete = new List<Person__c>();
         
        for(String oppPersonId : deleteOppPersonsIds){
            oppPersonsListToDelete.add(new Person__c(Id = oppPersonId));
        }
        if(oppPersonsListToUpsert.size()> 0){
            upsert oppPersonsListToUpsert;
        }
        if(oppPersonsListToDelete.size()> 0){
            delete oppPersonsListToDelete;
        }
    }

}