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
#Summary :This feature file will 1)Import the swagger file 2)Get the list of API's 3)Hit each API and assert on 200 OK
@smoketests



Feature: This feature file will test the basic API Management Functionality

  Background: 
    * configure ssl = true
    * def nameSpace = test_user_ns
    * def params = '?blocking=true&result=false'
    * def scriptcodeget = call read('classpath:com/karate/openwhisk/functions/getResponse.js')
    * def scriptcodepost = call read('classpath:com/karate/openwhisk/functions/postResponse.js')
    * def scriptcodeput = call read('classpath:com/karate/openwhisk/functions/putResponse.js')
    * def scriptcodedelete = call read('classpath:com/karate/openwhisk/functions/deleteResponse.js')
    * def base64encoding = read('classpath:com/karate/openwhisk/utils/base64.js')
    * string raw_swagger = read('classpath:com/karate/openwhisk/utils/pet-store-swagger.json')
    * def getAuth = callonce read('classpath:com/karate/openwhisk/utils/get-auth.feature')
    * def Auth = getAuth.Auth
    * def guid = getAuth.guid
    * def webAction = 'true'
       * table apis
    | endpoint   | methodtype |
    | '/apis/'+nameSpace+'/v2/pet/test123'  | 'get'|
    |'/apis/'+nameSpace+'/v2/pet/test123'    |'post'|
    |'/apis/'+nameSpace+'/v2/pet/test123'    |'delete'|
    |'/apis/'+nameSpace+'/v2/pet'   |'post'|
    |'/apis/'+nameSpace+'/v2/pet'   |'put'|
    |'/apis/'+nameSpace+'/v2/pet/findByStatus'   |'get'|
    |'/apis/'+nameSpace+'/v2/store/order'        |'post'|
    |'/apis/'+nameSpace+'/v2/store/order/test234' |'get'|
    |'/apis/'+nameSpace+'/v2/store/order/test234' |'delete'|
    |'/apis/'+nameSpace+'/v2/user/logout'         |'get'|
    |'/apis/'+nameSpace+'/v2/user'                |'post'|
    |'/apis/'+nameSpace+'/v2/user/login'          |'get'|
    |'/apis/'+nameSpace+'/v2/pet/test123/uploadImage'  |'post'|
    |'/apis/'+nameSpace+'/v2/user/createWithArray'    |'post'|
    |'/apis/'+nameSpace+'/v2/pet/findByTags'          |'get'|
    |'/apis/'+nameSpace+'/v2/store/inventory'         |'get'|
    |'/apis/'+nameSpace+'/v2/user/createWithList'     |'post'|
    |'/apis/'+nameSpace+'/v2/user/tester'             |'get'|
    |'/apis/'+nameSpace+'/v2/user/tester'             |'put'|
    |'/apis/'+nameSpace+'/v2/user/tester'             |'delete'|

    
  Scenario: TC03-As a user I want to import my swagger.json and see if my API gives a Two Hundred OK response  
    # Delete the list of actions if already present
    * def deleteAction = call read('classpath:com/karate/openwhisk/wskactions/delete-action.feature') {actionName:'getResponse' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * def deleteAction = call read('classpath:com/karate/openwhisk/wskactions/delete-action.feature') {actionName:'postResponse' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * def deleteAction = call read('classpath:com/karate/openwhisk/wskactions/delete-action.feature') {actionName:'putResponse' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * def deleteAction = call read('classpath:com/karate/openwhisk/wskactions/delete-action.feature') {actionName:'deleteResponse' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * print "Successfully deleted all the actions"
    
    
    # Create an Action .Create an 4 actions for the above defined guest name.This will be used by the API's
    * def createAction = call read('classpath:com/karate/openwhisk/wskactions/create-action.feature') {script:'#(scriptcodeget)' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)' , actionName: 'getResponse' , webAction: '#(webAction)'}
    * def createAction = call read('classpath:com/karate/openwhisk/wskactions/create-action.feature') {script:'#(scriptcodepost)' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)', actionName: 'postResponse' , webAction: '#(webAction)'}
    * def createAction = call read('classpath:com/karate/openwhisk/wskactions/create-action.feature') {script:'#(scriptcodeput)' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)' , actionName: 'putResponse' , webAction: '#(webAction)'}
    * def createAction = call read('classpath:com/karate/openwhisk/wskactions/create-action.feature') {script:'#(scriptcodedelete)' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)' ,actionName: 'deleteResponse' , webAction: '#(webAction)'}s
    * print "Successfully Created the required actions"
    
    # Call the import Swagger feature file and import the swagger
    * def importSwagger = call read('classpath:com/karate/openwhisk/apimanagement/import-swagger.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)',guid:'#(guid)' , raw_swagger: '#(raw_swagger)'}
    * print "Successfully imported the swagger"
    
    #Call the get-api-list swagger to get the list of the imported swagger
    * def getSwaggerList = call read('classpath:com/karate/openwhisk/apimanagement/get-api-list.feature') {guid:'#(guid)' ,Auth:'#(Auth)'}
    * print  = "Successfully got the List of API's"
    * def sleepsometime = callonce read('classpath:com/karate/openwhisk/utils/sleep.feature') {sheepCount:'15'}
     * print "Got the List of APIs Hurray!"
   
      #Hit the imnported APIs and asset the response
      * def result = callonce read('classpath:com/karate/openwhisk/apimanagement/hit-api.feature') apis
   
   
      # Call the Delete API feature file to delete the imported API List
    * def deleteSwagger = call read('classpath:com/karate/openwhisk/apimanagement/delete-api-list.feature') {guid:'#(guid)' ,Auth:'#(Auth)'}
    * print "Successfully imported the swagger"
    
    # Delete the list of actions
    * def deleteAction = call read('classpath:com/karate/openwhisk/wskactions/delete-action.feature') {actionName:'getResponse' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * def deleteAction = call read('classpath:com/karate/openwhisk/wskactions/delete-action.feature') {actionName:'postResponse' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * def deleteAction = call read('classpath:com/karate/openwhisk/wskactions/delete-action.feature') {actionName:'putResponse' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * def deleteAction = call read('classpath:com/karate/openwhisk/wskactions/delete-action.feature') {actionName:'deleteResponse' ,nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * print "Successfully deleted all the actions"
    
    