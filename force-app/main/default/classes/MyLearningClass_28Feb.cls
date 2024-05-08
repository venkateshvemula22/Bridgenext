public class MyLearningClass_28Feb {
    integer stdCount;
    public Void myStudentCount(){
        list<student__c> Std = new list<student__c>();
        Std = [SELECT Name, student_phone__c 
               FROM student__c 
               WHERE student_phone__c != NULL AND RecordTypeId =: 'Indian_students'];
        
        stdCount = Std.size();
        system.debug(Std);
        system.debug('Student Count is = ' + stdCount);
    }
    public void stdRecordInsert(){
        student__c st = new student__c();
        st.Name = 'Mahesh Gunolla2';
        st.Country__c = 'India';
        st.Course__c = 'a035g000004y2umAAA';
        st.student_phone__c = '8106267957';
        st.student_email__c = 'mahesh.gunolla22@gmail.com';
        INSERT st; 
        /* student__c stupdate = new student__c();
        stupdate.Id = 'a005g000032PLgsAAG';
        //stupdate.student_phone__c = '6302661519';
        DELETE stupdate; */
    }
}