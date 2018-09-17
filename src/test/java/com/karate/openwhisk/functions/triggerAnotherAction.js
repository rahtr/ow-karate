function(nameSpace){
var triggerAnotherAction = "function main(params) {\n  return new Promise((resolve, reject) => {\nvar openwhisk = require(\"openwhisk\")\t\t\nconsole.log(\"HIIIIII\");\nvar ow = openwhisk({\n  api_key: global.process.env.__OW_API_KEY,\n  apihost: global.process.env.__OW_API_HOST,\n  ignore_certs: true\n});\now.actions.invoke({\nname: \"/"+nameSpace+"/myNestedAction\",\n  blocking: true,\n  result: true,\n params: {\n    invoked_from_action: global.process.env.__OW_ACTION_NAME\n  }\n})\n.then(result => {\nconsole.log(\"HIIIIII3\");\n    resolve(result);\n})\n.catch(err => {\n    console.error(\"Could not invoke another action:\",err);\n    console.log(args);\n    reject(err);\n});\n} );\n}\n";
return triggerAnotherAction;
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