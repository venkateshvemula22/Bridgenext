/* 
   auther         : venkatesh vemula

   Description    : Creates the person record from the createPersonLWC component.

   LastModifiedBy : venkatesh vemula

 */
public with sharing class CreatePersonController {
    
    
	// this method is to get the payload from lwc and create Person record in the database then return success or error message.
	// used 2 return types string and map. one should be commented when testing other return type.
    @AuraEnabled
    public static Map<string, string> createPerson(string payload) 
    {
        system.debug('payload ==> ' + payload);
        PersonWrapper pr = (PersonWrapper) system.JSON.deserialize(payload,PersonWrapper.class);
        system.debug('person ==> ' + pr);
        String Message;
        Map<string, string> msg = new Map<string, string>();
        
        list<Person__c> personList = new list<Person__c>();
        Person__c p = new Person__c();
        
        p.Adhar_Number__c = pr.AdharNumber;
        p.PAN_Card_Number__c = pr.PanNumber;
        p.Name = pr.Name;
        p.Phone__c = pr.Phone;
        p.Email__c = pr.Email;
        if(pr.DOB != null || pr.DOB != '')
        {
            p.Date_Of_Birth__c = Date.valueOf(pr.DOB);
        }
        personList.add(p);
        
        /*
         // string returntype code..
        if(!personList.isEmpty())
        {
            try {
                system.debug('personList ==> ' + personList[0]);
                insert personList;
                Message = 'Person Record Created Successfully....! With Name = '+ personList[0].Name;
                system.debug('Message ==> ' + Message);
            }
            Catch(exception ex) 
            {
                Message = 'Error => ' + ex.getMessage();
                system.debug('Error Message ==> ' + Message);
            }
            
        }
		*/
        // Map returntype code..
        if(!personList.isEmpty())
        {
            try {
                system.debug('personList ==> ' + personList[0]);
                insert personList;
                msg.put('Success', 'Name = ' + personList[0].Name);
                system.debug('Age ==> ' + personList[0].Age__c);
                //sendEmail(personList[0].Id);
            }
            Catch(exception ex) 
            {
                msg.put('Error', ex.getMessage());
                system.debug('Error Message ==> ' + msg);
            }
    	}
        return msg;
   }
    
    public static string sendEmail(String perId)
    {
        Person__c person = [SELECT Id, Name, Date_Of_Birth__c, Age__c, Email__c, Adhar_Number__c FROM Person__c where Id =: perId];
        string message;
        string cc = 'venkateshvemula943@gmail.com';
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.toAddresses = new String[] {person.Email__c};
		email.Subject =  person.Name + ' - Created Record for You';
        email.plainTextBody  = 'Hi ' + person.Name + ',\n \n' + 'Your Details Recorded in our DataBase Successfully....!' + '\n\n' + 'Your Age is : ' + person.Age__c + '\n' +'Date Of Birth : ' + person.Date_Of_Birth__c;
        email.ccAddresses = new String[] {cc};

        Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {email};
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        
        if (results[0].success) 
        {
            System.debug('The email was sent successfully.');
        } else {
            System.debug('The email failed to send: ' + results[0].errors[0].message);
        } 
        
        return message;
    }

    public class PersonWrapper
    {
        @AuraEnabled public String AdharNumber;
        @AuraEnabled public String PanNumber;
        @AuraEnabled public String Phone;
        @AuraEnabled public String Name;
        @AuraEnabled public String Email;
        @AuraEnabled public String DOB;

    }
}