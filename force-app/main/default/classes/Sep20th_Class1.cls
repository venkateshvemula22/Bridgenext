//class for For Loop concepts
public class Sep20th_Class1 {
    public account acc = new account();
    public integer i = 0,j=5;
    
    public Sep20th_Class1(){
        for(i=0;i<=j;i++){
            account acc= new account();
            acc.Name = mymeth('Sample_test ',i);
            acc.site = (i<3) ? 'hyderabad' : 'Banglore';
            insert acc;
        }
    }

public string mymeth(string st,integer ie){
    string str =  st + ie;   
    system.debug('str== ' + str);
    return str;
    
    
}
}