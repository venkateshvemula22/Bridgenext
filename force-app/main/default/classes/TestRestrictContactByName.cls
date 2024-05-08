@isTest
public class TestRestrictContactByName {
    @isTest
    public static void testmethod1(){
        contact con = new contact();
        con.FirstName = 'Sai';
        con.LastName = 'INVALIDNAME';
        insert con;
    }
}