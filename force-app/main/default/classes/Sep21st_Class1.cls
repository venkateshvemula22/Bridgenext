public class Sep21st_Class1 {
    public string clasdName = 'SOQL Salesforce';
    public Sep21st_Class1(){
        mysoqlmethod();
        
    }
    public void mysoqlmethod(){
        list<account> acc = new list<account>();
        acc = [SELECT id,Name,site,BillingCountry,BillingCity,AnnualRevenue FROM Account];
           // system.debug('acc== ' + acc);
        for(account ac : acc){
            system.debug('ac== ' + ac);
            
        }
    }
    
}