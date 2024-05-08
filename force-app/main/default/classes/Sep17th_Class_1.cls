public class Sep17th_Class_1 {
    //class level variables
    public string location;
    public string str = 'Mohan';
    public account acc = new account(Name = 'venu', BillingCity = 'Hyderabad');
    opportunity oppo;
    
    //constructorc1
    public Sep17th_Class_1(){
        system.debug('acc== ' + acc + ' ' + '=== oppo== ' + oppo);//venu,hyderabad, null
        str = 'Venky';
        location = acc.BillingCity;//hyderabad
        system.debug('location==' + location + ' ' + 'str== ' + str);//hyderabad,venky
        acc = insertacc('raju');
        system.debug('oppo== ' + oppo + 'acc== ' + acc);//oppo={Sample one,200 }acc={raju,hyd}       
    }
    
    //Method1c1
    public account insertacc(string st){
        system.debug('location== ' + location + ' ' + 'str== ' + str);//hyderabad,venky
        system.debug('oppo ' + oppo + ' ' + 'acc== ' + acc);//null, venu,hyderabad
        acc.Name = st;
        oppo = bringoppo(200);
        system.debug('oppo ' + oppo + ' ' + 'acc== ' + acc);//oppo={Sample one,200 }acc={raju,hyd}
        return acc;
    }
    //Method2c1
    public Opportunity bringoppo(integer num){
        system.debug('location==' + location + '==str==' + str);//hyderabad,venky
        opportunity op = new opportunity();
        op.Name = 'Sample one';
        op.Amount = num;
        system.debug('oppo==' + oppo + '==acc==' + acc); //oppo=null,acc={raju,hyd}
        return op;
        
    }
    
}