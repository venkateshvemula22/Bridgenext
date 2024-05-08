public class Sep16th_Nonprim {
     public account acc = new account();
    public  contact con;
    public Sep16th_Nonprim(){
        system.debug('acc== ' + acc);//empty
        system.debug('con== ' + con);//empty
        acc = mymethod();
        system.debug('acc== ' + acc);//[acc== Account{Name=S.Nithin,Phone=95648752155}]
        
    }
    public Account mymethod(){
        Account acc1 = new Account();
        acc1.Name = 'S.Nithin';
        acc1.Phone = '95648752155';
        system.debug('acc1== ' + acc1);//[acc1== Account{Name=S.Nithin,Phone=95648752155}]
        return acc1;
    }
}