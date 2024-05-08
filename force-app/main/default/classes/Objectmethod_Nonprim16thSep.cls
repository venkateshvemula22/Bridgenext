public class Objectmethod_Nonprim16thSep {
    Account acc = new Account();
    Student__c std = new Student__c();
    public Objectmethod_Nonprim16thSep(){
        stdmethod();
        std.joining_date__c = system.today();
        system.debug(std);//student__c:{course_fees__c=20000, current_country__c=India, State__c=Telangana, joining_date__c=2021-09-16 00:00:00}
        stdmethod();
    }
    
    public Student__c stdmethod(){
        std.course_fees__c = 20000;
        std.current_country__c = 'India';
        std.State__c = 'Telangana';
        system.debug(std);//FIRST_TIME::: student__c:{course_fees__c=20000, current_country__c=India, State__c=Telang
        return std;       //SECOND_TIME:: student__c:{course_fees__c=20000, current_country__c=India, State__c=Telangana, joining_date__c=2021-09-16 00:00:00}
    }
}