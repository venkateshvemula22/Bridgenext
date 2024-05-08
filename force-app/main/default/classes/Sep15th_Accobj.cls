public class Sep15th_Accobj {
    //Class level variables
    public string AccountName = 'Vishal Kalyan';
    public string Platform = 'Platform';
    public integer AccountNumber= 501002;
    public string Type = 'Technology Partner';
    public string Industry = 'Engineering';
    public string SLA = 'Gold';
        public integer SLASerialNumber = 12548;
        public date SLA_ExpirationDate = system.today()+30;
    
    //Constructors
    public Sep15th_Accobj(){
        AccountName = 'Rajesh';
        system.debug(AccountName);
        integer rollNumber = 52;
        mymethod();
        system.debug(Industry);
        
    }
     public Sep15th_Accobj(string str){
        
    }
     public Sep15th_Accobj(integer num, string str1){
        num = 60;
         
    }
     public Sep15th_Accobj(integer num, string str1, boolean IsFeePaid){
        num = 201;
         IsFeePaid = false;
         mymethod1();
    }
    
    public void mymethod(){
        SLA_ExpirationDate = system.today()+60;
        system.debug('SLA_ExpirationDate== ' + SLA_ExpirationDate);
        Industry = 'Government';
            
    }
    public void mymethod1(){
        
    }
    public void mymethod2(){
        
    }

}