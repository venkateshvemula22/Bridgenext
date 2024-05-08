public class Contact_class16thsep {
    public Contact con;
    public Contact con2;
    public Contact con3;
    
    //construtor
    public Contact_class16thsep(){
        con = new Contact(id = '0035g00000F0HKT');
        nithinmethod2();
        con.Phone = '9059626049';
        con.Email = 'nithin@gmail.com';
        nithinmethod();
        system.debug(con);
        update con;
              
            }
    public Contact_class16thsep(integer s){
        con3 = new Contact(id = '0035g00000F0Hf5');
        con3.Salutation = 'Mr.';
        con3.FirstName = 'naresh';
        con3.LastName = 'sudhaganiii';
        con3.Department = 'Developer';
        con3.Phone = '9059625049';
        con3.Email = 'naresh@gmail.com';
        update con3;
        system.debug(con3);
        sravanmethod();
    }
    //method
    public void nithinmethod(){
        con.AssistantName = 'nandithhh';
        con.AssistantPhone = '9865478215';
    }
    public void nithinmethod2(){       
        con.Salutation = 'Mr.';
        con.FirstName = 'Nithin';
        con.LastName = 'sudhagani';
        con.Department = 'CSE';
    }
    public void  sravanmethod(){
        con2 = new Contact(id = '0035g00000C5LNm');
        con2.Department = 'SFDCccc';
        update con2;
        system.debug(con2);
        
    }
}