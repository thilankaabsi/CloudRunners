/*******************************************************************
 * Description      : Controller Extension for GF_PostCapture VF Page
 * @author          : Shermal Warnakula
 * @since           : 15 Dec 2014
 *******************************************************************/
public with sharing class GF_PostCaptureExtension {
	
	public Geo_Location__c geoLocation {get; set;}
	private Attachment geoImg {get; set;}
	
	public String base64GeoImgData {get; set;}
	public String geoImgFileName {get; set;}
	public String geoImgLatitude {get; set;}
	public String geoImgLongitude { get; set; }
	public Boolean isPostOnChat {get; set;}
	
	/**
	* constructor
	*/	
	public GF_PostCaptureExtension (Apexpages.Standardcontroller stdController){
		
		this.geoLocation = (Geo_Location__c) stdController.getRecord();
		
		this.geoImg = new Attachment();
		this.base64GeoImgData = '';
		this.geoImgFileName = '';
		this.geoImgLatitude = '';
		this.geoImgLongitude = '';
		this.isPostOnChat = false;
	}
	
	public Pagereference saveGeoLocationInfo () {
		
		// Create's a Savepoint since data should not be committed to the database
		Savepoint sp = Database.setSavepoint();

		try {
			
			//Inserts the Geo Location record
			this.geoLocation.Name = this.geoLocation.Title__c;
            this.geoLocation.Location__Latitude__s = Decimal.valueOf(geoImgLatitude);
            this.geoLocation.Location__Longitude__s = Decimal.valueOf(geoImgLongitude);
            this.geoLocation.User__c = UserInfo.getUserId();
            insert this.geoLocation;
            
            //Inserts Geo Location pic as attachment
            this.geoImg.OwnerID = Userinfo.getUserId();
            this.geoImg.ParentID = this.geoLocation.Id;
            this.geoImg.Name = this.geoImgFileName;
            this.geoImg.body = Encodingutil.base64Decode(this.base64GeoImgData);
            insert geoImg;
            
            return null;
			
		} catch (Exception ex) {
            System.debug('Error in saveGeoLocationInfo() failed. Exception : ' + ex);
            ApexPages.addMessages(ex);
            
            // Revert's the database to the original state
            Database.rollback(sp);
            
            return null;
            
        } finally {
            // Clear's the Attachment Object
            this.geoImg = null;
            
            // Initialize Page Data
            this.geoLocation = new Geo_Location__c();
            this.geoImg = new Attachment();  
            this.base64GeoImgData = '';
            this.geoImgFileName = '';   
            this.geoImgLatitude = '';
            this.geoImgLongitude = '';                         
            this.isPostOnChat = false;            
        } 
        
	}

}