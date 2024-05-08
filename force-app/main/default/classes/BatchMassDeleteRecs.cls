public class BatchMassDeleteRecs Implements Database.batchable<sobject>{
     
     public Database.QueryLocator start(Database.BatchableContext BC){
       string query = 'select id from contact';
      return Database.getQueryLocator(query);
     }
     public void execute(Database.BatchableContext BC,List<SObject> scope){
         system.debug('size => ' + scope.size());
         delete scope;
    
    }
    public void finish(Database.BatchableContext BC){
        system.debug('records deleted successfully...!');
    }

 }