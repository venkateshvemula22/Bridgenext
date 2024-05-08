public with sharing class ImperativeAccController {

    @AuraEnabled
    public static list<Opportunity> getOptyList(string stg){
        try {
            return [SELECT Id, Name, StageName From Opportunity WHERE StageName =: stg];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}