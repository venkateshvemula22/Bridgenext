public class contactSequenceController {
    public static void afterinsert(list<Contact> triggernew){
        //collect all parent accountid's where contacts are inserting.
        set<id> accountIdset = new set<id>(); 
        for(contact con : triggernew){
            accountIdset.add(con.AccountId);
        }
        contactLogicController.updateAccounts(accountIdset);
    }
    public static void afterupdate(list<Contact> triggernew, map<id,contact> triggeroldmap){
        //collect all accountids from contacts which are updating
        set<id> accountIdSet = new set<id>();
        for(contact con : triggernew){
            contact oldContact = triggeroldmap.get(con.Id);   //map<id,contact>
            if(con.AccountId != oldContact.AccountId){
                accountIdSet.add(con.AccountId);
                accountIdSet.add(oldContact.AccountId);
            }
            contactLogicController.updateAccounts(accountIdSet);
        }
    }
    public static void afterdelete(list<contact> triggerold){
        //collect all parent accountid's fot the contacts which are getting deleted.
        set<id> accountIdset = new set<id>();
        for(contact con : triggerold){
            accountIdset.add(con.AccountId);
        }
        contactLogicController.updateAccounts(accountIdset);
    }
    public static void afterundelete(list<Contact> triggernew){
        //collect all accountids from contacts which are undeleting
        set<id> accidSet = new set<id>();
        for(contact co : triggernew){
            accidSet.add(co.AccountId);
        }
        contactLogicController.updateAccounts(accidSet);
        
    }
    
}