public class PostalCodeController
{	
    
    public static string getPostalCode(string place) 
    {
        string Message;
        try
        {
            string endpoint = 'https://api.postalpincode.in/postoffice/' + place;
            List<PostalCodeRespWrapper> pParser = new List<PostalCodeRespWrapper>();
            HttpRequest request = new HttpRequest();
            request.setEndpoint(endpoint);
            request.setMethod('GET');
            
            Http h = new Http();
            
            HttpResponse response = h.send(request);
            system.debug('status code => ' + response.getStatusCode());
            if(response.getStatusCode() == 200 && response.getStatus() == 'OK')
            {
                string JSONResp = response.getBody();
                system.debug('JSONResp => ' + JSONResp);
                pParser = (List<PostalCodeRespWrapper>) system.JSON.deserialize(JSONResp, List<PostalCodeRespWrapper>.class);
                Message = pParser[0].Message;
                system.debug('message => ' + Message);
                if(pParser[0].PostOffice != null) 
                {
                    processPostalCodes(pParser[0].PostOffice);
                }
            }
            else if(response.getStatusCode() == 400)
            {
                string JSONResp = response.getBody();
                system.debug('JSONResp => ' + JSONResp);
                PostalCodeRespWrapper pParsererr = (PostalCodeRespWrapper) system.JSON.deserialize(JSONResp, PostalCodeRespWrapper.class);    
                Message = pParsererr.Message;
            }
        }
        catch(exception ex)
        {
            Message = ex.getMessage();
            system.debug('The following error occured = > ' + Message);
        }
        return Message;
    }
    
    public static void processPostalCodes(list<PostalCodeRespWrapper.PostOffice> postaapeeses)
    {
        if(!postaapeeses.isEmpty() || postaapeeses != null)
            {
                for(PostalCodeRespWrapper.PostOffice p : postaapeeses)
                {
                    system.debug('Pincode = '+ p.PINCode + ' && ' + 'Name = ' + p.Name);
                }
            }
    }

}