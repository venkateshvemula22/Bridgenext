public class Sep26th_SetsandLists {
    public set<Account> acc = new set<Account>();
    public list<Account> accl = new list<Account>();
    public list<contact> con = new list<contact>();
    public set<contact> con1 = new set<contact>();
    
    public Sep26th_SetsandLists(){
        accl = [select name from Account];
        for(Account ac : accl){
            acc.add(ac);
          
        }
         system.debug('acc== ' + acc); 
        conmethod();
    }
    public void conmethod(){
        con = [select id,name from contact];
        for(contact c : con){
            con1.add(c);
        }
        system.debug('con1== ' + con1);
    }

}