public class contactLogicController {
    public static void updateAccounts(set<id> accountIdset){
        //query all above accouunts and child contacts.
        list<account> accList = [select id,Name,(select id,Name from Contacts) from account where id IN:accountIdset];
        list<account> accFinalList = new list<account>();
        //Iterate all above accounts and insert them
        for(account ac : accList){
            account a = new account();
            a.id = ac.id;
            a.NumberOfContacts__c = ac.Contacts.size();
            accFinalList.add(a);
        }
        if(!accFinalList.isempty()){
            update accFinalList;
            
        }
    }
    
}