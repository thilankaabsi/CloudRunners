/******************************************
* Author : Inshar Anas
* Description : Home page Controller
* Created Date : 2014-12-15
*******************************************/
public class GF_HomeController {
	
	public List<LocationDTO> locationsDTO { get; set; }
	
    public static final Integer RESULTS_PER_PAGE = 3;  
    
    /** last page number */
    public Integer pageNumber { get; set; }
    public Boolean showMoreLink { get; set; }
    	
    //Constructor
    public GF_HomeController() {
		this.pageNumber = 0;
        this.showMoreLink = false;
        		
        this.locationsDTO = new List<LocationDTO>();
        loadLocations();        
    }
    	
    // Get all locations of the user
    public void loadLocations() {
            
        pageNumber++;
                
        String userId = Userinfo.getUserId();
        Integer numOfResults = RESULTS_PER_PAGE * pageNumber;
        
        Integer totalNumberOfResults = 0; 
        AggregateResult[] groupedResults  = [SELECT Count(id) result_count FROM Geo_Location__c WHERE user__c =: userId ];
        		
        if(groupedResults.size() > 0) {
        	totalNumberOfResults = (Integer)groupedResults[0].get('result_count');
        }
        
        locationsDTO.clear();
        		
        for(Geo_Location__c gl : [ SELECT id, name, Title__c, Description__c, (SELECT Id, Name FROM Attachments) 
                                   FROM Geo_Location__c WHERE user__c =: userId ORDER BY LastModifiedDate DESC LIMIT:numOfResults ]) {
            LocationDTO locationDTO = new LocationDTO();
            locationDTO.title = gl.Title__c; 
            locationDTO.description = gl.Description__c;
            locationDTO.id = gl.id;
            			
            if(!gl.Attachments.isEmpty()) {
            	locationDTO.attId = gl.Attachments.get(0).id;
            }
                    
            locationsDTO.add(locationDTO);
        }
                            
        System.debug('################# totalNumberOfResults :' + totalNumberOfResults + ' numOfResults :' + numOfResults + ' pageNumber :' + pageNumber);
        		
        if(totalNumberOfResults > numOfResults) {                    
        	showMoreLink = true;
        } else {
            showMoreLink = false;
        }               
    }
    
}