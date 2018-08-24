function() {
    var env = karate.env; // get system property 'karate.env'
    var adminauth = karate.properties['adminauth'];
    var adminbaseurl = karate.properties['adminbaseurl'];
    var baseurl = karate.properties['baseurl'];
    var test_user_ns = karate.properties['test_user_ns'];
    var test_user_key = karate.properties['test_user_key'];
    
    karate.log('karate.env system property was:', env);

    if (!adminauth) {

        adminauth='d2hpc2tfYWRtaW46c29tZV9wYXNzdzByZA=='

    }

    if (!adminbaseurl) {

        adminbaseurl='http://localhost:5984'

    }
    if (!baseurl) {

        baseurl='https://localhost:443'

    }
    
    if (!test_user_ns) {

        test_user_ns='guest'
    }

    var config = {
            env: env,
            adminauth:adminauth,
            baseurl:baseurl,
            adminbaseurl:adminbaseurl,
            test_user_ns:test_user_ns,
            test_user_key:test_user_key


    }


    // Bot Details

    
        // Admin Config
        config.AdminAuth="Basic " +adminauth,
        config.AdminBaseUrl=adminbaseurl,
        config.BaseUrl=baseurl
   

        //	config.AdminAuth="Basic d2hpc2tfYWRtaW46c29tZV9wYXNzdzByZA==",
        //   config.AdminBaseUrl="http://172.17.0.1:5984",
//      config.BaseUrl="https://172.17.0.1:443"

        return config;
}



/**
 *  Copyright 2017-2018 Adobe.
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *          http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */
/**
 * @author Rahul Tripathi
 *
 *
 */
