#Author: rtripath@adobe.com
# Summary :This feature file can be used to get action destils using action name
@ignore
Feature: Get User Credentials

Background:
* configure ssl = true
 
  Scenario: Get NS credentials
  
  #generate UUID
    * def keyMaker =  
    """
    function makeid() {
      var text = "";
      var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

      for (var i = 0; i < 64; i++)
           text += possible.charAt(Math.floor(Math.random() * possible.length));
					return text;
			}
		
    """ 
    * def nskey = keyMaker()
    * print 'Key is :' + nskey
    * def nsUUID = java.util.UUID.randomUUID()
    * print 'UUID to create namespace is :' + nsUUID
    * string xyz = nsUUID
    * def requestBody = {"_id": '#(nameSpace2)', "namespaces": [{"name": '#(nameSpace2)', "key": '#(nskey)', "uuid": '#(xyz)' }], "subject": '#(nameSpace2)'}
    * string payload = requestBody
    Given url AdminBaseUrl
    * print "I am here in get-user"
   # And path '/whisk_local_subjects/'+nameSpace
   And path '/local_subjects/'+nameSpace
    And header Authorization = AdminAuth
    And header Content-Type = 'application/json'
    When method get
    #Then status 404
    Given url AdminBaseUrl
    * print "I am here in create-user"
     And path '/whisk_local_subjects'
     And header Authorization = AdminAuth
    And header Content-Type = 'application/json'
    And request payload
    When method post
    * def responseCode = responseStatus
    * eval
    """
    if(responseCode == 201) {
    	 karate.log("User Created");
    	 }
    else if(responseCode == 409){
       karate.log("User already exists");
       }
    """
    * print 'User gets created'
    And string NScreds = response
    * print NScreds

 
