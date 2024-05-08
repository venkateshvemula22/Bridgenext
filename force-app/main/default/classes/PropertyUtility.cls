public class PropertyUtility {
    Public static void newListedProperties(){
        String propEmail;
        List<Property__c> newPropList = [SELECT Name,Broker__r.Email__c,Days_On_Market__c FROM Property__c WHERE Days_On_Market__c <= 30];
        for(Property__c prop: newPropList){
            propEmail = prop.Name + ' : ' + prop.Broker__r.Email__c;
        }
         system.debug('propEmail' + propEmail);
    }
    
}