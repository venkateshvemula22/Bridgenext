public class Oct14th_Apexcls2 {
    
    @AuraEnabled
    public static string saveaccount(account ac,string str,integer ie){
        string result = '';
        
        try{
            ac.NumberOfEmployees = ie;
            ac.Description = str;
            insert ac;
            result = 'account inserted with following id= ' + ac.Id ;
        }catch(exception e){
            result = e.getMessage();
        }
        return result;
    }

}