//this class is to findouthe simple interest  
public class Sep19th_Class1 {
    public integer principleAmount;
    public integer rateOfInterest = 24;
    public date givenDate = date.newInstance(2020, 9, 18);
    public date dueDate;
    public decimal i;
    public decimal total;
    public decimal t;
    
    public Sep19th_Class1(){
        interestcal();
        system.debug('total_Amount == ' + total);
    }
    public void interestcal(){
        principleAmount = 1000000;
        dueDate = date.today() + 15; 
        t = givenDate.daysBetween(dueDate);
        system.debug('numberOfdays == ' + t); 
        system.debug('dueDate == ' + dueDate); 
        i = (principleAmount * (t/365) * rateOfInterest)/100;
        system.debug('total_interest == ' + i);
        total = principleAmount + i;
        
    }
}