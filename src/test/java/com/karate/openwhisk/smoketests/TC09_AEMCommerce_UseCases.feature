#/*
 #*  Copyright 2017-2018 Adobe.
 #*
 #*  Licensed under the Apache License, Version 2.0 (the "License");
 #*  you may not use this file except in compliance with the License.
 #*  You may obtain a copy of the License at
 #*
 #*          http://www.apache.org/licenses/LICENSE-2.0
 #*
 #*  Unless required by applicable law or agreed to in writing, software
 #*  distributed under the License is distributed on an "AS IS" BASIS,
 #*  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 #*  See the License for the specific language governing permissions and
 #*  limitations under the License.
 #*/
#Author: mamishra@adobe.com
#Keywords Summary : This feature is all about basic test cases of Actions
@regression
Feature: This feature mimics the AEM commerce business workflow

  Background:
    * configure ssl = true
    * def nameSpace = test_user_ns
   #* def nameSpace2 = 'normaluser'
    * def params = '?blocking=true&result=false'
    * def scriptPrime = call read('classpath:com/karate/openwhisk/functions/primes.js')
    #* def scriptcodeWithParam = call read('classpath:com/karate/openwhisk/functions/greetings.js')
    * def scriptStrlen = call read('classpath:com/karate/openwhisk/functions/strlen.js')
    * json ns_details = read('classpath:com/karate/openwhisk/utils/ns_list.json')
    #* json ns_detailsObj = ns_details
    * print "Got list of ns details: " + ns_details



  Scenario: Mimic the the AEM commerce workflow for Testing web actions
    * def ns1_name = ns_details[0].name
    * print "Got Namespace1 name: " + ns1_name
    * def ns1_auth = ns_details[0].auth
    * print "Got Namespace1 auth: " + ns1_auth
    * def ns2_name = ns_details[1].name
    * print "Got Namespace2 name: " + ns2_name
    * def ns2_auth = ns_details[1].auth
    * print "Got Namespace2 auth: " + ns2_auth
    # creating first shared package in namespace1
    * def firstPkgNameNS1 = 'SharedFirstPackageNS1'+java.util.UUID.randomUUID()
    * def payload_pkg1 = {"name":'#(firstPkgNameNS1)',"namespace":"#(ns1_name)", "publish":true}
    * def createFirstPackageNS1 = call read('classpath:com/karate/openwhisk/wskpackages/create-package.feature') {nameSpace:'#(ns1_name)' ,Auth:'#(ns1_auth)', requestBody:'#(payload_pkg1)', packageName:'#(firstPkgNameNS1)'}
    * match createFirstPackageNS1.responseStatusCode == 200
    * print "Successfully Created the package"
    # creating second shared package in namespace1
    * def secondPkgNameNS1 = 'SharedSecondPackageNS1'+java.util.UUID.randomUUID()
    * def payload_pkg2 = {"name":'#(secondPkgNameNS1)',"namespace":"#(ns1_name)", "publish":true}
    * def createSecondPackage = call read('classpath:com/karate/openwhisk/wskpackages/create-package.feature') {nameSpace:'#(ns1_name)' ,Auth:'#(ns1_auth)', requestBody:'#(payload_pkg2)', packageName:'#(secondPkgNameNS1)'}
    * match createSecondPackage.responseStatusCode == 200
    * print "Successfully Created the package"
    # create prime action in first package of namespace1
    * def primeActionName = firstPkgNameNS1+'/'+'PrimeAction'+java.util.UUID.randomUUID()
    * print "Action name is "+primeActionName
    * def createAction1 = call read('classpath:com/karate/openwhisk/wskactions/create-action.feature') {script:'#(scriptPrime)' ,nameSpace:'#(ns1_name)' ,Auth:'#(ns1_auth)' ,actionName:'#(primeActionName)'}
    * match createAction1.responseStatusCode == 200
    # create strlen action in second package of namespace1
    * def strlenActionName = secondPkgNameNS1+'/'+'StrlenAction'+java.util.UUID.randomUUID()
    * print "Action name is "+strlenActionName
    * def createAction2 = call read('classpath:com/karate/openwhisk/wskactions/create-action.feature') {script:'#(scriptStrlen)' ,nameSpace:'#(ns1_name)' ,Auth:'#(ns1_auth)' ,actionName:'#(strlenActionName)'}
    * match createAction2.responseStatusCode == 200
    # Update the second package of namespace1 with default parameter as text = Testing
    * def payload = {"name":'#(secondPkgNameNS1)',"namespace":"#(ns1_name)","parameters":[{"key":"text","value":"Testing"}]}
    # update package with params
    * def updateSecondPackageNS1 = call read('classpath:com/karate/openwhisk/wskpackages/update-package.feature') {nameSpace:'#(ns1_name)' ,Auth:'#(ns1_auth)',packageName:'#(secondPkgNameNS1)', requestBody:'#(payload)'}
    * match updateSecondPackageNS1.responseStatusCode == 200
    # create package in namespace2
    * def createPackageNS2 = call read('classpath:com/karate/openwhisk/wskpackages/create-package.feature') {nameSpace:'#(ns2_name)' ,Auth:'#(ns2_auth)'}
    * match createPackageNS2.responseStatusCode == 200
    * def packageNameNS2 = createPackageNS2.pkgName
    * print "Successfully Created the package"
    # create bindings in namespace2 with the packages created in namespace1
    # create the first binding for firstPkgNameNS1
    * def payloadForBinding1 = {"binding":{"namespace":'#(ns1_name)',"name":'#(firstPkgNameNS1)'}}
    * def firstBinding = call read('classpath:com/karate/openwhisk/wskpackages/create-package.feature') {nameSpace:'#(ns2_name)' ,Auth:'#(ns2_auth)',packageName:'#(firstPkgNameNS1)', requestBody:'#(payloadForBinding1)'}
    * match firstBinding.responseStatusCode == 200
    * def bindingName1 = firstBinding.pkgName
    * print "Successfully created the first binding"
    # create the second binding for secondPkgNameNS1
    * def payloadForBinding2 = {"binding":{"namespace":'#(ns1_name)',"name":'#(secondPkgNameNS1)'}}
    * def secondBinding = call read('classpath:com/karate/openwhisk/wskpackages/create-package.feature') {nameSpace:'#(ns2_name)' ,Auth:'#(ns2_auth)',packageName:'#(secondPkgNameNS1)', requestBody:'#(payloadForBinding2)'}
    * match secondBinding.responseStatusCode == 200
    * def bindingName2 = secondBinding.pkgName
    * print "Successfully created the second binding"
    # create sequence for the actions in the package binding
    * def seqName = 'Sequence'+java.util.UUID.randomUUID()
    * def action1 = '/' + ns2_name + '/' + strlenActionName
    * print "Action1 name: " + action1
    * def action2 = '/' + ns2_name + '/' + primeActionName
    * print "Action2 name: " + action2
    * def payloadSequence = {"namespace":'#(ns2_name)',"name":'#(seqName)',"exec":{"kind":"sequence","components":['#(action1)','#(action2)']},"annotations":[{"key":"web-export","value":true},{"key":"raw-http","value":false},{"key":"final","value":true}]}
    * def createSequence = call read('classpath:com/karate/openwhisk/wskactions/create-action.feature') {nameSpace:'#(ns2_name)' ,Auth:'#(ns2_auth)',actionName:'#(seqName)', requestBody:'#(payloadSequence)'}
    * match createSequence.responseStatusCode == 200
    * print "Successfully created the sequence"
    # invoke the sequence
    * def invokeSequence = call read('classpath:com/karate/openwhisk/wskactions/invoke-action.feature') {params:'#(params)',requestBody:'',nameSpace:'#(ns2_name)' ,Auth:'#(ns2_auth)',actionName:'#(seqName)'}
    * match invokeSequence.responseStatusCode == 200
    * print "Successfully invoked the sequence"



    
    

