public class BulkStudentUpdateBatch implements Database.Batchable<sObject> {
    
    public Database.QueryLocator start(Database.BatchableContext bc) 
    {
        string query = 'select Name,Total_course_fee__c from student__c';
        
        
        return Database.getQueryLocator(query);
        
    }
    public void execute(Database.BatchableContext bc, List<Student__c> scope)
    {
        For(student__c std : scope) {
            std.Total_course_fee__c = 50000;
        }
        update scope;
    }    
    public void finish(Database.BatchableContext bc)
    {
        
    } 

}