/*# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/ */


(function() {
	var i = 0;
	var uid = $(".userloggedinfo input:hidden").val();
    setInterval(function() {
    	console.log("current count: ", i ++);
    	$.get("/users/" + uid + "/notifications.json?" + i, function(data) {
    		console.log(data);
    	});
    }, 1 * 1000);
}).call(this);