public class ManageStudentsController {
    
    @AuraEnabled
    public static list<Student__c> getAccounts(string accId) {
        list<Student__c> stds = [SELECT Id, account__r.Name, Contact__c, Country__c, course_fees__c, Is_Fee_Paid__c FROM Student__c WHERE Account__c =: accId];
        return stds;
    }
    
    @AuraEnabled
    public static void saveStudents(String studentsList,List<String> deleteStudentsIds) {
        List<Student__c> studntListToUpsert = (List<Student__c>) JSON.deserialize(studentsList, List<Student__c>.class);
        List<Student__c> studentListToDelete = new List<Student__c>();
         
        for(String stdId : deleteStudentsIds){
            studentListToDelete.add(new Student__c(Id = stdId));
        }
        if(studntListToUpsert.size()> 0){
            upsert studntListToUpsert;
        }
        if(studentListToDelete.size()> 0){
            delete studentListToDelete;
        }
    }

}