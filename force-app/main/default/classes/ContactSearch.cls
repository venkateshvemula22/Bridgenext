public class ContactSearch {
    public static List<Contact> searchForContacts(String firstString, String secondString){
        List<Contact> conList = [SELECT Id, Name FROM Contact WHERE LastName =: firstString OR MailingPostalCode =: secondString];
        system.debug('conList => ' + conList);
        return conList;      
    }
}