public with sharing class WirePassArgmntsToApex {

    @AuraEnabled(cacheable=true)
    public static string getstringfromLWC(string str, integer num){
        try {
            return  str + ' - ' + num;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
}