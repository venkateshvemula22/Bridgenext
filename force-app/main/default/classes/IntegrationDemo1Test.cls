@isTest
public class IntegrationDemo1Test {
    
    @TestSetup
    public static void accountInformationTest(){
        
        list<account> accList = new list<account>();
        list<contact> contactList = new list<contact>();
        list<case> caseList = new list<case>();
        
        for(integer i=0; i<=3; i++){
            account acc =new account();
            acc.Name = 'Test account ' + i;
            acc.Type = 'Prospect';
            acc.Phone = '9550453228';
            if(i == 1 || i==3){
                acc.Rating = 'Hot';
                acc.Industry = 'Banking';
            }else{
                acc.Rating = 'Warm';
                acc.Industry = 'Agriculture';
            }
            accList.add(acc);
        }
        if(!accList.isEmpty()){
            insert accList;
        } 
        
        for(account ac : accList){
            
            contact con = new contact();
            con.AccountId = ac.Id;
            con.LastName = ac.Name + 'contact';
            con.Phone = '8106267957';
            con.Email = 'testcontact@test.com';
            contactList.add(con);
        }
        for(account ac : accList){
            
            case cs = new case();
            cs.AccountId = ac.Id;
            cs.Subject = ac.Name;
            cs.Description = 'test case for the account => ' + ac.Name;
            caseList.add(cs);
        }
        if(!contactList.isEmpty()){
            insert contactList;
        }
        if(!caseList.isEmpty()){
            insert caseList;
        }
        
    }
    
    static testMethod void testGet() {
        //do request
        account aclist = [select id, name, rating, industry, type, phone from account limit 1];
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = 'https://vlrcom3-dev-ed.my.salesforce.com/services/apexrest/v1/account/' + aclist.Id;  
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;
        IntegrationDemo1.wrapperclass results = IntegrationDemo1.accountInformation();
        
    }
    
    @isTest
    public static void testPost(){
        list<account> aclist = [select id, name, rating, industry, type, phone from account];
        
        RestRequest req = new RestRequest();
        String myJSON = JSON.serializePretty(aclist[0]);
        req.requestBody = Blob.valueof(myJSON);
        RestResponse res = new RestResponse();
        
        req.requestURI = 'https://vlrcom3-dev-ed.my.salesforce.com/services/apexrest/v1/account/' + aclist[0].Id;  
        req.httpMethod = 'POST';
        RestContext.request = req;
        RestContext.response = res;
        IntegrationDemo1.accountResponseWrapper results = IntegrationDemo1.insertAccountRecord();
        
    }
    
    @isTest
    public static void testPatch2(){
        list<account> aclist = [select id, name, rating, industry, type, phone from account limit 2];
        
        RestRequest req = new RestRequest();
        String myJSON = JSON.serializePretty(aclist);
        req.requestBody = Blob.valueof(myJSON);
        RestResponse res = new RestResponse();
        
        req.requestURI = 'https://vlrcom3-dev-ed.my.salesforce.com/services/apexrest/v1/account/' + aclist[0].Id;  
        req.httpMethod = 'PATCH';
        RestContext.request = req;
        RestContext.response = res;
        IntegrationDemo1.accountUpdateRespwrapper results = IntegrationDemo1.updateAccountRecord();
        
    }
    
    static testMethod void testDelete() {
        //do request
        account aclist = [select id, name, rating, industry, type, phone from account limit 1];
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = 'https://vlrcom3-dev-ed.my.salesforce.com/services/apexrest/v1/account/' + aclist.Id;  
        req.httpMethod = 'DELETE';
        RestContext.request = req;
        RestContext.response = res;
        IntegrationDemo1.accountDeleteRespwrapper results = IntegrationDemo1.deleteAccountRcod();
        
    }
    
}