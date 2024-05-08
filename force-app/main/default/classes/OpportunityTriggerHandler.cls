public class OpportunityTriggerHandler {
    
    //handle when Opportunity is Created.
    public static void handleAfterInsert(List<Opportunity> newOps)
    {
        string message = ManageStageDurationsController.createStageDurations(newOps);
    }
    
    //handle when Opportunity StageName is Updated.
    public static void handleAfterUpdate(Map<Id, Opportunity> oppNewMap, Map<Id, Opportunity> oppOldMap)
    {
        ManageStageDurationsController.updateStageDurations(oppNewMap, oppOldMap);
    }

}