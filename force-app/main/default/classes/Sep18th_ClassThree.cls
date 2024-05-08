public class Sep18th_ClassThree {
    public string sr;
    public course__c cr;
    public  batch__c bt;
    public advertisement__c ads;
    public student__c std;
    
    public Sep18th_ClassThree(){
        std = new student__c();
        std.Name = 'SNithin';
        std.student_phone__c = '9562354668';
        std.Course__c = 'a035g000003F179';
        std.joining_date__c = system.today()-30;
        system.debug('std == ' + std);
        insert std;
        mybatches();
        system.debug('batch== ' + bt);
        bt.Course__c = 'a035g000003F179';
        update bt;
        string btid = bt.Id;
        system.debug('batch_id== ' + btid);
        Sep18th_ClassTwo se2 = new Sep18th_ClassTwo();
        se2.myopp();
    }
    public batch__c mybatches(){
        bt = new batch__c();
        bt.Id = 'a025g0000063SAo';
        bt.Name = 'SFDC_Old_Batch';
        bt.Is_active__c = false;
        return bt;
    }

}