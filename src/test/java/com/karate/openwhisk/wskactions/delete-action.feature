#Author: rtripath@adobe.com
# Summary :This feature file will delete the action name based on the ActionName

@ignore
Feature:  Delete the action on the basis of the ActionName

  Background:
* configure ssl = true


  Scenario: As a user I want to get the list of actions available for the given namespace
    * def path = '/api/v1/namespaces/'+nameSpace+'/actions/'+actionName
    Given url BaseUrl+path
    And header Authorization = Auth
    And header Content-Type = 'application/json'
    When method delete
    Then status 200


   
   
