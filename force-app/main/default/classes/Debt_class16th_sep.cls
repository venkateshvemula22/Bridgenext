public class Debt_class16th_sep {
    public Debt__c dt = new Debt__c();

    public Debt_class16th_sep(){
        dt.Id='a075g000003g5z2';
        dt.Name='NaveeN';
        dt.Principle_amount__c=10000;
        dt.Rate_of_interest__c=24;
        dt.Amount_given_date__c=system.today()-17;
        dt.Amount_due_date__c=system.today()+20;
        system.debug('Debt== ' + dt);
        update dt;
    }
}