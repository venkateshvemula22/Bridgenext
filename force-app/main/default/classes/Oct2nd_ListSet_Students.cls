public class Oct2nd_ListSet_Students {
    public list<student__c> stdList = new list<student__c>();
    public list<string> strList = new list<string>();
    public list<integer> intList = new list<integer>();
    public student__c st = new student__c();
    public Oct2nd_ListSet_Students(){
        st.Name = 'sid2_Apex';
        st.Course__c = 'a035g0000039J66';
        st.Country__c = 'USA';
        st.student_email__c = 'Sid2@gmail.com';
        insert st;
        system.debug('st== ' + st);
        stdList = [select id,name from student__c where student_email__c != Null];
        system.debug('stdList== ' + stdList);
        for(student__c std : stdList){
            strList.add(std.name + ' == ' + std.Id);              
        }
        system.debug('strList== ' + strList);
    }
}
/*Output::::strList== (Sudagani Nithin == a005g00002zRCuQAAW,
                       Mohan std1 == a005g000030cUOpAAM, 
                       Rakesh == a005g00002ydBenAAE, 
                       sid_Apex == a005g000031MhmiAAC, 
                       Sudagani Nandith == a005g00002zRBt9AAG, 
                       venky == a005g00002yfo9TAAQ, 
                       navya == a005g00002ydBhNAAU, 
                       karthik == a005g00002yn6GbAAI, 
                       nivas == a005g00002yn6INAAY)                    */