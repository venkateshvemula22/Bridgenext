public class Sep15th_Method1 {
    //class level variable
    public string str='Mohan'; //VLR
    public integer ie;
    public boolean be;
    
    //Constructor
    public Sep15th_Method1(){
        str='VLR';
        str = mymethod2(); 
        system.debug('str==' + str); //Mohan only training
        system.debug('be==' + be); //NULL
        system.debug('ie==' + ie); //NULL
        mymethod();
    }
    
    //Methoods
    public void mymethod(){
        system.debug('mymethod=='+ str);//Mohan only training
        str='Mohan VLR';
    }
    public string mymethod2(){
        system.debug('mymethod2=='+ str); //VLR
        be = mybemethod(); 
        return 'Mohan only training';
    }
    public boolean mybemethod(){
        Boolean b = false;
        ie = myintmethod(); 
        system.debug('mymethod2=='+ be); //NULL
        return b;
    }
    public integer myintmethod(){
        system.debug('mymethod2=='+ ie); //NULL
        return 900;
    }
}