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
#Keywords Summary : This feature is all about smoke test cases of Triggers
@dbmigrationsmoketests
@ignore
Feature: This feature contains smoke test cases of openwhisk triggers

	Background: 
    * configure ssl = true
    * def nameSpace = test_user_ns
    * def scriptcode = call read('classpath:com/karate/openwhisk/functions/hello-world.js')
    * def scriptcodeWithParam = call read('classpath:com/karate/openwhisk/functions/greetings.js')
    * def getAuth = callonce read('classpath:com/karate/openwhisk/utils/get-auth.feature')
    * def Auth = getAuth.Auth
    * def ruleName = ''
    * def triggerName1 = ''
    * def actionName1 = ''
    * def trgrName1 = ''
    * def actName1 = ''
    
   #@ignore  
  Scenario: As a user i want to verify create rule, get rule, update rule,list rule and delete rule
   	* print "Test case started --> verify create rule, get rule, update rule,list rule and delete rule" 
    #get the rule
    * def getRule = call read('classpath:com/karate/openwhisk/wskrules/get-rule.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)',ruleName:'#(ruleName)'}
    * match getRule.responseStatusCode == 200
    * def actualRuleName = getRule.rulName
    * match actualRuleName == ruleName
    * print "Asserted "+actualRuleName+" with " + ruleName
    * print "Successfully got the rule details"
    
    #update the rule
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
    # Delete the Rule
    * def deleteRule = call read('classpath:com/karate/openwhisk/wskrules/delete-rule.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)',ruleName:'#(ruleName)'}
    * match deleteRule.responseStatusCode == 200
    * print "Test case completed --> verify create rule, get rule, update rule,list rule and delete rule"
   
    
    