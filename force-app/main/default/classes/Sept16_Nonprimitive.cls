public class Sept16_Nonprimitive {
    public string staff = 'Mohan';
    public Account acc = new Account(Name='Name',Active__c='Yes',SLAExpirationDate__c=system.today(),SLA__c='Gold',SLASerialNumber__c='1245');
    public  Student__c std;
    public Sept16_Nonprimitive(){
        std = new Student__c(id='a005g000030ccaH');
        std.Name= 'kumar_Apex';
        std.Country__c ='India';
        std.joining_date__c = system.today()-30;
        std.Course__c = 'a035g000003F179';
        system.debug('acc==' + acc);
        system.debug('std==' + std);
        
        update std;
    }
    
}