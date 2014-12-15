/*******************************************************************
 * Description      : Controller Extension for GF_PostDetail VF Page
 * @author          : Shermal Warnakula
 * @since           : 15 Dec 2014
 *******************************************************************/
public with sharing class GF_PostDetailExtension {
	
    private final Geo_Location__c glc;
    private List<Attachment> postAttachment = new List<Attachment>();
    
    public string postTitle{get;set;}
    public string postDescription{get;set;}
    public string postImage{get;set;}
    
    public GF_PostDetailExtension(ApexPages.StandardController controller) {
    	
        try{
        
            this.glc = (Geo_Location__c)controller.getRecord();
            this.postTitle = this.glc.Title__c;
            this.postDescription = this.glc.Description__c;
            
            loadAttachment();
            			
        } Catch(Exception ex){
        	
            ApexPages.Message errMsg = new ApexPages.Message(ApexPages.severity.INFO, ex.getMessage());  
            ApexPages.addMessage(errMsg);
        }
    }
    	
   	public void loadAttachment() {
    

    }

}