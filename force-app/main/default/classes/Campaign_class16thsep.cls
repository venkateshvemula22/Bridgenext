public class Campaign_class16thsep {
    public Campaign camp = new Campaign();
    public Campaign camp2 = new Campaign();
    
    public Campaign_class16thsep(){
        secondcamp();
        camp.Id='7015g0000009Ij7';
        camp.Name='September_Campaign_Apex';
        camp.IsActive=true;
        camp.Type='Webinar';
        camp.Status='In Progress';
        camp.StartDate=system.today()-17;
        camp.EndDate=system.today()+13;
        camp.ExpectedRevenue=500000;
        camp.BudgetedCost=25000;
        camp.ActualCost=30000;
        camp.ExpectedResponse=80;
        system.debug(camp);
        update camp;
        
        
        
    }
    public void secondcamp(){
        camp2.id='7015g0000009Ij6';
        camp2.Name='October_Campaign_Apex';
        camp2.IsActive=false;
        camp2.Type='Webinar';
        camp2.Status='Panned';
        camp2.StartDate=system.today()+13;
        camp2.EndDate=system.today()+43;
        camp2.ExpectedRevenue=1000000;
        camp2.BudgetedCost=50000;
        camp2.ActualCost=70000;
        camp2.ExpectedResponse=88;
        system.debug(camp2);
        update camp2;
        
    }
}