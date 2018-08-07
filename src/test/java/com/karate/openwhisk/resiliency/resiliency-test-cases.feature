#Author: rtripath@adobe.com
# Summary :This feature file will check for the containers

@resiliency
@ignore

Feature:  This feature file will test all the wsk functions.It will use User3 credentails

  Background:
* configure ssl = true
* def nameSpace = NS_botTester3
* def Auth = Auth_botTester3
* def params = '?blocking=true&result=false'
* def scriptcode = call read('classpath:com/karate/openwhisk/functions/hello-world.js')
* def largeResponseAction = call read('classpath:com/karate/openwhisk/functions/largeResponse.js')



  Scenario: Create an Action , update the action details , Get Action Details and then Delete the Action
  # Create an Action 
     * def createAction = call read('classpath:com/karate/openwhisk/wskactions/create-action.feature') {script:'#(scriptcode)' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
     * def actionName = createAction.actName
     * print actName
     * print "Successfully Created an action"
     
  # Update Action
     * def updateAction = call read('classpath:com/karate/openwhisk/wskactions/update-action.feature') {actionName:'#(actionName)',script:'#(scriptcode)' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
     * def actionName = createAction.actName
     * print actionName
     * print "Successfully updated the action"
     
  # Get Action Details
  * def actionDetails = call read('classpath:com/karate/openwhisk/wskactions/get-action.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)',actionName:'#(actionName)'}
  * print "Successfully got the action details"
  
  # Delete Action   
    * def deleteAction = call read('classpath:com/karate/openwhisk/wskactions/delete-action.feature') {actionName:'#(actionName)' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * print "Successfully deleted the action"
  
 
 Scenario: Invoke an Action and get Activation Details
 # Invoke Action
  * def invokeAction = call read('classpath:com/karate/openwhisk/wskactions/invoke-action.feature') {params:'#(params)',requestBody:'',nameSpace:'#(nameSpace)' ,Auth:'#(Auth)',actionName:'#(actionName)'}
  * def actID = invokeAction.activationId
  * print  = "Successfully invoked the action"
  
 # Get Activation details
  * def getActivationDetails = call read('classpath:com/karate/openwhisk/wskactions/get-activation-details.feature') { activationId: '#(actID)' ,Auth:'#(Auth)'}
  * print "Successfully pulled the activation details"
  
  
 Scenario: Get list of actions for the given namespace 
 # List Action
     * def listActions = call read('classpath:com/karate/openwhisk/wskactions/list-action.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
     * print "Successfully pulled up the list of actions"
     
  Scenario: Create and Invoke an Action which generates large JSON response
  # Invoke Action
	  * def createAction = call read('classpath:com/karate/openwhisk/wskactions/create-action.feature') {script:'#(largeResponseAction)' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
	  * def actionName = createAction.actName
	  * def invokeAction = call read('classpath:com/karate/openwhisk/wskactions/invoke-action.feature') {params:'#(params)',requestBody:'',nameSpace:'#(nameSpace)' ,Auth:'#(Auth)',actionName:'#(actionName)'}
	  * def actID = invokeAction.activationId
	  * match invokeAction.responseStatusCode == 502
  

     

     

 