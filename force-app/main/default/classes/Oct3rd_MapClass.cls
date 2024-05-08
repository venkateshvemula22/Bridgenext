public class Oct3rd_MapClass {
    public list<list<list<string>>> allList = new list<list<list<string>>>();
    public list<list<string>> allList2 = new list<list<string>>();
    public list<list<string>> allList3 = new list<list<string>>();
    
    public Oct3rd_MapClass(){
        list<string> str1 = new list<string>{'ramu','somu'};
            list<string> str2 = new list<string>{'sita','githa'};
                list<string> str3 = new list<string>{'raja','kuja'};
                    list<string> str4 = new list<string>{'rani','boni'};
        allList2.add(str1);
        allList2.add(str2);
        allList3.add(str3);
        allList3.add(str4);
        
        allList.add(allList2);
        allList.add(allList3);
        
        system.debug('allList== ' + allList);
    }

}