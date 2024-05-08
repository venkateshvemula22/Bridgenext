/* 
* @description        : Create and update Opportunity Stage Duration records.
 * @author            : Venkatesh Vemula(Wave6)
 * @group             : 
 * @last modified on  : 11-09-2023
 * @last modified by  : Venkatesh Vemula(Wave6)
*/
public class ManageStageDurationsController {
    
    public static string createStageDurations(List<Opportunity> newOpList) 
    {
        string message;
        List<Stage_Duration__c> SDList = new List<Stage_Duration__c>();
        
        for(Opportunity op : newOpList)
        {
            Stage_Duration__c sd = new Stage_Duration__c();
            sd.Name = op.StageName;
            sd.OwnerId = op.OwnerId;
            sd.Opportunity__c = op.Id;
            sd.Stage_Start_TimeStamp__c = op.LastModifiedDate;
            SDList.add(sd);
        }
        
        try
        {
            if(!SDList.isEmpty())
            {
                insert SDList;
                system.debug('SDList => ' + SDList);
                message = 'Stage Duration Record Inserted Successfully....!';
                system.debug('mesaage => ' + message);
            }
        } 
        catch(exception ex) {
            system.debug('Error => ' + ex.getMessage());
            message = 'Error - ' + ex.getMessage();
        }
        
        return message;
    }
    
    public static void updateStageDurations(Map<Id, Opportunity> newOpMap, Map<Id, Opportunity> oldOpMap)
    {
        List<Stage_Duration__c> SDListNew = new List<Stage_Duration__c>();
        List<Stage_Duration__c> SdListOld = new List<Stage_Duration__c>();
        for(Opportunity op : newOpMap.values())
        {
            if(op.StageName != oldOpMap.get(op.Id).StageName)
            {
                Stage_Duration__c[] sdNew = [SELECT Id, Name, Stage_Start_TimeStamp__c, Stage_End_TimeStamp__c, OwnerId, Opportunity__c, Duration_Time__c FROM Stage_Duration__c WHERE Name = :op.StageName AND Opportunity__c = :op.Id];
                Stage_Duration__c[] sdOld = [SELECT Id, Name, Stage_Start_TimeStamp__c, Stage_End_TimeStamp__c, OwnerId, Opportunity__c, Duration_Time__c FROM Stage_Duration__c WHERE Name = :oldOpMap.get(op.Id).StageName AND Opportunity__c = :oldOpMap.get(op.Id).Id];
                if(sdNew.size() > 0)
                {
                    sdNew[0].OwnerId = op.OwnerId;
                    sdNew[0].Stage_End_TimeStamp__c = null;
                    sdNew[0].Stage_Start_TimeStamp__c = op.LastModifiedDate;
                    SDListNew.add(sdNew[0]);
                } else {
                    Stage_Duration__c newSdRec = new Stage_Duration__c();
                    newSdRec.Name = op.StageName;
                    newSdRec.Opportunity__c = oldOpMap.get(op.Id).Id;
                    newSdRec.OwnerId = op.OwnerId;
                    newSdRec.Stage_End_TimeStamp__c = null;
                    newSdRec.Stage_Start_TimeStamp__c = op.LastModifiedDate;
                    SDListNew.add(newSdRec);
                }
                
                if(sdOld.size() > 0)
                {
                    sdOld[0].OwnerId = op.OwnerId;
                    sdOld[0].Stage_End_TimeStamp__c = op.LastModifiedDate;
                    string previousDuration_str =string.valueOf(sdOld[0].Duration_Time__c);
                    
                    long diff = (op.LastModifiedDate.getTime() - sdOld[0].Stage_Start_TimeStamp__c.getTime()) + long.valueOf(previousDuration_str);
                    sdOld[0].Duration_Time__c = diff;
                        
                    double calc_Days = diff / 86400000.0;
                    integer Days = calc_Days.intValue();
                    
                    string getDecimalHours = '0.' + String.valueOf(calc_days).substringAfter('.');
                    decimal  calc_Hours = decimal.valueOf(getDecimalHours)*24;
                    integer Hours = calc_Hours.intValue();
                    
                    string getDecimalMin = '0.' + String.valueOf(calc_Hours).substringAfter('.');
                    decimal  calc_Minutes = decimal.valueOf(getDecimalMin)*60;
                    integer Minutes = calc_Minutes.intValue();
                    
                    sdOld[0].Duration__c = Days + ' Days : ' + Hours + ' Hours : ' + Minutes + ' Minutes';
                    
                    SdListOld.add(sdOld[0]);
                }
                
                if(!SDListNew.isEmpty()) 
                {
                    upsert SDListNew;
                }
                if(!SdListOld.isEmpty()) 
                {
                    update SdListOld;
                }
                
            }
        }
    }

}