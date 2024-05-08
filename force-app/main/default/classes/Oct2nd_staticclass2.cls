public class Oct2nd_staticclass2 {
    public Oct2nd_staticclass2(){
        set<string> listSet = new set<string>();  
        listSet.addAll(Oct2nd_staticclass.str);
        listSet.add(Oct2nd_staticclass.st);
        
        system.debug('listSet== ' + listSet);
    }
}