public with sharing class CreateNewAccountRecord {

    @AuraEnabled
    public static string saveAccountRecord(account acc ){

        try {
            insert acc;

            return acc.Name + ' - Account inserted Successfully with ID - ' + acc.Id;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }

    }


    @AuraEnabled
    public static list<account> saveAccountRecords(list<account> accts){

        try {
            insert accts;

            return accts;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }

    }
    
}