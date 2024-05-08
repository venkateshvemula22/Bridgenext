public class Sep17th_AccClass1 {
    //class level variables
    public Account acc;
    public contact con;
    public opportunity op = new opportunity();
    public lead ld = new lead();
    public integer staff;
    public string str;
    //constructor
    public Sep17th_AccClass1(){
        acc = new Account();
        staff = 120;
        str = 'VENKATESH';
        system.debug('acc==' + acc + ' ' + 'staff==' + staff + ' ' + 'str==' + str );//mt,120 ,ven 
        leadrecord();
        acc.Name = ld.Name;
        system.debug('acc== ' + acc );//np
        conrecord();
        system.debug('Email== ' + con.Email);//narayana@gmail.com
        
    }
    public lead leadrecord(){
        ld.LastName = 'Narayana Perumandla';
        ld.City = 'Hyderabad';
        ld.Email = 'narayana@gmail.com';
        ld.Company = 'CTS';
        ld.Status = 'Working - Contacted';
        system.debug('ld=== ' + ld);//lead details
        insert ld;
        return ld;
        
    }
    public contact conrecord(){
       con = new contact();
        con.Email = ld.Email;
        return con;
        
    }
}