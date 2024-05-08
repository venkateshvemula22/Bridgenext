public class Sep17th_Class_2 {
    //class level variables
    public string staff;
    public account ac;
    
    //constructorc2
    public Sep17th_Class_2(){
        system.debug('ac== ' + ac + 'staff== ' + staff);//null,null
        Sep17th_Class_1 c1 = new Sep17th_Class_1();
        ac = fetchacc(c1.str);//venky
        system.debug('ac== ' + ac + 'staff== ' + staff);//venky, venky
    }
    //method1c2
    public account fetchacc(string s){
        system.debug('ac== ' + ac + 'staff== ' + staff);//null,null
        account a = new account();
        a.Name = s;//venky
        staff = datamethod(a);//raju
        return a;
    }
    //method2c2
    public string datamethod(account acc){
        system.debug('ac== ' + ac + 'staff== ' + staff);//venky,stff= raju,hyd
        staff = acc.Name; //raju
        return staff;
    }
}