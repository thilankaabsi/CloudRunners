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
    public boolean postEditable {get;set;}
    
    /**
     * Constructor
     */
    public GF_PostDetailExtension(ApexPages.StandardController controller) {
    	
        try{
        
            this.glc = (Geo_Location__c)controller.getRecord();
            this.postTitle = this.glc.Title__c;
            this.postDescription = this.glc.Description__c;
            this.postEditable = true;
            
            loadAttachment();
            			
        } Catch(Exception ex){
        	
            ApexPages.Message errMsg = new ApexPages.Message(ApexPages.severity.INFO, ex.getMessage());  
            ApexPages.addMessage(errMsg);
        }
    }
    
    /**
	* Load attachments related ot the selected post
	*/
   	public void loadAttachment() {
    
        try{      

           this.postAttachment = [ SELECT Id FROM Attachment WHERE ParentId =: this.glc.Id LIMIT 1 ];

            if(!this.postAttachment.isEmpty()) {

                this.postImage = '/servlet/servlet.FileDownload?file=' + this.postAttachment[0].Id;                  
            }
            			
        } Catch(Exception ex){
            ApexPages.Message errMsg = new ApexPages.Message(ApexPages.severity.INFO, ex.getMessage());  
            ApexPages.addMessage(errMsg);
        }
    }
    	
    
    public void edit() {
    	
        try{      
            this.postEditable = false;
            			
        } Catch(Exception ex){
            ApexPages.Message errMsg = new ApexPages.Message(ApexPages.severity.INFO, ex.getMessage());  
            ApexPages.addMessage(errMsg);
        }
    }
    	
   	public void save() {
        try{      
            this.glc.Name = this.glc.Title__c;
            
            update this.glc;
            
            this.postEditable = true;
            ApexPages.Message errMsg = new ApexPages.Message(ApexPages.severity.INFO, 'Succesfully Saved');  
            ApexPages.addMessage(errMsg);
        }
        Catch(Exception ex){
            ApexPages.Message errMsg = new ApexPages.Message(ApexPages.severity.INFO, ex.getMessage());  
            ApexPages.addMessage(errMsg);
        }
    }

    public void remove() {
        try{      
              
            delete this.glc;
            
            this.postEditable = true;
            ApexPages.Message errMsg = new ApexPages.Message(ApexPages.severity.INFO, 'Succesfully Deleted');  
            ApexPages.addMessage(errMsg);
        }
        Catch(Exception ex){
            ApexPages.Message errMsg = new ApexPages.Message(ApexPages.severity.INFO, ex.getMessage());  
            ApexPages.addMessage(errMsg);
        }
    }
    
    public void cancel() {
    	try{      
              
            this.postEditable = true;
        }
        Catch(Exception ex){
            ApexPages.Message errMsg = new ApexPages.Message(ApexPages.severity.INFO, ex.getMessage());  
            ApexPages.addMessage(errMsg);
        }
    }

}