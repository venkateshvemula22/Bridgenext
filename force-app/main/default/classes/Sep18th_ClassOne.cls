public class Sep18th_ClassOne {
    public Account acc;
    public contact con;
    public opportunity oppo;
    public lead ld;
    public string str;
    public student__c std;
    
    public Sep18th_ClassOne(){
        acc = new Account();
        acc.Name = 'Shashi';
        myAccMethod2();
        str = acc.Name;
        system.debug('str== ' + str);
       myAccmethod();
    }
    public Sep18th_ClassOne(string std){
        string name = 'ramesh';
        integer num = 120;
    }
    public contact myAccmethod(){
        con = new contact();
        con.LastName = 'malaiah';
        con.Languages__c = 'Telugu';
        system.debug('con== '  + con);
        return con;
    }
    public lead myAccMethod2(){
        ld = new lead();
        ld.LastName = 'Vemula';
        ld.FirstName = 'Venkatesh';
        ld.Company = 'Cognizant';
        return ld;
    }
    
    }