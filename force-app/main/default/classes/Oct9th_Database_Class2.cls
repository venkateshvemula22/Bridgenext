//Dynamic SOQL query of different objects and displaying their all records and count
public class Oct9th_Database_Class2 {
    public list<string> objectName = new list<string>{'account','lead','opportunity','contact','student__c','course__c'};
        public list<string> fieldNames = new list<string>{'id,name,site,industry,rating','id,name','id,name,StageName','id,name,Phone','id,name,course__c,student_phone__c,student_email__c','id,name,total_students_count__c'};
            public list<sobject> sob;
    public Oct9th_Database_Class2(){
        for(integer i=0;i<objectName.size();i++){           
                    string str = ' select ' + fieldNames[i] + ' from ' + objectName[i];
                    list<sobject> sob = Database.query(str);
                    system.debug(objectName[i] + '==='  + sob);
                    system.debug(objectName[i] + ' ===> '  + sob.size());               
            }     
            
        }                
        
    }