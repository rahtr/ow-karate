@ignore
Feature: This feature will generate the basic auth

  Background:
    * configure ssl = tru
    * def nameSpace = 'guest'
    * def base64encoding = read('classpath:com/karate/openwhisk/utils/base64.js')
  Scenario: This feature will generate the basic auth
    # Get User Auth
    * def getNSCreds = call read('classpath:com/karate/openwhisk/wskadmin/get-user.feature') {nameSpace:'#(nameSpace)'}
    * def result = getNSCreds.result
    * def Auth = base64encoding(result)
    * print "Got the Creds for the guest user"
    * print Auth
