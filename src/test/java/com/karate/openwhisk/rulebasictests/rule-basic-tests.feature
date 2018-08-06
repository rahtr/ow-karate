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
#Keywords Summary : This feature is all about basic test cases of Rule
@basictests
Feature: This feature contains basic test cases of openwhisks rules

  Background: 
    * configure ssl = true
    * def nameSpace = 'guest'
    * def nameSpace2 = 'normaluser'
    * def params = '?blocking=true&result=false'
    * def scriptcode = call read('classpath:com/karate/openwhisk/functions/hello-world.js')
    * def scriptcodeWithParam = call read('classpath:com/karate/openwhisk/functions/greetings.js')
    * def base64encoding = read('classpath:com/karate/openwhisk/utils/base64.js')
  #@ignore  
  Scenario: As a user i want to verify create rule, get rule, update rule and list rule
   	* print "Test case started --> verify create rule, get rule, update rule and list rule"
		# Get User Auth
    * def getNSCreds = call read('classpath:com/karate/openwhisk/wskadmin/get-user.feature') {nameSpace:'#(nameSpace)'}
    * def result = getNSCreds.result
    * def Auth = base64encoding(result)
    * print "Got the Creds for the guest user"
    * print Auth  
    #create a trigger
    * def createTrigger = call read('classpath:com/karate/openwhisk/wsktriggers/create-trigger.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * match createTrigger.responseStatusCode == 200
    * def triggerName = createTrigger.trgrName
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
    * def ruleName = createRule.rulName
    * match createRule.responseStatusCode == 200
    * print 'successfully created the rule'
    #get the rule
    * def getRule = call read('classpath:com/karate/openwhisk/wskrules/get-rule.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)',ruleName:'#(ruleName)'}
    * match getRule.responseStatusCode == 200
    * def actualRuleName = getRule.rulName
    * match actualRuleName == ruleName
    * print "Asserted "+actualRuleName+" with " + ruleName
    * print "Successfully got the rule details"
    
    #update the rule
    # create another trigger to update the rule
    * def trgrName1 = 'Trigger'+java.util.UUID.randomUUID()
    * def createTrigger = call read('classpath:com/karate/openwhisk/wsktriggers/create-trigger.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)', triggerName:'#(trgrName1)'}
    * def triggerName1 = createTrigger.trgrName
    * match createTrigger.responseStatusCode == 200
    * print "Successfully Created an trigger"
    #create another action to update the rule
    * def actName1 = 'Testing'+java.util.UUID.randomUUID()
    * def createAction = call read('classpath:com/karate/openwhisk/wskactions/create-action.feature') {actionName:'#(actName1)', script:'#(scriptcode)' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * def actionName1 = createAction.actName
    * match createAction.responseStatusCode == 200
    * print "Successfully Created an action"
    #now updating the rule
    * def trgrName = '/'+nameSpace +'/'+triggerName1
    * def actName = '/'+nameSpace +'/'+actionName1
    * def updateRule = call read('classpath:com/karate/openwhisk/wskrules/update-rule.feature') {ruleName:'#(ruleName)', triggerName:'#(trgrName)', actionName:'#(actName)' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * def ruleName = updateRule.rulName
    * print ruleName
    * def actualTriggerName = updateRule.updateRuleResponse.trigger.name
    * match actualTriggerName == trgrName1
    * print "Asserted "+actualTriggerName+" with " + trgrName1
    * def actualActionName = updateRule.updateRuleResponse.action.name
    * match actualActionName == actName1
    * print "Asserted "+actualActionName+" with " + actName1
    * print "Successfully updated the rule"
    # List rules
    * def listRules = call read('classpath:com/karate/openwhisk/wskrules/list-rule.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * print "Successfully pulled up the list of rules"
    * print "Test case completed --> verify create rule, get rule, update rule and list rule"
  
  #@ignore 
  Scenario: As a user i want to verify create rule, get rule, ensure rule is enabled by default
    * print "Test case started --> verify create rule, get rule, ensure rule is enabled by default"
    # Get User Auth
    * def getNSCreds = call read('classpath:com/karate/openwhisk/wskadmin/get-user.feature') {nameSpace:'#(nameSpace)'}
    * def result = getNSCreds.result
    * def Auth = base64encoding(result)
    * print "Got the Creds for the guest user"
    * print Auth  
     #create a trigger
    * def createTrigger = call read('classpath:com/karate/openwhisk/wsktriggers/create-trigger.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * match createTrigger.responseStatusCode == 200
    * def triggerName = createTrigger.trgrName
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
    * def ruleName = createRule.rulName
    * match createRule.responseStatusCode == 200
    * print 'successfully created the rule'
    * def ruleStatus = createRule.createRuleResponse.status
    * match ruleStatus == "active"
    * print "Asserted "+ruleStatus+" with active"
    * print "Test case completed --> verify create rule, get rule, ensure rule is enabled by default"
  #@ignore  
  Scenario: As user i want to verify reject creation of duplicate rules  
    * print "Test case started --> verify creject creation of duplicate rules"
    # Get User Auth
    * def getNSCreds = call read('classpath:com/karate/openwhisk/wskadmin/get-user.feature') {nameSpace:'#(nameSpace)'}
    * def result = getNSCreds.result
    * def Auth = base64encoding(result)
    * print "Got the Creds for the guest user"
    * print Auth  
     #create a trigger
    * def createTrigger = call read('classpath:com/karate/openwhisk/wsktriggers/create-trigger.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * match createTrigger.responseStatusCode == 200
    * def triggerName = createTrigger.trgrName
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
    * def ruleName = createRule.rulName
    * match createRule.responseStatusCode == 200
    * print 'successfully created the rule'
    # create the same rule again
    * def createRule = call read('classpath:com/karate/openwhisk/wskrules/create-rule.feature') {ruleName:'#(ruleName)', triggerName:'#(trgrName)', actionName:'#(actName)' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * match createRule.responseStatusCode == 409
    * print "rejected creating rule as duplicate"
    * print "Test case completed --> verify creject creation of duplicate rules" 
  #@ignore
  Scenario: As user i want to verify reject delete of rule that does not exist
    * print "Test case Started --> Verify reject delete of rule that does not exist" 
    # Get User Auth
    * def getNSCreds = call read('classpath:com/karate/openwhisk/wskadmin/get-user.feature') {nameSpace:'#(nameSpace)'}
    * def result = getNSCreds.result
    * def Auth = base64encoding(result)
    * print "Got the Creds for the guest user"
    * print Auth 
    
    * def ruleName = 'Rule'+java.util.UUID.randomUUID()
    * def deleteRule = call read('classpath:com/karate/openwhisk/wskrules/delete-rule.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)',ruleName:'#(ruleName)'}
    * match deleteRule.responseStatusCode == 404
  	*  print "Trigger got deleted"
    * print "Test case completed --> Verify reject delete of rule that does not exist" 
  #@ignore
  Scenario: As user i want to verify reject enable of rule that does not exist
  	* print "Test case Started --> verify reject enable of rule that does not exist" 
  	# Get User Auth
    * def getNSCreds = call read('classpath:com/karate/openwhisk/wskadmin/get-user.feature') {nameSpace:'#(nameSpace)'}
    * def result = getNSCreds.result
    * def Auth = base64encoding(result)
    * print "Got the Creds for the guest user"
    * print Auth 
    
    * def ruleName = 'Rule'+java.util.UUID.randomUUID()
    * def deleteRule = call read('classpath:com/karate/openwhisk/wskrules/delete-rule.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)',ruleName:'#(ruleName)'}
    * match deleteRule.responseStatusCode == 404
    * print "Test case completed --> verify reject enable of rule that does not exist"
  #@ignore  
  Scenario: As user i want to verify reject disable of rule that does not exist 
   	* print "Test case Started --> verify reject disable of rule that does not exist" 
  	# Get User Auth
    * def getNSCreds = call read('classpath:com/karate/openwhisk/wskadmin/get-user.feature') {nameSpace:'#(nameSpace)'}
    * def result = getNSCreds.result
    * def Auth = base64encoding(result)
    * print "Got the Creds for the guest user"
    * print Auth 
    
    * def ruleName = 'Rule'+java.util.UUID.randomUUID()
    * def deleteRule = call read('classpath:com/karate/openwhisk/wskrules/disable-rule.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)',ruleName:'#(ruleName)'}
    * match deleteRule.responseStatusCode == 404
    * print "Test case completed --> verify reject disable of rule that does not exist"
  #@ignore  
  Scenario: As user i want to verify reject get of rule that does not exist
   	* print "Test case Started --> verify reject get of rule that does not exist" 
  	# Get User Auth
    * def getNSCreds = call read('classpath:com/karate/openwhisk/wskadmin/get-user.feature') {nameSpace:'#(nameSpace)'}
    * def result = getNSCreds.result
    * def Auth = base64encoding(result)
    * print "Got the Creds for the guest user"
    * print Auth 
    
    * def ruleName = 'Rule'+java.util.UUID.randomUUID() 
    #get the rule
    * def getRule = call read('classpath:com/karate/openwhisk/wskrules/get-rule.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)',ruleName:'#(ruleName)'}
    * match getRule.responseStatusCode == 404
    * print "Test case completed --> verify reject get of rule that does not exist"
    
    
    
    