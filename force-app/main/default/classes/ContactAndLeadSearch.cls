public class ContactAndLeadSearch {
    public ContactAndLeadSearch(){
        String soslFindClause = 'Smith';
        searchContactsAndLeads(soslFindClause);
    }
    public static List<List<sObject>> searchContactsAndLeads(String input){
        //String soslFindClause = 'Smith';
        //Lead le = [SELECT Id,LastName FROM Lead WHERE LastName='Smith' LIMIT 1];
        //Lead le = new Lead(FirstName = 'av', LastName = 'Smith', Email = 'email@gmail.com', Phone = '9876545637',Company = 'Emtec');
        //insert le;
        //contact le = [SELECT Id,LastName FROM contact WHERE LastName='Smith' LIMIT 1];
        //contact smith = new contact(FirstName='av',LastName='Smith');
        //insert smith;
        List<List<sObject>> searchList = [FIND :input IN ALL FIELDS RETURNING Lead(LastName),Contact(LastName)];
        Lead[] searchLead = (Lead[])searchList[0];
        Contact[] searchContacts = (Contact[])searchList[1];
        System.debug('Found the following accounts.' + searchLead);
        for (Lead a : searchLead) {
            System.debug(a.LastName);
        }
        System.debug('Found the following contacts.' + searchContacts);
        for (Contact c : searchContacts) {
            System.debug(c.LastName);
        }
        system.debug('searchList@@ ' + searchList);
        Return searchList;
    }
}