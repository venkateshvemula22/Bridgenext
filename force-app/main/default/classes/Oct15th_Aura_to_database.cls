public class Oct15th_Aura_to_database {
    
    @AuraEnabled
    public static list<Account> fetchconts(){
        return [select id,name,Site,Industry from Account];
    }
    
    @AuraEnabled
    public static string AccList(list<Account> acc){
        string result = '';
        try{
            update acc;
            result = 'Updated successfully';
        }catch(exception e){
            result = 'Error is ::: ' + e.getMessage() + ' Linenumber is:: ' + e.getLineNumber(); 
        }
        return result;
    }

}