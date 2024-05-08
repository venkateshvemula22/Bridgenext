public with sharing class WireFetchAccoutRecords {


 @AuraEnabled(cacheable=true)
 public static account getaccountrecord(string str){
    string accName = '%' + str + '%';
        account acc = [SELECT Id, Name FROM Account WHERE Name LIKE:accName LIMIT 1];
        return acc;
    }

  @AuraEnabled(cacheable=true)  //For wired services
  public static List<wrappercls> accountsList(string str){
    string searchName = '%'+ str + '%';
    List<wrappercls> wrapList = new List<wrappercls>();

    try {
      List<account> accList = [SELECT Id, Name, Industry,IsPersonAccount, AnnualRevenue FROM Account WHERE Name LIKE:searchName];
        
      for(account ac: accList){
        wrappercls wrp = new wrappercls();
        wrp.id = ac.Id;
        wrp.accname = ac.Name;
        wrp.industry = ac.Industry;
        wrp.isPersonaccount = ac.IsPersonAccount;
        wrp.annualRevenue = ac.AnnualRevenue;
        wrapList.add(wrp);
      }

        return wrapList;
    } catch (Exception e) {
        throw new AuraHandledException(e.getMessage() + ' - ' + e.getCause());
    }
  }

  @AuraEnabled //For imperative services
  public static List<wrappercls> accountsListimperative(string str){
    string searchName = '%'+ str + '%';
    List<wrappercls> wrapList = new List<wrappercls>();

    try {
      List<account> accList = [SELECT Id, Name, Industry,IsPersonAccount, AnnualRevenue FROM Account WHERE Name LIKE:searchName];
        
      for(account ac: accList){
        wrappercls wrp = new wrappercls();
        wrp.id = ac.Id;
        wrp.accname = ac.Name;
        wrp.industry = ac.Industry;
        wrp.isPersonaccount = ac.IsPersonAccount;
        wrp.annualRevenue = ac.AnnualRevenue;
        wrapList.add(wrp);
      }

        return wrapList;
    } catch (Exception e) {
        throw new AuraHandledException(e.getMessage() + ' - ' + e.getCause());
    }
  }

  //list of account records for LWC Parent to child communication
  @AuraEnabled(cacheable=true)  
  public static List<account> accountsListLWCPtoC(){
    try {
      return [SELECT Id, Name, Industry FROM Account WHERE Industry != null LIMIT 10];
        
    } catch (Exception e) {
        throw new AuraHandledException(e.getMessage() + ' - ' + e.getCause());
    }
  }

  public class wrappercls{
    @AuraEnabled public string id;
    @AuraEnabled public string accname;
    @AuraEnabled public string industry;
    @AuraEnabled public boolean isPersonaccount;
    @AuraEnabled public Decimal annualRevenue;
  }
}