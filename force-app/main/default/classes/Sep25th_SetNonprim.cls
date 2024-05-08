public class Sep25th_SetNonprim {
    public set<string > str = new set<string>();
    public list<student__c> stdlist = new list<student__c>();
    public set<string> stdset = new set<string>();
    public Sep25th_SetNonprim(){
        stdlist = [select id,name,student_email__c from student__c];
        for(student__c st : stdlist){
            stdset.add(st.name);
        }
        system.debug('stdset== ' + stdset);
    }
    
}