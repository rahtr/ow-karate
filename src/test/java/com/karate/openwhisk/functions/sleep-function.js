/**
 * @author Rahul Tripathi
 *
 * 
 */

function(){
var scriptcode="function main(params) {  return new Promise(function(resolve, reject) {     setTimeout(function() {         resolve({ message: \"Hello world\" });    }, params.time);  });}";
return scriptcode;
}

//Sleep function,Can be used to implement sleep between functions