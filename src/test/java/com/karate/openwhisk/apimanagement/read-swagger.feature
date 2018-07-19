@apimanagement
Feature: Read Swagger.json

  Scenario: Read Swagger.json from the utils and print the output as a string

    #Trigger an event
    * def raw_swagger = read('classpath:com/karate/openwhisk/utils/pet-store-swagger.json')
    ## Below can be passed to any request as a request
    * string converted_swagger = raw_swagger 
    * print converted_swagger
    