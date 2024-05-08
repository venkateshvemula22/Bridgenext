public class Sep16th_Class_1 {
    //class level variable
    public string str = 'VENKATESH';
    public Opportunity  oppo = new Opportunity(StageName='Prospect');
    public integer batchSize = 122;
    
    //Constructor
    public Sep16th_Class_1(){
        oppo.Name = 'Sam';
        system.debug('StageName== ' + oppo.StageName);  //Prospect
        oppo = getop('October');
    }
    
    //Method
    public Opportunity getop(string std){   //October
        Opportunity op = new Opportunity();
        op.Name = 'VLR';
        op.StageName = 'Prospect';
        op.Amount = batchSize;
        system.debug('op== ' + op);   //name stagename amount
        return op;
        
    }
    
}