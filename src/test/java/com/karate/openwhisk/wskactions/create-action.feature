#Author: rtripath@adobe.com
# Summary :This feature file can be used to create actions
@ignore

Feature: Create an Action
  I want to use this template for my feature file
  
  Background:
* configure ssl = true


  Scenario: As a user I want to create an action
    
 #Create an Action
     * def actionName =  'Testing'+java.util.UUID.randomUUID()
     * def requestBody = {"namespace":'#(nameSpace)',"name":'#(actionName)',"exec":{"kind":"nodejs:default","code":'#(script)'}}
     * string payload = requestBody
    Given url BaseUrl+'/api/v1/namespaces/'+nameSpace+'/actions/'+actionName+'?overwrite=false'
    And header Authorization = Auth
    And header Content-Type = 'application/json'
    And request payload
    When method put
    Then status 200
    And def actName = response.name
    * print 'Action name for the created action ' + actName+status
    
    
    
  