#Author: rtripath@adobe.com
# Summary :This feature file can be used to get action destils using action name
@ignore
Feature: Get Action

Background:
* configure ssl = true
 
  Scenario: Get Details of an action
    Given url BaseUrl
    And path '/api/v1/namespaces/'+nameSpace+'/actions/'+actionName
    And header Authorization = Auth
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And string action_details = response

 
