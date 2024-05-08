public class RandomContactFactory {
    public static List<contact> generateRandomContacts(Integer i, String FName) {
        List<contact> conList = new List<contact>();
        Integer n;        
        for(n=1;n<=i;n++){
            contact con = new contact();
            con.FirstName = String.valueOf(n);
            con.LastName = FName;
            insert con;
            conList.add(con);
        }
        system.debug('conList => ' + conList);
        return conList;
    }

}