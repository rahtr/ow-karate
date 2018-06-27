#Author: mamishra@adobe.com
#Keywords Summary : This feature is all about basic test cases of openwhisk
@basictests
Feature: This feature contains basic test cases of openwhisks

  Background: 
    * configure ssl = true
    * def nameSpace = 'guest'
    * def params = '?blocking=true&result=false'
    * def scriptcode = call read('classpath:com/karate/openwhisk/functions/hello-world.js')
    * def base64encoding = read('classpath:com/karate/openwhisk/utils/base64.js')

  Scenario: As a user i want to verify the creation of duplicate entity
    # Get User Auth
    * def getNSCreds = call read('classpath:com/karate/openwhisk/wskadmin/get-user.feature') {nameSpace:'#(nameSpace)'}
    * def result = getNSCreds.result
    * def Auth = base64encoding(result)
    * print "Got the Creds for the guest user"
    * print Auth
    #create action. Create an action for the above defined guest name
    
    * def createAction = call read('classpath:com/karate/openwhisk/wskactions/create-action.feature') {script:'#(scriptcode)' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * def actionName = createAction.actName
    * print actionName
    * print "Successfully Created an action"
    
    #recreate the duplicate action with the same name
    * def createAction = call read('classpath:com/karate/openwhisk/wskactions/create-action.feature') {script:'#(scriptcode)' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)' ,actionName:'#(actionName)'}
    * def actionName = createAction.actName
    * match createAction.response.error == "resource already exists"
    
    
