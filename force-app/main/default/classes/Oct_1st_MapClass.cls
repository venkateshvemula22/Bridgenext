public class Oct_1st_MapClass {
    public list<Account> accList = new list<Account>();
    public list<student__c> stdList = new list<student__c>();
    public list<string> strlist = new list<string>{'maanas','ravi','priyanka','kajal','shwetha'};
    public map<Account,student__c> ma = new map<Account,student__c>();
    public Oct_1st_MapClass(){
        mymethod();
    }
    public void mymethod(){
         list<string> strlist2 = new list<string>();
         set<string> strset = new set<string>();
        system.debug('strlist== ' + strlist);     //{'maanas','ravi','priyanka','kajal','shwetha'}    |strlist== (maanas, ravi, priyanka, kajal, shwetha)
        strlist.add('yellareddy');
        system.debug('strlist== ' + strlist);     //{'maanas','ravi','priyanka','kajal','shwetha','yellareddy'} |strlist==(maanas, ravi, priyanka, kajal, shwetha, yellareddy)
        strlist2 = strlist.clone();
        system.debug('strlist2== ' + strlist2);   //{'maanas','ravi','priyanka','kajal','shwetha','yellareddy'} | (maanas, ravi, priyanka, kajal, shwetha, yellareddy)
        strlist2.add('Ilamma');
        system.debug('strlist2== ' + strlist2);   //{'maanas','ravi','priyanka','kajal','shwetha','yellareddy','Ilamma'} |  (maanas, ravi, priyanka, kajal, shwetha, yellareddy, Ilamma)
        string st = strlist2.get(3);
        system.debug('st== ' + st);              //kajal   kajal
        integer i = strlist.size();              
        system.debug('i== ' + i);                //6    6
        strset.addAll(strlist2);
        system.debug('strset== ' + strset);   //{'Ilamma','kajal','maanas','priyanka''ravi','shwetha','yellareddy',} | {Ilamma, kajal, maanas, priyanka, ravi, shwetha, yellareddy}
        boolean bool = strlist.isEmpty();
        system.debug('bool== ' + bool);   //false   false
        strlist.remove(1);
        system.debug('strlist== ' + strlist);   //{'maanas','priyanka','kajal','shwetha','yellareddy'}  (maanas, priyanka, kajal, shwetha, yellareddy)
        
        }
        
    }