function()
{
var postResponse = "function main(params) {\n    return {\n        statusCode: 200,\n        body: params,\n        headers: {\n            \"Cache-Control\": \"max-age=60\"\n        }\n    }\n}\n";
return postResponse;
}