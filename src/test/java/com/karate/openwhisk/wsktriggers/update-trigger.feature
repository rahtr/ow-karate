#Author: mamishra@adobe.com
#this feature is for updating the trigger

@ignore
Feature: Update a Trigger details
  I want to use this template for my feature file
  
  Background:
	* configure ssl = true
	
	Scenario: As a user i want to update a trigger
	  #Update an Action
    * def requestBody = {"name":"#(triggerName)"}
    * string payload = requestBody
    Given url BaseUrl+'/api/v1/namespaces/'+nameSpace+'/triggers/'+triggerName+'?overwrite=true'
    And header Authorization = Auth
    And header Content-Type = 'application/json'
    And request payload
    When method put
    Then status 200
    And def trgrName = response.name
    * print 'Trigger name for the created trigger ' + trgrName
