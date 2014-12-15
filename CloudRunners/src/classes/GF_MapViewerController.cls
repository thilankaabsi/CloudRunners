/**
* Thilanka Kumarasingha
*
* The controller for the Map Viewer page. In the map viewer page you will be able to 
* see all the locations that others are marked as interesting
*/
public with sharing class GF_MapViewerController {

	/**
	* this method can be modified to get nearby locations
	* use js remoting to get data to map as a json array
	*/
	@RemoteAction
	public static List<LocationDTO> getLocations() {
		return GF_Utils.getAllLocationsMapped(); 
	}
}