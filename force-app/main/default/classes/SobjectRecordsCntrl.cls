public class SobjectRecordsCntrl {
	@AuraEnabled
    public static list<Sobject> getObjectRecords(string objectName, list<string> fieldsList, integer recordsLimit){             
        
        String fields = String.join(fieldsList, ',');
        system.debug('fields => '+ fields);
        string queryString = 'SELECT Id, ' + fields + ' FROM ' + objectName + ' LIMIT ' + recordsLimit;
        system.debug('queryString => '+ queryString);
        return Database.query(queryString);
    }
}