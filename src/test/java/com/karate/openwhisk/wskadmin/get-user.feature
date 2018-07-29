#Author: rtripath@adobe.com
# Summary :This feature file can be used to get action destils using action name
#@ignore
Feature: Create Namespace

  Background:
    * configure ssl = true
    * def nameSpace = 'guest'
    * def base64encoding = read('classpath:com/karate/openwhisk/utils/base64.js')
    #* def authFile = '/com/karate/openwhisk/utils'

  Scenario: Get NS credentials
    Given url AdminBaseUrl
    * print "I am here in get-user"
    * def DBpath =
    """
   
    if (BaseUrl.match ('rtbeta'))
    {
     DBpath = '/whisk_dev_subjects/';
    }
    else{
     DBpath = '/whisk_local_subjects/';
    }
    
    """
    #And path '/whisk_local_subjects/'+nameSpace
    And path DBpath+nameSpace
    And header Authorization = AdminAuth
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And string NScreds = response
    * def uuid = $response.namespaces[*].uuid
    * def key = $response.namespaces[*].key
    * def result = uuid[0]+':'+ key[0]
    * def Auth = base64encoding(result)
    #* def uuid = $response.namespaces[*].uuid
    * print result
    * def FileUtil = Java.type('com.karate.openwhisk.utils.OWFileUtil')
    * string fileSaveResult = FileUtil.writeToFile(Auth, 'authFile.txt')
    * assert fileSaveResult == 'success'
    # * def webhooks = callonce read('classpath:com/karate/openwhisk/utils/sleep.feature') {sheepCount:'20'}
    

 
