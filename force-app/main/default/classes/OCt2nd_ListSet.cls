public class OCt2nd_ListSet {
    public list<string> strList = new list<string>{'palle','chelli'};
        public list<account> accList = new list<account>();
    public account acc  = new account();
    public account acc2  = new account();
    public OCt2nd_ListSet(){
        myaccmethod();
        myacc1method();
        accList.add(acc);
        accList.add(acc2);
        system.debug('accList=== ' + accList);
    }
    public account myaccmethod(){
        acc.Name = 'KCR_Apecx';
        acc.Sic = 'medak';
        acc.Rating = 'Hot';
        acc.Industry = 'Agriculture';
        system.debug('acc== ' + acc);
        
        return acc;
    }
    public account myacc1method(){
        acc2.Name = 'revanth_Apex';
        acc2.Sic = 'suryapet';
        acc2.Rating = 'Warm';
        acc2.Industry = 'Technology';
        system.debug('acc2== ' + acc2);
        return acc2;
    }
    
    
}