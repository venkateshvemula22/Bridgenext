public with sharing class WireExampleApex1 {

    @AuraEnabled(cacheable=true)
    public static string getstdName(){
        try {

            return 'Reyaansh Vemula \n Venkatesh Vemula';
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
}