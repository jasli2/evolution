(function() {
    $("#quick_form").on("hidden", function() {
        console.log("quick_form hidden");
        $(this).removeData('modal');
    });    
    var generatForm = function(title, type, label) {
        var modalForm = '<div id="quick_form" class="modal hide fade">' + 
        '<div class="modal-header">' +
        '    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>' +
        '    <h3 class="ModalLabel">' + title + '</h3>' +
        '  </div>' +
        '  <div class="modal-body"></div>' +
        '  <div class="modal-footer">' +
        '    <button class="btn" data-dismiss="modal">关闭</button>' +
        '    <button class="btn btn-primary" form-type="' + type + '">' + label + '</button>' +
        '  </div>' + 
        '</div>';
        return modalForm;
    };
    var generatAlert = function(title) {
        var alertInfo = '<div class="alert fade in alert-info"><button class="close" data-dismiss="alert">×</button>成功' + 
            title + ' &nbsp;<strong>' + '' + '</strong></div>';
        return alertInfo;
    };
    var beforeSendFunc = function() {
        var control_groups = $(".control-group");
        console.log("beforeSend ", control_groups);            
        for(var i = 0; i < control_groups.length; i ++) {
            $(control_groups[i]).removeClass("error");
            $(control_groups[i]).find(".help-inline").text("");
        }
    };
    $("a[modal-type]").click(function(e) {
        var prefix = $(this).attr("prefix");
        var title = $(this).attr("title");
        var type = $(this).attr("modal-type");
        var label = $(this).text();
        console.log("quick button click: prefix:" + prefix, e);
        
        $("#quick_form").replaceWith(generatForm(title, type, label));  
        $("button[form-type]").click(function(e) {            
            prefix = undefined === prefix ? "" : prefix;
            console.log("form submit button clicked! " + prefix, e);
            type = $(this).attr("form-type");
            $.ajax({
                url: prefix + "/" + type + "s.json",
                type: "POST",
                data: $("#new_" + type).serialize(),
                cache: false,
                async: false,
                error: function (request) {
                    console.log("Connection error", request);            
                    for(var i in request.responseJSON) {
                        if (undefined == $("#" + type + "_" + i).next(".help-inline").html()) {
                            $("#" + type + "_" + i).after('<span class="help-inline">' + request.responseJSON[i] + '</span>');
                        } else {
                            $("#" + type + "_" + i).next(".help-inline").text(request.responseJSON[i]);
                        }                
                        $("#" + type + "_" + i).parents(".control-group").addClass("error");
                        console.log(i,request.responseJSON[i], 
                            $("#" + type + "_" + i).parents(".control-group").html());
                    }
                },
                success: function(data){
                    if ("user" == type) {
                        var beforeEmployeeCount = $("#competency").next(".media-body").children(".media-heading").text();
                        $("#competency").next(".media-body").children(".media-heading").text(++ beforeEmployeeCount);
                        console.log(beforeEmployeeCount, data);
                    };
                    $("#quick_form").modal("hide");
                    setTimeout(function() {
                        $(".breadcrumbs").after(generatAlert(title));
                    }, 100);
                    setTimeout(function() {
                        $(".alert").alert('close');
                    }, 5000);                
                },
                beforeSend: beforeSendFunc
            });
        });
    });
    $("a[modal-type-edit]").click(function(e) {
        var prefix = $(this).attr("prefix");
        var title = $(this).attr("title");
        var type = $(this).attr("modal-type-edit");
        var label = $(this).text();
        var id = $(this).attr("data-id");
        console.log("quick button click: prefix:" + prefix, e);
        $("#quick_form").replaceWith(generatForm(title, type, label));  
        $("button[form-type]").click(function(e) {            
            prefix = undefined === prefix ? "" : prefix;
            console.log("form submit button clicked! " + prefix, e);
            type = $(this).attr("form-type");
            $.ajax({
                url: prefix + "/" + type + "s/" + id +".json",
                type: "PUT",
                data: $("#edit_" + type + "_" + id).serialize(),
                cache: false,
                async: false,
                error: function (request) {
                    console.log("Connection error", request);            
                    for(var i in request.responseJSON) {
                        if (undefined == $("#" + type + "_" + i).next(".help-inline").html()) {
                            $("#" + type + "_" + i).after('<span class="help-inline">' + request.responseJSON[i] + '</span>');
                        } else {
                            $("#" + type + "_" + i).next(".help-inline").text(request.responseJSON[i]);
                        }                
                        $("#" + type + "_" + i).parents(".control-group").addClass("error");
                        console.log(i,request.responseJSON[i], 
                            $("#" + type + "_" + i).parents(".control-group").html());
                    }
                },
                success: function(data){
                    $("#quick_form").modal("hide");
                    setTimeout(function() {
                        $(".breadcrumbs").after(generatAlert(title));
                    }, 100);
                    // setTimeout($(".alert")alert('close'), 5000);
                    setTimeout(function() {
                        $(".alert").alert('close');
                    }, 5000);                
                },
                beforeSend: beforeSendFunc
            });
        });
    });
}).call(this);