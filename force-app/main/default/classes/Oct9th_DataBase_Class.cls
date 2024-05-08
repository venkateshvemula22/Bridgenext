//Database Class to insert records into account object and check for the successful and unsuccessful insertion records.
public class Oct9th_DataBase_Class {
    public list<account> acc = new list<account>();
    public list<student__c> std = new list<student__c>();
    public list<Database.Error> errorList = new list<Database.Error>();  // orderOfexecution::::49,52,57,60,63,20,23,28,31,34
    public Oct9th_DataBase_Class(){
        stdmethod();
        account ac1 = new account();
        ac1.Name = 'Database_ClassApex_check2';
        ac1.Site = 'Chennai';
        ac1.SLAExpirationDate__c = date.today()-15;
        ac1.SLASerialNumber__c = '15895882';
        ac1.Rating = 'Cold';
        
        account ac2 = new account();
        ac2.Site = 'Bangalore';
        ac2.SLAExpirationDate__c = date.today()-20;
        acc.add(ac1);
        acc.add(ac2);
        system.debug('acc== ' + acc);
        Database.SaveResult[] saveRe =  database.insert(acc, false);
        set<string> succinsertedidset = new set<string>();
        system.debug('SaveResult== ' +  saveRe);
        
        for(database.SaveResult d : saveRe){
            if(d.isSuccess()){
                succinsertedidset.add(d.getId());
                system.debug('succinsertedidset== ' + succinsertedidset);
            }else{
                list<Database.Error> errorList = d.getErrors();
                system.debug('errorList== ' + errorList);
                for(Database.Error er : errorList){
                    list<string> erfieldNameList = er.getFields();
                    system.debug('erfieldNameList== ' + erfieldNameList);
                }
            }
        }
    }
    public void stdmethod(){
        student__c std1 = new student__c();
        std1.Name = 'checking_Database_ClassApex2';
        std1.Course__c = 'a035g0000039J66';
        
        student__c std2 = new student__c();
        std2.Name = 'Lenovo_database_apex';
        //std2.Course__c = 'a035g0000039J66';
        std.add(std1);
        std.add(std2);
        system.debug('std== ' + std);
        Database.SaveResult[] stdsaveRe =  database.insert(std, false);
        set<string> stdsuccinsertedidset = new set<string>();
        system.debug('stdsaveRe== ' +  stdsaveRe);
        
        for(database.SaveResult st : stdsaveRe){
            if(st.isSuccess()){
                stdsuccinsertedidset.add(st.getId());
                system.debug('stdsuccinsertedidset== ' + stdsuccinsertedidset);
            }else{
                list<Database.Error> stderrorList = st.getErrors();
                system.debug('stderrorList== ' + stderrorList);
                for(Database.Error err : stderrorList){
                    list<string> stderfieldNameList = err.getFields();
                    system.debug('stderfieldNameList== ' + stderfieldNameList);
                }
            }
        }
    }
    
}