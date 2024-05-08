public class AccountUtility {
    
    Public static void viewAnnualRevenue(){
        string acctRev;
        List<Account> accountsList =[SELECT Name,AnnualRevenue FROM Account];
        for(Account acc: accountsList){
            acctRev = acc.Name + ' : ' + acc.AnnualRevenue;
        }
        system.debug('acctRev@' + acctRev);
    }

}