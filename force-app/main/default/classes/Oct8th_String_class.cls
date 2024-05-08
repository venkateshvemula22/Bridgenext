public class Oct8th_String_class {
    public set<string> se = new set<string>();
    public string str;
    public string str3 = 'sandeep talla';
    public list<string> str1 = new list<string>{'venky','navi','sandeep','srinu','reddy'};
        public Oct8th_String_class(){
            integer i = str1.size();
            str1.add(2, 'nithin');
            str1.add('nandu');
            for(i=0;i<str1.size();i++){
                str = str1[i];
                system.debug('str== ' + str);
                se.add(str);
            }
            system.debug('String_Size== ' + i);
            str = str1[3];
            system.debug('se== ' + se);
            boolean bool = se.contains('navi');
            system.debug('bool== ' + bool);
            
            string sr = str.difference(str3);
            system.debug('sr== ' + sr);
            
            boolean bool2 =str3.containsNone('v');
            system.debug('bool2== ' + bool2);  
            
            boolean bool3 = str3.containsIgnoreCase('SanDeeP');
            system.debug('bool3== ' + bool3);
            
            boolean bool4 = str3.containsAny('alla');
            system.debug('bool4== ' + bool4);
            
            list<integer> inte = new list<integer>();
            inte = str3.getChars();
            system.debug('inte== ' + inte);
        }
}