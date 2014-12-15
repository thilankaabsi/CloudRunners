/**
* wrapper to the Geo_Location__c object to transfer more details to client side
*/	 
public class LocationDTO {		
	public String name { get; set; }        
    public String id { get; set; }
    public String title { get; set; }
    public String description { get; set; }
    public String attId { get; set; }
    public String latitude { get; set; }
    public String longitude { get; set; }
}