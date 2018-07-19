function() { 
	var scriptcode ="function main(params) {\n    console.log('hello stdout');\n    console.error('hello stderr');\n    var name = params.name || \"World\";\n    return {payload: \"Hello, \" + name + \"!\"};\n}\n";
		return scriptcode;
}


//Sample Hello World Functions