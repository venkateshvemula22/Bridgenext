public with sharing class CurrencyLayerIntegration {

    @AuraEnabled
    public static string convertCurrency(string fromC, string toC, integer amount) {
    
    string convertedAmount;
    string accessKey = 'ba1b3e02be011e7345ba2ef0f2d97896';
    string endpoint = 'https://api.currencylayer.com/convert?'+'access_key='+accessKey+'&from='+fromC+'&to='+toC+'&amount='+amount;
    system.debug('endpoint ==> ' + endpoint);
    HttpRequest req = new HttpRequest();
    req.setEndpoint(endpoint);
    req.setMethod('GET');

    http h = new http();

    httpResponse resp = h.send(req);

    string result = resp.getBody();
    system.debug('result ==> ' + result);
    decimal amt;

    system.JSONParser jp = JSON.createParser(result);

    while (jp.nextToken() != null) {

        if(jp.getText() == 'USDINR') {
            jp.nextToken();
            amt = (Decimal)jp.getDecimalValue();
        }
    }
    convertedAmount = string.valueOf(amt);
    return convertedAmount;
   }
}