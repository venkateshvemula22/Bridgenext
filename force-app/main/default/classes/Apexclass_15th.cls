public class Apexclass_15th {
    public integer batchsize=118;
    public Account acc = new Account();
    public student__c std = new student__c(id='a005g000030cUOp');
    public Course__c cur = new Course__c();
    
    public Apexclass_15th(){
        system.debug('acc==' + acc); //empty
        
        cur.Name = 'DummyCourse_from_Apex_class';
        /*acc.Name = 'VLR Training';
        acc.Site = 'Hyderabad';
        acc.BillingCity = 'Hyd';
        acc.BillingCountry = 'India';
        acc.BillingPostalCode = '556633';
        acc.BillingState = 'Telangana';
        acc.BillingStreet = 'Ameerpet';
        system.debug('acc==' + acc); //VLR Training
        insert acc;*/
        //mystdcreation();
        system.debug('Course== ' + cur);
        insert cur;
    }
    
    public void mystdcreation(){
       /* std.Name='Mohan std1';
        std.State__c= 'Telangana';
        std.course_fees__c=25000;
        std.Country__c='India';
        std.Course__c='a035g0000039J66';
        std.student_phone__c='8106267957';
        std.student_email__c='mohan@gmail.com';
       
        system.debug('std==' + std);*/
        
        update std;
    }
}