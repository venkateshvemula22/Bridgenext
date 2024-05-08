public class Opportunity_16thSepclass {
    Opportunity op;
    Lead ld;
    public Opportunity_16thSepclass(){
        op = new Opportunity();
        ld = new Lead();
        system.debug('op==' + op);//empty
        system.debug('ld==' + ld);//empty
        leadmethod();
        oppomethod();
        system.debug('opld== ' + op);
        
    }
    public  void leadmethod(){
        ld.Id = '00Q5g000007ibc6';
        ld.FirstName = 'Srinivas';
        ld.LastName = 'Reddy';
        ld.City = 'Hyd';
        ld.CompanyDunsNumber = '125463';
        ld.Company = 'COGNIZANT';
        ld.Status = 'ClosedConverted';
        system.debug('ld== ' + ld);
        
        update ld;
    }
    public void oppomethod(){
        op.Name = 'pallam Venkanna';
        op.Start_date__c = system.today();
        op.CloseDate= system.today()+30;
        op.StageName = 'Closed Won';
        system.debug('op== ' + op);
        insert op;
    }
    
}