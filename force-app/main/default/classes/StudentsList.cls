public class StudentsList {
    
    @AuraEnabled
    public static List<student__c> listofStudents(string recordType) 
    {
        List<student__c> studentsList = [SELECT Name, Pending_fee_is__c, RecordType.Name FROM student__c where RecordType.Name =: recordType];
        system.debug('studentsList--->' + studentsList);
        return studentsList;
    }

}