#Author: rtripath@adobe.com
# Summary :This feature file can be used to create actions
@ignore

Feature: Restart Service Via Marathon API
  
  Background:
* configure ssl = true


  Scenario: As a user I want to restart the defined service using the MarathonAPI
    
 #Restart Service Using Marathon API
    * string payload = ''  
    Given url MarathonAPIURL+'/marathon/v2/apps/'+serviceName+'/restart?force=true'
    And header Authorization = marathonAuth
    And header Content-Type = 'application/json'
    And request payload
    When method post
    Then status 200
    
    
  