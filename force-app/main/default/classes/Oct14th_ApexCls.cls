public class Oct14th_ApexCls {
    
    @AuraEnabled
    public static list<account> fetchAccounts(){
         list<account> acList =  [select id,name,site,industry,rating from account order by Name ASC];
        system.debug('acList== ' + acList.size());
        return aclist;
    }
    @future
    public static void myFuturemethod(){
        account acc = new account();
        
    }
    

}