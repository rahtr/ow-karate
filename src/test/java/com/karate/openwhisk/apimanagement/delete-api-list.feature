@apimanagement
@ignnore
Feature: The feature deletes the list of API from the input base path.This Feature can be run standalone or in sequence with other tests

 Background: 
    * configure ssl = true
    * def nameSpace = 'guest'

    
  Scenario: Import Swagger.json from the utils and print the output as a string    
     Given url BaseUrl + '/api/v1/web/whisk.system/apimgmt/deleteApi.http?accesstoken=DUMMY+TOKEN&basepath=v2'+ '&spaceguid='+guid
     And header Authorization = Auth
     And header Content-Type = 'application/json'
     When method delete
     * print Successfully Deleted the API List
     Then status 204