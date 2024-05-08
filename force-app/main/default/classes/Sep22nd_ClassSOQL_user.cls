public class Sep22nd_ClassSOQL_user {
    public string st;
    public Sep22nd_ClassSOQL_user(){
        myusermethod();
    }
    public void myusermethod(){
        list<User> ur = new list<User>();
        ur = [SELECT Username, Profile.Name FROM User];
        for(User u : ur){
            system.debug('UserName== ' + u.Username + '  ' + 'Profile== ' + u.Profile.Name);
        }
    }
    

}