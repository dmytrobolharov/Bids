function GridEditor(master) {
    this.master = master; // is the a GantEditor instance
    this.gridified = $.gridify($.JST.createFromTemplate({}, "TASKSEDITHEAD"));
    this.element = this.gridified.find(".gdfTable").eq(1);
}
var ge; //this is the hugly but very friendly global var for the gantt editor
var path = location.href.split('=');
(function ($) {
    $.fn.tacalendar = function (options) {
        var taskEdit = '<div class="__template__" type="TASKSEDITHEAD">' +
            '<table class="gdfTable" cellspacing="0" cellpadding="0">' +
            '<thead>' +
            '<tr style="height:40px">' +
            '<th class="gdfColHeader" style="width:35px;">Ind.</th>' +
            '<th class="gdfColHeader" style="width:50px;">Notes</th>' +
            '<th class="gdfColHeader gdfResizable" style="width:100px;">Task Type</th>' +
            '<th class="gdfColHeader gdfResizable" style="width:160px;">Task name</th>' +
            '<th class="gdfColHeader gdfResizable" style="width:145px;">Assigned to</th>' +
            '<th class="gdfColHeader gdfResizable" style="width:60px;">New</th>' +
            '<th class="gdfColHeader gdfResizable" style="width:75px;">Carryover</th>' +
            '<th class="gdfColHeader gdfResizable" style="width:125px;">start</th>' +
            '<th class="gdfColHeader gdfResizable" style="width:125px;">end</th>' +
            '<th class="gdfColHeader gdfResizable" style="width:50px;">dur.</th>' +
            '<th class="gdfColHeader gdfResizable" style="width:50px;">dep.</th>' +
            '</tr>' +
            '</thead>' +
            '</table>' +
            '</table>' +
            '</div>';

        var ganntButtons = ' <div class="__template__" type="GANTBUTTONS">' +
            '<div class="ganttButtonBar noprint">' +
            '<div class="buttons">' +
            '<button onclick="$(\'#workSpace\').trigger(\'addAboveCurrentTask.gantt\');" type="button" class="button textual" title="insert above"><span class="teamworkIcon">l</span></button>' +
            '<button onclick="$(\'#workSpace\').trigger(\'addBelowCurrentTask.gantt\');" type="button" class="button textual" title="insert below"><span class="teamworkIcon">X</span></button>' +
            '<button onclick="$(\'#workSpace\').trigger(\'addBelowNewTask.gantt\');" type="button" class="button textual" title="add new"><img src = "jQueryGantt/css/images/addNewSameLvl.png"/></button>' +
            '<span class="ganttButtonSeparator"></span>' +
            '<button onclick="$(\'#workSpace\').trigger(\'indentCurrentTask.gantt\');" type="button" class="button textual" title="indent task"><span class="teamworkIcon">.</span></button>' +
            '<button onclick="$(\'#workSpace\').trigger(\'outdentCurrentTask.gantt\');" type="button" class="button textual" title="unindent task"><span class="teamworkIcon">:</span></button>' +
            '<span class="ganttButtonSeparator"></span>' +
            '<button onclick="$(\'#workSpace\').trigger(\'moveUpCurrentTask.gantt\');" type="button" class="button textual" title="move up"><span class="teamworkIcon">k</span></button>' +
            '<button onclick="$(\'#workSpace\').trigger(\'moveDownCurrentTask.gantt\');" type="button" class="button textual" title="move down"><span class="teamworkIcon">j</span></button>' +
            '<span class="ganttButtonSeparator"></span>' +
            '<button onclick="$(\'#workSpace\').trigger(\'zoomMinus.gantt\');" type="button" class="button textual" title="zoom out"><span class="teamworkIcon">)</span></button>' +
            '<button onclick="$(\'#workSpace\').trigger(\'zoomPlus.gantt\');" type="button" class="button textual" title="zoom in"><span class="teamworkIcon">(</span></button>' +
            '<span class="ganttButtonSeparator"></span>' +
            '<button onclick="$(\'#workSpace\').trigger(\'deleteCurrentTask.gantt\');" type="button" class="button textual" title="delete"><span class="teamworkIcon">&cent;</span></button>' +
            '</div></div>' +
            '</div>';


        var taskEmptyRow = '<div class="__template__" type="TASKEMPTYROW"><!--' +
            '<tr class="taskEditRow emptyRow" >' +
            '<td class="gdfCell gdfThCell" align="right"></td>' +
            '<td class="gdfCell noClip" align="center"></td>' +
            '<td class="gdfCell"></td>' +
            '<td class="gdfCell"></td>' +
            '<td class="gdfCell"></td>' +
            '<td class="gdfCell"></td>' +
            '<td class="gdfCell"></td>' +
            '<td class="gdfCell"></td>' +
            '<td class="gdfCell"></td>' +
            '<td class="gdfCell"></td>' +
            '<td class="gdfCell"></td>' +
            '</tr>' + '--></div>';


        //var taskBar = '<div class="__template__" type="TASKBAR"><!--'+
        //    '<div class="taskBox taskBoxDiv" taskId="(#=obj.id#)" >'+
        //    '<div class="layout (#=obj.hasExternalDep?extDep\':\'\'#)">'+
        //        '<div class="taskStatus" status="(#=obj.status#)"></div>'+
        //        '<div class="taskProgress" style="width:(\'#=obj.progress>100?100:obj.progress#)%; background-color:(#=obj.progress>100?\'red\':\'rgb(153,255,51);\'#);"></div>'+
        //        '<div class="milestone (#=obj.startIsMilestone?\'active\':\'\'#)" ></div>'+
        //        '<div class="taskLabel"></div>'+
        //        '<div class="milestone end (#=obj.endIsMilestone?\'active\':\'\'#)" ></div>'+
        //    '</div>'+
        //    '</div>'+'--></div>';

        var status = '<div class="__template__" type="CHANGE_STATUS"><!--' +
            '<div>' +
            '<h1 style="opacity: 0.6;margin-left: 15px;margin-top: 15px;">Notes:<h1>' +
            '<textarea id="taskNote" name = "taskNote" class="taskNoteTextArea"></textarea>' +
            '<div class="taskNoteSave"><button class="button taskNoteSaveBnt" id="saveNote">Save</button></div>' +
            '</div>' +
            '--></div>';

        var taskRow = '<div class="__template__" type="TASKROW"><!--' +
            '<tr taskId="(#=obj.id#)" class="taskEditRow" level="(#=level#)">' +
            '<td class="gdfCell gdfThCell edit" align="right" style="cursor:pointer;"><span class="taskRowIndex">(#=obj.getRow()+1#)</span> <span class="teamworkIcon" style="font-size:12px;" >e</span></td>' +
            '<td class="gdfCell noClip" align="center"><img class="taskStatus" src="jQueryGantt/css/images/notes_add.png" alt=""/></td>' +
            '<td class="gdfCell taskTypeYunique"><input class="typeYunique" name="type"/></td>' +
            '<td class="gdfCell indentCell calendarTask" style="padding-left:(#=obj.level*10#)px;">' +
            '<span class="taskNameDDL"></span>' +
            '<input class="taskNameYunique" type="text" name="name"  style="(#=obj.level>0#)">' +
            '</td>' +
            '<td class="gdfCell teamYunique"><input name="team"/></td>' +
            '<td class="gdfCell new"><input type="checkbox" name="new" value="(#=obj.new#)"/></td>' +
            '<td class="gdfCell carryOver"><input type="checkbox" name="carryOver" value="(#=obj.carryOver#)"/></td>' +
            '<td class="gdfCell"><input type="text" name="start"  value="" class="date"></td>' +
            '<td class="gdfCell"><input type="text" name="end" value="" class="date"></td>' +
            '<td class="gdfCell"><input type="text" name="duration" value="(#=obj.duration#)"></td>' +
            '<td class="gdfCell"><input type="text" name="depends" value="(#=obj.depends#)" (#=obj.hasExternalDep?"readonly":""#)></td>' +
            '<td class="gdfCell taskAssigs">(#=obj.getAssigsString()#)</td>' +
            '</tr>' + '--></div>';


        var rowEdit = '    <div class="__template__" type="TASK_EDITOR"><!--' +
            '<div class="ganttTaskEditor">' +
            '<table width="100%">' +
            '<tr>' +
            '<td>' +
            '</table>' +
            '</td>' +
            '<td valign="top">' +
            '<table cellpadding="5">' +
            '<tr>' +
            '<td colspan="2"><label for="status">status</label><br><div id="status" class="taskStatus" status=""></div></td>' +
            '<td><label for="start">start</label><br><input type="text" name="start" id="start"  value="" class="date" size="10" class="formElements"><input type="checkbox" id="startIsMilestone"> </td>' +
            '<td rowspan="2" class="graph" style="padding-left:50px"><label for="duration">dur.</label><br><input type="text" name="duration" id="duration" value=""  size="5" class="formElements"></td>' +
            '<tr>' +
            '</tr>' +
            '<tr>' +
            '<td colspan="2"><label for="progress">progress</label><br><input type="text" name="progress" id="progress" value="" size="3" class="formElements"></td>' +
            '<td><label for="end">end</label><br><input type="text" name="end" id="end" value="" class="date"  size="10" class="formElements"><input type="checkbox" id="endIsMilestone"></td>' +
            '</tr><tr>' +
            '</table>' +
            '</td>' +
            '</tr>' +
            '</table>' +
            '<div style="text-align: right; padding-top: 20px"><button id="saveButton" class="button big">save</button></div>' +
            '</div>' +
            '--></div>';

        $(taskEdit).appendTo(this);
        $(taskRow).appendTo(this);
        $(taskEmptyRow).appendTo(this);
        $(status).appendTo(this);
        $(rowEdit).appendTo(this);
        $(ganntButtons).appendTo(this);
//        createGannt('0fce0d27-2a7f-43d1-999f-e15190ebe32d', options.calendarHeight, options.calendarWidth);
                        createGannt(path[1],options.calendarHeight,options.calendarWidth);
    };
})(jQuery);

