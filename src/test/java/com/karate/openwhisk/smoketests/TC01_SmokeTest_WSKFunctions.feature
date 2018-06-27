#Author: rtripath@adobe.com
#Summary :This feature file will check for the containers
@smoketests
Feature: This feature file will test all the wsk functions

  Background: 
    * configure ssl = true
    * def nameSpace = 'guest'
    * def params = '?blocking=true&result=false'
    * def scriptcode = call read('classpath:com/karate/openwhisk/functions/hello-world.js')
    * def base64encoding = read('classpath:com/karate/openwhisk/utils/base64.js')

  Scenario: TC01-As a user I want to all the wsk functions available to the user and check if they give the proper response
    # Get User Auth
    * def getNSCreds = call read('classpath:com/karate/openwhisk/wskadmin/get-user.feature') {nameSpace:'#(nameSpace)'}
    * def result = getNSCreds.result
    * def Auth = base64encoding(result)
    * print "Got the Creds for the guest user"
    * print Auth
    
    # Create an Action .Create an action for the above defined guest name
    #* def createAction = call read('classpath:com/karate/openwhisk/wskactions/create-action.feature') {script:'#(scriptcode)' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)', actionName:'Dammyyy'}
    * def createAction = call read('classpath:com/karate/openwhisk/wskactions/create-action.feature') {script:'#(scriptcode)' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * def actionName = createAction.actName
    * print actionName
    * print "Successfully Created an action"
    
    # Get Action Details
    * def actionDetails = call read('classpath:com/karate/openwhisk/wskactions/get-action.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)',actionName:'#(actionName)'}
    * print "Successfully got the action details"
    
    #Invoke Action
    * def invokeAction = call read('classpath:com/karate/openwhisk/wskactions/invoke-action.feature') {params:'#(params)',requestBody:'',nameSpace:'#(nameSpace)' ,Auth:'#(Auth)',actionName:'#(actionName)'}
    * def actID = invokeAction.activationId
    * print  = "Successfully invoked the action"
    * def webhooks = callonce read('classpath:com/karate/openwhisk/utils/sleep.feature') {sheepCount:'20'}
    
    #Get Activation details
    * def getActivationDetails = call read('classpath:com/karate/openwhisk/wskactions/get-activation-details.feature') { activationId: '#(actID)' ,Auth:'#(Auth)'}
    * print "Successfully pulled the activation details"
    
    # Update Action
    * def updateAction = call read('classpath:com/karate/openwhisk/wskactions/update-action.feature') {actionName:'#(actionName)',script:'#(scriptcode)' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * def actionName = createAction.actName
    * print actionName
    * print "Successfully updated the action"
    
    # List Action
    * def listActions = call read('classpath:com/karate/openwhisk/wskactions/list-action.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * print "Successfully pulled up the list of actions"
    
    # Delete Action
    * def deleteAction = call read('classpath:com/karate/openwhisk/wskactions/delete-action.feature') {actionName:'#(actionName)' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * print "Successfully deleted the action"
