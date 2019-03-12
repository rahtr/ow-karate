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
#Author: rtripath@adobe.com
#Summary :This feature file will check for the containers
@smoketests

Feature: This feature file will test all the wsk functions

  Background: 
    * configure ssl = true
    * configure connectTimeout = 6000000
    * configure readTimeout = 6000000
    * def nameSpace = test_user_ns
    * def params = '?blocking=true&result=false'
    * def scriptcodefirst = call read('classpath:com/karate/openwhisk/functions/myAction.js')
    * def scriptcodesecondparams =  read('classpath:com/karate/openwhisk/functions/triggerAnotherAction.js')
    * def scriptcodesecond = scriptcodesecondparams(nameSpace)
    * def getAuth = callonce read('classpath:com/karate/openwhisk/utils/get-auth.feature')
    * def Auth = getAuth.Auth

  Scenario: TC01-As a user I want to all the wsk functions available to the user and check if they give the proper response
     # Create an Action .Create an action for the above defined guest name.The action code with invoke another action
    * print 'TC01 STARTS'
    * def createFirstAction = call read('classpath:com/karate/openwhisk/wskactions/create-action.feature') {script:'#(scriptcodefirst)' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)',actionName:'myNestedAction'}
    * def createSecondAction = call read('classpath:com/karate/openwhisk/wskactions/create-action.feature') {script:'#(scriptcodesecond)' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)', provideApiKey: true}
    * def actionName = createSecondAction.actName
    * print actionName
    * print "Successfully Created an action"
    
    # Get Action Details
    * def actionDetails = call read('classpath:com/karate/openwhisk/wskactions/get-action.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)',actionName:'#(actionName)'}
    * print "Successfully got the action details"
    
    #Invoke Action+ Nested Action Code
    * def invokeAction = call read('classpath:com/karate/openwhisk/wskactions/invoke-action.feature') {params:'#(params)',requestBody:'',nameSpace:'#(nameSpace)' ,Auth:'#(Auth)',actionName:'#(actionName)'}
    * def actID = invokeAction.activationId
    * print  = "Successfully invoked the action"
    * def webhooks = callonce read('classpath:com/karate/openwhisk/utils/sleep.feature') {sheepCount:'20'}
    
    #Get Activation details
    * def getActivationDetails = call read('classpath:com/karate/openwhisk/wskactions/get-activation-details.feature') { activationId: '#(actID)' ,Auth:'#(Auth)'}
    * match getActivationDetails.nestedActionName == '["/'+test_user_ns+'/myNestedAction"]'
    * print "Successfully pulled the activation details"
    
    # Update Action
    * def updateAction = call read('classpath:com/karate/openwhisk/wskactions/update-action.feature') {actionName:'#(actionName)',script:'#(scriptcodesecond)' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * def actionName = createSecondAction.actName
    * print actionName
    * print "Successfully updated the action"
    
    # List Action
    * def listActions = call read('classpath:com/karate/openwhisk/wskactions/list-action.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * print "Successfully pulled up the list of actions"
    
    # Delete Action
    * def deleteAction = call read('classpath:com/karate/openwhisk/wskactions/delete-action.feature') {actionName:'#(actionName)' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * def deleteAction = call read('classpath:com/karate/openwhisk/wskactions/delete-action.feature') {actionName:'myNestedAction' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * print "Successfully deleted the action"
    
    * print 'TC01 ENDS'
