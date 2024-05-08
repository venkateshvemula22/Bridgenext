public class Sep24th_listNames {
    public list<string> accNames = new list<string>();
    public set<integer> intset = new set<integer>{5,8,4,1,69,7,10,23,52,2,6,6,7,9,2};
    public Sep24th_listNames(){
       list<student__c> acNames = [select id,name from student__c order by name ASC];
        for(student__c s : acNames){
            accNames.add(s.name);
           
        }
         system.debug('accName== ' + accNames);
        myintmethod();
    }
    public void myintmethod(){
        intset.add(13);
        intset.add(44);
        system.debug('intset== ' + intset);
    }
    

}