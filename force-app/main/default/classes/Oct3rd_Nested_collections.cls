//Fetching all contact records according to the account
public class Oct3rd_Nested_collections {
    public map<id,list<contact>> conList = new map<id,list<contact>>();    
    public Oct3rd_Nested_collections(){
        list<account> accList = [select id,(select id,name from contacts) from account];
        for(account ac : accList){
            conList.put(ac.id, ac.contacts);
        }
        system.debug('conList== ' + conList);
    }
    public class innercls {    
        public map<id,list<contact>> conList2 = new map<id,list<contact>>();   
        Oct3rd_Nested_collections se =new Oct3rd_Nested_collections();
        public innercls(){            
            list<contact> conlistt = [select id,name,accountid from contact];        
            for(contact c : conlistt){ 
                if(conList2.containsKey(c.AccountId)){                 
                    list<contact> addedcontacts = conList2.get(c.AccountId); 
                    addedcontacts.add(c); 
                    conList2.put(c.AccountId, addedcontacts);                
                }else{		
                    
                    list<contact> newconlist = new list<contact>{c};
                        conList2.put(c.AccountId, newconlist);
                }
            }       
            system.debug('conList2==' + conList2);        
        }
    }
}
/*  conList2=={null=(Contact:{Id=0035g00000F0HKTAA3, Name=Nithin sudhagani, CurrencyIsoCode=INR}, Contact:{Id=0035g00000F0Hf5AAF, Name=naresh sudhaganiii, CurrencyIsoCode=INR}, Contact:{Id=0035g00000F0HbrAAF, Name=naresh sudhagani, CurrencyIsoCode=INR}, Contact:{Id=0035g00000F0HbwAAF, Name=naresh sudhagani, CurrencyIsoCode=INR}), 0015g00000L4wKrAAJ=(Contact:{Id=0035g00000AgoTEAAZ, Name=Rose Gonzalez, AccountId=0015g00000L4wKrAAJ, CurrencyIsoCode=INR}, Contact:{Id=0035g00000AgoTFAAZ, Name=Sean Forbes,*/

/* conList== {0015g00000L2PP2AAN=(), 0015g00000L4wKrAAJ=(Contact:{AccountId=0015g00000L4wKrAAJ, Id=0035g00000AgoTFAAZ, Name=Sean Forbes, CurrencyIsoCode=INR}, Contact:{AccountId=0015g00000L4wKrAAJ, Id=0035g00000AgoTEAAZ, Name=Rose Gonzalez, CurrencyIsoCode=INR}),
0015g00000L4wKsAAJ=(Contact:{AccountId=0015g00000L4wKsAAJ, Id=0035g00000AgoTGAAZ, Name=Jack Rogers, CurrencyIsoCode=INR}), 
0015g00000L4wKtAAJ=(Contact:{AccountId=0015g00000L4wKtAAJ, Id=0035g00000AgoTHAAZ, Name=Pat Stumuller, CurrencyIsoCode
*/