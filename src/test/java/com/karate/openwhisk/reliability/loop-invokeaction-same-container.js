/**
 * @author Rahul Tripathi
 *
 * 
 */
function(path2feature,loopcount,nameSpace,Auth){ 
	var res = []; 
	console = { 
		    log: print,
		    warn: print,
		    error: print
		};
  for (var i = 0; i <loopcount; i++) {
	  
	  if (i==0){
		  var res1 = karate.call(path2feature,{params:'?blocking=false&result=true', requestBody:'',actionName : 'helloworld',nameSpace:nameSpace ,Auth:Auth });
		    res.push(res1.response);
	
	  }
	  
	  else{
	    var res1 = karate.call(path2feature,{params:'?blocking=false&result=true', requestBody:'',actionName : 'helloworld',nameSpace:nameSpace ,Auth:Auth });
	    res.push(res1.response);
	    var actID = res1.activationId;
	    java.lang.Thread.sleep(10000);
	    
	    
	    var res2 = karate.call('classpath:com/adobe/karate/openwhisk/test-same-action-same-container.feature',{ activationId: res1.activationId ,Auth:Auth});
	    console.log('I am printing'+i);
	    
	  }
	    
  }
  return actID; 
}




