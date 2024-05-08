public with sharing class AccountFollowersCount {
    
    @AuraEnabled(cacheable=true)
    public static Followerswrapper getFollowersCount(String accountId) {
        
        String currentUserId = UserInfo.getUserId();
         system.debug('accountId = > ' + accountId);
        List<EntitySubscription> followersCount = [SELECT Id FROM EntitySubscription WHERE ParentId = :accountId AND SubscriberId != :currentUserId];
        
        List<EntitySubscription> currentUsersubscription = [SELECT Id FROM EntitySubscription WHERE ParentId = :accountId AND SubscriberId = :currentUserId];
        
        Followerswrapper wrap = new Followerswrapper();
        wrap.isCurrentUserFollowing = !currentUsersubscription.isEmpty();
        wrap.FollowersCount = followersCount.size();
        system.debug('FollowersCount = > ' + wrap.FollowersCount);
        system.debug('isCurrentUserFollowing = > ' + wrap.isCurrentUserFollowing);
        return wrap;
    }

    @AuraEnabled
    public static Followerswrapper followUnfollowAccont(String accountId, string action) {
        
        Followerswrapper wrapper = new Followerswrapper();
        List<EntitySubscription> esubList = new List<EntitySubscription>();
        String currentUserId = UserInfo.getUserId();
        if(accountId != null && action == 'Follow') {
            EntitySubscription esub = new EntitySubscription();
            esub.ParentId = accountId;
            esub.SubscriberId = currentUserId;
            esubList.add(esub);
            
            if(esubList.size() > 0){
                insert esubList;
                publishPlatformEvent(esubList[0].Id, 'Create',currentUserId);
            }
            wrapper = getFollowersCount(esubList[0].ParentId);
            
        } else if(accountId != null && action == 'Unfollow') {
            try {
                List<EntitySubscription> subscriptionList = [SELECT Id FROM EntitySubscription WHERE ParentId =: accountId AND SubscriberId =: UserInfo.getUserId()];
                if(subscriptionList.size() > 0) {
                    DELETE subscriptionList;
                    publishPlatformEvent(subscriptionList[0].Id, 'Delete',UserInfo.getUserId());
                    wrapper = getFollowersCount(accountId);
                }
            } catch (Exception ex) {
                string errorMessage = ('Failed Unfollow Account ' + ex.getMessage());
                System.debug('Error in Unfollowing the account => ' + ex.getMessage());
            }
        }
        return wrapper;
    }
    
    public static void publishPlatformEvent(string recordId,string action, string currentUserId) {
        List<AccountFollowEvent__e> eventsToPublish = new List<AccountFollowEvent__e>();
        AccountFollowEvent__e event = new AccountFollowEvent__e(
                                                eSub_recordId__c = recordId,
                                                Action__c = action,
                                                ObjectType__c = 'EntitySubscription',
                								UserId__c = currentUserId,
                                                Timestamp__c = System.now()
                                            );
        eventsToPublish.add(event);
        
        if (!eventsToPublish.isEmpty()) {
        		EventBus.publish(eventsToPublish);
    	}
        
    }
    public class Followerswrapper {
       @AuraEnabled public Integer FollowersCount;
       @AuraEnabled public boolean isCurrentUserFollowing;
    }    
}