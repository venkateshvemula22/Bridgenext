public class DisplayStudentRecords {
    
    @AuraEnabled
    public static List<student__c> DisplayStdRecords(){
        List<student__c> studentList = [SELECT Name, student_email__c, student_phone__c, Course__r.Name, Roll_Number_del__c 
                                        FROM student__c 
                                        WHERE student_phone__c != NULL
                                        ORDER BY Roll_Number_del__c ASC];
        system.debug('studentList== ' + studentList);
        RETURN studentList;
    }

}