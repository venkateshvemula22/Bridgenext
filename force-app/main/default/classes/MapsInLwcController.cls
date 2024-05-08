public with sharing class MapsInLwcController {

    @AuraEnabled(cacheable=true)
    public static list<account> getAccounts(){
       return [SELECT Id, Name, Description, BillingStreet, BillingCity, BillingState, BillingCountry, 
               BillingPostalCode FROM account WHERE CreatedDate <= 2021-07-20T00:06:08.000+0000 ORDER BY Name LIMIT 10];
    }
   
}