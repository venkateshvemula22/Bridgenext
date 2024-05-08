public class StringArrayTest {
    public static List<string> generateStringArray(integer i){
        integer n;
        List<string> stringList = new List<string>();
        for(n=0;n<i;n++){
            string s = 'Test ' + n ;
            stringList.add(s);
        }
        system.debug('stringList => ' + stringList);
        return stringList;
    }

}