/**
* Thilanka Kumarasingha
*
* All the utility methods will go there 
* 
*/
public with sharing class GF_Utils {
	private GF_Utils() {
		
	} 
	
	/**
	* this method will return all the locations for a given user
	*/
	public static List<Geo_Location__c> getAllLocations( String userId ) {
		return [SELECT Description__c, Title__c, Name, 
					Location__latitude__s, Location__longitude__s
					FROM Geo_Location__c
					WHERE User__c=:userId];		
	}
	
	/**
	* this method will return all the locations t
	*/
	public static List<Geo_Location__c> getAllLocations() {
		return [SELECT id, name, Title__c, Description__c, Location__latitude__s, Location__longitude__s, 
        							(SELECT Id, Name FROM Attachments) FROM Geo_Location__c ];		
	}
	
	/**
	* use this method to get all the locations mapped for display
	*/
	public static List<LocationDTO> getAllLocationsMapped() {
		List<Geo_Location__c> geoLocations = getAllLocations();
		return mapLocations(geoLocations);
	}
	
	/**
	* use this method to get all the locations mapped for display to the given user
	*/
	public static List<LocationDTO> getAllLocationsMappedForUser(String userId) {
		List<Geo_Location__c> geoLocations = getAllLocations( userId );
		return mapLocations(geoLocations);
	}
	
	public static List<LocationDTO> mapLocations( List<Geo_Location__c> geoLocations ) {
		List<LocationDTO> locations = new List<LocationDTO>();
		
		for(Geo_Location__c geoLocation:geoLocations) {
			LocationDTO locationDto = mapLocation(geoLocation);
			locations.add(locationDto);
		}
		
		return locations;
	}
	 
	/**
	* map the location
	*/
	public static LocationDTO mapLocation( Geo_Location__c gl ) {
		LocationDTO locationDTO = new LocationDTO();
		
        locationDTO.title = gl.Title__c; 
        locationDTO.description = gl.Description__c;
        locationDTO.id = gl.id;
        locationDTO.name = gl.name;
        locationDTO.latitude = String.valueOf(gl.Location__latitude__s);
        locationDTO.longitude = String.valueOf(gl.Location__longitude__s);
        if(!gl.Attachments.isEmpty()) {
			locationDTO.attId = gl.Attachments.get(0).id;
        } else { 
        	// TODO Display the default image
                
        }
		
		return locationDTO;
	}

}