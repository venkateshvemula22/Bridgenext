public class Sep23rd_Class_Collections {
    list<integer> numList = new list<integer>{24,26};
        list<string> strlist = new list<string>{'Venkat'};
            list<boolean> bool = new list<boolean>{true,false};
                list<Account> acc = new list<Account>{new Account(name='mohan')};
                    list<student__c> std = new list<student__c>{new student__c(name='vlr')};
        
        public Sep23rd_Class_Collections(){
            account acc1 = new account();
            acc1.name = 'Naveen';
            account acc2 = new account();
            acc2.Name = 'TOSCA';
            account acc3 = new account();
            acc3.Name = 'Srinivas';
            acc.add(acc1);
            acc.add(acc2);
            acc.add(acc3);
            system.debug('acc== ' + acc);
            myintmethod();
            mystrmethod();
            myboolmethod();
            mystdmethod();           
            system.debug('std== ' + std);
            system.debug('numList== ' + numList);
            system.debug('strlist== ' + strlist);
            system.debug('bool== ' + bool);
           // insert acc;
            insert std;
            
                              
        }
    public void myintmethod(){
        numList.add(46);
        numList.add(100);      
    }
    public void mystrmethod(){
        strlist.add('Sandeep');
        strlist.add('Power BI');
    }
    public void myboolmethod(){
        bool.add(true);
        bool.add(true);
    }
    public void mystdmethod(){
        student__c std1 = new student__c();
        std1.name = 'Venkatesh';
        std1.Course__c='SFDC';
        student__c std2 = new student__c();
        std2.name = 'Salesforce learner';
        std2.Course__c='developer';
        student__c std3 = new student__c();
        std3.name = 'Power Bi';
        std3.Course__c='Salesforce';
        std.add(std1);
        std.add(std2);
        std.add(std3);
        
    }
}