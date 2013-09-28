(function() {
    $("#quick_form").on("hidden", function() {
        console.log("quick_form hidden");
        $(this).removeData('modal');
    }).on("loaded", function() {
        console.log("loaded");
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
    var addUser = function(data) {
        var user = '<tr><td class="center">' +
            '       <a href="/ajax/form/users/edit/' + data.id + '" ' +
            '               class="btn btn-primary" data-id="' + data.id + '" ' +
            '               modal-type="user" ' +
            '               title="修改用户资料">编辑</a> ' +
            '   </td>' +
            '   <td class="center"><a href="/users/' + data.id + '">' + data.name + '</a></td>' +
            '   <td class="center">' + data.staff_id + '</td>' +
            '   <td class="center">' + data.department + '</td>' +
            '   <td class="center">' + data.department + '</td>' +
            '   <td class="center">' + data.joined_at + '</td>' +
            '</tr>';
        $("table.table").children("tbody").prepend(user);
        $("a[modal-type]").bind("click", showModal);
    };
    var addCourse = function(data) {
        var course = '<li><img alt="Default_cover_normal" class="pull-left" src="/assets/default_cover_normal.png">' +
            '<div class="course-info">' +
            '  <h4><a href="/courses/' + data.id + '">' + data.title + '</a></h4>' +
            '  <ul>' +
            '    <li>目标学员：' + data.audience + '</li>' +
            '    <li>授课老师：' + data.duration + '</li>' +
            '    <li>课程时长：' + data.duration + ' 小时</li>' +
            '    <li>所属胜任力级别：无</li>' +
            '  </ul>' +
            '  <a href="/courses/43" class="btn btn-primary btn-small">' +
            '    <span class="iconfa-info-sign icon-white"></span> 查看详情</a>' +
            '  <a href="/ajax/form/courses/edit/' + data.id + '" ' +
            '        class="btn btn-warning btn-small" title="编辑课程" ' +
            '        data-id="' + data.id + '" ' +
            '        modal-type="course">' +
            '    <span class="iconfa-edit icon-white"></span> 编辑课程' +
            '  </a></div></li>';
        $("ul.courselist").prepend(course);
        $("a[modal-type]").bind("click", showModal);
    };
    var showModal = function(e) {
        e.preventDefault();
        var currBtn = $(this);
        var target = $(this).attr("href");
        var prefix = $(this).attr("prefix");
        var title = $(this).attr("title");
        var type = $(this).attr("modal-type");
        var data_id = $(this).attr("data-id");
        var label = undefined === data_id ? $(this).text() : "保存";
        console.log(data_id);
        console.log("quick button click: prefix:" + prefix, e);
        $("#quick_form").replaceWith(generatForm(title, type, label));
        // load the url and show modal on success
        $("#quick_form .modal-body").load(target, function() {
            $("input.date_picker").datepicker({
                dateFormat: "yy-mm-dd"
            });
            
            $("#quick_form").modal("show");
            $("#quick_form").on("shown", function() {
                console.log("quick_form show");
                $.fn.dataTableExt.afnSortData['dom-checkbox'] = function  ( oSettings, iColumn ){
                    return $.map( oSettings.oApi._fnGetTrNodes(oSettings), function (tr, i) {
                        return $('td:eq('+iColumn+') input', tr).prop('checked') ? '1' : '0';
                    });
                };
                var requiredCourseDataTable = $("#required_course_dyntable").dataTable( {
                    "bScrollInfinite": true,
                    "bScrollCollapse": true,
                    "sScrollY": "200px",
                    "iDisplayLength": -1,
                    "aoColumns": [{"sSortDataType": "dom-checkbox"},
                        null, null, null, null]
                });
                var optionalCourseDataTable = $("#optional_course_dyntable").dataTable( {
                    "bScrollInfinite": true,
                    "bScrollCollapse": true,
                    "sScrollY": "200px",
                    "iDisplayLength": -1,
                    "aoColumns": [{"sSortDataType": "dom-checkbox"},
                        null, null, null, null]
                });
                var usersDataTable = $("#users_dyntable").dataTable( {
                    "bScrollInfinite": true,
                    "bScrollCollapse": true,
                    "sScrollY": "200px",
                    "iDisplayLength": -1,
                    "aoColumns": [{"sSortDataType": "dom-checkbox"},
                        null, null]
                });
                $("#required_course").change(function(){
                    // console.log($(":checkbox[name*=required_course_ids]", dataTable.fnGetNodes()));
                    // console.log($(":checkbox[name*=required_course_ids]", dataTable.fnIsOpen()));
                    if ($(this).prop("checked")) {
                        // $("checkboxSelector", dataTable.fnGetNodes()).attr("checked", true);
                        $(":checkbox[name*=required_course_ids]", 
                            requiredCourseDataTable.fnIsOpen()).prop("checked", true);
                    } else {
                        // $("checkboxSelector", dataTable.fnGetNodes()).attr("checked", true);
                        $(":checkbox[name*=required_course_ids]", 
                            requiredCourseDataTable.fnIsOpen()).prop("checked", false);
                    }
                });
                $("#optional_course").change(function(){
                    if ($(this).prop("checked")) {
                        $(":checkbox[name*=optional_course_ids]", 
                            optionalCourseDataTable.fnIsOpen()).prop("checked", true);
                    } else {
                        $(":checkbox[name*=optional_course_ids]", 
                            optionalCourseDataTable.fnIsOpen()).prop("checked", false);
                    }
                });
                $("#optional_users").change(function(){
                    if ($(this).prop("checked")) {
                        $(":checkbox[name*=user_ids]", 
                            usersDataTable.fnIsOpen()).prop("checked", true);
                    } else {
                        $(":checkbox[name*=user_ids]", 
                            usersDataTable.fnIsOpen()).prop("checked", false);
                    }
                });
            });
        });
        
        if (undefined === data_id) {
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
                        switch(type){
                            case "user":
                                addUser(data);
                                break;
                            case "course":
                                addCourse(data);
                                break;
                            default:
                                console.log("default type");
                                break;
                        }              
                    },
                    beforeSend: beforeSendFunc
                });
            });
        } else {
            $("button[form-type]").click(function(e) {            
                prefix = undefined === prefix ? "" : prefix;
                // console.log("form submit button clicked! " + prefix, e);
                type = $(this).attr("form-type");
                $.ajax({
                    url: prefix + "/" + type + "s/" + data_id +".json",
                    type: "PUT",
                    data: $("#edit_" + type + "_" + data_id).serialize(),
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
                        console.log(data);
                        $("#quick_form").modal("hide");
                        setTimeout(function() {
                            $(".breadcrumbs").after(generatAlert(title));
                        }, 100);
                        // setTimeout($(".alert")alert('close'), 5000);
                        setTimeout(function() {
                            $(".alert").alert('close');
                        }, 5000);
                        switch(type){
                            case "user":
                                console.log($(currBtn).parent("td").nextAll());
                                var tds = $(currBtn).parent("td").nextAll();
                                $(tds[0]).children("a").text(data.name);
                                $(tds[1]).text(data.staff_id);
                                $(tds[2]).text(data.department);
                                // tds[3].text(data.);
                                $(tds[4]).text(data.joined_at);
                                break;
                            case "course":
                                console.log($(currBtn).parents("li"));
                                var li = $(currBtn).parents("li");
                                // console.log(li.children(".course-info"));
                                // console.log(li.find("h4 > a"));
                                li.find("h4 > a").text(data.title);
                                var lis = li.find("ul > li");
                                // console.log(li.children("ul > li"));
                                $(lis[0]).text("目标学员：" + data.audience);
                                $(lis[1]).text("授课老师：");
                                $(lis[2]).text("课程时长：" + data.duration + "小时");
                                $(lis[3]).text("所属胜任力级别：无");
                                break;
                            default:
                                console.log("default type");
                                break;
                        }                    
                    },
                    beforeSend: beforeSendFunc
                });
            });
        }
    };
    $("a[modal-type]").click(showModal);
    // $("a[modal-type-edit]").click(function(e) {
    //     var currBtn = $(this);
    //     var prefix = $(this).attr("prefix");
    //     var title = $(this).attr("title");
    //     var type = $(this).attr("modal-type-edit");
    //     var id = $(this).attr("data-id");
    //     console.log("quick button click: prefix:" + prefix, e);
    //     $("#quick_form").replaceWith(generatForm(title, type, "保存"));
    //     $("#quick_form").on("shown", function() {
    //         console.log("quick_form shown", $("input.date_picker"));
    //         //$("input.date_picker").datepicker("option", "z-index", "1151 !important");
    //         $("input.date_picker").datepicker({
    //             dateFormat: "yy-mm-dd"
    //         }); 
    //     });
    // });
}).call(this);