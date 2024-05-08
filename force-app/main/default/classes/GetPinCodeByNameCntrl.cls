public with sharing class GetPinCodeByNameCntrl {

    @AuraEnabled
    public static list<GetPotOfficeDetailsWrapper> getPincode(string pincode) {
        http p = new http();

        httpRequest request = new httpRequest();
        request.setEndPoint('https://api.postalpincode.in/pincode/'+pincode);
        request.setMethod('GET');
        list<GetPotOfficeDetailsWrapper> pw = new  list<GetPotOfficeDetailsWrapper>();
        try {
            httpResponse response = p.send(request);
            system.debug('response == > ' + response.getBody());
            system.debug('response.getStatusCode() == > ' + response.getStatusCode());
            system.debug('response.getStatus() ' + response.getStatus());
            if (response.getStatusCode() == 200 && response.getStatus() == 'OK') {

                string jsonResponse = response.getBody();
                pw = GetPotOfficeDetailsWrapper.parse(jsonResponse);
                 system.debug('pw == > ' + pw);
        
            }
        } catch (Exception ex ) {

            string error = ex.getMessage();
            system.debug('error == > ' + error);
        } 
    return pw;
    }
  
}