public class Oct2nd_SetClass {
    public list<opportunity> op = new list<opportunity>();
    public map<integer,opportunity> opMap = new map<integer,opportunity>();
    
    public Oct2nd_SetClass (){
        opportunity oppo = new opportunity();
        oppo.Name = 'Anupama_oppo_Apex';
        oppo.CloseDate = system.today()-1;
        oppo.StageName = 'Prospecting';
        //oppo.ForecastCategory = 'pipeline';
        insert oppo;
        op = [select id,name,StageName,ForecastCategory from opportunity where StageName = 'Prospecting' order by name desc limit 20];
        for(integer i=0;i<op.size();i++){
            opportunity opp = new opportunity();
            opp = op[i];
            opMap.put(i, opp);
            system.debug('opp== ' + opp);
        }
        system.debug('opportunity== ' + opMap);
        system.debug('op== ' + op);
    }
}
/*  opportunity== {0=Opportunity:{Id=0065g00000CAVrFAAX, Name=Sravan CTS Opportunity, StageName=Prospecting, ForecastCategory=Pipeline, CurrencyIsoCode=INR}, 
 *                 1=Opportunity:{Id=0065g00000D8wzWAAR, Name=Shashi_oppo_Apex, StageName=Prospecting, ForecastCategory=Pipeline, CurrencyIsoCode=INR}, 
 *                 2=Opportunity:{Id=0065g00000D8wz2AAB, Name=Shashi_oppo_Apex, StageName=Prospecting, ForecastCategory=Pipeline, CurrencyIsoCode=INR}, 
 *                 3=Opportunity:{Id=0065g00000AmcKsAAJ, Name=relationship one to one, StageName=Pro
 *  op== (Opportunity:{Id=0065g00000CAVrFAAX, Name=Sravan CTS Opportunity, StageName=Prospecting, ForecastCategory=Pipeline, CurrencyIsoCode=INR}, 
 *        Opportunity:{Id=0065g00000D8wzWAAR, Name=Shashi_oppo_Apex, StageName=Prospecting, ForecastCategory=Pipeline, CurrencyIsoCode=INR}, 
 *        Opportunity:{Id=0065g00000D8wz2AAB, Name=Shashi_oppo_Apex, StageName=Prospecting, ForecastCategory=Pipeline, CurrencyIsoCode=INR}, 
 *        Opportunity:{Id=0065g00000AmcKsAAJ, Name=relationship one to one, StageName=Prospecting, Forecas
*/