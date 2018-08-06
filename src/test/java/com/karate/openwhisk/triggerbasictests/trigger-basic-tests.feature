#/*
 #*  Copyright 2017-2018 Adobe.
 #*
 #*  Licensed under the Apache License, Version 2.0 (the "License");
 #*  you may not use this file except in compliance with the License.
 #*  You may obtain a copy of the License at
 #*
 #*          http://www.apache.org/licenses/LICENSE-2.0
 #*
 #*  Unless required by applicable law or agreed to in writing, software
 #*  distributed under the License is distributed on an "AS IS" BASIS,
 #*  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 #*  See the License for the specific language governing permissions and
 #*  limitations under the License.
 #*/
#Author: mamishra@adobe.com
#Keywords Summary : This feature is all about basic test cases of Triggers

@basictests
Feature: This feature contains basic test cases of openwhisks triggers

	Background: 
    * configure ssl = true
    * def nameSpace = 'guest'
    * def nameSpace2 = 'normaluser'
    * def scriptcode = call read('classpath:com/karate/openwhisk/functions/hello-world.js')
    * def scriptcodeWithParam = call read('classpath:com/karate/openwhisk/functions/greetings.js')
    * def base64encoding = read('classpath:com/karate/openwhisk/utils/base64.js') 
	
	#@ignore
	Scenario: As a user i want to verify create, update, get, fire, list and delete trigger
		* print "Test case started --> verify create, update, get, fire, list and delete trigger"
		# Get User Auth
    * def getNSCreds = call read('classpath:com/karate/openwhisk/wskadmin/get-user.feature') {nameSpace:'#(nameSpace)'}
    * def result = getNSCreds.result
    * def Auth = base64encoding(result)
    * print "Got the Creds for the guest user"
    * print Auth
    
    #create a trigger
    * def createTrigger = call read('classpath:com/karate/openwhisk/wsktriggers/create-trigger.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * def triggerName = createTrigger.trgrName
    * match createTrigger.responseStatusCode == 200
    * print "Successfully Created an trigger"
    
    #fire a trigger
    * def fireTrigger = call read('classpath:com/karate/openwhisk/wsktriggers/fire-trigger.feature') {requestBody:'',nameSpace:'#(nameSpace)' ,Auth:'#(Auth)',triggerName:'#(triggerName)'}
    * def actID = fireTrigger.activationId
    * match fireTrigger.responseStatusCode == 204
    * print "Successfully fired the trigger"
    * def webhooks = callonce read('classpath:com/karate/openwhisk/utils/sleep.feature') {sheepCount:'20'}
    
   	#get trigger details
   	* def triggerDetails = call read('classpath:com/karate/openwhisk/wsktriggers/get-trigger.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)',triggerName:'#(triggerName)'}
    * print "Successfully got the trigger details"
    
    #update the trigger
    * def updateTrigger = call read('classpath:com/karate/openwhisk/wsktriggers/update-trigger.feature') {triggerName:'#(triggerName)',nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * def triggerName = updateTrigger.trgrName
    * print triggerName
    * print "Successfully updated the trigger"
    
    # List Triggers
    * def listRules = call read('classpath:com/karate/openwhisk/wsktriggers/list-trigger.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * print "Successfully pulled up the list of triggers"
    
    #Delete the trigger
    * def deleteTrigger = call read('classpath:com/karate/openwhisk/wsktriggers/delete-trigger.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)',triggerName:'#(triggerName)'}
  	* match deleteTrigger.responseStatusCode == 200
  	*  print "Trigger got deleted"
  	* print "Test case completed --> verify create, update, get, fire, list and delete trigger"
  	
  #@ignore  
	Scenario: As user i want to verify create a trigger with a name that contains spaces
		* print "Test case started --> verify create a trigger with a name that contains spaces"
		# Get User Auth
    * def getNSCreds = call read('classpath:com/karate/openwhisk/wskadmin/get-user.feature') {nameSpace:'#(nameSpace)'}
    * def result = getNSCreds.result
    * def Auth = base64encoding(result)
    * print "Got the Creds for the guest user"
    * print Auth
    
    #create a trigger
    * def UUID = java.util.UUID.randomUUID()
    * def triggerNameWithSpce = 'Trigger%20'+ UUID
    * def createTrigger = call read('classpath:com/karate/openwhisk/wsktriggers/create-trigger.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)', triggerName:'#(triggerNameWithSpce)'}
    * def triggerName = createTrigger.trgrName
    * match createTrigger.responseStatusCode == 200
    * match triggerName == "Trigger "+ UUID
    * print "Successfully Created an trigger"
  #@ignore  
  Scenario: As a user i want to verify reject creation of duplicate triggers
    * print "Test case started --> verify reject creation of duplicate triggers"
		# Get User Auth
    * def getNSCreds = call read('classpath:com/karate/openwhisk/wskadmin/get-user.feature') {nameSpace:'#(nameSpace)'}
    * def result = getNSCreds.result
    * def Auth = base64encoding(result)
    * print "Got the Creds for the guest user"
    * print Auth
    
    #create a trigger
    * def createTrigger = call read('classpath:com/karate/openwhisk/wsktriggers/create-trigger.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * def triggerName = createTrigger.trgrName
    * match createTrigger.responseStatusCode == 200 
    * print "Successfully Created an trigger"
    
    #Create the same trigger again
    * def createTrigger = call read('classpath:com/karate/openwhisk/wsktriggers/create-trigger.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)', triggerName:'#(triggerName)'}
    * def triggerName = createTrigger.trgrName
    * match createTrigger.responseStatusCode == 409 
    * print "Successfully rejected for duplicate trigger"
    * print "Test case completed --> verify reject creation of duplicate triggers"
  #@ignore  
	Scenario: As a user i want to verify reject delete of trigger that does not exist
    * print "Test case started --> verify reject delete of trigger that does not exist" 
		# Get User Auth
    * def getNSCreds = call read('classpath:com/karate/openwhisk/wskadmin/get-user.feature') {nameSpace:'#(nameSpace)'}
    * def result = getNSCreds.result
    * def Auth = base64encoding(result)
    * print "Got the Creds for the guest user"
    * print Auth 
    
    * def triggerName = 'Trigger'+java.util.UUID.randomUUID()
    #delete the trigger
    * def deleteTrigger = call read('classpath:com/karate/openwhisk/wsktriggers/delete-trigger.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)',triggerName:'#(triggerName)'}
	 	* match deleteTrigger.responseStatusCode == 404
	 	* print "Test case completed --> verify reject delete of trigger that does not exist"
	#@ignore 	
	Scenario: As a user i want to verify reject get of trigger that does not exist
    * print "Test case started --> verify reject get of trigger that does not exist" 
    # Get User Auth
    * def getNSCreds = call read('classpath:com/karate/openwhisk/wskadmin/get-user.feature') {nameSpace:'#(nameSpace)'}
    * def result = getNSCreds.result
    * def Auth = base64encoding(result)
    * print "Got the Creds for the guest user"
    * print Auth
    
    * def triggerName = 'Trigger'+java.util.UUID.randomUUID()
    #get the trigger details
    * def triggerDetails = call read('classpath:com/karate/openwhisk/wsktriggers/get-trigger.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)',triggerName:'#(triggerName)'}
    * match triggerDetails.responseStatusCode == 404
    * print "Test case completed --> verify reject get of trigger that does not exist"
  #@ignore
  Scenario: As a user i want to verify reject firing of a trigger that does not exist
    * print "Test case started --> verify reject firing of a trigger that does not exist" 
    # Get User Auth
    * def getNSCreds = call read('classpath:com/karate/openwhisk/wskadmin/get-user.feature') {nameSpace:'#(nameSpace)'}
    * def result = getNSCreds.result
    * def Auth = base64encoding(result)
    * print "Got the Creds for the guest user"
    * print Auth  
    
    * def triggerName = 'Trigger'+java.util.UUID.randomUUID()
    #fire the trigger
    * def fireTrigger = call read('classpath:com/karate/openwhisk/wsktriggers/fire-trigger.feature') {requestBody:'',nameSpace:'#(nameSpace)' ,Auth:'#(Auth)',triggerName:'#(triggerName)'}
		* match fireTrigger.responseStatusCode == 404
    * print "Test case completed --> verify reject firing of a trigger that does not exist"
  #@ignore  
  Scenario: As a user i want to verify create and fire a trigger with a rule
    * print "Test case started --> verify create and fire a trigger with a rule" 
    # Get User Auth
    * def getNSCreds = call read('classpath:com/karate/openwhisk/wskadmin/get-user.feature') {nameSpace:'#(nameSpace)'}
    * def result = getNSCreds.result
    * def Auth = base64encoding(result)
    * print "Got the Creds for the guest user"
    * print Auth 
    
    #create a trigger
    * def createTrigger = call read('classpath:com/karate/openwhisk/wsktriggers/create-trigger.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * def triggerName = createTrigger.trgrName
    * match createTrigger.responseStatusCode == 200
    * print "Successfully Created an trigger" 
    #create a action
    * def createAction = call read('classpath:com/karate/openwhisk/wskactions/create-action.feature') {script:'#(scriptcode)' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * def actionName = createAction.actName
    * match createAction.responseStatusCode == 200
    * print "Successfully Created an action"
    #create a rule
    * def trgrName = '/'+nameSpace +'/'+triggerName
    * def actName = '/'+nameSpace +'/'+actionName
    * def createRule = call read('classpath:com/karate/openwhisk/wskrules/create-rule.feature') {triggerName:'#(trgrName)', actionName:'#(actName)' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * match createRule.responseStatusCode == 200
    * print 'successfully created the rule'
    #fire the trigger
    * def fireTrigger = call read('classpath:com/karate/openwhisk/wsktriggers/fire-trigger.feature') {requestBody:'{"name":"Manoj","place":"Bangalore"}',nameSpace:'#(nameSpace)' ,Auth:'#(Auth)',triggerName:'#(triggerName)'}
    * def actID = fireTrigger.activationId
    * print  = "Successfully fired the trigger"
    * print 'Test Case completed--> verify create and fire a trigger with a rule'
  #@ignore  
  Scenario: As a user i want to verify create and fire a trigger with a rule whose action has been deleted
    * print "Test case started --> verify create and fire a trigger with a rule whose action has been deleted" 
    # Get User Auth
    * def getNSCreds = call read('classpath:com/karate/openwhisk/wskadmin/get-user.feature') {nameSpace:'#(nameSpace)'}
    * def result = getNSCreds.result
    * def Auth = base64encoding(result)
    * print "Got the Creds for the guest user"
    * print Auth
    #create a trigger
    * def createTrigger = call read('classpath:com/karate/openwhisk/wsktriggers/create-trigger.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * def triggerName = createTrigger.trgrName
    * match createTrigger.responseStatusCode == 200
    * print "Successfully Created an trigger" 
    #create a action
    * def createAction = call read('classpath:com/karate/openwhisk/wskactions/create-action.feature') {script:'#(scriptcode)' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * def actionName = createAction.actName
    * match createAction.responseStatusCode == 200
    * print "Successfully Created an action"
    #create a rule
    * def trgrName = '/'+nameSpace +'/'+triggerName
    * def actName = '/'+nameSpace +'/'+actionName
    * def createRule = call read('classpath:com/karate/openwhisk/wskrules/create-rule.feature') {triggerName:'#(trgrName)', actionName:'#(actName)' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * match createRule.responseStatusCode == 200
    * print 'successfully created the rule'
    # Delete Action
    * def deleteAction = call read('classpath:com/karate/openwhisk/wskactions/delete-action.feature') {actionName:'#(actionName)' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * match deleteAction.responseStatusCode == 200
    * print 'successfully deleted the action'
    #fire the trigger
    * def fireTrigger = call read('classpath:com/karate/openwhisk/wsktriggers/fire-trigger.feature') {requestBody:'{"name":"Manoj","place":"Bangalore"}',nameSpace:'#(nameSpace)' ,Auth:'#(Auth)',triggerName:'#(triggerName)'}
    * def actID = fireTrigger.activationId
    * match fireTrigger.responseStatusCode == 202
    * print  = "Successfully fired the trigger"
    * def webhooks = callonce read('classpath:com/karate/openwhisk/utils/sleep.feature') {sheepCount:'20'}
    #Get Activation details
    * def getActivationDetails = call read('classpath:com/karate/openwhisk/wskactions/get-activation-details.feature') { activationId: '#(actID)' ,Auth:'#(Auth)'}
    * print "Successfully pulled the activation details"
    * string log = getActivationDetails.activationDetails.logs
    * print 'logs are: ' + log
    * string error = "The requested resource does not exist."
    * match log contains error
    * print "Test case completed --> verify create and fire a trigger with a rule whose action has been deleted"
  #@ignore  
  Scenario: As a user i want to verify create and fire a trigger having an active rule and an inactive rule
    * print "Test case started --> verify create and fire a trigger having an active rule and an inactive rule"
    # Get User Auth
    * def getNSCreds = call read('classpath:com/karate/openwhisk/wskadmin/get-user.feature') {nameSpace:'#(nameSpace)'}
    * def result = getNSCreds.result
    * def Auth = base64encoding(result)
    * print "Got the Creds for the guest user"
    * print Auth
    #create a trigger
    * def createTrigger = call read('classpath:com/karate/openwhisk/wsktriggers/create-trigger.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * def triggerName = createTrigger.trgrName
    * match createTrigger.responseStatusCode == 200
    * print "Successfully Created an trigger" 
    #create a action
    * def createAction = call read('classpath:com/karate/openwhisk/wskactions/create-action.feature') {script:'#(scriptcode)' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * def actionName = createAction.actName
    * match createAction.responseStatusCode == 200
    * print "Successfully Created an action"
    #create a rule
    * def trgrName = '/'+nameSpace +'/'+triggerName
    * def actName = '/'+nameSpace +'/'+actionName
    * def createRule = call read('classpath:com/karate/openwhisk/wskrules/create-rule.feature') {triggerName:'#(trgrName)', actionName:'#(actName)' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * match createRule.responseStatusCode == 200
    * print 'successfully created the rule'
     #create another rule to make it disable
    * def trgrName = '/'+nameSpace +'/'+triggerName
    * def actName = '/'+nameSpace +'/'+actionName
    * def createRule = call read('classpath:com/karate/openwhisk/wskrules/create-rule.feature') {triggerName:'#(trgrName)', actionName:'#(actName)' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * match createRule.responseStatusCode == 200
    * def ruleName = createRule.rulName
    * print 'successfully created the rule'
    #disable the rule
    * def disableRule = call read('classpath:com/karate/openwhisk/wskrules/disable-rule.feature') {ruleName:'#(ruleName)' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * match disableRule.responseStatusCode == 200
    #fire the trigger
    * def fireTrigger = call read('classpath:com/karate/openwhisk/wsktriggers/fire-trigger.feature') {requestBody:'{"name":"Manoj","place":"Bangalore"}',nameSpace:'#(nameSpace)' ,Auth:'#(Auth)',triggerName:'#(triggerName)'}
    * def actID = fireTrigger.activationId
    * print  = "Successfully fired the trigger"
    * def webhooks = callonce read('classpath:com/karate/openwhisk/utils/sleep.feature') {sheepCount:'20'}
    #Get Activation details
    * def getActivationDetails = call read('classpath:com/karate/openwhisk/wskactions/get-activation-details.feature') { activationId: '#(actID)' ,Auth:'#(Auth)'}
    * print "Successfully pulled the activation details"
    * string log = getActivationDetails.activationDetails.logs[1]
    * print 'log is: ' + log
    * string error = "Rule \'guest/" + ruleName + "\' is inactive"
    * print "error message is: " + error
    * match log contains error
    * print "Test case completed --> verify create and fire a trigger having an active rule and an inactive rule"
    
    
    
    
    	
	 	
	 	
