//printing students names and emails from student object
public class Sep23rd_ClassStudentobj {
    public list<string> stdemail = new list<string>();
    public list<string> stdName = new list<string>();
    public Sep23rd_ClassStudentobj(){
        list<student__c> std = new list<student__c>();
        std = [select id,name,student_email__c from student__c where student_email__c != null];
        for(student__c st : std){
            stdemail.add(st.student_email__c);
        }
        for(student__c sn : std){
            stdName.add(sn.Name);
        }
        system.debug('stdName== ' + stdName);
        system.debug('stdemail== ' + stdemail);
    }

}