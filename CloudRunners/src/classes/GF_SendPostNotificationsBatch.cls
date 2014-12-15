/******************************************
* Author : Inshar Anas
* Description : Send notification email batch
* Created Date : 2014-12-15
*******************************************/
global class GF_SendPostNotificationsBatch implements Database.Batchable<sObject>, Database.Stateful {
	
	private String query;
	private List<User> lsUsers;
	private String messageBody;
	public final String messageSubject = 'GeoForce Daily Notification';
	
	// Constructor
	global GF_SendPostNotificationsBatch(){}
	
	global Database.querylocator start(Database.BatchableContext BC){
		this.query = 'SELECT g.Title__c, g.Id, g.Description__c FROM Geo_Location__c g WHERE g.CreatedDate = TODAY';
		return Database.getQueryLocator(query);
	}
	
	global void execute(Database.BatchableContext BC, List<sObject> locations){
		
		this.messageBody = '';
	
		for(sObject so : locations){
			
	        Geo_Location__c location = (Geo_Location__c)so;
			this.messageBody += '<br /> <b>' + location.Title__c + '</b><br /> ' + location.Description__c + '<br /><br /> ';
			
		}
		
		this.lsUsers = [ SELECT id FROM User LIMIT 100 ];
		
		List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();  
	   
		for(User geoUser :lsUsers) {
			     
			Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();  
		   	mail.setSubject(this.messageSubject);  
		   	mail.setTargetObjectId(geoUser.Id);  
		   	mail.setSaveAsActivity(false);  
		   	mail.setHtmlBody(this.messageBody);  
		   	mails.add(mail);  
		}
		  
		Messaging.sendEmail(mails);
	
	}
	
	global void finish(Database.BatchableContext BC) {
		AsyncApexJob a = [  SELECT 	Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email
							FROM 	AsyncApexJob 
							WHERE 	Id = :BC.getJobId() ];
							
		// Sending an email to the batch submitter notifying of job completion.
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		String[] toAddresses = new String[] { a.CreatedBy.Email }; 				
		mail.setToAddresses(toAddresses);
		mail.setSubject('Send Notification job process ' + a.Status);
		mail.setPlainTextBody('The batch Send Notification job processed ' + a.TotalJobItems + ' batches with '+ a.NumberOfErrors + ' failures.');
		Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
		
	}

}