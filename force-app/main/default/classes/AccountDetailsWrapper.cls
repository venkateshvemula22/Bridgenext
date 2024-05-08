public class AccountDetailsWrapper {
    
    public list<caselist> caselist{get;set;}
    public list<contactlist> contactlist{get;set;}
    public ac ac{get;set;}
    public String message{get;set;}
    
    public class contactlist{
        public String Email{get;set;}
        public String Phone{get;set;}
        public String Name{get;set;}
        public String Id{get;set;}
    }
    public class caselist{
        public String CaseNumber{get;set;}
        public String Subject{get;set;}
        public String Description{get;set;}
        public String Id{get;set;}
    }
    public class ac{
        public String Name{get;set;}
        public String Rating{get;set;}
        public String Industry{get;set;}
        public String Id{get;set;}
    }
    
}