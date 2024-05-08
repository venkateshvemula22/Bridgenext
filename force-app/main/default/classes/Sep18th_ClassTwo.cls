public class Sep18th_ClassTwo {
    public string st;
    public integer num;
    public boolean IsfeePaid = true;
    public opportunity opp = new opportunity();
    public account acc1;
    Sep18th_ClassOne se = new Sep18th_ClassOne();
    public Sep18th_ClassTwo(){
        
        acc1 = new account();
        acc1.Name = 'suresh';
        st = acc1.Name;
        system.debug('st== ' + st);
        myopp();
        system.debug('opp== ' + myopp());
    }
    public opportunity myopp(){
        se.myAccmethod();
        opp.Name = acc1.Name;
        opp.Amount = 15000;
        system.debug('opp== ' + opp);      
        return opp;
    }
}