@isTest 
public class contactTrigger_Test {
    
    @isTest
    public static void contactRecordInsert(){
        //You should have an Account Recrd
        Account acc = new Account();
        acc.Name = 'Test_Class';
        acc.Rating = 'Hot';
        insert acc;
        
        //Create a contact record and add it parent account record
        Contact con = new contact();
        con.LastName = 'Test_class_contact';
        con.AccountId = acc.Id;
        insert con;
        
        //Check weather NumberOfContacts field on account record is updated properly or not
        List<Account> accList = [SELECT Id,Name,NumberOfContacts__c FROM Account]; 
        system.debug('accList== ' +accList);
        system.debug('accListSize== ' +accList.size());
        
        system.assertEquals(1, accList[0].NumberOfContacts__c, 'Operation Succssful');
        system.assert(1 == accList[0].NumberOfContacts__c, 'Test Passed');
      
    }
    public testmethod static void contactRecordUpdate(){
        
        
    }

}