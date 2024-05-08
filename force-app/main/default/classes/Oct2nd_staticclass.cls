public class Oct2nd_staticclass {
    public static list<string> str = new list<string>{'karthik','raju','laddu','naveen'};
    public static string st = 'mohan';
    public Oct2nd_staticclass(){
        str.add(st);
        system.debug('str=== ' + str);
    }
    public static account mytestclass(){
        list<account> acc = [select id,name from account where Industry = 'technology'];
        system.debug('acc== ' + acc);
        return new account();
         
        
    }

}