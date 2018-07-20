@apimanagement
@ignnore
Feature: The feature gets the list of API's from the input base path.This Feature can be run standalone or in sequence with other tests

 Background: 
    * configure ssl = true
    * def nameSpace = 'guest'

    
  Scenario: Import Swagger.json from the utils and print the output as a string    
     Given url BaseUrl + '/api/v1/web/whisk.system/apimgmt/getApi.http?accesstoken=DUMMY+TOKEN&basepath=v2'+ '&spaceguid='+guid
     And header Authorization = Auth
     And header Content-Type = 'application/json'
     When method get
     And string ApiList = response
     * print ApiList
     Then status 200