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
    * string scriptcode20mb = read('classpath:com/karate/openwhisk/functions/big-hello20.js')
    * string scriptcode41mb = read('classpath:com/karate/openwhisk/functions/big-hello41.js')
    * def getAuth = callonce read('classpath:com/karate/openwhisk/utils/get-auth.feature')
    * def Auth = getAuth.Auth

  Scenario: Verify create and invoke of 20 MB action
     #create a action
    * def create20MBAction = call read('classpath:com/karate/openwhisk/wskactions/create-action.feature') {script:'#(scriptcode20mb)' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * def actionName = create20MBAction.actName
    * match create20MBAction.responseStatusCode == 200
    * print "Successfully Created 20 MB action"

    #invoke the action
    * def invoke20MBAction = call read('classpath:com/karate/openwhisk/wskactions/invoke-action.feature') {params:'#(params)',requestBody:'',nameSpace:'#(nameSpace)' ,Auth:'#(Auth)',actionName:'#(actionName)'}
    * match invoke20MBAction.responseStatusCode == 200
    * print  = "Successfully invoked the 20 MB action"

  #@ignore
  Scenario: Verify creation of 41MB action
    #create a action
    * def create41MBAction = call read('classpath:com/karate/openwhisk/wskactions/create-action.feature') {script:'#(scriptcode41mb)' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * def actionName = create41MBAction.actName
    * match create41MBAction.responseStatusCode == 200
    * print "Successfully Created 41 MB action"

    #invoke the action
    * def invoke41MBAction = call read('classpath:com/karate/openwhisk/wskactions/invoke-action.feature') {params:'#(params)',requestBody:'',nameSpace:'#(nameSpace)' ,Auth:'#(Auth)',actionName:'#(actionName)'}
    * match invoke41MBAction.responseStatusCode == 200
    * print  = "Successfully invoked the 41 MB action"