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
#this feature is for creating a rule

@ignore
Feature: Create a Package
  I want to use this template for my feature file
  
  Background:
	* configure ssl = true


  Scenario: As a user I want to create a package
  * eval
 		 """
					if (typeof packageName == 'undefined') {
					    karate.set('packageName', 'Package'+java.util.UUID.randomUUID());
					} else {
							karate.set('packageName', packageName);
					}
 		 """
 		* def requestBody = {"name":'#(packageName)',"namespace":"#(nameSpace)"}
    * string payload = requestBody
    Given url BaseUrl+'/api/v1/namespaces/'+nameSpace+'/packages/'+packageName+'?overwrite=false'
    And header Authorization = Auth
    And header Content-Type = 'application/json'
    And request payload
    When method put
    * def responseStatusCode = responseStatus
    * def createRuleResponse = response
    * print 'The value of responseStatusCode is:',responseStatusCode
    * eval
    """
    if(responseStatusCode == 200) {
    	 karate.log("Package Created");
    	 karate.set('pkgName', response.name )
    	 }
    else if(responseStatusCode == 409){
       karate.log("Duplicate Package");
       }
    """
    * print 'Package name for the created package is ' + pkgName