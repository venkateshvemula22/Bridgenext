public class Sep21st_SOQLClass1 {
public string topicName = 'SOQL Salesforce';
    public Sep21st_SOQLClass1(){
        //mymeth();
        mystmethod();
    }
    public void mymeth(){
        list<student__c> std = new list<student__c>();
        std = [select name,Country__c,course_fees__c,courses_joined__c,current_course_status__c,Is_Fee_Paid__c,Course__c,State__c,student_email__c,student_phone__c from student__c where Country__c = 'India' or Country__c = 'USA'];        
        for(student__c stud : std){
            system.debug('stud==  ' + stud.Name + '  ' + stud.Country__c);
        }
    }
    public void mystmethod(){
        list<student__c> st = new list<student__c>();
        st = [SELECT Name,Country__c,Parent_Batch__r.Course__r.Owner.Profile.name,Parent_Batch__r.Course__r.Owner.name FROM student__c ];
        for(student__c so : st){
            system.debug('StOwner=== ' + so.Parent_Batch__r.Course__r.Owner.Profile.name + '  ' + 'CourseOwnerName== ' + so.Parent_Batch__r.Course__r.owner.name);
        }
    }
}