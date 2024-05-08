public class Oct2nd_SetListMap {
     public list<account> accList = new list<account>();
    public list<student__c> stdList = new list<student__c>();
    public map<integer,account> accMap = new map<integer,account>();
    public map<integer,student__c> stdMap = new map<integer,student__c>();
    public list<integer> intList = new list<integer>();
    public list<string> strList = new list<string>();
    list<string> strL = new list<string>();
    public integer i;
    public string j;
    public Oct2nd_SetListMap(){
        mystdMethod();        
        accList = [select id,name from account];
        for(i=0;i<accList.size();i++){
            account ac = accList[i];
            strList.add(ac.Name);
            accMap.put(i, ac);
            system.debug('i==> ' + i + ' && ' + 'accName==> ' + strList[i]);
        }
        system.debug('accMap== ' + accMap);
    }
    public void mystdMethod(){
        stdList = [select id,name,student_phone__c from student__c where student_email__c != null];
        for(i=0;i<stdList.size();i++){
            student__c st = stdList[i];
            strL.add(st.Name);
            stdMap.put(i, st);
            system.debug('i==> ' + i + ' && ' + 'stdName==> ' + strL[i]);
        }
        system.debug('stdMap== ' + stdMap);
    }

}
/*Line::18 ===>  accMap== {0=Account:{Id=0015g00000S3QhgAAF, Name=Sample_test 0, CurrencyIsoCode=INR}, 
                           1=Account:{Id=0015g00000S3QhhAAF, Name=Sample_test 1, CurrencyIsoCode=INR}, 
                           2=Account:{Id=0015g00000S3QhiAAF, Name=Sample_test 2, CurrencyIsoCode=INR}, 
                           3=Account:{Id=0015g00000S3QhjAAF, Name=Sample_test 3, CurrencyIsoCode=INR}, 
                           4=Account:{Id=0015g00000S3QhkAAF, Name=Sample_test 4, CurrencyIsoCode=INR}, 
                           5=Account:{Id=0015g00000S3QhlAAF, Name=Sample_test 5, CurrencyIsoCode=INR}, 
                           6=Account:{Id=0015g00000Txz7KAAR, N

  Line::30 ===> stdMap== {0=student__c:{Id=a005g00002zRCuQAAW, Name=Sudagani Nithin, student_phone__c=(905) 962-6049, RecordTypeId=0125g00000073wrAAA, CurrencyIsoCode=INR}, 
                          1=student__c:{Id=a005g000030cUOpAAM, Name=Mohan std1, student_phone__c=8106267957, RecordTypeId=0125g00000073wrAAA, CurrencyIsoCode=INR}, 
                          2=student__c:{Id=a005g00002ydBenAAE, Name=Rakesh, student_phone__c=(955) 045-3228, CurrencyIsoCode=INR}, 
                          3=student__c:{Id=a005g000031MhmiAAC, Name=sid_Apex, RecordTypeId=0125g00000073wrAAA, CurrencyIsoCode=
 */