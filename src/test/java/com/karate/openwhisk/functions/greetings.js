function() { 
	var scriptcodeWithParam ="function main(params) {\n  console.log('params:', params);\n  var name = params.name || 'stranger';\n  var place = params.place || 'somewhere';\n  return {msg:  'Hello, ' + name + ' from ' + place + '!'};\n}";
		return scriptcodeWithParam;
}


//sample greeting method