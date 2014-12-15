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
		
     	return null;
        
	}

}