function createGannt(templateId, ganntHeight, ganntWidth) {
    var yuniqueGanntMain;
    var TaskAssignedToID;
    var typeDatasource;
    var datasourceLength;
    var taskWorkflow;
    var localStorageForIE;
    //    console.log(localStorage)
    try {
        localStorage.setItem("yuniqueColumnsData", "");
    } catch (e) {}
    Yunique.Http.get('/CDN/JavaScriptFileSet/newSet',{
    }).then(function (e) {
         console.log(e)
    });
    Yunique.Http.get('/TACalendarTemplateTask', {
        "TACalTemplateId": templateId
    }, {
        pagesize: 9999
    })
        .then(function (resp) {
            $(function () {
                // here starts gantt initialization
                ge = new GanttMaster();
                var workSpace = $("#workSpace");

                workSpace.css({
                    width: ganntWidth ? ganntWidth : $(window).width() - 20,
                    height: ganntHeight ? ganntHeight : $(window).height() - 20
                });
                ge.init(workSpace);
                $(window).resize(function () {
                    workSpace.css({
                        width: ganntWidth ? ganntWidth : $(window).width() - 20,
                        height: ganntHeight ? ganntHeight : $(window).height() - 20
                    });
                    workSpace.trigger("resize.gantt");
                })

            });
            var tempDatasource = resp.YuniqueAPI.pTACalTemplateTask;
            typeDatasource = resp.YuniqueAPI.Lookups.TaskTypeId;
            if (!$.isArray(tempDatasource)) {
                tempDatasource = new Array();
                tempDatasource.push(resp.YuniqueAPI.pTACalTemplateTask);
            }
            var calendarDatasource = new Array();

            function compare(a, b) {
                if (parseInt(a.TaskId) < parseInt(b.TaskId))
                    return -1;
                if (parseInt(a.TaskId) > parseInt(b.TaskId))
                    return 1;
                return 0;
            }
            tempDatasource.sort(compare);
            for (var i = 0, k = tempDatasource.length; i < k; i++) {
                var objectToPush = {};
                objectToPush.id = tempDatasource[i].TaskId;
                objectToPush.start = (new Date(tempDatasource[i].TaskPlanStart)).getTime();
                if (!tempDatasource[i].TaskPlanEnd) {
                    objectToPush.end = computeEndByDuration(new Date(tempDatasource[i].TaskPlanStart), tempDatasource[i].TaskDuration)
                } else {
                    objectToPush.end = (new Date(tempDatasource[i].TaskPlanEnd)).getTime();
                }
                objectToPush.TaskWorkflowId = tempDatasource[i].TaskWorkflowId;
                objectToPush.duration = tempDatasource[i].TaskDuration;
                objectToPush.TACalTemplateId = tempDatasource[i].TACalTemplateId;
                objectToPush.depends = tempDatasource[i].depends;
                objectToPush.name = tempDatasource[i].TaskName;
                objectToPush.level = parseInt(tempDatasource[i].level);
                objectToPush.type = tempDatasource[i].TaskTypeId;
                objectToPush.progress = tempDatasource[i].TaskProgress;
                objectToPush.team = tempDatasource[i].TaskAssignedToID;
                objectToPush.new = tempDatasource[i].new;
                objectToPush.carryOver = tempDatasource[i].CarryOver;
                objectToPush.TACalTemplateTaskID = tempDatasource[i].TACalTemplateTaskID;
                objectToPush.TaskNote = tempDatasource[i].TaskNote;
                calendarDatasource.push(objectToPush);
            }
            //recompute dates;
            //            var newStart = computeStart(new Date('04/27/13'));
            //            var newEnd =computeEnd(new Date('05/27/13'));
            //            var oldSrart =computeStart(new Date('04/27/14'));
            //            var oldEnd =computeEnd(new Date('05/27/14'));
            //            var panData = oldSrart - newStart;
            //            calendarDatasource[0].start = newStart
            //            calendarDatasource[0].end = newEnd
            //            calendarDatasource[0].duration = recomputeDuration(newStart,newEnd)
            //            for(var i= 1,k=calendarDatasource.length;i<k;i++){
            //                var a = computeEndByDuration(calendarDatasource[i].start - panData,calendarDatasource[i].duration)
            //                calendarDatasource[i].start = calendarDatasource[i].start - panData;
            //                calendarDatasource[i].end = a
            //            }

            datasourceLength = calendarDatasource.length;
            calendarDatasource[0].level = 0; //remove this after API update
            calendarDatasource[0].hasChild = true; //remove this after API update
            //            calendarDatasource[0].startIsMilestone = true; //remove this after API update
            var datasourceObj = {
                'tasks': calendarDatasource,
                "selectedRow": 0,
                "canWrite": true,
                "canWriteOnParent": true
            };
            taskWorkflow = resp.YuniqueAPI.Lookups.TaskWorkflowId;
//            taskWorkflow.unshift({
//                key: '',
//                value: ' '
//            });
            var groupNameForTasks = [];
            for (var i = 0; i < taskWorkflow.length; i++) {
                var obj = taskWorkflow[i].value2;
                if($.inArray(obj,groupNameForTasks) === -1){
                    groupNameForTasks.push(obj);
                    taskWorkflow.splice(i,0,{value:obj,key:'group'});
                }
            }
            TaskAssignedToID = resp.YuniqueAPI.Lookups.TaskAssignedToID;
            var objectToCreate = new Array();
            $.fn.multiselect = function () {
                $(this).each(function () {
                    var checkboxes = $(this).find("input:checkbox");
                    checkboxes.each(function () {
                        var checkbox = $(this);
                        // Highlight pre-selected checkboxes
                        if (!checkbox.prop("checked"))
                            checkbox.parent().addClass("multiselect-on");

                        // Highlight checkboxes that the user selects
                        checkbox.click(function () {
                            var taskEditRow = $('.taskEditRow ');
                            var checkboxValue = checkbox.val();
                            if (!checkbox.prop("checked")) {
                                taskEditRow.each(function () {
                                    $(this).find('td').eq(checkboxValue).css('display', 'none')
                                });
                                objectToCreate.push(checkboxValue);
                                try {
                                    localStorage.setItem("yuniqueColumnsData", objectToCreate);
                                } catch (e) {
                                    localStorageForIE = objectToCreate;
                                }
                                $($('.gdfTable')[1]).find('.gdfColHeader').eq(checkbox.val()).css('display', 'none');

                                checkbox.parent().addClass("multiselect-on");
                            } else {
                                var index = objectToCreate.indexOf(checkboxValue);
                                if (index > -1) {
                                    objectToCreate.splice(index, 1);
                                }
                                try {
                                    localStorage.setItem("yuniqueColumnsData", objectToCreate);
                                } catch (e) {
                                    localStorageForIE = objectToCreate;
                                }
                                taskEditRow.each(function () {
                                    $(this).find('td').eq(checkboxValue).css('display', 'table-cell')
                                });
                                $($('.gdfTable')[1]).find('.gdfColHeader').eq(checkbox.val()).css('display', 'table-cell');
                                checkbox.parent().removeClass("multiselect-on");
                            }
                        });
                    });
                });
            };

            function openResourceEditor() {
                var editor = $("<div>");
                editor.append("<h2>Resource editor</h2>");
                editor.addClass("resEdit");

                for (var i in ge.resources) {
                    var res = ge.resources[i];
                    var inp = $("<input type='text'>").attr("pos", i).addClass("resLine").val(res.name);
                    editor.append(inp).append("<br>");
                }

                var sv = $("<div>save</div>").css("float", "right").addClass("button").click(function () {
                    $(this).closest(".resEdit").find("input").each(function () {
                        var el = $(this);
                        var pos = el.attr("pos");
                        ge.resources[pos].name = el.val();
                    });
                    ge.editor.redraw();
                    closeBlackPopup();
                });
                editor.append(sv);

                var ndo = createBlackPage(800, 500).append(editor);
            }
            var taskName;
            ge.loadProject(datasourceObj);
            //recreate calendar on top
            var holidayData = holidayArray();
            var disableHolidays = function (e) {
                var disabledDay = $('.disabledDay');
                disabledDay.parent().removeAttr("href");
                disabledDay.parent().parent().removeClass("k-state-hover");
                disabledDay.parent().removeClass("k-link");
                disabledDay.parent().addClass("disabledDayClicked");
            };
            $(".calendarYU input").kendoDatePicker({
                format: "MM/dd/yyyy",
                dates: holidayData,
                month: {
                    // template for dates in month view
                    content: '# if ($.inArray(+data.date, data.dates) != -1) { #' +
                        '<div class="disabledDay">#= data.value #</div>' +
                        '# } else { #' +
                        '#= data.value #' +
                        '# } #'
                },
                open: function (e) {
                    $(document).on('mouseover', '.disabledDay', disableHolidays);
                },
                close: function () {
                    $(document).off('mouseover', '.disabledDay', disableHolidays);
                }
            });
            //aspx
            var firstRow = $('.taskEditRow')[0];
            $($('.gdfTable')[1]).find('tbody').sortable({
                items: "tr:not(.emptyRow)",
                start: function (e, ui) {
                    $(ui.item[0]).click();
                },
                stop: function (e, ui) {
                    var moveTo = ($(ui.item[0]).index());
                    $(this).sortable("cancel");
                    if (moveTo !== ($(ui.item[0]).index()) && moveTo != 0) {
                        var type = moveTo > ($(ui.item[0]).index()) ? 'down' : 'up';
                        $('#workSpace').trigger('moveCurrentTask.gantt', {
                            type: type,
                            line: moveTo
                        });
                    }
                }
            });
            var btnSave = $('#btnSave');
            window.saveFunc = function () {
                var tempDatasource = (ge.saveProject()).tasks;
                var deletedIds = ge.yuniqueDeletedGuis;
                var calendarDatasource = new Array();

                for (var i = 0, k = tempDatasource.length; i < k; i++) {
                    var objectToPush = {};
                    var id = i + 1;
                    objectToPush.TaskId = id;
                    objectToPush.TaskTypeId = tempDatasource[i].type;
                    if (tempDatasource[i].type === '0') {
                        objectToPush.new = '0';
                        objectToPush.CarryOver = '0';
                    } else {
                        objectToPush.new = tempDatasource[i].new;
                        objectToPush.CarryOver = tempDatasource[i].carryOver;
                    }
                    objectToPush.TaskPlanEnd = new Date(tempDatasource[i].end);
                    objectToPush.TaskPlanStart = new Date(tempDatasource[i].start);
                    objectToPush.TaskWorkflowId = tempDatasource[i].TaskWorkflowId;
                    objectToPush.TACalTemplateId = tempDatasource[0].TACalTemplateId;
                    objectToPush.TaskAssignedToID = tempDatasource[i].team;
                    objectToPush.TaskName = tempDatasource[i].name;
                    if ((tempDatasource[i].id).indexOf('tmp') !== -1 && tempDatasource[i].type !== '0' && !tempDatasource[i].TaskWorkflowId) {
                        tempDatasource[i].TaskWorkflowId = taskWorkflow[0].key;
                        objectToPush.TaskName = taskWorkflow[0].value;
                    }
                    objectToPush.TaskDuration = tempDatasource[i].duration;
                    objectToPush.depends = tempDatasource[i].depends;
                    objectToPush.active = 0;
                    objectToPush.TaskProgress = tempDatasource[i].progress;
                    objectToPush.level = tempDatasource[i].level;
                    objectToPush.TACalTemplateTaskID = tempDatasource[i].TACalTemplateTaskID;
                    objectToPush.TaskNote = tempDatasource[i].TaskNote;
                    calendarDatasource.push(objectToPush);
                }
                //Attention WTF with DELETE headers?
                $(deletedIds).each(function () {
                    var newArr = new Array();
                    newArr.push(this);
                    Yunique.Http.delete('/TACalendarTemplateTask', newArr)
                        .then(function (e) {});
                });
                btnSave.unbind("click", saveFunc);
                Yunique.Http.post('/TACalendarTemplateTask', calendarDatasource)
                    .then(function (resp) {
                        btnSave.on('click', saveFunc);
                        toastr.success('All changes saved');
                        //ugly hack for "tooo fast" browsers
                        setTimeout(function () {
                            window.__doPostBack('btnSave', '');
                        }, 1000)

                    });
            };
            btnSave.removeAttr('onclick')
            btnSave.click(function(event){
                event.preventDefault();
                saveFunc()
            });
        });


    GridEditor.prototype.hideColumns = function () {
        var dataForSelection = [];
        var headerTable = $('.gdfTable.fixHead').find('.gdfColHeader');
        var header = $('.gdfColHeader');
        headerTable.each(function () {
            if ($.inArray($(this).html(), dataForSelection) == -1 && $(this).html() !== '') {
                var objectToPush = {
                    name: $(this).html(),
                    val: $(this).index()
                };
                dataForSelection.push(objectToPush)
            }
        });

        var multiselectBox = $('<div class="multiselect">');
        $(dataForSelection).each(function () {
            var opt = $('<label><input type="checkbox" checked="checked" name="option[]" value="' + this.val + '" />' + this.name + '</label>');
            multiselectBox.append(opt);
        });
        var headerClicked = false;
        multiselectBox.append($('</div>'));
        header.click(function (e) {
            if (!headerClicked) {
                $(this).append(multiselectBox);
                $(".multiselect").multiselect();
                headerClicked = true;
                $(document).mouseup(function (e) {
                    var container = $(".multiselect");
                    if (!container.is(e.target) && container.has(e.target).length === 0) {
                        multiselectBox.remove();
                    }
                });
            } else {
                headerClicked = false;
            }
        })
    };
    GridEditor.prototype.fillEmptyLines = function () {
        var factory = new TaskFactory();

        //console.debug("GridEditor.fillEmptyLines");
        var rowsToAdd = datasourceLength + 10 - this.element.find(".taskEditRow").size();

        //fill with empty lines
        for (var i = 0; i < rowsToAdd; i++) {
            var emptyRow = $.JST.createFromTemplate({}, "TASKEMPTYROW");
            //click on empty row create a task and fill above
            var master = this.master;
            emptyRow.click(function (ev) {
                var emptyRow = $(this);
                //add on the first empty row only
                if (!master.canWrite || emptyRow.prevAll(".emptyRow").size() > 0)
                    return

                master.beginTransaction();
                var lastTask;
                var start = new Date().getTime();
                var level = 0;
                if (master.tasks[0]) {
                    start = master.tasks[0].start;
                    level = master.tasks[0].level + 1;
                }

                //fill all empty previouses
                emptyRow.prevAll(".emptyRow").andSelf().each(function () {
                    var ch = factory.build("tmp_fk" + new Date().getTime(), "", "", level, start, 1);
                    var task = master.addTask(ch);
                    lastTask = ch;
                });
                master.endTransaction();
                lastTask.rowElement.click();
                lastTask.rowElement.find("[name=name]").focus() //focus to "name" input
                    .blur(function () { //if name not inserted -> undo -> remove just added lines
                        var imp = $(this);
                        if (imp.val() == "") {
                            lastTask.name = "Task " + (lastTask.getRow() + 1);
                            imp.val(lastTask.name);
                        }
                    });
            });
            this.element.append(emptyRow);
        }
    };


    GridEditor.prototype.addTask = function (task, row) {
        var factory = new TaskFactory();
        //console.debug("GridEditor.addTask",task,row);
        //var prof = new Profiler("editorAddTaskHtml");

        //remove extisting row
        this.element.find("[taskId=" + task.id + "]").remove();

        var taskRow = $.JST.createFromTemplate(task, "TASKROW");
        //save row element on task
        task.rowElement = taskRow;

        this.bindRowEvents(task, taskRow);

        if (typeof (row) != "number") {
            var emptyRows = this.element.find(".emptyRow:first"); //tries to fill an empty row
            if (emptyRows.size() > 0) {
                emptyRows.replaceWith(taskRow);
                var emptyRow = $.JST.createFromTemplate({}, "TASKEMPTYROW");
                //click on empty row create a task and fill above
                var master = this.master;
                emptyRow.click(function (ev) {
                    var emptyRow = $(this);
                    //add on the first empty row only
                    if (!master.canWrite || emptyRow.prevAll(".emptyRow").size() > 0)
                        return

                    master.beginTransaction();
                    var lastTask;
                    var start = new Date().getTime();
                    var level = 0;
                    if (master.tasks[0]) {
                        start = master.tasks[0].start;
                        level = master.tasks[0].level + 1;
                    }

                    //fill all empty previouses
                    emptyRow.prevAll(".emptyRow").andSelf().each(function () {
                        var ch = factory.build("tmp_fk" + new Date().getTime(), "", "", level, start, 1);
                        var task = master.addTask(ch);
                        lastTask = ch;
                    });
                    master.endTransaction();
                    lastTask.rowElement.click();
                    lastTask.rowElement.find("[name=name]").focus() //focus to "name" input
                        .blur(function () { //if name not inserted -> undo -> remove just added lines
                            var imp = $(this);
                            if (imp.val() == "") {
                                lastTask.name = "Task " + (lastTask.getRow() + 1);
                                imp.val(lastTask.name);
                            }
                        });
                });
                this.element.append(emptyRow);
            } else {
                this.element.append(taskRow);
            }
        } else {
            var tr = this.element.find("tr.taskEditRow").eq(row);
            if (tr.size() > 0) {
                tr.before(taskRow);
            } else {
                this.element.append(taskRow);
            }

        }
        this.element.find(".taskRowIndex").each(function (i, el) {
            $(el).html(i + 1);
        });
        //prof.stop();
        try {
            if (localStorage.getItem("yuniqueColumnsData")) {
                var columnsArray = (localStorage.getItem("yuniqueColumnsData"));
                for (var i = 0, k = columnsArray.length; i < k; i++) {
                    taskRow.each(function () {
                        $(this).find('td').eq(columnsArray[i]).css('display', 'none')
                    });
                }
            }
        } catch (e) {
            if (localStorageForIE) {
                for (var i = 0, k = localStorageForIE.length; i < k; i++) {
                    taskRow.each(function () {
                        $(this).find('td').eq(localStorageForIE[i]).css('display', 'none')
                    });
                }
            };

        }
        return taskRow;
    };


    GridEditor.prototype.refreshTaskRow = function (task) {
        //console.debug("refreshTaskRow")
        //var profiler = new Profiler("editorRefreshTaskRow");
        var row = task.rowElement;

        row.find(".taskRowIndex").html(task.getRow() + 1);
        row.find(".indentCell").css("padding-left", task.level * 10);
        row.find("[name=name]").val(task.name);
        row.find("[name=code]").val(task.code);
        row.find("[status]").attr("status", task.status);

        row.find("[name=duration]").val(task.duration);
        row.find("[name=start]").val(new Date(task.start).format()).updateOldValue(); // called on dates only because for other field is called on focus event
        row.find("[name=end]").val(new Date(task.end).format()).updateOldValue();
        row.find("[name=depends]").val(task.depends);
        row.find(".taskAssigs").html(task.getAssigsString());

        //profiler.stop();
    };

    GridEditor.prototype.redraw = function () {
        for (var i = 0; i < this.master.tasks.length; i++) {
            this.refreshTaskRow(this.master.tasks[i]);
        }
    };

    GridEditor.prototype.reset = function () {
        this.element.find("[taskId]").remove();
    };


    GridEditor.prototype.bindRowEvents = function (task, taskRow) {
        var self = this;
        //console.debug("bindRowEvents",this,this.master,this.master.canWrite, task.canWrite);
        if (this.master.canWrite && task.canWrite) {
            self.bindRowInputEvents(task, taskRow);

        } else { //cannot write: disable input
            taskRow.find("input").attr("readonly", true);
        }

        taskRow.find(".edit").click(function () {
            self.openFullEditor(task, taskRow)
        });

    };


    GridEditor.prototype.bindRowInputEvents = function (task, taskRow) {
        $($('.teamYunique')[0]).find('span').css('visibility', 'hidden');
        $($('.new')[0]).find('input').css('visibility', 'hidden');
        $($('.carryOver')[0]).find('input').css('visibility', 'hidden');
        var self = this;
        taskRow.find('.taskNameYunique').each(function () {
            var el = $(this);
            el.change(function () {
                task.name = el.val();
                self.master.taskIsChanged();

            })
        });
        taskRow.find('.calendarTask').each(function () {
            var el = $(this).find('.taskNameDDL');
            var el2 = $(this).find('input');
            var indexElem = 1;
            for (var i = 0, k = taskWorkflow.length; i < k; i++) {
                if (task.TaskWorkflowId === taskWorkflow[i].key) {
                    indexElem = i
                }
            }

            $(el).kendoDropDownList({
                dataTextField: "value",
                dataValueField: "key",
                dataSource: taskWorkflow,
                template:
                   '#if (data.key === "group") {#' +
                    '<span class="groupName" > ${data.value}</span>' +
                    '# } else { # '+
                    '<span class="groupItem">${data.value}</span > #' +'}#' ,
                index: indexElem,
                dataBound: function (e) {
                    var grName = $(".groupName");
                    grName.parent().addClass('groupNameColor').addClass('k-state-disabled');
                    grName.parent().click(false);
                },
                select: function (e) {
                    task.TaskWorkflowId = this.dataItem(e.item.index()).key
                    task.name = this.dataItem(e.item.index()).value
                    self.master.taskIsChanged();
                }
            });
            if (task.type === '0') {
                $(this).find('span.taskNameDDL').css('display', 'none');
                taskRow.find('.new').find('input').css('visibility', 'hidden');
                taskRow.find('.carryOver').find('input').css('visibility', 'hidden');
            }
            if (task.type === '1') {
                $(el2).css('display', 'none')
            } else {
                task.type === '0';
                task.level === '1';
                $(this).find('span.taskNameDDL').css('display', 'none');
            }

        });


        taskRow.find('.taskTypeYunique').each(function () {
            if (task.id !== '1') {
                var el = $(this).find('input');
                var indexElem = 0;
                for (var i = 0, k = typeDatasource.length; i < k; i++) {
                    if (task.type === typeDatasource[i].key) {
                        indexElem = i
                    }
                }
                $(el).kendoDropDownList({
                    dataTextField: "value",
                    dataValueField: "key",
                    dataSource: typeDatasource,
                    index: indexElem
                });
                if (!task.type) {
                    task.type = '0';
                }
                el.change(function () {
                    task.type = el.val();
                    if (el.val() === '1') {
                        taskRow.find('span.taskNameDDL').css('display', 'block');
                        taskRow.find('.taskNameYunique').css('display', 'none');
                        taskRow.find('.new').find('input').css('visibility', 'visible');
                        taskRow.find('.carryOver').find('input').css('visibility', 'visible');
                    } else {
                        taskRow.find('span.taskNameDDL').css('display', 'none');
                        taskRow.find('.taskNameYunique').css('display', 'block');
                        taskRow.find('.new').find('input').css('visibility', 'hidden');
                        taskRow.find('.carryOver').find('input').css('visibility', 'hidden');
                    }


                })
            } else {
                $(this).find('input').attr('disabled', 'true')
            }
        });

        taskRow.find('.new').each(function () {
            var el = $(this).find('input');
            if (task.new === '1') {
                $(el).prop('checked', true);
            } else if (task.new === '0') {
                task.new = '0'
            }
            if (!task.new) {
                task.new = '1'
                $(el).prop('checked', true);
                task.TACalTemplateTaskID = "00000000-0000-0000-0000-000000000000";
                taskRow.find('.new').find('input').css('visibility', 'hidden');
                taskRow.find('.carryOver').find('input').css('visibility', 'hidden');
            }

            el.change(function (e) {
                if ($(this).is(":checked")) {
                    task.new = '1'
                } else {
                    task.new = '0'
                }
            })
        });
        taskRow.find('.carryOver').each(function () {
            var el = $(this).find('input');
            if (task.carryOver === '1') {
                $(el).prop('checked', true);
            } else {
                task.carryOver = '0'
            }
            el.change(function (e) {
                if ($(this).is(":checked")) {
                    task.carryOver = '1'
                } else {
                    task.carryOver = '0'
                }
            })
        });


        taskRow.find('.teamYunique').each(function () {
            var el = $(this).find('input');
            var indexElem = 0;
            if (task.team) {
                for (var i = 0, k = TaskAssignedToID.length; i < k; i++) {
                    if (task.team === TaskAssignedToID[i].key) {
                        indexElem = i
                    }
                }
            } else {
                indexElem = 0;
                task.team = TaskAssignedToID[0].key;
            }
            el.kendoComboBox({
                dataTextField: "value",
                dataValueField: "key",
                dataSource: TaskAssignedToID,
                filter: "contains",
                suggest: true,
                index: indexElem,
                change: function () {}
            });
        });
        var disableHolidays = function (e) {
            var disabledDay = $('.disabledDay');
            disabledDay.parent().removeAttr("href");
            disabledDay.parent().removeAttr("title");
            disabledDay.parent().parent().removeClass("k-state-hover");
            disabledDay.parent().removeClass("k-link");
            disabledDay.parent().addClass("disabledDayClicked");
        };
        //bind dateField on dates
        taskRow.find(".date").each(function () {
            var el = $(this);
            var holidayName = '';
            //start is readonly in case of deps
            $(el).kendoDatePicker({
                format: "MM/dd/yyyy",
                dates: holidayArrayData.dates,
                month: {
                    // template for dates in month view
                    content: '# if ($.inArray(+data.date, data.dates) != -1) { #' +
                        '# $.each(holidayArrayData.holNames,function(i,e){if(e.key === new Date(data.date).getTime()){holidayName = e.value}})#'+
                        '<div class="disabledDay" title=\"#:holidayName#\">#= data.value #</div>' +
                        '# } else { #' +
                        '#= data.value #' +
                        '# } #'
                },
                open: function (e) {
                    $(document).on('mouseover', '.disabledDay', disableHolidays);
                },
                close: function () {
                    $(document).off('mouseover', '.disabledDay', disableHolidays);
                }

            }).data("kendoDatePicker");
            if (task.depends && el.attr("name") == "start") {
                $(el).data('kendoDatePicker').enable(false)
            } else {
                $(el).data('kendoDatePicker').enable(true)
            }
            el.blur(function (date) {
                var inp = $(this);
                if (inp.isValueChanged()) {
                    if (!Date.isValid(inp.val())) {
                        alert(GanttMaster.messages["INVALID_DATE_FORMAT"]);
                        inp.val(inp.getOldValue());

                    } else {
                        var date = Date.parseString(inp.val());
                        var row = inp.closest("tr");
                        var taskId = row.attr("taskId");
                        var task = self.master.getTask(taskId);
                        var lstart = task.start;
                        var lend = task.end;

                        if (inp.attr("name") == "start") {
                            lstart = date.getTime();
                            if (lstart >= lend) {
                                var end_as_date = new Date(lstart);
                                lend = end_as_date.add('d', task.duration).getTime();
                            }

                            //update task from editor
                            self.master.beginTransaction();
                            self.master.moveTask(task, lstart);
                            self.master.endTransaction();

                        } else {
                            lend = date.getTime();
                            if (lstart >= lend) {
                                lend = lstart;
                            }
                            lend = lend + 3600000 * 20; // this 20 hours are mandatory to reach the correct day end (snap to grid)

                            //update task from editor
                            self.master.beginTransaction();
                            self.master.changeTaskDates(task, lstart, lend);
                            self.master.endTransaction();
                        }


                        inp.updateOldValue(); //in order to avoid multiple call if nothing changed
                    }
                }
            });
        });


        //binding on blur for task update (date exluded as click on calendar blur and then focus, so will always return false, its called refreshing the task row)
        taskRow.find("input:not(.date)").focus(function () {
            $(this).updateOldValue();

        }).blur(function () {
                var el = $(this);
                if (el.isValueChanged()) {
                    var row = el.closest("tr");
                    var taskId = row.attr("taskId");

                    var task = self.master.getTask(taskId);

                    //update task from editor
                    var field = el.attr("name");

                    self.master.beginTransaction();

                    if (field == "depends") {
                        var oldDeps = task.depends;
                        task.depends = el.val();

                        //start is readonly in case of deps
                        if (task.depends) {
                            //            row.find("[name=start]").attr("readonly", "true");
                        } else {
                            //            row.find("[name=start]").removeAttr("readonly");
                        }


                        // update links
                        var linkOK = self.master.updateLinks(task);
                        if (linkOK) {
                            //synchronize status from superiors states
                            var sups = task.getSuperiors();
                            for (var i = 0; i < sups.length; i++) {
                                if (!sups[i].from.synchronizeStatus())
                                    break;
                            }
                            self.master.changeTaskDates(task, task.start, task.end); // fake change to force date recomputation from dependencies
                        }

                    } else if (field == "duration") {
                        var dur = task.duration;
                        dur = parseInt(el.val()) || 1;
                        el.val(dur);
                        var newEnd = computeEndByDuration(task.start, dur);
                        self.master.changeTaskDates(task, task.start, newEnd);

                    } else if (field == "name" && el.val() == "") { // remove unfilled task
                        task.deleteTask();

                    } else {
                        task[field] = el.val();
                    }
                    self.master.endTransaction();
                }
            });

        //cursor key movement
        taskRow.find("input").keydown(function (event) {
            var theCell = $(this);
            var theTd = theCell.parent();
            var theRow = theTd.parent();
            var col = theTd.prevAll("td").size();

            var ret = true;
            switch (event.keyCode) {

                case 37: //left arrow
                    if (this.selectionEnd == 0)
                        theTd.prev().find("input").focus();
                    break;
                case 39: //right arrow
                    if (this.selectionEnd == this.value.length)
                        theTd.next().find("input").focus();
                    break;

                case 38: //up arrow
                    var prevRow = theRow.prev();
                    var td = prevRow.find("td").eq(col);
                    var inp = td.find("input");

                    if (inp.size() > 0)
                        inp.focus();
                    break;
                case 40: //down arrow
                    var nextRow = theRow.next();
                    var td = nextRow.find("td").eq(col);
                    var inp = td.find("input");
                    if (inp.size() > 0)
                        inp.focus();
                    else
                        nextRow.click(); //create a new row
                    break;
                case 36: //home
                    break;
                case 35: //end
                    break;

                case 9: //tab
                case 13: //enter
                    break;
            }
            return ret;

        }).focus(function () {
                $(this).closest("tr").click();
            });

        var notes = taskRow.find(".taskStatus");
        if (task.TaskNote && (task.TaskNote).length !== 0) {
            notes.attr('src', 'jQueryGantt/css/images/notes_edit.png');
            var notesInside = task.TaskNote.length >= 128 ? task.TaskNote.substring(0, 128) + '...' : task.TaskNote;
            notes.attr('title', notesInside);
        }
        //change status
        taskRow.find(".taskStatus").click(function () {
            var el = $(this);
            var tr = el.closest("[taskId]");
            var taskId = tr.attr("taskId");
            var task = self.master.getTask(taskId);

            var changer = $.JST.createFromTemplate({}, "CHANGE_STATUS");
            var taskNote = changer.find('#taskNote').text(task.TaskNote);
            changer.find('#saveNote').click(function () {
                task.TaskNote = taskNote.val();
                if (task.TaskNote && (task.TaskNote).length !== 0) {
                    el.attr('src', 'jQueryGantt/css/images/notes_edit.png');
                    var notesInside = task.TaskNote.length >= 128 ? task.TaskNote.substring(0, 128) + '...' : task.TaskNote;
                    notes.attr('title', notesInside);
                } else {
                    el.attr('src', 'jQueryGantt/css/images/notes_add.png');
                    notes.attr('title', '');
                }
                $("#__blackpopup__").trigger("close");
            });
            createBlackPage(800, 500).append(changer);
        });

        //bind row selection
        taskRow.click(function () {
            var row = $(this);
            //var isSel = row.hasClass("rowSelected");
            row.closest("table").find(".rowSelected").removeClass("rowSelected");
            row.addClass("rowSelected");

            //set current task
            self.master.currentTask = self.master.getTask(row.attr("taskId"));

            //move highlighter
            self.master.gantt.synchHighlight();

            //if offscreen scroll to element
            var top = row.position().top;
            if (top > self.element.parent().height()) {
                row.offsetParent().scrollTop(top - self.element.parent().height() + 100);
            } else if (top < 40) {
                row.offsetParent().scrollTop(row.offsetParent().scrollTop() - 40 + top);
            }
        });

    };


    GridEditor.prototype.openFullEditor = function (task, taskRow) {

        var self = this;

        //task editor in popup
        var taskId = taskRow.attr("taskId");
        if (task.id !== '1' && task.type !== '0' && task.TACalTemplateTaskID !== '00000000-0000-0000-0000-000000000000') {
            showTaskDetails(task.TACalTemplateTaskID)
        }
    };
};
Storage.prototype.getObject = function (key) {
    return this.getItem(key) && JSON.parse(this.getItem(key));
};