/*# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/ */


(function() {
	var count = 0;
	var uid = $(".userloggedinfo input:hidden").val();
    setInterval(function() {
    	// console.log("current count: ", count);
    	$.get("/users/" + uid + "/notifications.json?" + count ++, function(data) {
    		console.log(data);
    		var menu = '<ul class="dropdown-menu">';
    		if (0 < data.length) {
    			menu += '<li class="nav-header">未读消息</li>';
    			for(var i in data) {
    				menu += '<li id="' + data[i].id + '"><a href="' + data[i].url + '">' + data[i].description + '<small class="muted"> - ' + data[i].created_at + '</small></a></li>';
    			}    			
    			if (undefined == $(".notification span.badge").html()) {
    				$(".notification i.iconfa-envelope").after('<span class="badge badge-important">' + data.length + '</span>');
    			} else {
    				$(".notification span.badge").text(data.length);
    			}
    		} else {
    			menu += '<li class="nav-header">无未读消息</li>';
    			$(".notification span.badge").remove();
    		}
    		menu += "</ul>"
    		// console.log(menu);
    		// console.log($(".headmenu .notification").children("ul.dropdown-menu"));
    		$(".notification ul.dropdown-menu").replaceWith(menu);
    	});
    }, 60 * 1000);
    $(".notification li[id]").click(function() {
		var nid = $(this).attr("id");
		var href = $(this).children("a").attr("href");
		console.log(nid);
		// $.post("/users/" + uid + "/notifications.json", { 'notifications[]': [nid] }, function() {});
		$.ajax({ url: "/users/" + uid + "/notifications.json", 
			data: { 'notifications[]': [nid] }, 
			async: false,
			type: "POST",
			success: function(){
				// location.href = $(this).children("a").attr("href");
				location.href = href;
			}
		});
		return false;
	});
}).call(this);