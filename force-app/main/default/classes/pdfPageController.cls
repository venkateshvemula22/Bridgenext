public with sharing class pdfPageController {
    
    public string pdfText{get; set;}
    
    public pdfPageController(){
        pdfText = string.escapeSingleQuotes(
        		ApexPages.currentPage().getParameters().get('pdfText')
        );
    }

}