public class AccountSequenceClass {
    public static void afterinsret(list<account> triggernew,map<id,account> triggernewmap){
        date dtt = system.today()+30;
        //InsertAccounnts.createOpportunity(triggernew);
        //AccountHandler.insertContacts(triggernew);
    }
    public static void afterUpdate(list<account> triggernew,map<id,account> triggernewmap,list<account> triggerold,map<id,account> triggeroldmap){
        //InsertAccounnts.updateContacts(triggernew,triggeroldmap);
    }
}