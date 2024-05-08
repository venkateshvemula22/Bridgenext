public class InsertAccounnts {
    
    public static void createOpportunity(list<account> triggernew){
        list<opportunity> opties = new list<opportunity>();
        list<opportunity> oldOptyList = [SELECT id,Name FROM opportunity];
        
        for(account ac : triggernew){
            for(opportunity op : oldOptyList){
                if(ac.Name != op.Name){
                    for(integer i=1;i<=2;i++){
                        string opName = 'AccTriggeropty_' + i + ' - '+  ac.Name;
                        opportunity op1 = createOpty(opName,'Prospecting',ac.Id);
                        opties.add(op1);
                    }
                }else{
                    system.debug('duplicate record found with the Opportunity Name = ' + op.Name);
                }
            }  
        }
        insert opties;
    }
    // This method is to prepare the opportunity record data.
    public static opportunity createOpty(string name,string Stage,Id accId){
        opportunity op = new opportunity();
        op.Name = name;
        op.StageName = Stage;
        op.AccountId = accId;
        op.CloseDate = system.today()+20;
        return op;
    }
    
    public static void updateContacts(list<account> triggernew,map<id,account> triggeroldmap){
        map<id,string> accidphoneMap = new map<id,string>();  //Map account id and phone
        for(account acc : triggernew){
            account oldMap = triggeroldmap.get(acc.id); //collects the old data of the updated records
            string oldPhoneNumber = oldMap.Phone;       //phone number before update
            string newPhoneNumber = acc.Phone;         //phone number after update
            if(oldPhoneNumber != newPhoneNumber){     //if both are not equal then
                accidphoneMap.put(acc.id,acc.Phone); //collect the new phone  number
            }
        }
        if(!accidphoneMap.isempty()){
            //fetch all child contacts for above accounnts and  update the phone
            //list<contact> contactList = [select Id,Name,Phone,accountId from contact where accountId IN:trigger.new.keySet()];
            list<contact> contactList = [select Id,Name,Phone,accountId from contact where accountId IN:accidphoneMap.keySet()];
            for(contact c : contactList){
                c.Phone = accidphoneMap.get(c.accountId);
                system.debug('after update=== '); //to check weather the code is executed or not.
                update contactList;
            }
        }
    }
}