function(raw_swagger){ 
	
	    var swagger2connv = JSON.stringify(raw_swagger);
	   var convertedswagger = '{"apidoc":{"namespace":"guest","swagger":' + swagger2connv + '}}';
	   // console.log(convertedswagger);
	   
        return convertedswagger; 
}