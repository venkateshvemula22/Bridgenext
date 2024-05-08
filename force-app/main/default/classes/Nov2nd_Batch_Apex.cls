public class Nov2nd_Batch_Apex implements Database.Batchable<sobject> {
    public Nov2nd_Batch_Apex(){
        
    }
    
    public string mymethod(){
        return 'hello';
        
    }
    public database.QueryLocator START(database.BatchableContext dbc){
        string soqlQuery = 'select Id,Name,Industry,Site,Description from Account';
        database.QueryLocator dc = database.getQueryLocator(soqlQuery);
        return dc;
    }
    public void EXECUTE(database.BatchableContext dbc,list<Account> acclist){
        for(Account ac : acclist){
            ac.Description = 'This Description is inserted by Nov2nd_Batch_Apex class';
        }
        update acclist;
    }
    public void FINISH(database.BatchableContext dbc){
        system.debug('Execution is completed== ');
    }

}