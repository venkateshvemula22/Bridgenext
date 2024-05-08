public with sharing class AccountOpportunityDetailsController {
    public Account account { get; set; }
    public List<Opportunity> opportunities { get; set; }
    public Decimal ClosedWonAmount { get; set; }
    
    public AccountOpportunityDetailsController() {
        // Get the account ID from the page URL
        Id accountId = ApexPages.currentPage().getParameters().get('Id');
        
        // Query the account and related opportunities
        account = [SELECT Name, Industry, Phone, AnnualRevenue, Sum_of_Opportunities__c FROM Account WHERE Id =: accountId];
        opportunities = [SELECT Name, StageName, Amount, CloseDate FROM Opportunity WHERE StageName = 'Closed Won' AND AccountId = :accountId ORDER BY CloseDate DESC];
        
        ClosedWonAmount = 0.00;
        for(opportunity opty: opportunities){
            ClosedWonAmount = ClosedWonAmount + opty.Amount;
             
        }
    }
}