@RestResource(urlMapping='/v1/account/*')
global with sharing class IntegrationDemo1 {

    @httpGet
    global static wrapperclass accountInformation() {
        RestRequest req = RestContext.request;
        string RequestURI = req.RequestURI;
        string accId = RequestURI.subStringAfterLast('/');
        
        list<account> accList = [SELECT Id, Name, Rating, Industry, Phone FROM Account WHERE Id =: accId];
        list<contact> conlist = [SELECT Name, Phone, Email, AccountId FROM contact WHERE AccountId =: accId];
        list<case> clist = [SELECT caseNumber, Subject, Description, AccountId FROM case WHERE AccountId =: accId];
        
        wrapperclass wrap = new wrapperclass();
        try {
            if(!accList.isEmpty()) {
                wrap.ac = accList[0];
                wrap.contactlist = conlist;
                wrap.caselist = clist;
                wrap.message = 'Account fetched successfully...!';
            }
            
        } catch (Exception ex) {
            wrap.message = 'Account not fetched because of the following reason = ' + ex.getMessage();
        }
        
        return wrap;
    }
    @httpPost
    global static accountResponseWrapper insertAccountRecord() {
        
        RestRequest request = RestContext.request;
        Blob breq = request.requestbody;
        System.debug('breq ==> ' + breq);
        string orginalrequestBody = breq.toString();
        System.debug('orginalrequestBody ==  ' + orginalrequestBody);
        Object obj = JSON.deserialize(orginalrequestBody, accountRequestWrapper.class);

        accountRequestWrapper accreqwrap = (accountRequestWrapper)obj;

        account acc = new account();
        acc.Name = accreqwrap.name;
        acc.Type = accreqwrap.type;
        acc.Industry = accreqwrap.industry;
        acc.Rating = accreqwrap.rating;
        acc.Phone = accreqwrap.phone;

        accountResponseWrapper accrespwrap = new accountResponseWrapper();
         try {
            insert acc;
            accrespwrap.accountRecord = acc;
            accrespwrap.message = 'Account record inserted successfully.....!';
         } catch (Exception ex) {
            accrespwrap.message = 'Account record not inserted because of the following error => ' + ex.getMessage();
         }

        return accrespwrap;

    }

    @httpPatch
    global static accountUpdateRespwrapper updateAccountRecord() {
        
        RestRequest req = RestContext.request;
        string RequestURI = req.RequestURI;
        string accId = RequestURI.subStringAfterLast('/');

        string actualRequest = req.requestbody.tostring();
        system.debug('actualRequest => ' + actualRequest);
        list<accountUpdateReqwrapper> wrapperList = (list<accountUpdateReqwrapper>)JSON.deserialize(actualRequest, list<accountUpdateReqwrapper>.class);
        system.debug('wrapperList => ' + wrapperList);
        set<string> accIds = new set<string>();
        for (accountUpdateReqwrapper wrap : wrapperList) {
            accIds.add(wrap.id);
        }
        system.debug('accIds => ' + accIds);
        list<account> accList = [SELECT Id, Name, Rating, Industry, Phone, Type FROM Account WHERE Id IN : accIds];
        system.debug('accList => ' + accList);
        //Update account
        accountUpdateRespwrapper accupdaterespwrap = new accountUpdateRespwrapper();
        list<Account> accountsToUpdate = new list<Account>();
        for (accountUpdateReqwrapper wrp : wrapperList) {
                account ac = new account();
                ac.Id = wrp.id;
                ac.Name = wrp.name;
                ac.Rating = wrp.rating;
                ac.Industry = wrp.industry;
                ac.Phone = wrp.phone;
                ac.Type = wrp.type;
				system.debug('ac = > ' + ac);
                accountsToUpdate.add(ac);
        }
        try {
            if (!accList.isEmpty()) {
                update accountsToUpdate;
                accupdaterespwrap.accounts = accountsToUpdate;
                accupdaterespwrap.msg = 'Accounts updated successfully..';
            }
        } catch (Exception ex) {
            accupdaterespwrap.msg = 'Accounts are not updated because of the following reason = ' + ex.getMessage();
        }

        return accupdaterespwrap;

    }
    @httpDelete
    global static accountDeleteRespwrapper deleteAccountRcod() {
        RestRequest request = Restcontext.request;
        string accId = request.RequestURI.subStringAfterLast('/');
        account acc = [SELECT Id, Name, Rating, Industry, Phone, Type FROM Account WHERE Id =: accId LIMIT 1];
        
        accountDeleteRespwrapper wrapper = new accountDeleteRespwrapper();
        try {
            if(acc != null){
            delete acc;
            wrapper.acct = acc;
            wrapper.message = 'Account deleted successfully => ' + acc.Id;
        }
        }catch(exception ex) {
            wrapper.message = 'Unable to delete the account because of the following reason => ' + ex.getMessage();
        }
        
        return wrapper;
    }

   // Get method Wrapper class
    global class wrapperclass {
        global string message;
        global account ac;
        global list<contact> contactlist;
        global list<case> caselist;
    }
    // Post method wrapper classes
    global class accountRequestWrapper {
         public string name;
         public string type;
         public string industry;
         public string rating;
         public string phone;
    }

    global class accountResponseWrapper {
        global string message;
        global account accountRecord;
    }

    // Patch method wrapper class

    global class accountUpdateReqwrapper {
        public string id;
         public string name;
         public string rating;
         public string industry;
         public string phone;
         public string type;
    }

    global class accountUpdateRespwrapper {

         public list<account> accounts;
         public string msg;
    }
    
    // delete account records
    global class accountDeleteRespwrapper {

        public account acct;
        public string message;
   }
}