public class Sep21st_SOQLClass2 {
public string studentName;
    public Sep21st_SOQLClass2(){      
        mystdmethod();
        myoppomethod();
        myaccmethod();
        mystdmethod1();
        mystmethod();
    }
    public void mystdmethod(){
        list<student__c> std = new list<student__c>();
        std = [select Name,Country__c,State__c from student__c where Name = 'KCR'];
        for(student__c student : std){
            system.debug('studentName==' + student);
        }
    }
        public void myoppomethod(){
            list<opportunity> oppo = new list<opportunity>();
        oppo = [select Name,stageName,Amount from opportunity where StageName='Closed Won' and Amount > 100 limit 10];
        for(opportunity op : oppo){
            system.debug('opName==  ' + op);
        }
    }
    public void myaccmethod(){
        list<Account> acc = new list<Account>();
        acc = [select Name,rating,industry,numberofEmployees from Account where rating = 'hot' and industry = 'Technology'];
        for( account ac : acc){ 
            system.debug('ac=== ' + ac);
        }
    }
    public void mystdmethod1(){
        list<student__c> stu = new list<student__c>();
        stu = [select Name,Country__c,State__c,Course__r.Name,Course__r.Totally_fee__c from student__c];
        for(student__c st : stu){
            system.debug('stName=== ' + st);
            
        }
    }
    public void mystmethod(){
        list<student__c> st = new list<student__c>();
        st = [SELECT Name,Country__c,Parent_Batch__r.Course__r.Owner.Profile.name,Parent_Batch__r.Course__r.Owner.name FROM student__c ];
        for(student__c so : st){
            system.debug('StOwner=== ' + so.Parent_Batch__r.Course__r.Owner.Profile.name + '  ' +  'CourseOwnerName==' + so.Parent_Batch__r.Course__r.Owner.name);
        }
    }
}