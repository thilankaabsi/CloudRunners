/******************************************
* Author : Inshar Anas
* Description : Home page Controller
* Created Date : 2014-12-15
*******************************************/
public class GF_HomeController {
	
	//Constructor
	public GF_HomeController() {
	
	}
	
	// Get all locations of the user
	public void loadLocations() {
		
		List<Geo_Location__c> locations = GF_Utils.getAllLocations();
		
	}

}