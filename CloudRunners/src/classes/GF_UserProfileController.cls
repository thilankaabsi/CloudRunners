/**
* Inshar Anas
* This control will be used to show and update users	
*
*/
public class GF_UserProfileController {
	public User user { get; set; }
	
	public GF_UserProfileController(ApexPages.StandardController controller) {
		user = GF_Utils.loadUser(UserInfo.getUserId());
	}
	
    /**
     * Update User.
     */
    public PageReference updateUser() {
        GF_Utils.updateSObj(this.user); 
        return null;
    }	
}