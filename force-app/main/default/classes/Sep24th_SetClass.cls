public class Sep24th_SetClass {
    public set<string> strset = new set<string>{'venky','naveen','sandeep','srinu','ram','narendra','shashi'};
        public list<string> strlist = new list<string>{'venky','naveen','sandeep','srinu','ram'};
            public  set<integer> intset = new set<integer>{9,8,7,6,5,4,0,4,5,6,7,8,9};
                public list<integer> intlist = new list<integer>{9,8,7,6,5,4,3,2,1,0,1,2,3};
                    public Sep24th_SetClass(){
                        strsetmethod();
                                  system.debug('strset== ' + strset);
                        strset.clear();
                                  system.debug('strset== ' + strset);
                        strlistmethod();
                                  system.debug('strlist== ' + strlist); 
                        string str1 = strlist.get(2);
                                  system.debug('str1== ' + str1);
                        intsetmethod();
                                  system.debug('intset==  ' + intset);
                        intlistmethod();
                                  system.debug('intlist==  ' + intlist);
                    }
    public void strsetmethod(){
        strset.remove('narendra');
        strset.remove('shashi');
        strset.add('nandith');
        strset.add('nithin');        
    }
    public void strlistmethod(){
        strlist.add('shashi');
        strlist.add('murali');        
    }
    public void intsetmethod(){
        intset.remove(0);
        intset.add(10);        
    }
    public void intlistmethod(){
        intlist.remove(0);
        intlist.remove(1);
        intlist.add(0, 10);
        boolean be = intlist.contains(0);
        system.debug('be== ' + be);                
    }

}