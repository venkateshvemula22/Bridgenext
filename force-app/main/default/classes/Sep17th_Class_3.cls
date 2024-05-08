public class Sep17th_Class_3 {    //[3=>17][2=>8][1=>10,13,20,21,29,33,24,15,][2=>15,23,11][3=>26,20,13,8]                                
    //class level variables
    public integer ie = 10;
    
    //constructorc3
    public Sep17th_Class_3(){
        mysample();
        system.debug('ie== ' + ie);//98
    }
    //method1c3
    public void mysample(){
        ie = method2(8);
        system.debug('ie== ' + ie);//98
    }
    //method2c3
    public integer method2(integer iet){
        system.debug('ie== ' + ie);//10
        ie = iet + 90;//ie = 98
        sample2();
        system.debug('ie== ' + ie);//ie=98
        return ie;
    }
    //method3c3
    public void sample2(){
        Sep17th_Class_2 c2 = new Sep17th_Class_2();
        system.debug('ie== ' + ie);//ie=98
    }   
}