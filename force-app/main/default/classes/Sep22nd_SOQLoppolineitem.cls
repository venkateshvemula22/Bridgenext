public class Sep22nd_SOQLoppolineitem {
    public string opport;
    public Sep22nd_SOQLoppolineitem(){
        myoplimethod();
    }
    public void myoplimethod(){
        list<OpportunityLineItem> opli = new list<OpportunityLineItem>();
        opli = [SELECT Id,Name,Opportunity.Account.Owner.Profile.Name, ServiceDate, TotalPrice, UnitPrice, ListPrice FROM OpportunityLineItem];
        for(OpportunityLineItem oplitem : opli){
            system.debug('OwnerName=== ' + oplitem.Opportunity.Account.Owner.Name + '  ' + 'Profile==  ' + oplitem.Opportunity.Account.Owner.Profile.Name);
        }
    }

}