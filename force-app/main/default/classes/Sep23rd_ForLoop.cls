public class Sep23rd_ForLoop {
    public list<integer> intlist;
    public list<integer> evenlist;
    public list<integer> oddlist;
    public list<integer> primelist;
    
    public Sep23rd_ForLoop(){
        intlist = new list<integer>();
        for(integer i=1 ; i<=100 ; i++){
            intlist.add(i);
        }
        system.debug('intlist== ' + intlist);
        even_oddmethod();
        prime_method();
        
    }
    public void even_oddmethod(){
        evenlist = new list<integer>();
        oddlist = new list<integer>();
        for(integer j=1 ; j<=100 ; j++){
            IF(math.mod(j,2)==0){
                evenlist.add(j);
            }
            else{
                oddlist.add(j);
            }
        }
        system.debug('evenlist== ' + evenlist);
        system.debug('oddlist== ' + oddlist);
    }
    public void prime_method(){
        primelist = new list<integer>(); 
        integer k,l,count;
        for(k=1 ; k<=100 ; k++){ 
            count=0;
            for(l=1 ; l<=k ; l++){
                if(math.mod(k,l)==0){
                    count = count + 1;
                }                          
            }            
            if(count == 2){
                primelist.add(k);
            }            
        }
        system.debug('primelist=== ' + primelist);      
    }
}