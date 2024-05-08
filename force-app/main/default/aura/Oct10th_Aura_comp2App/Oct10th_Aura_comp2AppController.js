({
	myAction : function(component, event, helper) {
		var trainerName = 'Mohan_VLR';
        var designation = 'vedava';
        console.log('trainerName= ' + trainerName + ' ' + 'designation= ' + designation);
        var batchList = [4,6,7,10,12,20,35,46,80,90,110,124];
        var batchList2 = [];
        var batchList3;
        batchList.push(130,144,169,186,225,256);
        console.log('batchList== ' + batchList);
        console.log('batchList2== ' + batchList2);
        console.log('batchList3== ' + batchList3);
        var batchFinalList = [];
        for(var i=batchList.length;i>=0;i--){
            console.log('value== ' + batchList[i]);
            batchFinalList.push(batchList[i]);
        }
        console.log('batchFinalList== ' + batchFinalList);
        console.log('batchSize== ' + batchList.length);
        console.log('batchSize== ' + batchList.slice(2,10));
        
        var a;
        batchList.forEach(function(a){
            var intt = batchList.indexOf(a);
            if(intt<5){
                console.log('a== ' + a);
            }
                               
                               })
       /* var accRecord = {
            'accName' : 'Naresh',
            'industry' : 'Technology',
            'address' : 'Jangiligonda',
            'city' : 'Mahabubabad',
            'state' : 'Telangana'
            
        };
        var conRecord = {};
        var optyRecord;
        console.log('accRecord== ' + accRecord);
        console.log('conRecord== ' + conRecord);
        console.log('optyRecord== ' + optyRecord);
        console.log('accRecord city== ' + accRecord.city);*/
    }
})