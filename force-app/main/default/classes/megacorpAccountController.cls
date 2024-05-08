public with sharing class megacorpAccountController {

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountsFollowedByCurrentUser() {
        // Retrieve the current user's ID
        Id currentUserId = UserInfo.getUserId();

        // Query the accounts followed by the current user
        List<Account> accounts = [
            SELECT Id, Name, Industry, Phone, Owner.Name, LastModifiedBy.Name
            FROM Account
            WHERE Id IN (SELECT ParentId FROM EntitySubscription WHERE SubscriberId = :currentUserId)
        ];

        return accounts;
    }

    @AuraEnabled
    public static List<Account> setAccountOwner(List<Id> accountIds) {
        // Ensure the current user has the necessary permissions to set the account owner
        if (!isCurrentUserAllowedToUpdateAccountOwner(accountIds)) {
            throw new AuraHandledException('You do not have permission to update the account owner.');
        }

        // Perform the logic to set the account owner
        // For simplicity, let's assume we are assigning the account to the current user
        //Id currentUserId = UserInfo.getUserId();
        Id currentUserId = [select id from user where name = 'akshaya vemula'].Id;
        List<Account> accountsToUpdate = new List<Account>();
        for (Id accountId : accountIds) {
            Account acc = new Account(Id = accountId, OwnerId = currentUserId);
            accountsToUpdate.add(acc);
        }

        update accountsToUpdate;

        return accountsToUpdate;
    }

    // Helper method to check if the current user is allowed to update the account owner
    private static Boolean isCurrentUserAllowedToUpdateAccountOwner(List<Id> accountIds) {
        // Implement your custom logic here to check the user's permissions
        // For example, check if the user has the necessary profile or permission set

        // For demonstration purposes, let's assume all users are allowed to update the account owner
        return true;
    }

    
}