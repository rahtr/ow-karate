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
#Author: rtripath@adobe.com

@resiliency
  Feature:  This feature file will will use Pumba Functions to inject failures

  Background:
* configure ssl = true
* def nameSpace = test_user_ns
* def sheepCountValue =  '30'


  Scenario: Pause all running processes within target containers for ten seconds
   * def ExecuteShell = Java.type('com.karate.openwhisk.utils.ExecuteShellComand')
   * def pumba = ExecuteShell.CallCommand('./pumba pause -d 10s')
   * print 'I have paused all the containers.Now sleeping for 30 seconds'
      #Sleep for sheepCountValue seconds
   * def sleep =  call read('classpath:com/karate/openwhisk/utils/sleep.feature') {sheepCount:'#(sheepCountValue)'}
   * def runtests = call read('classpath:com/karate/openwhisk/resiliency/resiliency-test-cases.feature')    
   

   

    
  
  