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
@smoketests

Feature: This feature contains smoke test cases of openwhisk package

	Background: 
    * configure ssl = true
    * def nameSpace = test_user_ns
    * def scriptcode = call read('classpath:com/karate/openwhisk/functions/hello-world.js')
    * def scriptcodeWithParam = call read('classpath:com/karate/openwhisk/functions/greetings.js')
    * def getAuth = callonce read('classpath:com/karate/openwhisk/utils/get-auth.feature')
    * def Auth = getAuth.Auth
  #@ignore
  Scenario: As a user i want to verify create, update, get and list a package
  	* print "Test case started --> verify create, update, get and list a package"
  	#create package
  	* def createPackage = call read('classpath:com/karate/openwhisk/wskpackages/create-package.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * match createPackage.responseStatusCode == 200
    * def packageName = createPackage.pkgName
    * print "Successfully Created the package"
    
    #get the package
    * def getPackage = call read('classpath:com/karate/openwhisk/wskpackages/get-package.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)',packageName:'#(packageName)'}
    * match getPackage.responseStatusCode == 200
    * def actualPackageName = getPackage.pkgName
    * match actualPackageName == packageName
    * print "Asserted "+actualPackageName+" with " + packageName
    * print "Successfully got the package details" 
    
    #update the package
    * def updatePackage = call read('classpath:com/karate/openwhisk/wskpackages/update-package.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)',packageName:'#(packageName)'}
    * match updatePackage.responseStatusCode == 200
    * match updatePackage.response contains {"version":"0.0.2"}
    * print "Successfully package got updated"
    
    #list the package
    * def listRules = call read('classpath:com/karate/openwhisk/wskpackages/list-package.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * print "Successfully pulled up the list of packages"
  	* print "Test case completed --> verify create, update, get and list a package"
  #@ignore	
  Scenario: As a tester i want to verify create a package, and get its individual fields
  	* print "Test case started --> verify create a package, and get its individual fields"
  	#create package
  	* def createPackage = call read('classpath:com/karate/openwhisk/wskpackages/create-package.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * match createPackage.responseStatusCode == 200
    * def packageName = createPackage.pkgName
    * print "Successfully Created the package"
    
    #get package and verify its individual fields
    * def getPackage = call read('classpath:com/karate/openwhisk/wskpackages/get-package.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)',packageName:'#(packageName)'}
    * match getPackage.responseStatusCode == 200
    * def actualPackageName = getPackage.pkgName
    * def actualNameSpace = getPackage.response.namespace
    * def actualPublish = getPackage.response.publish
    * match actualPackageName == packageName
    * match actualNameSpace == nameSpace
    * match actualPublish == false
    * match getPackage.response contains {"version":"0.0.1"}
  	* print "Test case completed --> verify create a package, and get its individual fields"
  	
  Scenario: As a tester i want to verify allow binding of a package
  	* print "Test case started --> verify allow binding of a package"
  	#create package
  	* def createPackage = call read('classpath:com/karate/openwhisk/wskpackages/create-package.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)'}
    * match createPackage.responseStatusCode == 200
    * def packageName = createPackage.pkgName
    * print "Successfully Created the package"
    #bind the package
    * def bindPackage = call read('classpath:com/karate/openwhisk/wskpackages/bind-package.feature') {nameSpace:'#(nameSpace)' ,Auth:'#(Auth)',packageName:'#(packageName)'}
    * match bindPackage.responseStatusCode == 200
    * print "Package binding created"
  	* print "Test case completed --> verify allow binding of a package"
  
    