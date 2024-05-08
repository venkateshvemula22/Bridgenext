({
    doInit : function(component, event, helper) {
        var jsonList = [{'name':'venky',
                         'city':'Hyderabad',
                         'address':'Jangiligonda',
                         'state':'Telangana'
                        },
                        {'name':'Naveen',
                         'city':'Mahabubabad',
                         'address':'Jangiligonda',
                         'state':'Taminadu'},
                        {
                            'name':'Sandeep',
                            'city':'Bangalore',
                            'address':'Jayyaram',
                            'state':'Karnataka'
                        }];
        var anotherList = [];
        jsonList.forEach(function(a){
            anotherList.push(a.name);
        })
    }
})