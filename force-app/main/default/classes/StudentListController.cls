public with sharing class StudentListController {
    
    @AuraEnabled(cacheable=true)
    public static String GetStudentList(String objectName, String soqlQuery){
        Map<String, String> returnMap = new Map<String,String>();
        if(!String.isEmpty(objectName) && !String.isEmpty(soqlQuery)){
            SObject sObj = (SObject)(Type.forName('Schema.'+ objectName).newInstance());

            String query = 'SELECT ' + soqlQuery;
            query += ' FROM ' + objectName ;

            List<SObject> lstRecords = Database.query(query); 
            returnMap.put('RECORD_LIST', JSON.serialize(lstRecords));
            return JSON.serialize(returnMap);
        } 
        return null;  
    }

    @AuraEnabled
    public static string savearecords(object data){
        /*
        List<student__c> studentListToUpdate = ( List<student__c> ) JSON.Deserialize(
            JASON.Serialize(data),
            List<student__c>.class
        );
        
        try{
            
        }catch(exception e){
            result = e.getMessage();
        }
        return result;*/
        return null;
    }
}