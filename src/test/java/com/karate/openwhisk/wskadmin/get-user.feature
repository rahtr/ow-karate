#Author: rtripath@adobe.com
# Summary :This feature file can be used to get action destils using action name
@ignore
Feature: Create Namespace

Background:
* configure ssl = true
 
  Scenario: Get NS credentials
    Given url AdminBaseUrl
    * print "I am here in create-user"
  #  And path '/local_subjects/'+nameSpace
     And path '/whisk_dev_subjects/'+nameSpace
    And header Authorization = AdminAuth
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And string NScreds = response

 
