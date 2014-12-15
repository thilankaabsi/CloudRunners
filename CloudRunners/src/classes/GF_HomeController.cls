/******************************************
* Author : Inshar Anas
* Description : Home page Controller
* Created Date : 2014-12-15
*******************************************/
public class GF_HomeController {
	
	public List<LocationDTO> locationsDTO { get; set; }
	
	//Constructor
	public GF_HomeController() {
		this.loadLocations();
	}
	
	// Get all locations of the user
	public void loadLocations() {
		
		this.locationsDTO = GF_Utils.getAllLocationsMappedForUser(UserInfo.getUserId());
		
	}

}