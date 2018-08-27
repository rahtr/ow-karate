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
#Summary :This feature file will either use the NS credentials provided or get the NS of guest
@smoketests
@ignore


Feature: This feature file will either use the NS credentials provided or get the NS of guest

  Background: 
    * configure ssl = true
    * def nameSpace = test_user_ns
    * def base64decoding = read('classpath:com/karate/openwhisk/utils/base64_decode.js')
    * print "Start"
    * eval 
    """
    if (!test_user_key)
    {
    var getNSCreds = karate.callSingle('classpath:com/karate/openwhisk/wskadmin/get-user.feature');
    var test=getNSCreds.Auth; 
    karate.set('authFunction',  'Basic '+getNSCreds.Auth);
    karate.set('guid', getNSCreds.uuid[0]);
    }   
    else
    {
    var getGUID = base64decoding(test_user_key); 
    karate.set('authFunction' , 'Basic '+test_user_key);
    karate.set('guid' , getGUID);
    karate.log('I am here');
    karate.log(getGUID);
    }
    """

   Scenario: This line is required please do not delete - or the functions cannot be called
     * def Auth = authFunction
     * def guid = guid
     * print 'In get-auth file' + guid

    
      