public class Accountobject {
    //variable declaration
    public string accountName,platform,isActive,country;
    public integer numberOfstaff=200, annualRevenue;
    public string lastName='vemula';
    public integer i,j,num=100,count, numberOfprimeNumbers;
    
    
    //constructors
    //varaible assignment
    public Accountobject(){
        accountName='venkatesh';
        platform='Java';
        isActive='Yes';
        annualRevenue=2500000;
        system.debug(accountName+' '+lastName+' and his annual Revenue is: '+annualRevenue);
        
        for(i=1;i<=num;i++){
            count=0;
            numberOfprimeNumbers=0;
            for(j=1;j<=i;j++){
                if(Math.Mod(i,j)==0){
                    count=count+1;
                    numberOfprimeNumbers=numberOfprimeNumbers+1;
                }
            }
            
            if(count==2){
                
                system.debug(i+': is a prime number');
                
            }
        }
        system.debug('numberOfprimeNumbers are: '+numberOfprimeNumbers);
    }
    
    
}