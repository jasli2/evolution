/*# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/ */


(function() {
    // $("#newCourse").click (function() {
    //     console.log("newCourse click");
    //     $.ajax({
    //         url: "/courses.json",
    //         type: "POST",
    //         data: $("#new_course").serialize(),
    //         cache: false,
    //         async: false,
    //         error: function (request) {
    //             console.log("Connection error", request);            
    //             for(var i in request.responseJSON) {
    //                 if (undefined == $("#course_" + i).next(".help-inline").html()) {
    //                     $("#course_" + i).after('<span class="help-inline">' + request.responseJSON[i] + '</span>');
    //                 } else {
    //                     $("#course_" + i).next(".help-inline").text(request.responseJSON[i]);
    //                 }                
    //                 $("#course_" + i).parents(".control-group").addClass("error");
    //                 console.log(i,request.responseJSON[i], 
    //                     $("#course_" + i).parents(".control-group").html());
    //             }
    //         },
    //         success: function(data){
    //             // var beforeEmployeeCount = $("#competency").next(".media-body").children(".media-heading").text();
    //             // $("#competency").next(".media-body").children(".media-heading").text(++ beforeEmployeeCount);
    //             console.log(beforeEmployeeCount, data);
    //             var a = '<div class="alert fade in alert-info"><button class="close" data-dismiss="alert">×</button>成功创建用户 <strong>' +
    //                 data.name + '</strong></div>';
    //             $(".breadcrumbs").after(a);
    //             $("#courses_form").modal("hide");
    //         },
    //         beforeSend: function(){
    //             var control_groups = $(".control-group");
    //             console.log("beforeSend ", control_groups);            
    //             for(var i = 0; i < control_groups.length; i ++) {
    //                 $(control_groups[i]).removeClass("error");
    //                 $(control_groups[i]).find(".help-inline").text("");
    //             }
    //         }
    //     });
    // });
}).call(this);