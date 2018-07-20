function(){
	var deleteResponse = "function main({name:name='Serverless API'}) {\n    return {\n      body: {payload:`Hello world ${name}`},\n      statusCode: 200,\n      headers:{ 'Content-Type': 'application/json'}\n    };\n}\n";
    return deleteResponse;
}