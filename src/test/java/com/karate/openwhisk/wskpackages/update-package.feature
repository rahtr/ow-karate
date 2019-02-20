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
#this feature is for updating a rule

@ignore
Feature: Update a package
  I want to use this template for my feature file
  
  Background:
	* configure ssl = true
    #* def pkgName = packageName
    #* print "package name is: " + packageName
    #* def ns = nameSpace
    #* print "Namespace name is: " + ns
    * def defaultPayload = {"name":'#(packageName)',"namespace":'#(nameSpace)'}
    * print "default payload is: " + defaultPayload
    #* def parameter = "parameters":[{"key":'#(paramkey)',"value":'#(paramvalue)'}]


  Scenario: As a user I want to update a package
    * eval
 		 """
					if (typeof requestBody == 'undefined') {
					    karate.set('requestBody', defaultPayload);
					} else {
							karate.set('requestBody', requestBody);
					}
 		 """


    * string payload = requestBody
    Given url BaseUrl+'/api/v1/namespaces/'+nameSpace+'/packages/'+packageName+'?overwrite=true'
    And header Authorization = Auth
    And header Content-Type = 'application/json'
    And request payload
    When method put
    * def responseStatusCode = responseStatus
    * def updateRuleResponse = response
    * print 'The value of responseStatusCode is:',responseStatusCode
    * eval
    """
    if(responseStatusCode == 200) {
    	 karate.log("Package updated");
    	 karate.set('pkgName', response.name )
    	 }
    else if(responseStatusCode == 409){
       karate.log("Duplicate package");
       }
    """
    * print 'Package name for the updated package: ' + pkgName
    * def version = response.version
    * print "New version is: "+version
    
