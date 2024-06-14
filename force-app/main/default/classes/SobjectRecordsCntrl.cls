/*  @Created By: venkatesh vemula
 *  @Created Date : 04-05-2024
 *  @Last Modified : 09-05-2024
 *  @Test Class : SobjectListCntrlTest  
 *  @Description : Get objects and thier fields dynamically and show the records in a data table.
*/
public with sharing class SobjectRecordsCntrl {
    
    //This Method will be called using wire adapter from LWC and returns available entities (objects) in Map<objectApiName, objectName> to lwc component. 
    @AuraEnabled(Cacheable=true)
    public static Map<String,String> getObjects(){
        
        list<String> ObjNames = new list<String>{'Account', 'Contact', 'Opportunity', 'Lead', 'Person__c', 'Student__c','Stage_Duration__c', 'Staff__c', 'Assignment__c', 'Broker__c', 'Course__c', 'Credit__c', 'Debt__c', 'Energy_Audit__c'};
        Map<String,String> objectMap = new Map<String,String>();
        for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values()){
           String name = objTyp.getDescribe().getName();
           String label = objTyp.getDescribe().getLabel();
           if( ObjNames.contains(name) 
                && objTyp.getDescribe().isAccessible() 
                && objTyp.getDescribe().getRecordTypeInfos().size() > 0){      
                objectMap.put(name,label);
           }
        }
		System.debug(objectMap);
        if(objectMap != null && objectMap.size() > 0){
            system.debug('objectMap => ' + objectMap);
        	return objectMap;   
        }else{
            return null;
        }
    }
    
    //This method will be called imperatively from lwc based on the running user inputs to get records of any given entity(object)
 /*
    @AuraEnabled
    public static list<Sobject> getObjectRecords(string objectName, list<string> fieldsList, integer recordsLimit){             
        
        String fields = String.join(fieldsList, ',');
        system.debug('fields => '+ fields);
        string queryString = 'SELECT Id, ' + fields + ' FROM ' + objectName + ' ORDER BY CreatedDate DESC LIMIT ' + recordsLimit;
        system.debug('queryString => '+ queryString);
        return Database.query(queryString);
    }  */
    
     
    @AuraEnabled
    public static list<Wrapper> getObjectRecords(string objectName, list<string> fieldsList, integer recordsLimit){             
        list<Wrapper> lstWrapper = new list<Wrapper>();
        String fields = String.join(fieldsList, ',');
        system.debug('fields => '+ fields);
        string queryString = 'SELECT Id, ' + fields + ' FROM ' + objectName + ' ORDER BY CreatedDate DESC LIMIT ' + recordsLimit;
        system.debug('queryString => '+ queryString);
        list<Sobject> lstobj= Database.query(queryString);
        system.debug('lstobj => '+ lstobj);
        id userid = userInfo.getUserId();
        for(Sobject obj : lstobj){
            UserRecordAccess seditible =[SELECT RecordId, HasEditAccess fROM UserRecordAccess WHERE UserId =:userid and RecordId =:obj.Id];
            Wrapper wrap = new Wrapper();
            wrap.Rec = obj;
            wrap.editable = seditible.HasEditAccess;
            lstWrapper.add(wrap);
        }
        system.debug('lstWrapper==>'+lstWrapper);
        return lstWrapper;
    }
     public class Wrapper{
        @AuraEnabled public Sobject Rec{get;set;}
        @AuraEnabled public boolean editable{get;set;}
    } 
    
    @AuraEnabled
    public static string deleteSobjectRecord(string recId, string objectName){
        string message;
        system.debug('recId==> '+ recId);
        system.debug('objectName==> '+ objectName);
        try{
            if(recId != null){
                string query = 'SELECT Id FROM ' + objectName + ' WHERE Id = \'' + recId + '\'';
                list<Sobject> record = Database.query(query);
                system.debug('record==> '+ record);
                Database.deleteResult[] srList = Database.delete(record, false);
                system.debug('srList==> '+ srList);
                if(!srList.isEmpty()){
                    message = 'Record Deleted Succefully.';
                }
            }
        }catch(exception ex){
            system.debug('Error==> '+ ex.getMessage());
            message = 'Error : ' + ex.getMessage();
        }
        
        return message;
    }
    
}