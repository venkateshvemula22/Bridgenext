public class AccountHandler {
    
    public static void insertContacts(list<account> acclist){
        list<contact> newConlist = new list<contact>();
        for (account acc  : acclist) {
            contact newCon = new contact();
            newCon.LastName = acc.Name;
            newCon.FirstName = 'Contact';
            newCon.accountId = acc.Id;
            newConlist.add(newCon);
        }
        if(!newConlist.isempty()){
            try{
                insert newConlist;
            }catch(DmlException ex){
                System.debug('The following exception has occurred: ' + ex.getMessage());
            }
        }
    }
}