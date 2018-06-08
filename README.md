# openwhisk
This repository contains all the Test Cases needed to do various forms of automated test on the BR/OW environments.
It is based of karate (https://github.com/intuit/karate) framework. 

### Structure
The project structure is divided into the following packages:
1. Functions:This package will contain all the test functions needed to Create/Update an action
2. Utils:This package bundles all the utility functions like sleep,generate test string/number together
3. WSKActions:This package has all the OW actions which a User can perform through a CLI.These are re-usable features and are only run through test packages.
4. WSKAdmin:This package has all the OW actions which an Admin can perform through a CLI.These are re-usable features and are only run through test packages.
5. Test Packages(Relibility.tests/resiliency etc):These packages will have all the feature files needed to perform the type of testing defined in the package


### How to run the test
1. Pick up the suite to run.Say for example Reliability Test
2. Use the following command to run the above selected suite: `mvn test -Dadminauth=$adminauth -Dtest=com.karate.openwhisk.smoketests.SmokeTestRunner` (This will run all the tests in com.karate.openwhisk.smoketests package)


### How to add more tests

1. Select a package(Type of test).Example Reliablity test
2. Add a new feature file which has your test with the following tags `@rlt`

### How to add a new test type
1. Create a package in `src/test/java`.Say for example `com.karate.openwhisk.sanity.tests`
2. Create a feature and runner file 


### Pre-requisites to run the tests
The variables in karate.config

* env-->Environment Name
* adminauth-->Admin Auth,Used for Admin API's
* BaseUrl-->Target URL(SUT)
* NS_botTester[i]=Namespace of the bot testers
* Auth_botTester[i]=Auth of the bot testers(Base64 decode of the credentials)
* MarathonAPIURL=URL of the environment where marathon is hosted.
* Marathon Auth Token=Auth token to use the marathon API's.Links on how to optain and use Marathon API's
1. https://docs.mesosphere.com/1.10/security/ent/iam-api/#/obtaining-an-authentication-token
2. http://mesosphere.github.io/marathon/api-console/index.html



### more info
1. https://github.com/intuit/karate/tree/master/karate-demo
2. https://github.com/intuit/karate
