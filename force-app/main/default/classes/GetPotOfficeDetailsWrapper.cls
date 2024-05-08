public class GetPotOfficeDetailsWrapper {

	@AuraEnabled public String Message;
	@AuraEnabled public String Status;
	@AuraEnabled public List<PostOffice> PostOffice;

	public class PostOffice {
		@AuraEnabled public String Name;
		@AuraEnabled public String Description;
		@AuraEnabled public String BranchType;
		@AuraEnabled public String DeliveryStatus;
		@AuraEnabled public String Circle;
		@AuraEnabled public String District;
		@AuraEnabled public String Division;
		@AuraEnabled public String Region;
		@AuraEnabled public String State;
		@AuraEnabled public String Country;
	}

	
	public static list<GetPotOfficeDetailsWrapper> parse(String json) {
		return (list<GetPotOfficeDetailsWrapper>) System.JSON.deserialize(json, list<GetPotOfficeDetailsWrapper>.class);
	}

}