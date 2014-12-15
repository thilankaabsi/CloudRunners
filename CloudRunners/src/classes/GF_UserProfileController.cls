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
        // Create's a Savepoint since data should not be committed to the database
        Savepoint sp = Database.setSavepoint();    
        try {        
            update this.user;
        } catch (Exception ex) {
            System.debug('Error in updateUser() failed. Exception : ' + ex);
            ApexPages.addMessages(ex);            
            // Revert's the database to the original state
            Database.rollback(sp);
        } 
        return null;
    }	
}