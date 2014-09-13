/*
 Copyright (c) 2012-2014 Open Lab
 Written by Roberto Bicchierai and Silvia Chelazzi http://roberto.open-lab.com
 Permission is hereby granted, free of charge, to any person obtaining
 a copy of this software and associated documentation files (the
 "Software"), to deal in the Software without restriction, including
 without limitation the rights to use, copy, modify, merge, publish,
 distribute, sublicense, and/or sell copies of the Software, and to
 permit persons to whom the Software is furnished to do so, subject to
 the following conditions:

 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
$.gridify = function (table, opt) {
    var options = {
        resizeZoneWidth:10
    };

    $.extend(options, opt);

    var box = $("<div>").addClass("gdfWrapper");
    box.append(table);

    var head = table.clone();
    head.css('display','none');
    head.addClass("fixHead");
    //remove non head
    head.find("tbody").remove();
    box.append(head);

    box.append(table);

    var hTh=head.find(".gdfColHeader");
    var cTh=table.find(".gdfColHeader");
    for (var i=0; i<hTh.length;i++){
        hTh.eq(i).data("fTh",cTh.eq(i));
    }

    //--------- set table to 0 to prevent a strange 100%
    table.width(0);
    head.width(0);


    //----------------------  header management start
    head.find("th.gdfColHeader.gdfResizable:not(.gdfied)").mouseover(function () {
        $(this).addClass("gdfColHeaderOver");

    }).bind("mouseout.gdf",function () {
            $(this).removeClass("gdfColHeaderOver");
            if (!$.gridify.columInResize) {
                $("body").removeClass("gdfHResizing");
            }

        }).bind("mousemove.gdf",function (e) {
            if (!$.gridify.columInResize) {
                var colHeader = $(this);
                var mousePos = e.pageX - colHeader.offset().left;

                if (colHeader.width() - mousePos < options.resizeZoneWidth) {
                    $("body").addClass("gdfHResizing");
                } else {
                    $("body").removeClass("gdfHResizing");
                }
            }

        }).bind("mousedown.gdf",function (e) {
            var colHeader = $(this);
            var mousePos = e.pageX - colHeader.offset().left;
            if (colHeader.width() - mousePos < options.resizeZoneWidth) {
                $("body").unselectable();
                $.gridify.columInResize = $(this);
                //bind event for start resizing
                //console.debug("start resizing");
                $(document).bind("mousemove.gdf",function (e) {
                    //manage resizing
                    $.gridify.columInResize.width(e.pageX - $.gridify.columInResize.offset().left);
                    $.gridify.columInResize.data("fTh").width($.gridify.columInResize.outerWidth());


                    //bind mouse up on body to stop resizing
                }).bind("mouseup.gdf", function () {
                        //console.debug("stop resizing");
                        $(this).unbind("mousemove.gdf").unbind("mouseup.gdf").clearUnselectable();
                        $("body").removeClass("gdfHResizing");
                        delete $.gridify.columInResize;
                    });
            }
        }).addClass("gdfied unselectable").attr("unselectable", "true");


    //----------------------  cell management start wrapping
    table.find("td.gdfCell:not(.gdfied)").each(function () {
        var cell = $(this);
        if (cell.is(".gdfEditable")) {
            var inp = $("<input type='text'>").addClass("gdfCellInput");
            inp.val(cell.text());
            cell.empty().append(inp);
        } else {
            var wrp = $("<div>").addClass("gdfCellWrap");
            wrp.html(cell.html());
            cell.empty().append(wrp);
        }
    }).addClass("gdfied");
    return box;
};

$.splittify = {
    init: function(where, first, second,perc) {

        perc=perc || 50;

        var element = $("<div>").addClass("splitterContainer");
        var firstBox = $("<div>").addClass("splitElement splitBox1");
        var splitterBar = $("<div>").addClass("splitElement vSplitBar").attr("unselectable", "on").html("|").css("padding-top",where.height()/2+"px");
        var secondBox = $("<div>").addClass("splitElement splitBox2");

        var splitter= new Splitter(element,firstBox,secondBox,splitterBar);
        splitter.perc=perc;


        firstBox.append(first);
        secondBox.append(second);

        element.append(firstBox).append(secondBox).append(splitterBar);

        where.append(element);

        var w = where.innerWidth();
        var fbw = w *perc/ 100 - splitterBar.width();
        var realW=firstBox.get(0).scrollWidth;
        fbw=fbw>realW?realW:fbw;
        firstBox.width(fbw).css({left:0});
        splitterBar.css({left:firstBox.width()});
        secondBox.width(w -fbw-splitterBar.width() ).css({left:firstBox.width() + splitterBar.width()});


        splitterBar.bind("mousedown.gdf", function(e) {
            $.splittify.splitterBar = $(this);
            //bind event for start resizing
            //console.debug("start splitting");
            var realW=firstBox.get(0).scrollWidth;
            $("body").unselectable().bind("mousemove.gdf", function(e) {
                //manage resizing
                var sb = $.splittify.splitterBar;
                var pos = e.pageX - sb.parent().offset().left;
                var w = sb.parent().width();
                var fbw=firstBox;
                if (pos > 10 && pos < realW) {
                    sb.css({left:pos});
                    firstBox.width(pos);
                    secondBox.css({left:pos + sb.width(),width:w - pos - sb.width()});
                }
                splitter.perc=(firstBox.width()/splitter.element.width())*100;

                //bind mouse up on body to stop resizing
            }).bind("mouseup.gdf", function() {
                    //console.debug("stop splitting");
                    $(this).unbind("mousemove.gdf").unbind("mouseup.gdf").clearUnselectable();
                    delete $.splittify.splitterBar;

                });
        });


        // keep both side in synch when scroll
        var stopScroll=false;
        var fs=firstBox.add(secondBox);
        fs.scroll(function(e) {
            var el = $(this);
            var top = el.scrollTop();
            if (el.is(".splitBox1") && stopScroll!="splitBox2"){
                stopScroll="splitBox1";
                secondBox.scrollTop(top);
            }else if (el.is(".splitBox2") && stopScroll!="splitBox1"){
                stopScroll="splitBox2";
                firstBox.scrollTop(top);
            }
            secondBox.find(".fixHead").css('top', top);
            firstBox.find(".fixHead").css('top', top);

            where.stopTime("reset").oneTime(100,"reset",function(){stopScroll="";})
        });



        function Splitter(element,firstBox, secondBox, splitterBar) {
            this.element=element;
            this.firstBox = firstBox;
            this.secondBox = secondBox;
            this.splitterBar = splitterBar;
            this.perc=0;

            this.resize=function(){
                var totW=this.element.width();
                var realW=this.firstBox.get(0).scrollWidth;
                var newW=totW*this.perc/100;
                newW=newW<realW?newW:realW;
                this.firstBox.css({width:newW});
                this.splitterBar.css({left:newW});
                this.secondBox.css({left:newW + this.splitterBar.width(),width:totW - newW - this.splitterBar.width()});
            }
        }

        return splitter;
    }
};





//<%------------------------------------------------------------------------  UTILITIES ---------------------------------------------------------------%>
function computeStart(start) {
    return computeStartDate(start).getTime();
}
function computeStartDate(start) {
    var d = new Date(start+3600000*12);

    d.setHours(0, 0, 0, 0);
    //move to next working day
    while (isHoliday(d)) {
        d.setDate(d.getDate() + 1);
    }
    d.setHours(0, 0, 0, 0);
    return d;
}

function computeEnd(end) {
    return computeEndDate(end).getTime()
}
function computeEndDate(end) {
    var d = new Date(end-3600000*12);
    d.setHours(23, 59, 59, 999);
    //move to next working day
    while (isHoliday(d)) {
        d.setDate(d.getDate() + 1);
    }
    d.setHours(23, 59, 59, 999);
    return d;
}

function computeEndByDuration(start, duration) {
    var d = new Date(start);
    //console.debug("computeEndByDuration start ",d,duration)
    var q = duration - 1;
    while (q > 0) {
        d.setDate(d.getDate() + 1);
        if (!isHoliday(d))
            q--;
    }
    d.setHours(23, 59, 59, 999);
    return d.getTime();
}

function incrementDateByWorkingDays(date, days) {
    var d = new Date(date);
    d.incrementDateByWorkingDays(days);
    return d.getTime();
}

function recomputeDuration(start, end) {
    //console.debug("recomputeDuration");
    return new Date(start).distanceInWorkingDays(new Date(end));
}



//This prototype is provided by the Mozilla foundation and
//is distributed under the MIT license.
//http://www.ibiblio.org/pub/Linux/LICENSES/mit.license

if (!Array.prototype.filter){
    Array.prototype.filter = function (fun) {
        var len = this.length;
        if (typeof fun != "function")
            throw new TypeError();

        var res = new Array();
        var thisp = arguments[1];
        for (var i = 0; i < len; i++) {
            if (i in this) {
                var val = this[i]; // in case fun mutates this
                if (fun.call(thisp, val, i, this))
                    res.push(val);
            }
        }
        return res;
    };
}
;/*
 Copyright (c) 2012-2014 Open Lab
 Written by Roberto Bicchierai and Silvia Chelazzi http://roberto.open-lab.com
 Permission is hereby granted, free of charge, to any person obtaining
 a copy of this software and associated documentation files (the
 "Software"), to deal in the Software without restriction, including
 without limitation the rights to use, copy, modify, merge, publish,
 distribute, sublicense, and/or sell copies of the Software, and to
 permit persons to whom the Software is furnished to do so, subject to
 the following conditions:

 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

/**
 * A method to instantiate valid task models from
 * raw data.
 */
function TaskFactory() {

    /**
     * Build a new Task
     */
    this.build = function(id, name, code, level, start, duration) {
        // Set at beginning of day
        var adjusted_start = computeStart(start);
        var calculated_end = computeEndByDuration(adjusted_start, duration);
        return new Task(id, name, code, level, adjusted_start, calculated_end, duration);
    };

}

function Task(id, name, code, level, start, end, duration) {
    this.id = id;
    this.name = name;
    this.code = code;
    this.level = level;
    this.status = "STATUS_UNDEFINED";
    this.depends;
    this.canWrite=true; // by default all tasks are writeable
    this.start = start
    this.duration = duration;
    this.end = end;

    this.startIsMilestone = false;
    this.endIsMilestone = false;

    this.collapsed = false;

    this.rowElement; //row editor html element
    this.ganttElement; //gantt html element
    this.master;

    this.assigs = [];
}

Task.prototype.clone = function () {
    var ret = {};
    for (var key in this) {
        if (typeof(this[key]) != "function") {
            ret[key] = this[key];
        }
    }
    return ret;
};

Task.prototype.getAssigsString = function () {
    var ret = "";
    for (var i=0;i<this.assigs.length;i++) {
        var ass = this.assigs[i];
        var res = this.master.getResource(ass.resourceId);
        if (res) {
            ret = ret + (ret == "" ? "" : ", ") + res.name;
        }
    }
    return ret;
};

Task.prototype.createAssignment = function (id, resourceId, roleId, effort) {
    var assig = new Assignment(id, resourceId, roleId, effort);
    this.assigs.push(assig);
    return assig;
};


//<%---------- SET PERIOD ---------------------- --%>
Task.prototype.setPeriod = function (start, end) {
    //console.debug("setPeriod ",this.name,new Date(start),new Date(end));
    //var profilerSetPer = new Profiler("gt_setPeriodJS");

    if (start instanceof Date) {
        start = start.getTime();
    }

    if (end instanceof Date) {
        end = end.getTime();
    }

    var originalPeriod = {
        start: this.start,
        end:  this.end,
        duration: this.duration
    };

    //console.debug("setStart",date,date instanceof Date);
    var wantedStartMillis = start;

    //cannot start after end
    if (start > end) {
        start = end;
    }

    //set a legal start
    start = computeStart(start);

    //if depends -> start is set to max end + lag of superior
    var sups = this.getSuperiors();
    if (sups && sups.length > 0) {

        var supEnd = 0;
        for (var i=0;i<sups.length;i++) {
            var link = sups[i];
            supEnd = Math.max(supEnd, incrementDateByWorkingDays(link.from.end, link.lag));
        }
        //if changed by depends move it
        if (computeStart(supEnd) != start) {
            return this.moveTo(supEnd + 1, false);
        }
    }

    var somethingChanged = false;

    //move date to closest day
    var date = new Date(start);

    if (this.start != start || this.start != wantedStartMillis) {
        this.start = start;
        somethingChanged = true;
    }

    //set end
    var wantedEndMillis = end;

    end = computeEnd(end);

    if (this.end != end || this.end != wantedEndMillis) {
        this.end = end;
        somethingChanged = true;
    }

    this.duration = recomputeDuration(this.start, this.end);

    //profilerSetPer.stop();

    //nothing changed exit
    if (!somethingChanged)
        return true;

    //cannot write exit
    if(!this.canWrite){
        this.master.setErrorOnTransaction(GanttMaster.messages["CANNOT_WRITE"] + "\n" + this.name, this);
        return false;
    }

    //external dependencies: exit with error
    if (this.hasExternalDep) {
        this.master.setErrorOnTransaction(GanttMaster.messages["TASK_HAS_EXTERNAL_DEPS"] + "\n" + this.name, this);
        return false;
    }

    var todoOk = true;

    //I'm restricting
    var deltaPeriod = originalPeriod.duration - this.duration;
    var restricting = deltaPeriod > 0;
    var restrictingStart = restricting && (originalPeriod.start < this.start);
    var restrictingEnd = restricting && (originalPeriod.end > this.end);

    //console.debug( " originalPeriod.duration "+ originalPeriod.duration +" deltaPeriod "+deltaPeriod+" "+"restricting "+restricting);
    if (restricting) {
        //loops children to get boundaries
        var children = this.getChildren();
        var bs = Infinity;
        var be = 0;
        for (var i=0;i<children.length;i++) {

            ch = children[i];
            //console.debug("restricting: test child "+ch.name+" "+ch.end)
            if (restrictingEnd) {
                be = Math.max(be, ch.end);
            } else {
                bs = Math.min(bs, ch.start);
            }
        }

        if (restrictingEnd) {
            //console.debug("restricting end ",be, this.end);
            this.end = Math.max(be, this.end);
        } else {
            //console.debug("restricting start");
            this.start = Math.min(bs, this.start);
        }

        this.duration = recomputeDuration(this.start, this.end);
    } else {

        //check global boundaries
        if (this.start < this.master.minEditableDate || this.end > this.master.maxEditableDate) {
            this.master.setErrorOnTransaction(GanttMaster.messages["CHANGE_OUT_OF_SCOPE"], this);
            todoOk = false;
        }

        //console.debug("set period: somethingChanged",this);
        if (todoOk && !updateTree(this)) {
            todoOk = false;
        }
    }

    if (todoOk) {
        //and now propagate to inferiors
        var infs = this.getInferiors();
        if (infs && infs.length > 0) {
            for (var i=0;i<infs.length;i++) {
                var link = infs[i];
                if (!link.to.canWrite){
                    this.master.setErrorOnTransaction(GanttMaster.messages["CANNOT_WRITE"] + "\n" + link.to.name, link.to);
                    break;
                }
                todoOk = link.to.moveTo(end, false); //this is not the right date but moveTo checks start
                if (!todoOk)
                    break;
            }
        }
    }

    return todoOk;
};


//<%---------- MOVE TO ---------------------- --%>
Task.prototype.moveTo = function (start, ignoreMilestones) {
    //console.debug("moveTo ",this,start,ignoreMilestones);
    //var profiler = new Profiler("gt_task_moveTo");
    if (start instanceof Date) {
        start = start.getTime();
    }
    var originalPeriod = {
        start:this.start,
        end:this.end
    };
    var wantedStartMillis = start;
    //set a legal start
    start = computeStart(start);
    //if start is milestone cannot be move
    if (!ignoreMilestones && this.startIsMilestone && start != this.start) {
        //notify error
        this.master.setErrorOnTransaction(GanttMaster.messages["START_IS_MILESTONE"], this);
        return false;
    } else if (this.hasExternalDep) {
        //notify error
        this.master.setErrorOnTransaction(GanttMaster.messages["TASK_HAS_EXTERNAL_DEPS"], this);
        return false;
    }

    //if depends start is set to max end + lag of superior
    var sups = this.getSuperiors();
    if (sups && sups.length > 0) {
        var supEnd = 0;
        for (var i=0;i<sups.length;i++) {
            var link = sups[i];
            supEnd = Math.max(supEnd, incrementDateByWorkingDays(link.from.end, link.lag));
        }
        start = supEnd + 1;
    }
    //set a legal start
    start = computeStart(start);

    var end = computeEndByDuration(start, this.duration);

    if (this.start != start || this.start != wantedStartMillis) {
        //in case of end is milestone it never changes, but recompute duration
        if (!ignoreMilestones && this.endIsMilestone) {
            end = this.end;
            this.duration = recomputeDuration(start, end);
        }
        this.start = start;
        this.end = end;
        //profiler.stop();

        //check global boundaries
        if (this.start < this.master.minEditableDate || this.end > this.master.maxEditableDate) {
            this.master.setErrorOnTransaction(GanttMaster.messages["CHANGE_OUT_OF_SCOPE"], this);
            return false;
        }


        var panDelta = originalPeriod.start - this.start;
        //console.debug("panDelta",panDelta);
        //loops children to shift them
        var children = this.getChildren();
        for (var i=0;i<children.length;i++) {
            ch = children[i];
            if (!ch.moveTo(ch.start - panDelta, false)) {
                return false;
            }
        }


        //console.debug("set period: somethingChanged",this);
        if (!updateTree(this)) {
            return false;
        }


        //and now propagate to inferiors
        var infs = this.getInferiors();
        if (infs && infs.length > 0) {
            for (var i=0;i<infs.length;i++) {
                var link = infs[i];


                //this is not the right date but moveTo checks start
                if (!link.to.canWrite ) {
                    this.master.setErrorOnTransaction(GanttMaster.messages["CANNOT_WRITE"]+ "\n"+link.to.name, link.to);
                } else if (!link.to.moveTo(end, false)) {
                    return false;
                }
            }
        }

    }

    return true;
};


function updateTree(task) {
    //console.debug("updateTree ",task);
    var error;

    //try to enlarge parent
    var p = task.getParent();

    //no parent:exit
    if (!p)
        return true;
    var newStart = p.start;
    var newEnd = p.end;
    if (p.start > task.start) {
        if (p.startIsMilestone) {
            task.master.setErrorOnTransaction(GanttMaster.messages["START_IS_MILESTONE"] + "\n" + p.name, task);
            return false;
        } else if (p.depends) {
            task.master.setErrorOnTransaction(GanttMaster.messages["TASK_HAS_CONSTRAINTS"] + "\n" + p.name, task);
            return false;
        }

        newStart = task.start;
    }

    if (p.end < task.end) {
        if (p.endIsMilestone) {
            task.master.setErrorOnTransaction(GanttMaster.messages["END_IS_MILESTONE"] + "\n" + p.name, task);
            return false;
        }

        newEnd = task.end;
    }

    //propagate updates if needed
    if (newStart != p.start || newEnd != p.end) {

        //can write?
        if (!p.canWrite){
            task.master.setErrorOnTransaction(GanttMaster.messages["CANNOT_WRITE"] + "\n" + p.name, task);
            return false;
        }

        //has external deps ?
        if (p.hasExternalDep) {
            task.master.setErrorOnTransaction(GanttMaster.messages["TASK_HAS_EXTERNAL_DEPS"] + "\n" + p.name, task);
            return false;
        }

        return p.setPeriod(newStart, newEnd);
    }


    return true;
}

//<%---------- CHANGE STATUS ---------------------- --%>
Task.prototype.changeStatus = function(newStatus) {
    //console.debug("changeStatus: "+this.name+" from "+this.status+" -> "+newStatus);
    //compute descendant for identify a cone where status changes propagate
    var cone = this.getDescendant();

    function propagateStatus(task, newStatus, manuallyChanged, propagateFromParent, propagateFromChildren) {
        //console.debug("propagateStatus",task.name, task.status,newStatus)
        var oldStatus = task.status;

        //no changes exit
        if(newStatus == oldStatus){
            return true;
        }
        //console.debug("propagateStatus: "+task.name + " from " + task.status + " to " + newStatus + " " + (manuallyChanged?" a manella":"")+(propagateFromParent?" da parent":"")+(propagateFromChildren?" da children":""));

        var todoOk = true;
        task.status = newStatus;

        if( task.master.cannotCloseTaskIfIssueOpen && newStatus=="STATUS_DONE" && task.openIssues>0){
            task.master.setErrorOnTransaction(GanttMaster.messages["CANNOT_CLOSE_TASK_IF_OPEN_ISSUE"] +" " +task.name);
            return false;
        }

        //xxxx -> STATUS_DONE            may activate dependent tasks, both suspended and undefined. Will set to done all descendants.
        //STATUS_FAILED -> STATUS_DONE          do nothing if not forced by hand
        if (newStatus == "STATUS_DONE") {

            if ((manuallyChanged || oldStatus != "STATUS_FAILED")) { //cannot change for cascade when failed

                //can be closed only if superiors are already done
                var sups = task.getSuperiors();
                for (var i=0;i<sups.length;i++) {
                    if (cone.indexOf(sups[i].from) < 0) {
                        if (sups[i].from.status != "STATUS_DONE") {
                            if (manuallyChanged || propagateFromParent)
                                task.master.setErrorOnTransaction(GanttMaster.messages["GANTT_ERROR_DEPENDS_ON_OPEN_TASK"] + "\n" + sups[i].from.name + " -> " + task.name);
                            todoOk = false;
                            break;
                        }
                    }
                }

                if (todoOk) {
                    //todo set progress to 100% if set on config

                    var chds = task.getChildren();
                    //set children as done
                    for (var i=0;i<chds.length;i++)
                        propagateStatus(chds[i], "STATUS_DONE", false,true,false);

                    //set inferiors as active if outside the cone
                    propagateToInferiors(cone, task.getInferiors(), "STATUS_ACTIVE");
                }
            } else {
                todoOk = false;
            }


            //  STATUS_UNDEFINED -> STATUS_ACTIVE       all children become active, if they have no dependencies.
            //  STATUS_SUSPENDED -> STATUS_ACTIVE       sets to active all children and their descendants that have no inhibiting dependencies.
            //  STATUS_DONE -> STATUS_ACTIVE            all those that have dependencies must be set to suspended.
            //  STATUS_FAILED -> STATUS_ACTIVE          nothing happens: child statuses must be reset by hand.
        } else if (newStatus == "STATUS_ACTIVE") {

            if ((manuallyChanged || oldStatus != "STATUS_FAILED")) { //cannot change for cascade when failed

                //activate parent if closed
                var par=task.getParent();
                if (par && par.status != "STATUS_ACTIVE") {
                    todoOk=propagateStatus(par,"STATUS_ACTIVE",false,false,true);
                }

                if(todoOk){
                    //can be active only if superiors are already done
                    var sups = task.getSuperiors();
                    for (var i=0;i<sups.length;i++) {
                        if (sups[i].from.status != "STATUS_DONE") {
                            if (manuallyChanged || propagateFromChildren)
                                task.master.setErrorOnTransaction(GanttMaster.messages["GANTT_ERROR_DEPENDS_ON_OPEN_TASK"] + "\n" + sups[i].from.name + " -> " + task.name);
                            todoOk = false;
                            break;
                        }
                    }
                }

                if (todoOk) {
                    var chds = task.getChildren();
                    if (oldStatus == "STATUS_UNDEFINED" || oldStatus == "STATUS_SUSPENDED") {
                        //set children as active
                        for (var i=0;i<chds.length;i++)
                            if (chds[i].status != "STATUS_DONE" )
                                propagateStatus(chds[i], "STATUS_ACTIVE", false,true,false);
                    }

                    //set inferiors as suspended
                    var infs = task.getInferiors();
                    for (var i=0;i<infs.length;i++)
                        propagateStatus(infs[i].to, "STATUS_SUSPENDED", false,false,false);
                }
            } else {
                todoOk = false;
            }

            // xxxx -> STATUS_SUSPENDED       all active children and their active descendants become suspended. when not failed or forced
            // xxxx -> STATUS_UNDEFINED       all active children and their active descendants become suspended. when not failed or forced
        } else if (newStatus == "STATUS_SUSPENDED" || newStatus == "STATUS_UNDEFINED") {
            if (manuallyChanged || oldStatus != "STATUS_FAILED") { //cannot change for cascade when failed

                //suspend parent if not active
                var par=task.getParent();
                if (par && par.status != "STATUS_ACTIVE") {
                    todoOk=propagateStatus(par,newStatus,false,false,true);
                }


                var chds = task.getChildren();
                //set children as active
                for (var i=0;i<chds.length;i++){
                    if (chds[i].status != "STATUS_DONE")
                        propagateStatus(chds[i], newStatus, false,true,false);
                }

                //set inferiors as STATUS_SUSPENDED or STATUS_UNDEFINED
                propagateToInferiors(cone, task.getInferiors(), newStatus);
            } else {
                todoOk = false;
            }

            // xxxx -> STATUS_FAILED children and dependent failed
        } else if (newStatus == "STATUS_FAILED") {
            var chds = task.getChildren();
            //set children as failed
            for (var i=0;i<chds.length;i++)
                propagateStatus(chds[i], "STATUS_FAILED", false,true,false);

            //set inferiors as active
            //set children as done
            propagateToInferiors(cone, task.getInferiors(), "STATUS_FAILED");
        }
        if (!todoOk){
            task.status = oldStatus;
            //console.debug("status rolled back: "+task.name + " to " + oldStatus);
        }

        return todoOk;
    }

    /**
     * A helper method to traverse an array of 'inferior' tasks
     * and signal a status change.
     */
    function propagateToInferiors(cone, infs, status) {
        for (var i=0;i<infs.length;i++) {
            if (cone.indexOf(infs[i].to) < 0) {
                propagateStatus(infs[i].to, status, false, false, false);
            }
        }
    }

    var todoOk = true;
    var oldStatus = this.status;

    todoOk = propagateStatus(this, newStatus, true,false,false);

    if (!todoOk)
        this.status = oldStatus;

    return todoOk;
};

Task.prototype.synchronizeStatus=function(){
    var oldS=this.status;
    this.status="";
    return this.changeStatus(oldS);
};

Task.prototype.isLocallyBlockedByDependencies=function(){
    var sups = this.getSuperiors();
    var blocked=false;
    for (var i=0;i<sups.length;i++) {
        if (sups[i].from.status != "STATUS_DONE") {
            blocked=true;
            break;
        }
    }
    return blocked;
};

//<%---------- TASK STRUCTURE ---------------------- --%>
Task.prototype.getRow = function() {
    ret = -1;
    if (this.master)
        ret = this.master.tasks.indexOf(this);
    return ret;
};


Task.prototype.getParents = function() {
    var ret;
    if (this.master) {
        var topLevel = this.level;
        var pos = this.getRow();
        ret = [];
        for (var i = pos; i >= 0; i--) {
            var par = this.master.tasks[i];
            if (topLevel > par.level) {
                topLevel = par.level;
                ret.push(par);
            }
        }
    }
    return ret;
};


Task.prototype.getParent = function() {
    var ret;
    if (this.master) {
        for (var i = this.getRow(); i >= 0; i--) {
            var par = this.master.tasks[i];
            if (this.level > par.level) {
                ret = par;
                break;
            }
        }
    }
    return ret;
};


Task.prototype.isParent = function() {
    var ret = false;
    if (this.master) {
        var pos = this.getRow();
        if (pos < this.master.tasks.length - 1)
            ret = this.master.tasks[pos + 1].level > this.level;
    }
    return ret;
};


Task.prototype.getChildren = function() {
    var ret = [];
    if (this.master) {
        var pos = this.getRow();
        for (var i = pos + 1; i < this.master.tasks.length; i++) {
            var ch = this.master.tasks[i];
            if (ch.level == this.level + 1)
                ret.push(ch);
            else if (ch.level <= this.level) // exit loop if parent or brother
                break;
        }
    }
    return ret;
};


Task.prototype.getDescendant = function() {
    var ret = [];
    if (this.master) {
        var pos = this.getRow();
        for (var i = pos + 1; i < this.master.tasks.length; i++) {
            var ch = this.master.tasks[i];
            if (ch.level > this.level)
                ret.push(ch);
            else
                break;
        }
    }
    return ret;
};


Task.prototype.getSuperiors = function() {
    var ret = [];
    var task = this;
    if (this.master) {
        ret = this.master.links.filter(function(link) {
            return link.to == task;
        });
    }
    return ret;
};

Task.prototype.getSuperiorTasks = function() {
    var ret=[];
    var sups = this.getSuperiors();
    for (var i=0;i<sups.length;i++)
        ret.push(sups[i].from);
    return ret;
};


Task.prototype.getInferiors = function() {
    var ret = [];
    var task = this;
    if (this.master) {
        ret = this.master.links.filter(function(link) {
            return link.from == task;
        });
    }
    return ret;
};

Task.prototype.getInferiorTasks = function() {
    var ret=[];
    var infs = this.getInferiors();
    for (var i=0;i<infs.length;i++)
        ret.push(infs[i].to);
    return ret;
};

Task.prototype.deleteTask = function() {
    //delete both dom elements
    this.rowElement.remove();
    this.ganttElement.remove();

    //remove children
    var chd = this.getChildren();
    for (var i=0;i<chd.length;i++) {
        //add removed child in list
        if(!chd[i].isNew())
            this.master.deletedTaskIds.push(chd[i].id);
        if(chd[i] !== '00000000-0000-0000-0000-000000000000'){
            this.master.yuniqueDeletedGuis.push({TACalTemplateTaskID:chd[i].TACalTemplateTaskID})
        }
        chd[i].deleteTask();
    }

    if(!this.isNew()) {
        this.master.deletedTaskIds.push(this.id);
        if(this.TACalTemplateTaskID !== '00000000-0000-0000-0000-000000000000'){
            this.master.yuniqueDeletedGuis.push({TACalTemplateTaskID:this.TACalTemplateTaskID})
        }
    }


    //remove from in-memory collection
    this.master.tasks.splice(this.getRow(), 1);

    //remove from links
    var task = this;
    this.master.links = this.master.links.filter(function(link) {
        return link.from != task && link.to != task;
    });
};


Task.prototype.isNew=function(){
    return (this.id+"").indexOf("tmp_")==0;
};

Task.prototype.isDependent=function(t) {
    //console.debug("isDependent",this.name, t.name)
    var task=this;
    var dep= this.master.links.filter(function(link) {
        return link.from == task ;
    });

    // is t a direct dependency?
    for (var i=0;i<dep.length;i++) {
        if (dep[i].to== t)
            return true;
    }
    // is t an indirect dependency
    for (var i=0;i<dep.length;i++) {
        if (dep[i].to.isDependent(t)) {
            return true;
        }
    }
    return false;
};

Task.prototype.setLatest=function(maxCost) {
    this.latestStart = maxCost - this.criticalCost;
    this.latestFinish = this.latestStart + this.duration;
};


//<%------------------------------------------  INDENT/OUTDENT --------------------------------%>
Task.prototype.indent = function() {
    //console.debug("indent", this);
    //a row above must exist
    var row = this.getRow();

    //no row no party
    if (row <=0)
        return false;
    var ret = false;
    var taskAbove = this.master.tasks[row - 1];
    var newLev = parseInt(this.level) + 1;
    if (newLev <= parseInt(taskAbove.level) + 1) {
        ret = true;
        //trick to get parents after indent
        this.level++;
        var futureParents = this.getParents();
        this.level--;
        var oldLevel = parseInt(this.level);
        for (var i = row; i < this.master.tasks.length; i++) {
            var desc = this.master.tasks[i];
            if (desc.level > oldLevel || desc == this) {
                desc.level++;
                //remove links from descendant to my parents
                this.master.links = this.master.links.filter(function(link) {
                    var linkToParent = false;
                    if (link.to == desc)
                        linkToParent = futureParents.indexOf(link.from) >= 0;
                    else if (link.from == desc)
                        linkToParent = futureParents.indexOf(link.to) >= 0;
                    return !linkToParent;
                });
            } else
                break;
        }

        var parent = this.getParent();
        // set start date to parent' start if no deps
        if(parent && !this.depends){
            var new_end = computeEndByDuration(parent.start, this.duration);
            this.master.changeTaskDates(this, parent.start, new_end);
        }
        //recompute depends string
        this.master.updateDependsStrings();
        //enlarge parent using a fake set period
        this.setPeriod(this.start + 1, this.end + 1);

        //force status check
        this.synchronizeStatus();
    }
    return ret;
};


Task.prototype.outdent = function() {
    //console.debug("outdent", this);

    //a level must be >1 -> cannot escape from root
    if (parseInt(this.level) <= 1)
        return false;

    var ret = false;
    var oldLevel = parseInt(this.level);

    ret = true;
    var row = this.getRow();
    for (var i = row; i < this.master.tasks.length; i++) {
        var desc = this.master.tasks[i];
        if (desc.level > oldLevel || desc == this) {
            desc.level--;
        } else
            break;
    }

    var task = this;
    var chds = this.getChildren();
    //remove links from me to my new children
    this.master.links = this.master.links.filter(function(link) {
        var linkExist = (link.to == task && chds.indexOf(link.from) >= 0 || link.from == task && chds.indexOf(link.to) >= 0);
        return !linkExist;
    });


    //enlarge me if inherited children are larger
    for (var i=0;i<chds.length;i++) {
        //remove links from me to my new children
        chds[i].setPeriod(chds[i].start + 1, chds[i].end + 1);
    }

    //recompute depends string
    this.master.updateDependsStrings();

    //enlarge parent using a fake set period
    this.setPeriod(this.start + 1, this.end + 1);

    //force status check
    this.synchronizeStatus();
    return ret;
};


//<%------------------------------------------  MOVE UP / MOVE DOWN --------------------------------%>
Task.prototype.moveUp = function() {
    //console.debug("moveUp", this);
    var ret = false;

    //a row above must exist
    var row = this.getRow();

    //no row no party
    if (row <=0)
        return false;

    //find new row
    var newRow;
    for (newRow = row - 1; newRow >= 0; newRow--) {
        if (this.master.tasks[newRow].level <= this.level){
            break;
        }
    }

    //is a parent or a brother
    if (this.master.tasks[newRow].level == this.level) {
        ret = true;
        //compute descendant
        var descNumber = 0;
        for (var i = row + 1; i < this.master.tasks.length; i++) {
            var desc = this.master.tasks[i];
            if (desc.level > this.level) {
                descNumber++;
            } else {
                break;
            }
        }
        //move in memory
        var blockToMove = this.master.tasks.splice(row, descNumber + 1);
        var top = this.master.tasks.splice(0, newRow);
        this.master.tasks = [].concat(top, blockToMove, this.master.tasks);
        //move on dom
        var rows = this.master.editor.element.find("tr[taskId]");
        var domBlockToMove = rows.slice(row, row + descNumber + 1);
        rows.eq(newRow).before(domBlockToMove);
        //recompute depends string
        this.master.updateDependsStrings();
    } else {
        this.master.setErrorOnTransaction(GanttMaster.messages["TASK_MOVE_INCONSISTENT_LEVEL"], this);
        ret = false;
    }
    return ret;
};


Task.prototype.moveDown = function() {
    //console.debug("moveDown", this);
    //a row below must exist, and cannot move root task
    var row = this.getRow();
    if (row >= this.master.tasks.length - 1 || row==0)
        return false;

    var ret = false;

    //find nearest brother
    var newRow;
    for (newRow = row + 1; newRow < this.master.tasks.length; newRow++) {
        if (this.master.tasks[newRow].level <= this.level)
            break;
    }

    //is brother
    if (this.master.tasks[newRow] && this.master.tasks[newRow].level == this.level) {
        ret = true;
        //find last desc
        for (newRow = newRow + 1; newRow < this.master.tasks.length; newRow++) {
            if (this.master.tasks[newRow].level <= this.level)
                break;
        }

        //compute descendant
        var descNumber = 0;
        for (var i = row + 1; i < this.master.tasks.length; i++) {
            var desc = this.master.tasks[i];
            if (desc.level > this.level) {
                descNumber++;
            } else {
                break;
            }
        }

        //move in memory
        var blockToMove = this.master.tasks.splice(row, descNumber + 1);
        var top = this.master.tasks.splice(0, newRow - descNumber - 1);
        this.master.tasks = [].concat(top, blockToMove, this.master.tasks);


        //move on dom
        var rows = this.master.editor.element.find("tr[taskId]");
        var aft = rows.eq(newRow - 1);
        var domBlockToMove = rows.slice(row, row + descNumber + 1);
        aft.after(domBlockToMove);

        //recompute depends string
        this.master.updateDependsStrings();
    }

    return ret;
};

Task.prototype.moveDrag = function(params) {
    if(params.type ==='up'){
        var ret = false;

        //a row above must exist
        var row = this.getRow();

        //no row no party
        if (row <=0) {
            return false;
        }
        //find new row
        var newRow = parseInt(params.line);
        for (newRow; newRow >= 0; newRow--) {
            if (this.master.tasks[newRow].level <= this.level){
                break;
            }
        }

        //is a parent or a brother
        if (this.master.tasks[newRow].level == this.level) {
            ret = true;
            //compute descendant
            var descNumber = 0;
            for (var i = row + 1; i < this.master.tasks.length; i++) {
                var desc = this.master.tasks[i];
                if (desc.level > this.level) {
                    descNumber++;
                } else {
                    break;
                }
            }
            //move in memory
            var blockToMove = this.master.tasks.splice(row, descNumber + 1);
            var top = this.master.tasks.splice(0, newRow);
            this.master.tasks = [].concat(top, blockToMove, this.master.tasks);
            //move on dom
            var rows = this.master.editor.element.find("tr[taskId]");
            var domBlockToMove = rows.slice(row, row + descNumber + 1);
            rows.eq(newRow).before(domBlockToMove);

            //recompute depends string
            this.master.updateDependsStrings();
        } else {
            ret = false;
        }
        return ret;
    }else{
        var row = this.getRow();
        if (row >= this.master.tasks.length - 1 || row==0){
            return false;
        }

        var ret = false;

        //find nearest brother
        var newRow = parseInt(params.line);
        for (newRow; newRow < this.master.tasks.length; newRow++) {
            if (this.master.tasks[newRow].level <= this.level){
                break;
            }
        }

        //is brother
        if (this.master.tasks[newRow] && this.master.tasks[newRow].level == this.level) {
            ret = true;
            //find last desc
            for (newRow = newRow + 1; newRow < this.master.tasks.length; newRow++) {
                if (this.master.tasks[newRow].level <= this.level){
                    break;
                }
            }

            //compute descendant
            var descNumber = 0;
            for (var i = row + 1; i < this.master.tasks.length; i++) {
                var desc = this.master.tasks[i];
                if (desc.level > this.level) {
                    descNumber++;
                } else {
                    break;
                }
            }

            //move in memory
            var blockToMove = this.master.tasks.splice(row, descNumber + 1);
            var top = this.master.tasks.splice(0, newRow - descNumber - 1);
            this.master.tasks = [].concat(top, blockToMove, this.master.tasks);


            //move on dom
            var rows = this.master.editor.element.find("tr[taskId]");
            var aft = rows.eq(newRow - 1);
            var domBlockToMove = rows.slice(row, row + descNumber + 1);
            aft.after(domBlockToMove);

            //recompute depends string
            this.master.updateDependsStrings();
        }

        return ret;
    }
};

//<%------------------------------------------------------------------------  LINKS OBJECT ---------------------------------------------------------------%>
function Link(taskFrom, taskTo, lagInWorkingDays) {
    this.from = taskFrom;
    this.to = taskTo;
    this.lag = lagInWorkingDays;
}


//<%------------------------------------------------------------------------  ASSIGNMENT ---------------------------------------------------------------%>
function Assignment(id, resourceId, roleId, effort) {
    this.id = id;
    this.resourceId = resourceId;
    this.roleId = roleId;
    this.effort = effort;
}


//<%------------------------------------------------------------------------  RESOURCE ---------------------------------------------------------------%>
function Resource(id, name) {
    this.id = id;
    this.name = name;
}


//<%------------------------------------------------------------------------  ROLE ---------------------------------------------------------------%>
function Role(id, name) {
    this.id = id;
    this.name = name;
}




;/*
 Copyright (c) 2012-2014 Open Lab
 Written by Roberto Bicchierai and Silvia Chelazzi http://roberto.open-lab.com
 Permission is hereby granted, free of charge, to any person obtaining
 a copy of this software and associated documentation files (the
 "Software"), to deal in the Software without restriction, including
 without limitation the rights to use, copy, modify, merge, publish,
 distribute, sublicense, and/or sell copies of the Software, and to
 permit persons to whom the Software is furnished to do so, subject to
 the following conditions:

 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
function Ganttalendar(zoom, startmillis, endMillis, master, minGanttSize) {
    this.master = master; // is the a GantEditor instance
    this.element; // is the jquery element containing gantt
    this.highlightBar;
    this.zoom = zoom;
    this.minGanttSize = minGanttSize;
    this.includeToday=true; //when true today is always visible. If false boundaries comes from tasks periods
    this.showCriticalPath=false; //when true critical path is highlighted

    this.zoomLevels = ["d","w", "m", "q", "s", "y"];

    this.element = this.create(zoom, startmillis, endMillis);

}

Ganttalendar.prototype.zoomGantt = function(isPlus) {
    var curLevel = this.zoom;
    var pos = this.zoomLevels.indexOf(curLevel + "");

    var newPos = pos;
    if (isPlus) {
        newPos = pos <= 0 ? 0 : pos - 1;
    } else {
        newPos = pos >= this.zoomLevels.length - 1 ? this.zoomLevels.length - 1 : pos + 1;
    }
    if (newPos != pos) {
        curLevel = this.zoomLevels[newPos];
        this.zoom = curLevel;
        this.refreshGantt();
    }
};


Ganttalendar.prototype.create = function(zoom, originalStartmillis, originalEndMillis) {
    //console.debug("Gantt.create " + new Date(originalStartmillis) + " - " + new Date(originalEndMillis));

    var self = this;

    function getPeriod(zoomLevel, stMil, endMillis) {
        var start = new Date(stMil);
        var end = new Date(endMillis);


        //reset hours
        if (zoomLevel == "d") {
            start.setHours(0, 0, 0, 0);
            end.setHours(23, 59, 59, 999);

            start.setFirstDayOfThisWeek();
            end.setFirstDayOfThisWeek();
            end.setDate(end.getDate() + 6);

            //reset day of week
        } else if (zoomLevel == "w") {
            start.setHours(0, 0, 0, 0);
            end.setHours(23, 59, 59, 999);

            start.setFirstDayOfThisWeek();
            end.setFirstDayOfThisWeek();
            end.setDate(end.getDate() + 6);

            //reset day of month
        } else if (zoomLevel == "m") {
            start.setHours(0, 0, 0, 0);
            end.setHours(23, 59, 59, 999);

            start.setDate(1);
            end.setDate(1);
            end.setMonth(end.getMonth() + 1);
            end.setDate(end.getDate() - 1);

            //reset to quarter
        } else if (zoomLevel == "q") {
            start.setHours(0, 0, 0, 0);
            end.setHours(23, 59, 59, 999);
            start.setDate(1);
            start.setMonth(Math.floor(start.getMonth() / 3) * 3);
            end.setDate(1);
            end.setMonth(Math.floor(end.getMonth() / 3) * 3 + 3);
            end.setDate(end.getDate() - 1);

            //reset to semester
        } else if (zoomLevel == "s") {
            start.setHours(0, 0, 0, 0);
            end.setHours(23, 59, 59, 999);
            start.setDate(1);

            start.setMonth(Math.floor(start.getMonth() / 6) * 6);
            end.setDate(1);
            end.setMonth(Math.floor(end.getMonth() / 6) * 6 + 6);
            end.setDate(end.getDate() - 1);

            //reset to year - > gen
        } else if (zoomLevel == "y") {
            start.setHours(0, 0, 0, 0);
            end.setHours(23, 59, 59, 999);

            start.setDate(1);
            start.setMonth(0);

            end.setDate(1);
            end.setMonth(12);
            end.setDate(end.getDate() - 1);
        }
        return {start:start.getTime(),end:end.getTime()};
    }

    function createHeadCell(lbl, span, additionalClass,width) {
        var th = $("<th>").html(lbl).attr("colSpan", span);
        if (width)
            th.width(width);
        if (additionalClass)
            th.addClass(additionalClass);
        return th;
    }

    function createBodyCell(span, isEnd, additionalClass) {
        var ret = $("<td>").html("").attr("colSpan", span).addClass("ganttBodyCell");
        if (isEnd)
            ret.addClass("end");
        if (additionalClass)
            ret.addClass(additionalClass);
        return ret;
    }

    function createGantt(zoom, startPeriod, endPeriod) {
        var tr1 = $("<tr>").addClass("ganttHead1");
        var tr2 = $("<tr>").addClass("ganttHead2");
        var trBody = $("<tr>").addClass("ganttBody");

        function iterate(renderFunction1, renderFunction2) {
            var start = new Date(startPeriod);
            //loop for header1
            while (start.getTime() <= endPeriod) {
                renderFunction1(start);
            }

            //loop for header2
            start = new Date(startPeriod);
            while (start.getTime() <= endPeriod) {
                renderFunction2(start);
            }
        }

        //this is computed by hand in order to optimize cell size
        var computedTableWidth;

        // year
        if (zoom == "y") {
            computedTableWidth = Math.floor(((endPeriod - startPeriod) / (3600000 * 24 * 180)) * 100); //180gg = 1 sem = 100px
            iterate(function(date) {
                tr1.append(createHeadCell(date.format("yyyy"), 2));
                date.setFullYear(date.getFullYear() + 1);
            }, function(date) {
                var sem = (Math.floor(date.getMonth() / 6) + 1);
                tr2.append(createHeadCell('S' + sem, 1,null,100));
                trBody.append(createBodyCell(1, sem == 2));
                date.setMonth(date.getMonth() + 6);
            });

            //semester
        } else if (zoom == "s") {
            computedTableWidth = Math.floor(((endPeriod - startPeriod) / (3600000 * 24 * 90)) * 100); //90gg = 1 quarter = 100px
            iterate(function(date) {
                var end = new Date(date.getTime());
                end.setMonth(end.getMonth() + 6);
                end.setDate(end.getDate() - 1);
                tr1.append(createHeadCell(date.format("MMM") + " - " + end.format("MMM yyyy"), 2));
                date.setMonth(date.getMonth() + 6);
            }, function(date) {
                var quarter = ( Math.floor(date.getMonth() / 3) + 1);
                tr2.append(createHeadCell('Q' + quarter, 1,null,100));
                trBody.append(createBodyCell(1, quarter % 2 == 0));
                date.setMonth(date.getMonth() + 3);
            });

            //quarter
        } else if (zoom == "q") {
            computedTableWidth = Math.floor(((endPeriod - startPeriod) / (3600000 * 24 * 30)) * 300); //1 month= 300px
            iterate(function(date) {
                var end = new Date(date.getTime());
                end.setMonth(end.getMonth() + 3);
                end.setDate(end.getDate() - 1);
                tr1.append(createHeadCell(date.format("MMM") + " - " + end.format("MMM yyyy"), 3));
                date.setMonth(date.getMonth() + 3);
            }, function(date) {
                var lbl = date.format("MMM");
                tr2.append(createHeadCell(lbl, 1,null,300));
                trBody.append(createBodyCell(1, date.getMonth() % 3 == 2));
                date.setMonth(date.getMonth() + 1);
            });

            //month
        } else if (zoom == "m") {
            computedTableWidth = Math.floor(((endPeriod - startPeriod) / (3600000 * 24 * 1)) * 25); //1 day= 20px
            iterate(function(date) {
                var sm = date.getTime();
                date.setMonth(date.getMonth() + 1);
                var daysInMonth = Math.round((date.getTime() - sm) / (3600000 * 24));
                tr1.append(createHeadCell(new Date(sm).format("MMMM yyyy"), daysInMonth)); //spans mumber of dayn in the month
            }, function(date) {
                tr2.append(createHeadCell(date.format("d"), 1, isHoliday(date) ? "holyH" : null,25));
                var nd = new Date(date.getTime());
                nd.setDate(date.getDate() + 1);
                trBody.append(createBodyCell(1, nd.getDate() == 1, isHoliday(date) ? "holy" : null));
                date.setDate(date.getDate() + 1);
            });

            //week
        } else if (zoom == "w") {
            computedTableWidth = Math.floor(((endPeriod - startPeriod) / (3600000 * 24)) * 40); //1 day= 40px
            iterate(function(date) {
                var end = new Date(date.getTime());
                end.setDate(end.getDate() + 6);
                tr1.append(createHeadCell(date.format("MMM d") + " - " + end.format("MMM d'yy"), 7));
                date.setDate(date.getDate() + 7);
            }, function(date) {
                tr2.append(createHeadCell(date.format("EEEE").substr(0, 1), 1, isHoliday(date) ? "holyH" : null, 40));
                trBody.append(createBodyCell(1, date.getDay() % 7 == (self.master.firstDayOfWeek + 6) % 7, isHoliday(date) ? "holy" : null));
                date.setDate(date.getDate() + 1);
            });

            //days
        } else if (zoom == "d") {
            computedTableWidth = Math.floor(((endPeriod - startPeriod) / (3600000 * 24)) * 100); //1 day= 100px
            iterate(function(date) {
                var end = new Date(date.getTime());
                end.setDate(end.getDate() + 6);
                tr1.append(createHeadCell(date.format("MMMM d") + " - " + end.format("MMMM d yyyy"), 7));
                date.setDate(date.getDate() + 7);
            }, function (date) {
                tr2.append(createHeadCell(date.format("EEE d"), 1, isHoliday(date) ? "holyH" : null, 100));
                trBody.append(createBodyCell(1, date.getDay() % 7 == (self.master.firstDayOfWeek + 6) % 7, isHoliday(date) ? "holy" : null));
                date.setDate(date.getDate() + 1);
            });

        } else {
            console.error("Wrong level " + zoom);
        }

        //set a minimal width
        computedTableWidth = Math.max(computedTableWidth, self.minGanttSize);

        var table = $("<table cellspacing=0 cellpadding=0>");
        table.append(tr1).append(tr2).css({width:computedTableWidth});

        var head=table.clone().addClass("fixHead");

        table.append(trBody).addClass("ganttTable");


        table.height(self.master.editor.element.height());

        var box = $("<div>");
        box.addClass("gantt unselectable").attr("unselectable","true").css({position:"relative",width:computedTableWidth});
        box.append(table);

        box.append(head);

        //highlightBar
        var hlb = $("<div>").addClass("ganttHighLight");
        box.append(hlb);
        self.highlightBar = hlb;

        //create link container
        var links = $("<div>");
        links.addClass("ganttLinks").css({position:"absolute",top:0,width:computedTableWidth,height:"100%"});
        box.append(links);

        //compute scalefactor fx
        self.fx = computedTableWidth / (endPeriod - startPeriod);

        // drawTodayLine
        if (new Date().getTime() > self.startMillis && new Date().getTime() < self.endMillis) {
            var x = Math.round(((new Date().getTime()) - self.startMillis) * self.fx);
            var today = $("<div>").addClass("ganttToday").css("left", x);
            box.append(today);
        }

        return box;
    }

    //if include today synch extremes
    if (this.includeToday){
        var today=new Date().getTime();
        originalStartmillis=originalStartmillis>today ? today:originalStartmillis;
        originalEndMillis=originalEndMillis<today ? today:originalEndMillis;
    }


    //get best dimension fo gantt
    var period = getPeriod(zoom, originalStartmillis, originalEndMillis); //this is enlarged to match complete periods basing on zoom level

    //console.debug(new Date(period.start) + "   " + new Date(period.end));
    self.startMillis = period.start; //real dimension of gantt
    self.endMillis = period.end;
    self.originalStartMillis = originalStartmillis; //minimal dimension required by user or by task duration
    self.originalEndMillis = originalEndMillis;

    var table = createGantt(zoom, period.start, period.end);

    return table;
};



//<%-------------------------------------- GANT TASK GRAPHIC ELEMENT --------------------------------------%>
Ganttalendar.prototype.drawTask = function (task) {
    //console.debug("drawTask", task.name,new Date(task.start));

    //var prof = new Profiler("ganttDrawTask");
    var self = this;
    editorRow = task.rowElement;
    var top = editorRow.position().top+ editorRow.offsetParent().scrollTop();

    var x = Math.round((task.start - self.startMillis) * self.fx);

    var taskBox = $.JST.createFromTemplate(task, "TASKBAR");



    //save row element on task
    task.ganttElement = taskBox;

    //if I'm parent
    if (task.isParent())
        taskBox.addClass("hasChild");

    taskBox.css({top:top,left:x,width:Math.round((task.end - task.start) * self.fx)});

    if (this.master.canWrite && task.canWrite) {
        taskBox.resizable({
            handles: 'e' + ( task.depends ? "" : ",w"), //if depends cannot move start
            //helper: "ui-resizable-helper",
            //grid:[oneDaySize,oneDaySize],

            resize:function(event, ui) {
                //console.debug(ui)
                $(".taskLabel[taskId=" + ui.helper.attr("taskId") + "]").css("width", ui.position.left);
                event.stopImmediatePropagation();
                event.stopPropagation();
            },
            stop:function(event, ui) {
                //console.debug(ui)
                var task = self.master.getTask(ui.element.attr("taskId"));
                var s = Math.round((ui.position.left / self.fx) + self.startMillis);
                var e = Math.round(((ui.position.left + ui.size.width) / self.fx) + self.startMillis);

                self.master.beginTransaction();
                self.master.changeTaskDates(task, new Date(s), new Date(e));
                self.master.endTransaction();
            }

        }).on("mouseup",function(){
                $(":focus").blur(); // in order to save grid field when moving task
            });
    }

    taskBox.dblclick(function() {
        self.master.showTaskEditor($(this).closest("[taskId]").attr("taskId"));

    }).mousedown(function() {
            var task = self.master.getTask($(this).attr("taskId"));
            task.rowElement.click();
        });

    //panning only if no depends
    if (!task.depends && this.master.canWrite && task.canWrite) {

        taskBox.css("position", "absolute").draggable({
            axis:'x',
            drag:function (event, ui) {
                $(".taskLabel[taskId=" + $(this).attr("taskId") + "]").css("width", ui.position.left);
            },
            stop:function(event, ui) {
                var task = self.master.getTask($(this).attr("taskId"));
                var s = Math.round((ui.position.left / self.fx) + self.startMillis);

                self.master.beginTransaction();
                self.master.moveTask(task, new Date(s));
                self.master.endTransaction();
            }/*,
             start:function(event, ui) {
             var task = self.master.getTask($(this).attr("taskId"));
             var s = Math.round((ui.position.left / self.fx) + self.startMillis);
             }*/
        });
    }


    var taskBoxSeparator=$("<div class='ganttLines'></div>");
    taskBoxSeparator.css({top:top+taskBoxSeparator.height()});
//  taskBoxSeparator.css({top:top+18});


    self.element.append(taskBox);
    self.element.append(taskBoxSeparator);

    //ask for redraw link
    self.redrawLinks();

    //prof.stop();
};


Ganttalendar.prototype.addTask = function (task) {
    //set new boundaries for gantt
    this.originalEndMillis = this.originalEndMillis > task.end ? this.originalEndMillis : task.end;
    this.originalStartMillis = this.originalStartMillis < task.start ? this.originalStartMillis : task.start;
};


//<%-------------------------------------- GANT DRAW LINK ELEMENT --------------------------------------%>
//'from' and 'to' are tasks already drawn
Ganttalendar.prototype.drawLink = function (from, to, type) {
    var peduncolusSize = 10;
    var lineSize = 2;

    /**
     * A representation of a Horizontal line
     */
    HLine = function(width, top, left) {
        var hl = $("<div>").addClass("taskDepLine");
        hl.css({
            height: lineSize,
            left: left,
            width: width,
            top: top - lineSize / 2
        });
        return hl;
    };

    /**
     * A representation of a Vertical line
     */
    VLine = function(height, top, left) {
        var vl = $("<div>").addClass("taskDepLine");
        vl.css({
            height: height,
            left:left - lineSize / 2,
            width: lineSize,
            top: top
        });
        return vl;
    };

    /**
     * Given an item, extract its rendered position
     * width and height into a structure.
     */
    function buildRect(item) {
        var rect = item.ganttElement.position();
        rect.width = item.ganttElement.width();
        rect.height = item.ganttElement.height();

        return rect;
    }

    /**
     * The default rendering method, which paints a start to end dependency.
     *
     * @see buildRect
     */
    function drawStartToEnd(rectFrom, rectTo, peduncolusSize) {
        var left, top;

        var ndo = $("<div>").attr({
            from: from.id,
            to: to.id
        });

        var currentX = rectFrom.left + rectFrom.width;
        var currentY = rectFrom.height / 2 + rectFrom.top;

        var useThreeLine = (currentX + 2 * peduncolusSize) < rectTo.left;

        if (!useThreeLine) {
            // L1
            if (peduncolusSize > 0) {
                var l1 = new HLine(peduncolusSize, currentY, currentX);
                currentX = currentX + peduncolusSize;
                ndo.append(l1);
            }

            // L2
            var l2_4size = ((rectTo.top + rectTo.height / 2) - (rectFrom.top + rectFrom.height / 2)) / 2;
            var l2;
            if (l2_4size < 0) {
                l2 = new VLine(-l2_4size, currentY + l2_4size, currentX);
            } else {
                l2 = new VLine(l2_4size, currentY, currentX);
            }
            currentY = currentY + l2_4size;

            ndo.append(l2);

            // L3
            var l3size = rectFrom.left + rectFrom.width + peduncolusSize - (rectTo.left - peduncolusSize);
            currentX = currentX - l3size;
            var l3 = new HLine(l3size, currentY, currentX);
            ndo.append(l3);

            // L4
            var l4;
            if (l2_4size < 0) {
                l4 = new VLine(-l2_4size, currentY + l2_4size, currentX);
            } else {
                l4 = new VLine(l2_4size, currentY, currentX);
            }
            ndo.append(l4);

            currentY = currentY + l2_4size;

            // L5
            if (peduncolusSize > 0) {
                var l5 = new HLine(peduncolusSize, currentY, currentX);
                currentX = currentX + peduncolusSize;
                ndo.append(l5);

            }
        } else {
            //L1
            var l1_3Size = (rectTo.left - currentX) / 2;
            var l1 = new HLine(l1_3Size, currentY, currentX);
            currentX = currentX + l1_3Size;
            ndo.append(l1);

            //L2
            var l2Size = ((rectTo.top + rectTo.height / 2) - (rectFrom.top + rectFrom.height / 2));
            var l2;
            if (l2Size < 0) {
                l2 = new VLine(-l2Size, currentY + l2Size, currentX);
            } else {
                l2 = new VLine(l2Size, currentY, currentX);
            }
            ndo.append(l2);

            currentY = currentY + l2Size;

            //L3
            var l3 = new HLine(l1_3Size, currentY, currentX);
            currentX = currentX + l1_3Size;
            ndo.append(l3);
        }

        //arrow
        var arr = $("<img src='linkArrow.png'>").css({
            position: 'absolute',
            top: rectTo.top + rectTo.height / 2 - 5,
            left: rectTo.left - 5
        });

        ndo.append(arr);

        return ndo;
    }

    /**
     * A rendering method which paints a start to start dependency.
     *
     * @see buildRect
     */
    function drawStartToStart(rectFrom, rectTo, peduncolusSize) {
        var left, top;

        var ndo = $("<div>").attr({
            from: from.id,
            to: to.id
        });

        var currentX = rectFrom.left;
        var currentY = rectFrom.height / 2 + rectFrom.top;

        var useThreeLine = (currentX + 2 * peduncolusSize) < rectTo.left;

        if (!useThreeLine) {
            // L1
            if (peduncolusSize > 0) {
                var l1 = new HLine(peduncolusSize, currentY, currentX - peduncolusSize);
                currentX = currentX - peduncolusSize;
                ndo.append(l1);
            }

            // L2
            var l2_4size = ((rectTo.top + rectTo.height / 2) - (rectFrom.top + rectFrom.height / 2)) / 2;
            var l2;
            if (l2_4size < 0) {
                l2 = new VLine(-l2_4size, currentY + l2_4size, currentX);
            } else {
                l2 = new VLine(l2_4size, currentY, currentX);
            }
            currentY = currentY + l2_4size;

            ndo.append(l2);

            // L3
            var l3size = (rectFrom.left - peduncolusSize) - (rectTo.left - peduncolusSize);
            currentX = currentX - l3size;
            var l3 = new HLine(l3size, currentY, currentX);
            ndo.append(l3);

            // L4
            var l4;
            if (l2_4size < 0) {
                l4 = new VLine(-l2_4size, currentY + l2_4size, currentX);
            } else {
                l4 = new VLine(l2_4size, currentY, currentX);
            }
            ndo.append(l4);

            currentY = currentY + l2_4size;

            // L5
            if (peduncolusSize > 0) {
                var l5 = new HLine(peduncolusSize, currentY, currentX);
                currentX = currentX + peduncolusSize;
                ndo.append(l5);
            }
        } else {
            //L1

            var l1 = new HLine(peduncolusSize, currentY, currentX - peduncolusSize);
            currentX = currentX - peduncolusSize;
            ndo.append(l1);

            //L2
            var l2Size = ((rectTo.top + rectTo.height / 2) - (rectFrom.top + rectFrom.height / 2));
            var l2;
            if (l2Size < 0) {
                l2 = new VLine(-l2Size, currentY + l2Size, currentX);
            } else {
                l2 = new VLine(l2Size, currentY, currentX);
            }
            ndo.append(l2);

            currentY = currentY + l2Size;

            //L3

            var l3 = new HLine(currentX + peduncolusSize + (rectTo.left - rectFrom.left), currentY, currentX);
            currentX = currentX + peduncolusSize + (rectTo.left - rectFrom.left);
            ndo.append(l3);
        }

        //arrow
        var arr = $("<img src='linkArrow.png'>").css({
            position: 'absolute',
            top: rectTo.top + rectTo.height / 2 - 5,
            left: rectTo.left - 5
        });

        ndo.append(arr);

        return ndo;
    }

    var rectFrom = buildRect(from);
    var rectTo = buildRect(to);

    // Dispatch to the correct renderer
    if (type == 'start-to-start') {
        this.element.find(".ganttLinks").append(
            drawStartToStart(rectFrom, rectTo, peduncolusSize)
        );
    } else {
        this.element.find(".ganttLinks").append(
            drawStartToEnd(rectFrom, rectTo, peduncolusSize)
        );
    }
};

Ganttalendar.prototype.redrawLinks = function() {
    //console.debug("redrawLinks ");
    var self = this;
    this.element.stopTime("ganttlnksredr");
    this.element.oneTime(60, "ganttlnksredr", function() {
        //var prof=new Profiler("gd_drawLink_real");
        self.element.find(".ganttLinks").empty();
        for (var i=0;i<self.master.links.length;i++) {
            var link = self.master.links[i];
            self.drawLink(link.from, link.to);
        }
        //prof.stop();
    });
};


Ganttalendar.prototype.reset = function() {
    this.element.find(".ganttLinks").empty();
    this.element.find("[taskId]").remove();
};


Ganttalendar.prototype.redrawTasks = function() {
    for (var i=0;i<this.master.tasks.length;i++) {
        var task = this.master.tasks[i];
        this.drawTask(task);
    }
};


Ganttalendar.prototype.refreshGantt = function() {
    //console.debug("refreshGantt")
    var par = this.element.parent();

    //try to maintain last scroll
    var scrollY=par.scrollTop();
    var scrollX=par.scrollLeft();

    this.element.remove();
    //guess the zoom level in base of period
    if (!this.zoom ){
        var days = Math.round((this.originalEndMillis - this.originalStartMillis) / (3600000 * 24));
        this.zoom = this.zoomLevels[days < 2 ? 0 : (days < 15 ? 1 : (days < 60 ? 2 : (days < 150 ? 3 : 4  ) ) )];
    }
    var domEl = this.create(this.zoom, this.originalStartMillis, this.originalEndMillis);
    this.element = domEl;
    par.append(domEl);
    this.redrawTasks();

    //set current task
    this.synchHighlight();

    //set old scroll
    //console.debug("old scroll:",scrollX,scrollY)
    par.scrollTop(scrollY);
    par.scrollLeft(scrollX);

    if (this.showCriticalPath){
        this.master.computeCriticalPath();
        this.gantt.showCriticalPath();
    }


};


Ganttalendar.prototype.fitGantt = function() {
    delete this.zoom;
    this.refreshGantt();
};

Ganttalendar.prototype.synchHighlight = function() {
    if (this.master.currentTask && this.master.currentTask.ganttElement)
        this.highlightBar.css("top", this.master.currentTask.ganttElement.css("top"));
};

Ganttalendar.prototype.centerOnToday = function() {
    var x = Math.round(((new Date().getTime()) - this.startMillis) * this.fx)-30;
    //console.debug("centerOnToday "+x);
    this.element.parent().scrollLeft(x);
};


Ganttalendar.prototype.showCriticalPath = function () {
    //todo
    console.error("To be implemented");
};

;/*
 Copyright (c) 2012-2014 Open Lab
 Written by Roberto Bicchierai and Silvia Chelazzi http://roberto.open-lab.com
 Permission is hereby granted, free of charge, to any person obtaining
 a copy of this software and associated documentation files (the
 "Software"), to deal in the Software without restriction, including
 without limitation the rights to use, copy, modify, merge, publish,
 distribute, sublicense, and/or sell copies of the Software, and to
 permit persons to whom the Software is furnished to do so, subject to
 the following conditions:

 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
function Ganttalendar(zoom, startmillis, endMillis, master, minGanttSize) {
    this.master = master; // is the a GantEditor instance
    this.element; // is the jquery element containing gantt
    this.highlightBar;

    this.svg; // instance of svg object containing gantt
    this.tasksGroup; //instance of svg group containing tasks
    this.linksGroup; //instance of svg group containing links
    this.arrayOfLinks;
    this.zoom = zoom;
    this.minGanttSize = minGanttSize;
    this.includeToday = true; //when true today is always visible. If false boundaries comes from tasks periods
    this.showCriticalPath=false; //when true critical path is highlighted

    this.zoomLevels = ["d","w", "m", "q", "s", "y"];

    this.element = this.create(zoom, startmillis, endMillis);

    this.linkOnProgress=false; //set to true when creating a new link

}

Ganttalendar.prototype.zoomGantt = function (isPlus) {
    var curLevel = this.zoom;
    var pos = this.zoomLevels.indexOf(curLevel + "");

    var newPos = pos;
    if (isPlus) {
        newPos = pos <= 0 ? 0 : pos - 1;
    } else {
        newPos = pos >= this.zoomLevels.length - 1 ? this.zoomLevels.length - 1 : pos + 1;
    }
    if (newPos != pos) {
        curLevel = this.zoomLevels[newPos];
        this.zoom = curLevel;
        this.refreshGantt();
    }
};


Ganttalendar.prototype.create = function (zoom, originalStartmillis, originalEndMillis) {
    //console.debug("Gantt.create " + new Date(originalStartmillis) + " - " + new Date(originalEndMillis));

    var self = this;

    function getPeriod(zoomLevel, stMil, endMillis) {
        var start = new Date(stMil);
        var end = new Date(endMillis);


        //reset hours
        if (zoomLevel == "d") {
            start.setHours(0, 0, 0, 0);
            end.setHours(23, 59, 59, 999);

            start.setFirstDayOfThisWeek();
            end.setFirstDayOfThisWeek();
            end.setDate(end.getDate() + 6);


            //reset day of week
        } else if (zoomLevel == "w") {
            start.setHours(0, 0, 0, 0);
            end.setHours(23, 59, 59, 999);

            start.setFirstDayOfThisWeek();
            end.setFirstDayOfThisWeek();
            end.setDate(end.getDate() + 6);

            //reset day of month
        } else if (zoomLevel == "m") {
            start.setHours(0, 0, 0, 0);
            end.setHours(23, 59, 59, 999);

            start.setDate(1);
            end.setDate(1);
            end.setMonth(end.getMonth() + 1);
            end.setDate(end.getDate() - 1);

            //reset to quarter
        } else if (zoomLevel == "q") {
            start.setHours(0, 0, 0, 0);
            end.setHours(23, 59, 59, 999);
            start.setDate(1);
            start.setMonth(Math.floor(start.getMonth() / 3) * 3);
            end.setDate(1);
            end.setMonth(Math.floor(end.getMonth() / 3) * 3 + 3);
            end.setDate(end.getDate() - 1);

            //reset to semester
        } else if (zoomLevel == "s") {
            start.setHours(0, 0, 0, 0);
            end.setHours(23, 59, 59, 999);
            start.setDate(1);

            start.setMonth(Math.floor(start.getMonth() / 6) * 6);
            end.setDate(1);
            end.setMonth(Math.floor(end.getMonth() / 6) * 6 + 6);
            end.setDate(end.getDate() - 1);

            //reset to year - > gen
        } else if (zoomLevel == "y") {
            start.setHours(0, 0, 0, 0);
            end.setHours(23, 59, 59, 999);

            start.setDate(1);
            start.setMonth(0);

            end.setDate(1);
            end.setMonth(12);
            end.setDate(end.getDate() - 1);
        }
        return {start:start.getTime(), end:end.getTime()};
    }

    function createHeadCell(lbl, span, additionalClass, width) {
        var th = $("<th>").html(lbl).attr("colSpan", span);
        if (width)
            th.width(width);
        if (additionalClass)
            th.addClass(additionalClass);
        return th;
    }

    function createBodyCell(span, isEnd, additionalClass) {
        var ret = $("<td>").html("").attr("colSpan", span).addClass("ganttBodyCell");
        if (isEnd)
            ret.addClass("end");
        if (additionalClass)
            ret.addClass(additionalClass);
        return ret;
    }

    function createGantt(zoom, startPeriod, endPeriod) {
        var tr1 = $("<tr>").addClass("ganttHead1");
        var tr2 = $("<tr>").addClass("ganttHead2");
        var trBody = $("<tr>").addClass("ganttBody");

        function iterate(renderFunction1, renderFunction2) {
            var start = new Date(startPeriod);
            //loop for header1
            while (start.getTime() <= endPeriod) {
                renderFunction1(start);
            }

            //loop for header2
            start = new Date(startPeriod);
            while (start.getTime() <= endPeriod) {
                renderFunction2(start);
            }
        }

        //this is computed by hand in order to optimize cell size
        var computedTableWidth;

        // year
        if (zoom == "y") {
            computedTableWidth = Math.floor(((endPeriod - startPeriod) / (3600000 * 24 * 180)) * 100); //180gg = 1 sem = 100px
            iterate(function (date) {
                tr1.append(createHeadCell(date.format("yyyy"), 2));
                date.setFullYear(date.getFullYear() + 1);
            }, function (date) {
                var sem = (Math.floor(date.getMonth() / 6) + 1);
                tr2.append(createHeadCell('S' + sem, 1, null, 100));
                trBody.append(createBodyCell(1, sem == 2));
                date.setMonth(date.getMonth() + 6);
            });

            //semester
        } else if (zoom == "s") {
            computedTableWidth = Math.floor(((endPeriod - startPeriod) / (3600000 * 24 * 90)) * 100); //90gg = 1 quarter = 100px
            iterate(function (date) {
                var end = new Date(date.getTime());
                end.setMonth(end.getMonth() + 6);
                end.setDate(end.getDate() - 1);
                tr1.append(createHeadCell(date.format("MMM") + " - " + end.format("MMM yyyy"), 2));
                date.setMonth(date.getMonth() + 6);
            }, function (date) {
                var quarter = ( Math.floor(date.getMonth() / 3) + 1);
                tr2.append(createHeadCell('Q' + quarter, 1, null, 100));
                trBody.append(createBodyCell(1, quarter % 2 == 0));
                date.setMonth(date.getMonth() + 3);
            });

            //quarter
        } else if (zoom == "q") {
            computedTableWidth = Math.floor(((endPeriod - startPeriod) / (3600000 * 24 * 30)) * 300); //1 month= 300px
            iterate(function (date) {
                var end = new Date(date.getTime());
                end.setMonth(end.getMonth() + 3);
                end.setDate(end.getDate() - 1);
                tr1.append(createHeadCell(date.format("MMM") + " - " + end.format("MMM yyyy"), 3));
                date.setMonth(date.getMonth() + 3);
            }, function (date) {
                var lbl = date.format("MMM");
                tr2.append(createHeadCell(lbl, 1, null, 300));
                trBody.append(createBodyCell(1, date.getMonth() % 3 == 2));
                date.setMonth(date.getMonth() + 1);
            });

            //month
        } else if (zoom == "m") {
            computedTableWidth = Math.floor(((endPeriod - startPeriod) / (3600000 * 24 * 1)) * 25); //1 day= 20px
            iterate(function (date) {
                var sm = date.getTime();
                date.setMonth(date.getMonth() + 1);
                var daysInMonth = Math.round((date.getTime() - sm) / (3600000 * 24));
                tr1.append(createHeadCell(new Date(sm).format("MMMM yyyy"), daysInMonth)); //spans mumber of dayn in the month
            }, function (date) {
                tr2.append(createHeadCell(date.format("d"), 1, isHoliday(date) ? "holyH" : null, 25));
                var nd = new Date(date.getTime());
                nd.setDate(date.getDate() + 1);
                trBody.append(createBodyCell(1, nd.getDate() == 1, isHoliday(date) ? "holy" : null));
                date.setDate(date.getDate() + 1);
            });

            //week
        } else if (zoom == "w") {
            computedTableWidth = Math.floor(((endPeriod - startPeriod) / (3600000 * 24)) * 40); //1 day= 40px
            iterate(function (date) {
                var end = new Date(date.getTime());
                end.setDate(end.getDate() + 6);
                tr1.append(createHeadCell(date.format("MMM d") + " - " + end.format("MMM d'yy"), 7));
                date.setDate(date.getDate() + 7);
            }, function (date) {
                tr2.append(createHeadCell(date.format("EEEE").substr(0, 1), 1, isHoliday(date) ? "holyH" : null, 40));
                trBody.append(createBodyCell(1, date.getDay() % 7 == (self.master.firstDayOfWeek + 6) % 7, isHoliday(date) ? "holy" : null));
                date.setDate(date.getDate() + 1);
            });

            //days
        } else if (zoom == "d") {
            computedTableWidth = Math.floor(((endPeriod - startPeriod) / (3600000 * 24)) * 100); //1 day= 100px
            iterate(function (date) {
                var end = new Date(date.getTime());
                end.setDate(end.getDate() + 6);
                tr1.append(createHeadCell(date.format("MMMM d") + " - " + end.format("MMMM d yyyy"), 7));
                date.setDate(date.getDate() + 7);
            }, function (date) {
                tr2.append(createHeadCell(date.format("EEE d"), 1, isHoliday(date) ? "holyH" : null, 100));
                trBody.append(createBodyCell(1, date.getDay() % 7 == (self.master.firstDayOfWeek + 6) % 7, isHoliday(date) ? "holy" : null));
                date.setDate(date.getDate() + 1);
            });

        } else {
            console.error("Wrong level " + zoom);
        }

        //set a minimal width
        computedTableWidth = Math.max(computedTableWidth, self.minGanttSize);

        var table = $("<table cellspacing=0 cellpadding=0>");
        table.append(tr1).append(tr2).css({width:computedTableWidth});

        var head = table.clone().addClass("fixHead");

        table.append(trBody).addClass("ganttTable");


        var height = self.master.editor.element.height();
        table.height(height);

        var box = $("<div>");
        box.addClass("gantt unselectable").attr("unselectable", "true").css({position:"relative", width:computedTableWidth});
        box.append(table);

        box.append(head);


        //highlightBar
        var hlb = $("<div>").addClass("ganttHighLight");
        box.append(hlb);
        self.highlightBar = hlb;


        var rowHeight = 39; // todo get it from css?
        //create the svg
        box.svg({settings:{class:"ganttSVGBox"},
            onLoad:         function (svg) {
                //console.debug("svg loaded", svg);

                //creates gradient and definitions
                var defs = svg.defs('myDefs');
                svg.linearGradient(defs, 'taskGrad', [
                    [0, '#ddd'],
                    [.5, '#fff'],
                    [1, '#ddd']
                ], 0, 0, 0, "100%");

                //create backgound
                var extDep=svg.pattern(defs,"extDep", 0, 0, 40, 40,  0, 0, 40, 40, {patternUnits: 'userSpaceOnUse'});
                svg.image(extDep, 0, 0, 40, 40, "hasExternalDeps.png");

                self.svg = svg;
                $(svg).addClass("ganttSVGBox");

                //creates grid group
                var gridGroup=svg.group("gridGroup");

                //creates rows grid
                for (var i = 40; i <= height; i += rowHeight)
                    svg.line(gridGroup,0, i, "100%", i, {class:"ganttLinesSVG"});

                //creates links group
                self.linksGroup = svg.group("linksGroup");

                //creates tasks group
                self.tasksGroup = svg.group("tasksGroup");

                //compute scalefactor fx
                self.fx = computedTableWidth / (endPeriod - startPeriod);

                // drawTodayLine
                if (new Date().getTime() > self.startMillis && new Date().getTime() < self.endMillis) {
                    var x = Math.round(((new Date().getTime()) - self.startMillis) * self.fx);
                    svg.line(gridGroup,x, 0, x, "100%", {class:"ganttTodaySVG"});
                }

            }
        });

        return box;
    }

    //if include today synch extremes
    if (this.includeToday) {
        var today = new Date().getTime();
        originalStartmillis = originalStartmillis > today ? today : originalStartmillis;
        originalEndMillis = originalEndMillis < today ? today : originalEndMillis;
    }


    //get best dimension fo gantt
    var period = getPeriod(zoom, originalStartmillis, originalEndMillis); //this is enlarged to match complete periods basing on zoom level

    //console.debug(new Date(period.start) + "   " + new Date(period.end));
    self.startMillis = period.start; //real dimension of gantt
    self.endMillis = period.end;
    self.originalStartMillis = originalStartmillis; //minimal dimension required by user or by task duration
    self.originalEndMillis = originalEndMillis;

    var table = createGantt(zoom, period.start, period.end);

    return table;
};


//<%-------------------------------------- GANT TASK GRAPHIC ELEMENT --------------------------------------%>
Ganttalendar.prototype.drawTask = function (task) {
    //console.debug("drawTask", task.name,new Date(task.start));
    var self = this;
    //var prof = new Profiler("ganttDrawTask");
    editorRow = task.rowElement;
    //var top = editorRow.position().top + self.master.editor.element.parent().scrollTop();
    var top = editorRow.position().top+ editorRow.offsetParent().scrollTop();
    var x = Math.round((task.start - self.startMillis) * self.fx);
    task.hasChild = task.isParent();

    var taskBox = $(_createTaskSVG(task, {x:x, y:top+7, width:Math.round((task.end - task.start) * self.fx)}));
    task.ganttElement = taskBox;
    if (self.showCriticalPath && task.isCritical)
        taskBox.addClass("critical");


    //bind all events on taskBox
    taskBox
        .click(function(e){ // manages selection
            e.stopPropagation();// to avoid body remove focused
            self.element.find(".focused").removeClass("focused");
            $(".ganttSVGBox .focused").removeClass("focused");
            var el = $(this);
            if (!self.resDrop)
                el.addClass("focused");
            self.resDrop = false; //hack to avoid select

            $("body").off("click.focused").one("click.focused", function () {
                $(".ganttSVGBox .focused").removeClass("focused");
            })

        }).dblclick(function () {
            self.master.showTaskEditor($(this).attr("taskid"));
        }).mouseenter(function () {
            //bring to top
            var el = $(this);
            if (!self.linkOnProgress){
                el.find(".linkHandleSVG").show();
            } else {
                el.addClass("linkOver");
                //el.find(".linkHandleSVG"+(self.linkFromEnd?".taskLinkStartSVG ":".taskLinkEndSVG")).show()
            }
        }).mouseleave(function () {
            var el = $(this);
            el.removeClass("linkOver").find(".linkHandleSVG").hide();

        }).mouseup(function (e) {
            $(":focus").blur(); // in order to save grid field when moving task
        }).mousedown(function () {
            var task = self.master.getTask($(this).attr("taskId"));
            task.rowElement.click();
        }).dragExtedSVG($(self.svg.root()),{
            canResize: this.master.canWrite && task.canWrite,
            canDrag:   !task.depends && this.master.canWrite && task.canWrite,
            startDrag:function(e){
                $(".ganttSVGBox .focused").removeClass("focused");
            },
            drag:      function (e) {
                $("[from=" + task.id + "],[to=" + task.id + "]").trigger("update");
            },
            drop:      function (e) {
                self.resDrop=true; //hack to avoid select
                var taskbox = $(this);
                var task = self.master.getTask(taskbox.attr("taskid"));
                var s = Math.round((parseFloat(taskbox.attr("x")) / self.fx) + self.startMillis);
                self.master.beginTransaction();
                self.master.moveTask(task, new Date(s));
                self.master.endTransaction();
            },
            startResize:function(e){
                //console.debug("startResize");
                $(".ganttSVGBox .focused").removeClass("focused");
                var taskbox = $(this);
                var text=$(self.svg.text(parseInt(taskbox.attr("x"))+parseInt(taskbox.attr("width")+8), parseInt(taskbox.attr("y")),"", {"font-size":"10px","fill":"red"}));
                taskBox.data("textDur",text);
            },
            resize:    function (e) {
                //find and update links from, to
                var taskbox = $(this);
                var st = Math.round((parseFloat(taskbox.attr("x")) / self.fx) + self.startMillis);
                var en = Math.round(((parseFloat(taskbox.attr("x")) + parseFloat(taskbox.attr("width"))) / self.fx) + self.startMillis);
                var d=computeStartDate(st).distanceInWorkingDays(computeEndDate(en));
                var text = taskBox.data("textDur");
                text.attr("x",parseInt(taskbox.attr("x"))+parseInt(taskbox.attr("width"))+8).html(d);

                $("[from=" + task.id + "],[to=" + task.id + "]").trigger("update");
            },
            stopResize:function (e) {
                self.resDrop=true; //hack to avoid select
                //console.debug(ui)
                var textBox=taskBox.data("textDur");
                if (textBox)
                    textBox.remove();
                var taskbox = $(this);
                var task = self.master.getTask(taskbox.attr("taskid"));
                var st = Math.round((parseFloat(taskbox.attr("x")) / self.fx) + self.startMillis);
                var en = Math.round(((parseFloat(taskbox.attr("x")) + parseFloat(taskbox.attr("width"))) / self.fx) + self.startMillis);
                self.master.beginTransaction();
                if(computeStartDate(st).distanceInWorkingDays(computeEndDate(en)) !== 0){
                    self.master.changeTaskDates(task, new Date(st), new Date(en));
                }else{
                    toastr.warning('Task cannot be less than 1 day duration')
                }
                self.master.endTransaction();
            }
        });

    //binding for creating link
    taskBox.find(".linkHandleSVG").mousedown(function (e) {
        e.preventDefault();
        e.stopPropagation();
        var taskBox = $(this).closest(".taskBoxSVG");
        var svg = $(self.svg.root());
        var offs = svg.offset();
        self.linkOnProgress=true;
        self.linkFromEnd=$(this).is(".taskLinkEndSVG");
        svg.addClass("linkOnProgress");

        // create the line
        var startX = parseFloat(taskBox.attr("x")) + (self.linkFromEnd? parseFloat(taskBox.attr("width")) :0);
        var startY = parseFloat(taskBox.attr("y")) + parseFloat(taskBox.attr("height")) / 2;
        var line = self.svg.line(startX, startY, e.pageX - offs.left - 5, e.pageY - offs.top - 5, {class:"linkLineSVG"});
        var circle = self.svg.circle(startX, startY, 5, {class:"linkLineSVG"});

        //bind mousemove to draw a line
        svg.bind("mousemove.linkSVG", function (e) {
            var offs = svg.offset();
            var nx = e.pageX - offs.left;
            var ny = e.pageY - offs.top;
            var c=Math.sqrt(Math.pow(nx-startX,2)+Math.pow(ny-startY,2));
            nx=nx-(nx-startX)*10/c;
            ny=ny-(ny-startY)*10/c;
            self.svg.change(line, { x2:nx, y2:ny});
            self.svg.change(circle, { cx:nx, cy:ny});
        });

        //bind mouseup un body to stop
        $("body").one("mouseup.linkSVG", function (e) {
            $(line).remove();
            $(circle).remove();
            self.linkOnProgress=false;
            svg.removeClass("linkOnProgress");

            $(self.svg.root()).unbind("mousemove.linkSVG");
            var targetBox = $(e.target).closest(".taskBoxSVG");
            //console.debug("create link from " + taskBox.attr("taskid") + " to " + targetBox.attr("taskid"));

            if (targetBox && targetBox.attr("taskid")!=taskBox.attr("taskid") ){
                var taskTo;
                var taskFrom;
                if (self.linkFromEnd){
                    taskTo = self.master.getTask(targetBox.attr("taskid"));
                    taskFrom = self.master.getTask(taskBox.attr("taskid"));
                } else {
                    taskFrom = self.master.getTask(targetBox.attr("taskid"));
                    taskTo = self.master.getTask(taskBox.attr("taskid"));
                }

                if (taskTo && taskFrom) {
                    var gap = 0;
                    var depInp = taskTo.rowElement.find("[name=depends]");
                    depInp.val(depInp.val() + ((depInp.val() + "").length > 0 ? "," : "") + (taskFrom.getRow() + 1) + (gap != 0 ? ":" + gap : ""));
                    depInp.blur();
                }
            }
        })
    });

    //ask for redraw link
    self.redrawLinks();

    //prof.stop();


    function _createTaskSVG(task, dimensions) {
        var svg = self.svg;
        var taskSvg = svg.svg(self.tasksGroup, dimensions.x, dimensions.y, dimensions.width, 25, {class:"taskBox taskBoxSVG", taskid:task.id});

        //svg.title(taskSvg, task.name);
        //external box
        var layout = svg.rect(taskSvg, 0, 0, "100%", "100%", {class:"taskLayout", rx:"6", ry:"6"});

        if (task.hasExternalDep){
            layout.style.fill = "url(#extDep)";
        }else{
            layout.style.fill = "url(#taskGrad)";
        }

        //progress
        if (task.progress > 0) {
            var progress = svg.rect(taskSvg, 0, 0, (task.progress > 100 ? 100 : task.progress) + "%", "100%", {fill:(task.progress > 100 ? "red" : "rgb(153,255,51)"), rx:"6", ry:"6", opacity:.4});
            if (dimensions.width>50){
                var textStyle={fill:"#888", "font-size":"10px"};
                if (task.progress>90)
                    textStyle.transform="translate(-30)";
                svg.text(taskSvg, (task.progress > 90 ? 100 : task.progress) + "%", 18, task.progress + "%", textStyle);
            }
        }

        //status
        if (dimensions.width>15)
            svg.rect(taskSvg, 6, 6, 13, 13, {stroke:1, rx:"2", ry:"2", status:task.status, class:"taskStatusSVG"});

        if (task.hasChild)
            svg.rect(taskSvg, 0, 0, "100%", 3, {fill:"#000"});

        if (task.startIsMilestone) {
            svg.image(taskSvg, -9, 4, 18, 18, "milestone.png")
        }

        if (task.endIsMilestone) {
            svg.image(taskSvg, "100%", 4, 18, 18, "milestone.png", {transform:"translate(-9)"})
        }

        //task label
//      if(task.depends ==="" || !task.depends){
//        svg.text(taskSvg, "100%", 25, task.name, {class:"taskLabelSVG",  transform: "translate(8,-8)"});
//      }else{
        svg.text(taskSvg, "100%", 18, task.name, {class:"taskLabelSVG",  transform: "translate(8,-8)"});
//      }

        //link tool
        svg.circle(taskSvg, "0", 12, 4, {class:"taskLinkStartSVG linkHandleSVG", transform:"translate(0)"});
        svg.circle(taskSvg, "100%", 12, 4, {class:"taskLinkEndSVG linkHandleSVG", transform:"translate(0)"});

        return taskSvg
    }

};



Ganttalendar.prototype.addTask = function (task) {
    //set new boundaries for gantt
    this.originalEndMillis = this.originalEndMillis > task.end ? this.originalEndMillis : task.end;
    this.originalStartMillis = this.originalStartMillis < task.start ? this.originalStartMillis : task.start;
};


//<%-------------------------------------- GANT DRAW LINK SVG ELEMENT --------------------------------------%>
//'from' and 'to' are tasks already drawn
Ganttalendar.prototype.drawLink = function (from, to, type) {
    var self = this;
    //console.debug("drawLink")
    var peduncolusSize = 10;

    /**
     * Given an item, extract its rendered position
     * width and height into a structure.
     */
    function buildRect(item) {
        var p = item.ganttElement.position();
        var rect = {
            left:  parseFloat(item.ganttElement.attr("x")),
            top:   parseFloat(item.ganttElement.attr("y")),
            width: parseFloat(item.ganttElement.attr("width")),
            height:parseFloat(item.ganttElement.attr("height"))
        };
        return rect;
    }

    /**
     * The default rendering method, which paints a start to end dependency.
     */
    function drawStartToEnd(from, to, ps) {
        var svg = self.svg;

        //this function update an existing link
        function update() {
            var group = $(this);
            var from = group.data("from");
            var to = group.data("to");

            var rectFrom = buildRect(from);
            var rectTo = buildRect(to);

            var fx1 = rectFrom.left;
            var fx2 = rectFrom.left + rectFrom.width;
            var fy = rectFrom.height / 2 + rectFrom.top;

            var tx1 = rectTo.left;
            var tx2 = rectTo.left + rectTo.width;
            var ty = rectTo.height / 2 + rectTo.top;


            var tooClose = tx1 < fx2 + 2 * ps;
            var r = 5; //radius
            var arrowOffset = 5;
            var up = fy > ty;
            var fup = up ? -1 : 1;

            var prev = fx2 + 2 * ps > tx1;
            var fprev = prev ? -1 : 1;

            var image = group.find("image");
            var p = svg.createPath();

            if (tooClose) {
                var firstLine = fup * (rectFrom.height / 2 - 2 * r + 2);
                p.move(fx2, fy)
                    .line(ps, 0, true)
                    .arc(r, r, 90, false, !up, r, fup * r, true)
                    .line(0, firstLine, true)
                    .arc(r, r, 90, false, !up, -r, fup * r, true)
                    .line(fprev * 2 * ps + (tx1 - fx2), 0, true)
                    .arc(r, r, 90, false, up, -r, fup * r, true)
                    .line(0, (Math.abs(ty - fy) - 4 * r - Math.abs(firstLine)) * fup - arrowOffset, true)
                    .arc(r, r, 90, false, up, r, fup * r, true)
                    .line(ps, 0, true);
                //svg.image(group, tx1 - 5, ty - 5 - arrowOffset, 5, 10, "linkArrow.png");
                image.attr({x:tx1 - 5, y:ty - 5 - arrowOffset});

            } else {
                p.move(fx2, fy)
                    .line((tx1 - fx2) / 2 - r, 0, true)
                    .arc(r, r, 90, false, !up, r, fup * r, true)
                    .line(0, ty - fy - fup * 2 * r + arrowOffset, true)
                    .arc(r, r, 90, false, up, r, fup * r, true)
                    .line((tx1 - fx2) / 2 - r, 0, true);
                //svg.image(group, tx1 - 5, ty - 5 + arrowOffset, 5, 10, "linkArrow.png");
                image.attr({x:tx1 - 5, y:ty - 5 + arrowOffset});
            }

            group.find("path").attr({d:p.path()});
        }


        // create the group
        var group = svg.group(self.linksGroup, "" + from.id + "-" + to.id);
        svg.title(group, from.name+" -> "+to.name);

        var p = svg.createPath();

        //add the arrow
        svg.image(group, 0, 0, 5, 10, "linkArrow.png");
        //create empty path
        svg.path(group, p, {class:"taskLinkPathSVG"});

        //set "from" and "to" to the group, bind "update" and trigger it
        var jqGroup = $(group).data({from:from, to:to }).attr({from:from.id, to:to.id}).on("update", update).trigger("update");

        if (self.showCriticalPath && from.isCritical && to.isCritical)
            jqGroup.addClass("critical");

        jqGroup.addClass("linkGroup");
        return jqGroup;
    }


    /**
     * A rendering method which paints a start to start dependency.
     */
    function drawStartToStart(from, to) {
        console.error("StartToStart not supported on SVG");
        var rectFrom = buildRect(from);
        var rectTo = buildRect(to);
    }

    var link;
    // Dispatch to the correct renderer
    if (type == 'start-to-start') {
        link=drawStartToStart(from, to, peduncolusSize);
    } else {
        link=drawStartToEnd(from, to, peduncolusSize);
    }

    link.click(function(e){
        var el=$(this);
        e.stopPropagation();// to avoid body remove focused
        self.element.find(".focused").removeClass("focused");
        $(".ganttSVGBox .focused").removeClass("focused");
        var el = $(this);
        if (!self.resDrop)
            el.addClass("focused");
        self.resDrop = false; //hack to avoid select

        $("body").off("click.focused").one("click.focused", function () {
            $(".ganttSVGBox .focused").removeClass("focused");
        })

    });


};
//format Yunique dates to a well-know one.So IE will understand that
String.prototype.formatYuniqueDates = function(){
    var tempValue;
    tempValue = (this.toString()).replace('T',' ').split(' ')[0].split('-');
    return tempValue[1]+'/'+tempValue[2]+'/'+tempValue[0]
};



Ganttalendar.prototype.redrawLinks = function () {
    //console.debug("redrawLinks ");
    var self = this;
    this.element.stopTime("ganttlnksredr");
    this.element.oneTime(60, "ganttlnksredr", function () {

        //var prof=new Profiler("gd_drawLink_real");

        //remove all links
        $("#linksSVG").empty();

        for (var i = 0; i < self.master.links.length; i++) {
            var link = self.master.links[i];
            self.drawLink(link.from, link.to);
        }
        //prof.stop();
    });
};


Ganttalendar.prototype.reset = function () {
    this.element.find(".linkGroup").remove();
    this.element.find("[taskId]").remove();
};


Ganttalendar.prototype.redrawTasks = function () {
    for (var i = 0; i < this.master.tasks.length; i++) {
        var task = this.master.tasks[i];
        this.drawTask(task);
    }
};


Ganttalendar.prototype.refreshGantt = function () {
    //console.debug("refreshGantt")

    if (this.showCriticalPath){
        this.master.computeCriticalPath();
    }


    var par = this.element.parent();

    //try to maintain last scroll
    var scrollY = par.scrollTop();
    var scrollX = par.scrollLeft();

    this.element.remove();
    //guess the zoom level in base of period
    if (!this.zoom) {
        var days = Math.round((this.originalEndMillis - this.originalStartMillis) / (3600000 * 24));
        this.zoom = this.zoomLevels[days < 2 ? 0 : (days < 15 ? 1 : (days < 60 ? 2 : (days < 150 ? 3 : 4  ) ) )];
    }
    var domEl = this.create(this.zoom, this.originalStartMillis, this.originalEndMillis);
    this.element = domEl;
    par.append(domEl);
    this.redrawTasks();

    //set old scroll
    //console.debug("old scroll:",scrollX,scrollY)
    par.scrollTop(scrollY);
    par.scrollLeft(scrollX);

    //set current task
    this.synchHighlight();

};


Ganttalendar.prototype.fitGantt = function () {
    delete this.zoom;
    this.refreshGantt();
};

Ganttalendar.prototype.synchHighlight = function() {
    if (this.master.currentTask && this.master.currentTask.ganttElement)
        this.highlightBar.css("top", this.master.currentTask.ganttElement.attr("y")-7+"px");
};


Ganttalendar.prototype.centerOnToday = function () {
    var x = Math.round(((new Date().getTime()) - this.startMillis) * this.fx) - 30;
    //console.debug("centerOnToday "+x);
    this.element.parent().scrollLeft(x);
};


/**
 * Allows drag and drop and extesion of task boxes. Only works on x axis
 * @param opt
 * @return {*}
 */
$.fn.dragExtedSVG = function (svg,opt) {

    //doing this can work with one svg at once only
    var target;
    var svgX;
    var rectMouseDx;

    var options = {
        canDrag:        true,
        canResize:      true,
        resizeZoneWidth:15,
        minSize:10,
        startDrag:           function (e) {},
        drag:           function (e) {},
        drop:           function (e) {},
        startResize:         function (e) {},
        resize:         function (e) {},
        stopResize:     function (e) {}
    };

    $.extend(options, opt);

    this.each(function () {
        var el = $(this);
        svgX=svg.parent().offset().left; //parent is used instead of svg for a Firefox oddity
        if (options.canDrag)
            el.addClass("deSVGdrag");

        if (options.canResize || options.canDrag) {
            el.bind("mousedown.deSVG",
                function (e) {
                    if ($(e.target).is("image")){
                        e.preventDefault();
                    }

                    target = $(this);
                    var x1 = parseFloat(el.offset().left);

                    //var x1 = parseFloat(el.attr("x"));
                    var x2 = x1 + parseFloat(el.attr("width"));
                    var posx =  e.pageX;

                    $("body").unselectable();

                    //start resize
                    var x = x2 - posx;
                    if (options.canResize && (x>=0 && x <= options.resizeZoneWidth) ){
                        //store offset mouse x1
                        rectMouseDx=x2-e.pageX;
                        target.attr("oldw",target.attr("width"));

                        var one=true;

                        //bind event for start resizing
                        $(svg).bind("mousemove.deSVG",function (e) {

                            if (one){
                                //trigger startResize
                                options.startResize.call(target.get(0),e);
                                one=false;
                            }

                            //manage resizing
                            var posx =  e.pageX;
                            var nW = posx - x1 +rectMouseDx;
                            target.attr("width",nW < options.minSize ? options.minSize : nW);
                            //callback
                            options.resize.call(target.get(0),e);
                        });

                        //bind mouse up on body to stop resizing
                        $("body").one("mouseup.deSVG", stopResize );

                        // start drag
                    } else if (options.canDrag ) {
                        //store offset mouse x1
                        rectMouseDx=parseFloat(target.attr("x"))-e.pageX;
                        target.attr("oldx",target.attr("x"));

                        var one=true;
                        //bind event for start dragging
                        $(svg).bind("mousemove.deSVG",function (e) {
                            if (one){
                                //trigger startDrag
                                options.startDrag.call(target.get(0),e);
                                one=false;
                            }

                            //manage resizing
                            target.attr("x",rectMouseDx+ e.pageX);
                            //callback
                            options.drag.call(target.get(0),e);

                        }).bind("mouseleave.deSVG",drop);

                        //bind mouse up on body to stop resizing
                        $("body").one("mouseup.deSVG", drop );

                    }
                }

            ).bind("mousemove.deSVG",
                function (e) {
                    var el = $(this);
                    var x1 = el.offset().left;
                    var x2 = x1 + parseFloat(el.attr("width"));
                    var posx =  e.pageX;

                    //console.debug("mousemove", options.canResize && x2 - posx)
                    //set cursor handle
                    var x = x2 - posx;
                    if (options.canResize && (x>=0 && x <= options.resizeZoneWidth) ){
                        el.addClass("deSVGhand");
                    }else{
                        el.removeClass("deSVGhand");
                    }
                }

            ).addClass("deSVG");
        }
    });
    return this;


    function stopResize(e){
        $(svg).unbind("mousemove.deSVG").unbind("mouseup.deSVG").unbind("mouseleave.deSVG");
        //if (target && target.attr("oldw")!=target.attr("width"))
        if (target )
            options.stopResize.call(target.get(0),e); //callback
        target=undefined;
        $("body").clearUnselectable();
    }

    function drop(e){
        $(svg).unbind("mousemove.deSVG").unbind("mouseup.deSVG").unbind("mouseleave.deSVG");
        if (target && target.attr("oldx")!=target.attr("x"))
            options.drop.call(target.get(0),e); //callback
        target=undefined;
        $("body").clearUnselectable();
    }

};
;function GridEditor(master) {
    this.master = master; // is the a GantEditor instance
    this.gridified = $.gridify($.JST.createFromTemplate({}, "TASKSEDITHEAD"));
    this.element = this.gridified.find(".gdfTable").eq(1);
}
var ge; //this is the hugly but very friendly global var for the gantt editor
(function ($) {
    var userLocalCultureEndpoint;
    $.fn.tacalendar = function (options) {
        var self = this;
        Yunique.Http.get("/TACalendarHoliday", {
            pagesize: 9999
        }).then(function(resp) {
                window.userLocalCulture = resp.YuniqueAPI['@ClientCulture'];
                userLocalCultureEndpoint = '/l10n/translations/system/' + userLocalCulture + '/taCalendar';
                for (var apiResp = resp.YuniqueAPI.pTACalHoliday, tempArrayOfDates = [], tempArrayOfNames = [], i = 0, k = apiResp.length; k > i; i++) {
                    var holidayInternal = new Date(apiResp[i].TACalHolidayDate).format("#yyyy_MM_dd#");
                    tempArrayOfDates.push(new Date(apiResp[i].TACalHolidayDate).getTime()), tempArrayOfNames.push({
                        key: new Date(apiResp[i].TACalHolidayDate).getTime(),
                        value: apiResp[i].TACalHolidayName
                    }), holidayArrayForInternal.push(holidayInternal)
                }
                holidayArrayData.dates = tempArrayOfDates, holidayArrayData.holNames = tempArrayOfNames
                Yunique.Http.get(userLocalCultureEndpoint, {
                    pagesize: 9999
                }).then(function(resp) {
                        window.TranslationData = resp.YuniqueAPI.Table;
                        var taskEdit = '<div class="__template__" type="TASKSEDITHEAD">' +
                            '<table class="gdfTable" cellspacing="0" cellpadding="0">' +
                            '<thead>' +
                            '<tr style="height:40px">' +
                            '<th class="gdfColHeader" style="width:35px;">'+Yunique.Data.getTranslatedString(TranslationData,'Ind.')+'</th>' +
                            '<th class="gdfColHeader" style="width:50px;">'+Yunique.Data.getTranslatedString(TranslationData,'Notes')+'</th>' +
                            '<th class="gdfColHeader gdfResizable" style="width:100px;">'+Yunique.Data.getTranslatedString(TranslationData,'Task type')+'</th>' +
                            '<th class="gdfColHeader gdfResizable" style="width:160px;">'+Yunique.Data.getTranslatedString(TranslationData,'Task name')+'</th>' +
                            '<th class="gdfColHeader gdfResizable" style="width:145px;">'+Yunique.Data.getTranslatedString(TranslationData,'Assigned To')+'</th>' +
                            '<th class="gdfColHeader gdfResizable" style="width:60px;">'+Yunique.Data.getTranslatedString(TranslationData,'New')+'</th>' +
                            '<th class="gdfColHeader gdfResizable" style="width:75px;">'+Yunique.Data.getTranslatedString(TranslationData,'Carryover')+'</th>' +
                            '<th class="gdfColHeader gdfResizable" style="width:125px;">'+Yunique.Data.getTranslatedString(TranslationData,'Start')+'</th>' +
                            '<th class="gdfColHeader gdfResizable" style="width:125px;">'+Yunique.Data.getTranslatedString(TranslationData,'end')+'</th>' +
                            '<th class="gdfColHeader gdfResizable" style="width:50px;">'+Yunique.Data.getTranslatedString(TranslationData,'Dur.')+'</th>' +
                            '<th class="gdfColHeader gdfResizable" style="width:50px;">'+Yunique.Data.getTranslatedString(TranslationData,'Dep.')+'</th>' +
                            '</tr>' +
                            '</thead>' +
                            '</table>' +
                            '</table>' +
                            '</div>';

                             var ganntButtons = ' <div class="__template__" type="GANTBUTTONS">' +
                            '<div class="ganttButtonBar noprint">' +
                            '<div class="buttons">' +
                            '<button onclick="$(\'#workSpace\').trigger(\'addAboveCurrentTask.gantt\');" type="button" class="button textual" title="'+Yunique.Data.getTranslatedString(TranslationData,'insert above')+'"><span class="teamworkIcon">l</span></button>' +
                            '<button onclick="$(\'#workSpace\').trigger(\'addBelowCurrentTask.gantt\');" type="button" class="button textual" title="'+Yunique.Data.getTranslatedString(TranslationData,'insert below')+'"><span class="teamworkIcon">X</span></button>' +
                            '<button onclick="$(\'#workSpace\').trigger(\'addBelowNewTask.gantt\');" type="button" class="button textual" title="'+Yunique.Data.getTranslatedString(TranslationData,'add new')+'"><img src = "jQueryGantt/css/images/addNewSameLvl.png"/></button>' +
                            '<span class="ganttButtonSeparator"></span>' +
                            '<button onclick="$(\'#workSpace\').trigger(\'indentCurrentTask.gantt\');" type="button" class="button textual" title="'+Yunique.Data.getTranslatedString(TranslationData,'indent task')+'"><span class="teamworkIcon">.</span></button>' +
                            '<button onclick="$(\'#workSpace\').trigger(\'outdentCurrentTask.gantt\');" type="button" class="button textual" title="'+Yunique.Data.getTranslatedString(TranslationData,'unindent task')+'"><span class="teamworkIcon">:</span></button>' +
                            '<span class="ganttButtonSeparator"></span>' +
                            '<button onclick="$(\'#workSpace\').trigger(\'moveUpCurrentTask.gantt\');" type="button" class="button textual" title="'+Yunique.Data.getTranslatedString(TranslationData,'move up')+'"><span class="teamworkIcon">k</span></button>' +
                            '<button onclick="$(\'#workSpace\').trigger(\'moveDownCurrentTask.gantt\');" type="button" class="button textual" title="'+Yunique.Data.getTranslatedString(TranslationData,'move down')+'"><span class="teamworkIcon">j</span></button>' +
                            '<span class="ganttButtonSeparator"></span>' +
                            '<button onclick="ge.gantt.showCriticalPath=!ge.gantt.showCriticalPath; ge.redraw();" class="button textual" title="Critical Path"><span class="teamworkIcon">£</span></button>'+
                            '<span class="ganttButtonSeparator"></span>' +
                            '<button onclick="$(\'#workSpace\').trigger(\'zoomMinus.gantt\');" type="button" class="button textual" title="'+Yunique.Data.getTranslatedString(TranslationData,'zoom out')+'"><span class="teamworkIcon">)</span></button>' +
                            '<button onclick="$(\'#workSpace\').trigger(\'zoomPlus.gantt\');" type="button" class="button textual" title="'+Yunique.Data.getTranslatedString(TranslationData,'zoom in')+'"><span class="teamworkIcon">(</span></button>' +
                            '<span class="ganttButtonSeparator"></span>' +
                            '<button onclick="$(\'#workSpace\').trigger(\'deleteCurrentTask.gantt\');" type="button" class="button textual" title="'+Yunique.Data.getTranslatedString(TranslationData,'delete')+'"><span class="teamworkIcon">&cent;</span></button>' +
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

                        var status = '<div class="__template__" type="CHANGE_STATUS"><!--' +
                            '<div>' +
                            '<h1 style="opacity: 0.6;margin-left: 15px;margin-top: 15px;">'+Yunique.Data.getTranslatedString(TranslationData,'Notes')+':<h1>' +
                            '<textarea id="taskNote" name = "taskNote" class="taskNoteTextArea"></textarea>' +
                            '<div class="taskNoteSave"><button class="button taskNoteSaveBnt" id="saveNote">'+Yunique.Data.getTranslatedString(TranslationData,'Save')+'</button></div>' +
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
                            '--></div>';

                        $(taskEdit).appendTo(self);
                        $(taskRow).appendTo(self);
                        $(taskEmptyRow).appendTo(self);
                        $(status).appendTo(self);
                        $(rowEdit).appendTo(self);
                        $(ganntButtons).appendTo(self);
//createGannt('0fce0d27-2a7f-43d1-999f-e15190ebe32d', options.calendarHeight, options.calendarWidth);
createGannt(location.href.split('TID=')[1],options.calendarHeight,options.calendarWidth);
                    });
            });
    };
})(jQuery);

function createGannt(templateId, ganntHeight, ganntWidth) {
    var TaskAssignedToID;
    var typeDatasource;
    var datasourceLength;
    var taskWorkflow;
    var localStorageForIE;
    try {
        localStorage.setItem("yuniqueColumnsData", "");
    } catch (e) {}
    Yunique.Http.get('/TACalendarTemplateTask', {
        "TACalTemplateId": templateId
    }, {
        pagesize: 9999
    })
        .then(function (resp,status,xhrObj) {
            $(function () {
                // here starts gantt initialization
                ge = new GanttMaster();
                var workSpace = $("#workSpace");

                workSpace.css({
                    width: ganntWidth? ganntWidth: $(window).width() - 20,
                    height: ganntHeight ?ganntHeight :$(window).height() - 20
                });
                ge.init(workSpace);
                $(window).resize(function () {
                    workSpace.css({
                        width: ganntWidth? ganntWidth: $(window).width() - 20,
                        height: ganntHeight ?ganntHeight :$(window).height() - 20
                    });
                    workSpace.trigger("resize.gantt");
                })

            });
            if(!resp.YuniqueAPI.pTACalTemplateTask){
                toastr.options.timeOut = 0;
                toastr.error(Yunique.Data.getTranslatedString(TranslationData,'There was an error: No data from API'));
                $('#workSpace').hide();
            }
            var tempDatasource = resp.YuniqueAPI.pTACalTemplateTask;
            typeDatasource = resp.YuniqueAPI.Lookups.TaskTypeId;
            if (!$.isArray(tempDatasource)) {
                tempDatasource = [];
                tempDatasource.push(resp.YuniqueAPI.pTACalTemplateTask);
            }
            var calendarDatasource = [];

            function compare(a, b) {
                if (parseInt(a.TaskId) < parseInt(b.TaskId)){
                    return -1;
                }
                if (parseInt(a.TaskId) > parseInt(b.TaskId)){
                    return 1;
                }
                return 0;
            }
            tempDatasource.sort(compare);
            for (var i = 0, k = tempDatasource.length; i < k; i++) {
                var objectToPush = {};
                objectToPush.id = tempDatasource[i].TaskId;
                objectToPush.start = (new Date((tempDatasource[i].TaskPlanStart).formatYuniqueDates())).getTime();
                if (!tempDatasource[i].TaskPlanEnd) {
                    objectToPush.end = computeEndByDuration(new Date((tempDatasource[i].TaskPlanStart).formatYuniqueDates()), tempDatasource[i].TaskDuration)
                } else {
                    objectToPush.end = (new Date((tempDatasource[i].TaskPlanEnd).formatYuniqueDates())).getTime();
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
            datasourceLength = calendarDatasource.length;
            calendarDatasource[0].level = 0; //remove this after API update
            calendarDatasource[0].hasChild = true; //remove this after API update
            //calendarDatasource[0].startIsMilestone = true; //remove this after API update
            var datasourceObj = {
                'tasks': calendarDatasource,
                "selectedRow": 0,
                "canWrite": true,
                "canWriteOnParent": true
            };
            taskWorkflow = resp.YuniqueAPI.Lookups.TaskWorkflowId;
            taskWorkflow.unshift({
                key: '',
                value: ' ',
                value2:''
            });
            var groupNameForTasks = [];
            for (var i = 0; i < taskWorkflow.length; i++) {
                var obj = taskWorkflow[i].value2;
                if($.inArray(obj,groupNameForTasks) === -1 && obj !==''){
                    groupNameForTasks.push(obj);
                    taskWorkflow.splice(i,0,{value:obj,key:'group'});
                }
            }
            TaskAssignedToID = resp.YuniqueAPI.Lookups.TaskAssignedToID;
            var objectToCreate = [];
            $.fn.multiselect = function () {
                $(this).each(function () {
                    var checkboxes = $(this).find("input:checkbox");
                    checkboxes.each(function () {
                        var checkbox = $(this);
                        // Highlight pre-selected checkboxes
                        if (!checkbox.prop("checked")){
                            checkbox.parent().addClass("multiselect-on");
                        }

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
            kendo.culture(userLocalCulture);
            Date.defaultFormat = kendo.cultures.current.calendars.standard.patterns.d;
            Date.monthNames = kendo.cultures.current.calendars.standard.months.names;
            Date.monthAbbreviations = kendo.cultures.current.calendars.standard.months.namesAbbr;
            Date.dayNames = kendo.cultures.current.calendars.standard.days.names;
            Date.dayAbbreviations = kendo.cultures.current.calendars.standard.days.namesAbbr;
            Date.firstDayOfWeek = kendo.cultures.current.calendars.standard.firstDay;
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
            console.log(datasourceObj)
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
            function createYuniqueISODate(millis){
                var tempDate = new Date(millis);
                return new Date(Date.UTC(tempDate.getFullYear(),tempDate.getMonth(),tempDate.getDate())).toISOString().replace('.000Z','');
            }
            window.saveFunc = function () {
                var tempDatasource = (ge.saveProject()).tasks,
                    deletedIds = ge.yuniqueDeletedGuis,
                    calendarDatasource = [],
                    errorDuringProcess = false;

                for (var i = 0, k = tempDatasource.length; i < k; i++) {
                    var objectToPush = {};
                    var id = i + 1;
                    objectToPush.TaskId = id;
                    objectToPush.TaskTypeId = tempDatasource[i].type;
                    if (tempDatasource[i].type === '0') {
                        objectToPush.new = '0';
                        objectToPush.CarryOver = '0';
                    } else {
                        objectToPush.TaskWorkflowId = tempDatasource[i].TaskWorkflowId;
                        objectToPush.taskWorkfowIsChanged = tempDatasource[i].TaskWorkfowIsChanged ?tempDatasource[i].TaskWorkfowIsChanged:0;
                        objectToPush.new = tempDatasource[i].new;
                        objectToPush.CarryOver = tempDatasource[i].carryOver;
                    }
                    objectToPush.TaskPlanEnd = createYuniqueISODate(tempDatasource[i].end);
                    objectToPush.TaskPlanStart = createYuniqueISODate(tempDatasource[i].start);
                    objectToPush.TACalTemplateId = tempDatasource[0].TACalTemplateId;
                    objectToPush.TaskAssignedToID = tempDatasource[i].team;
                    objectToPush.TaskName = tempDatasource[i].name;
                    if ((tempDatasource[i].id).indexOf('tmp') !== -1 && tempDatasource[i].type !== '0' && !tempDatasource[i].TaskWorkflowId) {
                        errorDuringProcess = true;
                        break;
                    }
                    if(!tempDatasource[i].TaskWorkflowId && !tempDatasource[i].name && tempDatasource[i].type !== '0'){
                        errorDuringProcess = true;
                        break;
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
                if(!errorDuringProcess){
                    //Attention WTF with DELETE headers?
                    $(deletedIds).each(function () {
                        var newArr = [];
                        newArr.push(this);
                        Yunique.Http.delete('/TACalendarTemplateTask', newArr)
                            .then(function (e) {});
                    });
                    btnSave.unbind("click", saveFunc);
                    Yunique.Http.post('/TACalendarTemplateTask', calendarDatasource)
                        .then(function (resp) {
                            btnSave.on('click', saveFunc);
                            toastr.success(Yunique.Data.getTranslatedString(TranslationData,'All changes saved'));
                            //ugly hack for "tooo fast" browsers
                            setTimeout(function () {
                                window.__doPostBack('btnSave', '');
                            }, 1000)

                        },function(e){toastr.error(Yunique.Data.getTranslatedString(TranslationData,'There was an error during save.'));
                        });
                }else{
                    toastr.error(Yunique.Data.getTranslatedString(TranslationData,'There was an error during save. Check data for errors'));

                }
            };
            btnSave.removeAttr('onclick');
            btnSave.click(function(event){
                event.preventDefault();
                saveFunc()
            });
        },
        function(e){toastr.error(Yunique.Data.getTranslatedString(TranslationData,'There was an error during getting data.'));});


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
                if (!master.canWrite || emptyRow.prevAll(".emptyRow").size() > 0){
                    return
                }
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
         console.log(task)
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
                    if (!master.canWrite || emptyRow.prevAll(".emptyRow").size() > 0){
                        return
                    }
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
    function checkForOccurances(value){
        var geDatasource = ge.tasks,
            occurrenceFound=false;
        //loop datasource, and check if there is an element in datasource already with same taskWorkflowId
        // as selected
        if(value !==''){
            for (var i = 0; i < geDatasource.length; i++) {
                if(geDatasource[i].TaskWorkflowId === value){
                    occurrenceFound=true;
                    break;
                }
            }
        }
        if(occurrenceFound){
            return true;
        }else{
            return false;
        }
    };
    function dropDownChanger(task,value,text,self,e,el,m){
        //if no occurrences in datasource ->
        if(task.TaskWorkflowId !== value){
            if(!checkForOccurances(value)){
                task.TaskWorkflowId = value;
                task.name = text;
                task.TaskWorkfowIsChanged = 1;
                self.master.taskIsChanged();
            }else{
                toastr.warning(Yunique.Data.getTranslatedString(TranslationData,'You cannot choose same action'));
                e.preventDefault();
                //prevent data from selection
                el.data("kendoDropDownList").select(0);
                task.TaskWorkflowId = '';
                task.name = '';
                self.master.taskIsChanged();

            }
        }
    }

    GridEditor.prototype.bindRowInputEvents = function (task, taskRow) {
        $('.teamYunique').first().find('span').css('visibility', 'hidden');
        $('.new').first().find('input').css('visibility', 'hidden');
        $('.carryOver').first().find('input').css('visibility', 'hidden');
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
            var indexElem = 0;
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
                close:function(e,m,p){
                    if((this.value()==='group')){
                        e.preventDefault();
                        toastr.warning(Yunique.Data.getTranslatedString(TranslationData,'You cannot choose groupnames as tasks.'));;

                    }
                },
                open:function(e){
                    window.alreadyCalled = false;
                },
                select: function (e) {
                    var currValue = this.value();
                    if(e.item && !alreadyCalled){
                        alreadyCalled=true;
                        dropDownChanger(task,this.dataItem(e.item.index()).key,this.dataItem(e.item.index()).value,self,e,el)
                    }else{
                        dropDownChanger(task,currValue,this.text(),self,e,el);
                    }
                },
                change:function(e,m){
                    //since telerik doesnt know that someone would love to have 2 events,instead of just 1,
                    // if user use keyboard for navigation.We will trigger selection manually.
                    if(!alreadyCalled){
                        var ddl =  el.data("kendoDropDownList");
                        ddl.trigger('select');
                    }else{
                        alreadyCalled = false;
                    }
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
                task.type = '0';
//                task.level = '1';
                $(this).find('span.taskNameDDL').css('display', 'none');
            }
        }).data('kendoDropDownList');
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
                task.new = '1';
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
                    else {
                        nextRow.click()
                    }; //create a new row
                    break;
                case 36: //home
                    break;
                case 35: //end
                    break;
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
};;function GanttMaster() {
    this.tasks = [];
    this.deletedTaskIds = [];
    this.links = [];
    this.yuniqueDeletedGuis = [];

    this.editor; //element for editor
    this.gantt; //element for gantt

    this.element;


    this.resources; //list of resources
    this.roles; //list of roles

    this.minEditableDate = 0;
    this.maxEditableDate = Infinity;

    this.canWriteOnParent = true;
    this.canWrite = true;

    this.firstDayOfWeek = Date.firstDayOfWeek;

    this.currentTask; // task currently selected;

    this.__currentTransaction; // a transaction object holds previous state during changes
    this.__undoStack = [];
    this.__redoStack = [];
    this.__inUndoRedo = false; // a control flag to avoid Undo/Redo stacks reset when needed

    var self = this;
}

GanttMaster.prototype.init = function (place) {
    this.element = place;
    var self = this;
    //load templates
    $("#gantEditorTemplates").loadTemplates().remove(); // TODO: Remove inline jquery, this should be injected

    //create editor
    this.editor = new GridEditor(this);
    place.append(this.editor.gridified);

    //create gantt
    this.gantt = new Ganttalendar("m", new Date().getTime() - 3600000 * 24 * 2, new Date().getTime() + 3600000 * 24 * 15, this, place.width() * .6);

    //setup splitter
    var splitter = $.splittify.init(place, this.editor.gridified, this.gantt.element, 60);
    self.splitter = splitter;
    //prepend buttons
    place.before($.JST.createFromTemplate({}, "GANTBUTTONS"));


    //bindings
    place.bind("refreshTasks.gantt", function () {
        self.redrawTasks();
    }).bind("refreshTask.gantt", function (e, task) {
            self.drawTask(task);

        }).bind("deleteCurrentTask.gantt", function (e) {
            self.deleteCurrentTask();

        }).bind("addAboveCurrentTask.gantt", function () {
            self.addAboveCurrentTask();

        }).bind("addBelowCurrentTask.gantt", function () {
            self.addBelowCurrentTask();

        }).bind("addBelowNewTask.gantt", function () {
            self.addBelowNewTask();

        }).bind("indentCurrentTask.gantt", function () {
            self.indentCurrentTask();

        }).bind("outdentCurrentTask.gantt", function () {
            self.outdentCurrentTask();

        }).bind("moveUpCurrentTask.gantt", function () {
            self.moveUpCurrentTask();
        }).bind("moveCurrentTask.gantt", function (e,params) {
            self.moveCurrentTask(params);
        }).bind("moveDownCurrentTask.gantt", function () {
            self.moveDownCurrentTask();

        }).bind("zoomPlus.gantt", function () {
            self.gantt.zoomGantt(true);
        }).bind("zoomMinus.gantt", function () {
            self.gantt.zoomGantt(false);

        }).bind("undo.gantt", function () {
            if (!self.canWrite){
                return;
            }
            self.undo();
        }).bind("redo.gantt", function () {
            if (!self.canWrite){
                return;
            }
            self.redo();
        }).bind("resize.gantt", function () {
            self.resize();
        });

    //keyboard management bindings
    $("body").bind("keydown.body", function (e) {
        //console.debug(e.keyCode+ " "+e.target.nodeName)

        //manage only events for body -> not from inputs
        if (e.target.nodeName.toLowerCase() == "body" || e.target.nodeName.toLowerCase() == "svg") { // chrome,ff receive "body" ie "svg"
            //something focused?
            //console.debug(e.keyCode, e.ctrlKey)
            var eventManaged = true;
            switch (e.keyCode) {
                case 46: //del
                case 8: //backspace
                    var focused = self.gantt.element.find(".focused.focused"); // orrible hack for chrome that seems to keep in memory a cached object
                    if (focused.is(".taskBox")) { // remove task
                        self.deleteCurrentTask();
                    } else if (focused.is(".linkGroup")) {
                        self.removeLink(focused.data("from"), focused.data("to"));
                    }
                    break;

                case 38: //up
                    if (self.currentTask) {
                        if (self.currentTask.ganttElement.is(".focused")) {
                            self.moveUpCurrentTask();
                            self.gantt.element.oneTime(100, function () {
                                self.currentTask.ganttElement.addClass("focused");
                            });

                        } else {
                            self.currentTask.rowElement.prev().click();
                        }
                    }
                    break;

                case 40: //down
                    if (self.currentTask) {
                        //              console.log(self.currentTask)
                        //            if (self.currentTask.ganttElement.is(".focused")) {
                        //              self.moveDownCurrentTask();
                        //              self.gantt.element.oneTime(100, function () {self.currentTask.ganttElement.addClass("focused");});
                        //            } else {
                        self.currentTask.rowElement.next().click();
                        //            }
                    }
                    break;

                case 39: //right
                    if (self.currentTask) {
                        if (self.currentTask.ganttElement.is(".focused")) {
                            self.indentCurrentTask();
                            self.gantt.element.oneTime(100, function () {
                                self.currentTask.ganttElement.addClass("focused");
                            });
                        }
                    }
                    break;

                case 37: //left
                    if (self.currentTask) {
                        if (self.currentTask.ganttElement.is(".focused")) {
                            self.outdentCurrentTask();
                            self.gantt.element.oneTime(100, function () {
                                self.currentTask.ganttElement.addClass("focused");
                            });
                        }
                    }
                    break;


                case 89: //Y
                    if (e.ctrlKey) {
                        self.redo();
                    }
                    break;

                case 90: //Z
                    if (e.ctrlKey) {
                        self.undo();
                    }
                    break;

                default:
                {
                    eventManaged = false;
                }

            }
            if (eventManaged) {
                e.preventDefault();
                e.stopPropagation();
            }
        }
    });
};

GanttMaster.messages = {
    "CANNOT_WRITE": "CANNOT_WRITE",
    "CHANGE_OUT_OF_SCOPE": "NO_RIGHTS_FOR_UPDATE_PARENTS_OUT_OF_EDITOR_SCOPE",
    "START_IS_MILESTONE": "START_IS_MILESTONE",
    "END_IS_MILESTONE": "END_IS_MILESTONE",
    "TASK_HAS_CONSTRAINTS": "TASK_HAS_CONSTRAINTS",
    "GANTT_ERROR_DEPENDS_ON_OPEN_TASK": "GANTT_ERROR_DEPENDS_ON_OPEN_TASK",
    "GANTT_ERROR_DESCENDANT_OF_CLOSED_TASK": "GANTT_ERROR_DESCENDANT_OF_CLOSED_TASK",
    "TASK_HAS_EXTERNAL_DEPS": "TASK_HAS_EXTERNAL_DEPS",
    "GANTT_ERROR_LOADING_DATA_TASK_REMOVED": "GANTT_ERROR_LOADING_DATA_TASK_REMOVED",
    "CIRCULAR_REFERENCE": "CIRCULAR_REFERENCE",
    "ERROR_SETTING_DATES": "ERROR_SETTING_DATES",
    "CANNOT_DEPENDS_ON_ANCESTORS": "CANNOT_DEPENDS_ON_ANCESTORS",
    "CANNOT_DEPENDS_ON_DESCENDANTS": "CANNOT_DEPENDS_ON_DESCENDANTS",
    "INVALID_DATE_FORMAT": "INVALID_DATE_FORMAT",
    "GANTT_QUARTER_SHORT": "GANTT_QUARTER_SHORT",
    "GANTT_SEMESTER_SHORT": "GANTT_SEMESTER_SHORT",
    "CANNOT_CLOSE_TASK_IF_OPEN_ISSUE": "CANNOT_CLOSE_TASK_IF_OPEN_ISSUE",
    "TASK_MOVE_INCONSISTENT_LEVEL":"Task move inconsistent level"
};


GanttMaster.prototype.createTask = function (id, name, code, level, start, duration) {
    var factory = new TaskFactory();
    return factory.build(id, name, code, level, start, duration);
};


GanttMaster.prototype.createResource = function (id, name) {
    var res = new Resource(id, name);
    return res;
};


//update depends strings
GanttMaster.prototype.updateDependsStrings = function () {
    //remove all deps
    for (var i = 0; i < this.tasks.length; i++) {
        this.tasks[i].depends = "";
    }

    for (var i = 0; i < this.links.length; i++) {
        var link = this.links[i];
        var dep = link.to.depends;
        link.to.depends = link.to.depends + (link.to.depends == "" ? "" : ",") + (link.from.getRow() + 1) + (link.lag ? ":" + link.lag : "");
    }

};

GanttMaster.prototype.removeLink = function (fromTask, toTask) {
    //console.debug("removeLink");
    this.beginTransaction();
    var found = false;
    for (var i = 0; i < this.links.length; i++) {
        if (this.links[i].from == fromTask && this.links[i].to == toTask) {
            this.links.splice(i, 1);
            found = true;
            break;
        }
    }

    if (found) {
        this.updateDependsStrings();
        if (this.updateLinks(toTask)){
            this.changeTaskDates(toTask, toTask.start, toTask.end); // fake change to force date recomputation from dependencies
        }
    }
    this.endTransaction();
};

//------------------------------------  ADD TASK --------------------------------------------
GanttMaster.prototype.addTask = function (task, row) {
    //console.debug("master.addTask",task,row,this);
    task.master = this; // in order to access controller from task
    //replace if already exists
    var pos = -1;
    for (var i = 0; i < this.tasks.length; i++) {
        if (task.id == this.tasks[i].id) {
            pos = i;
            break;
        }
    }
    if (pos >= 0) {
        this.tasks.splice(pos, 1);
        row = parseInt(pos);
    }
    //add task in collection
    if (typeof (row) != "number") {
        this.tasks.push(task);
    } else {
        this.tasks.splice(row, 0, task);

        //recompute depends string
        this.updateDependsStrings();
    }

    //add Link collection in memory
    var linkLoops = !this.updateLinks(task);

    //set the status according to parent
    if (task.getParent()){
        task.status = task.getParent().status;
    }
    else{
        task.status = "STATUS_ACTIVE";
    }

    var ret = task;
    if (linkLoops || !task.setPeriod(task.start, task.end)) {
        //remove task from in-memory collection
        //console.debug("removing task from memory",task);
        this.tasks.splice(task.getRow(), 1);
        ret = undefined;
    } else {
        //append task to editor
        this.editor.addTask(task, row);
        //append task to gantt
        this.gantt.addTask(task);
    }
    return ret;
};


/**
 * a project contais tasks, resources, roles, and info about permisions
 * @param project
 */
GanttMaster.prototype.loadProject = function (project) {
    this.beginTransaction();
    this.resources = project.resources;
    this.roles = project.roles;
    this.canWrite = project.canWrite;
    this.canWriteOnParent = project.canWriteOnParent;
    this.cannotCloseTaskIfIssueOpen = project.cannotCloseTaskIfIssueOpen;

    if (project.minEditableDate){
        this.minEditableDate = computeStart(project.minEditableDate);}
    else{
        this.minEditableDate = -Infinity;
    }
    if (project.maxEditableDate){
        this.maxEditableDate = computeEnd(project.maxEditableDate);
    }
    else{
        this.maxEditableDate = Infinity;
    }
    this.loadTasks(project.tasks, project.selectedRow);
    this.deletedTaskIds = [];
    this.endTransaction();
    var self = this;
    this.gantt.element.oneTime(200, function () {
        self.gantt.centerOnToday()
    });
};


GanttMaster.prototype.loadTasks = function (tasks, selectedRow) {
    var factory = new TaskFactory();
    var _self =  this;
    //reset
    this.reset();
    for (var i = 0; i < tasks.length; i++) {
        var task = tasks[i];
        if (!(task instanceof Task)) {
            var t = factory.build(task.id, task.name, task.code, task.level, task.start, task.duration);
            for (var key in task) {
                if (key != "end" && key != "start") {
                    t[key] = task[key]; //copy all properties
                }
            }
            task = t;
        }
        task.master = _self; // in order to access controller from task

        /*//replace if already exists
         var pos = -1;
         for (var i=0;i<this.tasks.length;i++) {
         if (task.id == this.tasks[i].id) {
         pos = i;
         break;
         }
         }*/

        _self.tasks.push(task); //append task at the end
    }

    //var prof=new Profiler("gm_loadTasks_addTaskLoop");
    for (var i = 0; i < this.tasks.length; i++) {
        var task = this.tasks[i];
        //add Link collection in memory
        var linkLoops = !this.updateLinks(task);

        if (linkLoops || !task.setPeriod(task.start, task.end)) {
            alert(GanttMaster.messages.GANNT_ERROR_LOADING_DATA_TASK_REMOVED + "\n" + task.name + "\n" +
                (linkLoops ? GanttMaster.messages.CIRCULAR_REFERENCE : GanttMaster.messages.ERROR_SETTING_DATES));

            //remove task from in-memory collection
            this.tasks.splice(task.getRow(), 1);
        } else {
            //append task to editor
            this.editor.addTask(task);
            //append task to gantt
            this.gantt.addTask(task);
        }
    }

    this.editor.fillEmptyLines();
    this.editor.hideColumns();
    //prof.stop();

    // re-select old row if tasks is not empty
    if (this.tasks && this.tasks.length > 0) {
        selectedRow = selectedRow ? selectedRow : 0;
        this.tasks[selectedRow].rowElement.click();
    }

};


GanttMaster.prototype.getTask = function (taskId) {
    var ret;
    for (var i = 0; i < this.tasks.length; i++) {
        var tsk = this.tasks[i];
        if (tsk.id == taskId) {
            ret = tsk;
            break;
        }
    }
    return ret;
};


GanttMaster.prototype.getResource = function (resId) {
    var ret;
    for (var i = 0; i < this.resources.length; i++) {
        var res = this.resources[i];
        if (res.id == resId) {
            ret = res;
            break;
        }
    }
    return ret;
};


GanttMaster.prototype.changeTaskDates = function (task, start, end) {
    return task.setPeriod(start, end);
};


GanttMaster.prototype.moveTask = function (task, newStart) {
    return task.moveTo(newStart, true);
};


GanttMaster.prototype.taskIsChanged = function () {
    var master = this;
    //refresh is executed only once every 50ms
    this.element.stopTime("gnnttaskIsChanged");
    //var profilerext = new Profiler("gm_taskIsChangedRequest");
    this.element.oneTime(50, "gnnttaskIsChanged", function () {
        //console.debug("task Is Changed real call to redraw");
        //var profiler = new Profiler("gm_taskIsChangedReal");
        master.editor.redraw();
        master.gantt.refreshGantt();
        //profiler.stop();
    });
    //profilerext.stop();
};


GanttMaster.prototype.redraw = function () {
    this.editor.redraw();
    this.gantt.refreshGantt();
};

GanttMaster.prototype.reset = function () {
    this.tasks = [];
    this.links = [];
    this.deletedTaskIds = [];
    if (!this.__inUndoRedo) {
        this.__undoStack = [];
        this.__redoStack = [];
    } else { // don't reset the stacks if we're in an Undo/Redo, but restart the inUndoRedo control
        this.__inUndoRedo = false;
    }
    delete this.currentTask;

    this.editor.reset();
    this.gantt.reset();
};


GanttMaster.prototype.showTaskEditor = function (taskId) {
    var task = this.getTask(taskId);
    task.rowElement.find(".edit").click();
};

GanttMaster.prototype.saveProject = function () {
    return this.saveGantt(false);
};

GanttMaster.prototype.saveGantt = function (forTransaction) {
    //var prof = new Profiler("gm_saveGantt");
    var saved = [];
    for (var i = 0; i < this.tasks.length; i++) {
        var task = this.tasks[i];
        var cloned = task.clone();
        delete cloned.master;
        delete cloned.rowElement;
        delete cloned.ganttElement;

        saved.push(cloned);
    }

    var ret = {
        tasks: saved
    };
    if (this.currentTask) {
        ret.selectedRow = this.currentTask.getRow();
    }

    ret.deletedTaskIds = this.deletedTaskIds; //this must be consistent with transactions and undo

    if (!forTransaction) {
        ret.resources = this.resources;
        ret.roles = this.roles;
        ret.canWrite = this.canWrite;
        ret.canWriteOnParent = this.canWriteOnParent;
    }

    //prof.stop();
    return ret;
};


GanttMaster.prototype.updateLinks = function (task) {
    //console.debug("updateLinks",task);
    //var prof= new Profiler("gm_updateLinks");

    // defines isLoop function
    function isLoop(task, target, visited) {
        //var prof= new Profiler("gm_isLoop");
        //console.debug("isLoop :"+task.name+" - "+target.name);
        if (target == task) {
            return true;
        }

        var sups = task.getSuperiors();

        //my parent' superiors are my superiors too
        var p = task.getParent();
        while (p) {
            sups = sups.concat(p.getSuperiors());
            p = p.getParent();
        }

        //my children superiors are my superiors too
        var chs = task.getChildren();
        for (var i = 0; i < chs.length; i++) {
            sups = sups.concat(chs[i].getSuperiors());
        }


        var loop = false;
        //check superiors
        for (var i = 0; i < sups.length; i++) {
            var supLink = sups[i];
            if (supLink.from == target) {
                loop = true;
                break;
            } else {
                if (visited.indexOf(supLink.from.id + "x" + target.id) <= 0) {
                    visited.push(supLink.from.id + "x" + target.id);
                    if (isLoop(supLink.from, target, visited)) {
                        loop = true;
                        break;
                    }
                }
            }
        }

        //check target parent
        var tpar = target.getParent();
        if (tpar) {
            if (visited.indexOf(task.id + "x" + tpar.id) <= 0) {
                visited.push(task.id + "x" + tpar.id);
                if (isLoop(task, tpar, visited)) {
                    loop = true;
                }
            }
        }

        //prof.stop();
        return loop;
    }

    //remove my depends
    this.links = this.links.filter(function (link) {
        return link.to != task;
    });

    var todoOk = true;
    if (task.depends) {

        //cannot depend from an ancestor
        var parents = task.getParents();
        //cannot depend from descendants
        var descendants = task.getDescendant();

        var deps = task.depends.split(",");
        var newDepsString = "";

        var visited = [];
        for (var j = 0; j < deps.length; j++) {
            var dep = deps[j]; // in the form of row(lag) e.g. 2:3,3:4,5
            var par = dep.split(":");
            var lag = 0;

            if (par.length > 1) {
                lag = parseInt(par[1]);
            }

            var sup = this.tasks[parseInt(par[0] - 1)];

            if (sup) {
                if (parents && parents.indexOf(sup) >= 0) {
                    this.setErrorOnTransaction(task.name + "\n" + GanttMaster.messages.CANNOT_DEPENDS_ON_ANCESTORS + "\n" + sup.name);
                    todoOk = false;

                } else if (descendants && descendants.indexOf(sup) >= 0) {
                    this.setErrorOnTransaction(task.name + "\n" + GanttMaster.messages.CANNOT_DEPENDS_ON_DESCENDANTS + "\n" + sup.name);
                    todoOk = false;

                } else if (isLoop(sup, task, visited)) {
                    todoOk = false;
                    this.setErrorOnTransaction(GanttMaster.messages.CIRCULAR_REFERENCE + "\n" + task.name + " -> " + sup.name);
                } else {
                    this.links.push(new Link(sup, task, lag));
                    newDepsString = newDepsString + (newDepsString.length > 0 ? "," : "") + dep;
                }
            }
        }
        if (todoOk) {
            task.depends = newDepsString;

        }

    }

    //prof.stop();

    return todoOk;
};


GanttMaster.prototype.moveUpCurrentTask = function () {
    var self = this;
    //console.debug("moveUpCurrentTask",self.currentTask)
    if (!self.canWrite){
        return;
    }

    if (self.currentTask) {
        self.beginTransaction();
        self.currentTask.moveUp();
        self.endTransaction();
    }
};

GanttMaster.prototype.moveCurrentTask = function (params) {
    var self = this;
    //console.debug("moveUpCurrentTask",self.currentTask)
    if (!self.canWrite){
        return;
    }
    if (self.currentTask) {
        self.beginTransaction();
        self.currentTask.moveDrag(params);
        self.endTransaction();
    }
};


GanttMaster.prototype.moveDownCurrentTask = function () {
    var self = this;
    //console.debug("moveDownCurrentTask",self.currentTask)
    if (!self.canWrite){
        return;
    }
    if (self.currentTask) {
        self.beginTransaction();
        self.currentTask.moveDown();
        self.endTransaction();
    }
};

GanttMaster.prototype.outdentCurrentTask = function () {
    var self = this;
    if (!self.canWrite || !self.currentTask.canWrite){
        return;
    }
    if (self.currentTask) {
        self.beginTransaction();
        self.currentTask.outdent();
        self.endTransaction();
    }

};

GanttMaster.prototype.indentCurrentTask = function () {
    var self = this;
    if (!self.canWrite || !self.currentTask.canWrite){
        return;
    }
    if (self.currentTask) {
        self.beginTransaction();
        self.currentTask.indent();
        self.endTransaction();
    }
};

GanttMaster.prototype.addBelowCurrentTask = function () {
    var self = this;
    if (!self.canWrite){
        return;
    }
    var factory = new TaskFactory();
    self.beginTransaction();
    var ch;
    var row = 0;
    if (self.currentTask) {
        ch = factory.build("tmp_" + new Date().getTime(), "", "", parseInt(self.currentTask.level) + 1, self.currentTask.start, 1);
        row = self.currentTask.getRow() + 1;
    } else {
        ch = factory.build("tmp_" + new Date().getTime(), "", "", 0, new Date().getTime(), 1);
    }
    var task = self.addTask(ch, row);
    if (task) {
        task.rowElement.click();
        task.rowElement.find("[name=name]").focus();
    }
    self.endTransaction();

};

GanttMaster.prototype.addBelowNewTask = function () {
    var self = this;
    if (!self.canWrite){
        return;
    }

    var factory = new TaskFactory();
    self.beginTransaction();
    var ch;
    var row = 0;
    if (self.currentTask) {
        ch = factory.build("tmp_" + new Date().getTime(), "", "", parseInt(self.currentTask.level)!== 0 ? parseInt(self.currentTask.level) : 1, self.currentTask.start, 1);
        row = self.currentTask.getRow() + 1;
    } else {
        ch = factory.build("tmp_" + new Date().getTime(), "", "", 0, new Date().getTime(), 1);
    }
    var task = self.addTask(ch, row);
    task.status = "STATUS_UNDEFINED";
    if (task) {
        task.rowElement.click();
        task.rowElement.find("[name=name]").focus();
    }
    self.endTransaction();

};

GanttMaster.prototype.addAboveCurrentTask = function () {
    var self = this;
    if (!self.canWrite){
        return;
    }
    var factory = new TaskFactory();

    var ch;
    var row = 0;
    if (self.currentTask) {
        //cannot add brothers to root
        if (self.currentTask.level <= 0)
            return;
        ch = factory.build("tmp_" + new Date().getTime(), "", "", parseInt(self.currentTask.level), self.currentTask.start, 1);
        row = self.currentTask.getRow();
    } else {
        ch = factory.build("tmp_" + new Date().getTime(), "", "", 0, new Date().getTime(), 1);
    }
    self.beginTransaction();
    var task = self.addTask(ch, row);
    if (task) {
        task.rowElement.click();
        task.rowElement.find("[name=name]").focus();
    }
    self.endTransaction();

};

GanttMaster.prototype.deleteCurrentTask = function () {
    var self = this;
    if (!self.currentTask || !self.canWrite || !self.currentTask.canWrite)
        return;
    var row = self.currentTask.getRow();
    if (self.currentTask && (row > 0 || self.currentTask.isNew())) {
        self.beginTransaction();
        self.currentTask.deleteTask();
        self.currentTask = undefined;

        //recompute depends string
        self.updateDependsStrings();

        //redraw
        self.redraw();

        //focus next row
        row = row > self.tasks.length - 1 ? self.tasks.length - 1 : row;
        if (row >= 0) {
            self.currentTask = self.tasks[row];
            self.currentTask.rowElement.click();
            self.currentTask.rowElement.find("[name=name]").focus();
        }
        self.endTransaction();
    }
};



//<%----------------------------- TRANSACTION MANAGEMENT ---------------------------------%>
GanttMaster.prototype.beginTransaction = function () {
    if (!this.__currentTransaction) {
        this.__currentTransaction = {
            snapshot: JSON.stringify(this.saveGantt(true)),
            errors: []
        };
    } else {
        console.error("Cannot open twice a transaction");
    }
    return this.__currentTransaction;
};


GanttMaster.prototype.endTransaction = function () {
    if (!this.__currentTransaction) {
        console.error("Transaction never started.");
        return true;
    }

    var ret = true;

    //no error -> commit
    if (this.__currentTransaction.errors.length <= 0) {
        //console.debug("committing transaction");

        //put snapshot in undo
        this.__undoStack.push(this.__currentTransaction.snapshot);
        //clear redo stack
        this.__redoStack = [];

        //shrink gantt bundaries
        this.gantt.originalStartMillis = Infinity;
        this.gantt.originalEndMillis = -Infinity;
        for (var i = 0; i < this.tasks.length; i++) {
            var task = this.tasks[i];
            if (this.gantt.originalStartMillis > task.start)
                this.gantt.originalStartMillis = task.start;
            if (this.gantt.originalEndMillis < task.end)
                this.gantt.originalEndMillis = task.end;

        }
        this.taskIsChanged(); //enqueue for gantt refresh


        //error -> rollback
    } else {
        ret = false;
        //console.debug("rolling-back transaction");
        //try to restore changed tasks
        var oldTasks = JSON.parse(this.__currentTransaction.snapshot);
        this.deletedTaskIds = oldTasks.deletedTaskIds;
        this.loadTasks(oldTasks.tasks, oldTasks.selectedRow);
        this.redraw();

        //compose error message
        var msg = "";
        for (var i = 0; i < this.__currentTransaction.errors.length; i++) {
            var err = this.__currentTransaction.errors[i];
            msg = msg + err.msg + "\n\n";
        }
        toastr.warning(Yunique.Data.getTranslatedString(TranslationData,msg));
//        alert(msg);

    }
    //reset transaction
    this.__currentTransaction = undefined;

    return ret;
};

//this function notify an error to a transaction -> transaction will rollback
GanttMaster.prototype.setErrorOnTransaction = function (errorMessage, task) {
    if (this.__currentTransaction) {
        this.__currentTransaction.errors.push({
            msg: errorMessage,
            task: task
        });
    } else {
        console.error(errorMessage);
    }
};

// inhibit undo-redo
GanttMaster.prototype.checkpoint = function () {
    this.__undoStack = [];
    this.__redoStack = [];
};

//----------------------------- UNDO/REDO MANAGEMENT ---------------------------------%>

GanttMaster.prototype.undo = function () {
    //console.debug("undo before:",this.__undoStack,this.__redoStack);
    if (this.__undoStack.length > 0) {
        var his = this.__undoStack.pop();
        this.__redoStack.push(JSON.stringify(this.saveGantt()));
        var oldTasks = JSON.parse(his);
        this.deletedTaskIds = oldTasks.deletedTaskIds;
        this.__inUndoRedo = true; // avoid Undo/Redo stacks reset
        this.loadTasks(oldTasks.tasks, oldTasks.selectedRow);
        //console.debug(oldTasks,oldTasks.deletedTaskIds)
        this.redraw();
        //console.debug("undo after:",this.__undoStack,this.__redoStack);
    }
};

GanttMaster.prototype.redo = function () {
    //console.debug("redo before:",undoStack,redoStack);
    if (this.__redoStack.length > 0) {
        var his = this.__redoStack.pop();
        this.__undoStack.push(JSON.stringify(this.saveGantt()));
        var oldTasks = JSON.parse(his);
        this.deletedTaskIds = oldTasks.deletedTaskIds;
        this.__inUndoRedo = true; // avoid Undo/Redo stacks reset
        this.loadTasks(oldTasks.tasks, oldTasks.selectedRow);
        this.redraw();
        //console.debug("redo after:",undoStack,redoStack);
    }
};


GanttMaster.prototype.resize = function () {
    this.splitter.resize();
};

/**
 * Compute the critical path using Backflow algorithm.
 * Translated from Java code supplied by M. Jessup here http://stackoverflow.com/questions/2985317/critical-path-method-algorithm
 *
 * For each task computes:
 * earlyStart, earlyFinish, latestStart, latestFinish, criticalCost
 *
 * A task on the critical path has isCritical=true
 * A task not in critical path can float by latestStart-earlyStart days
 *
 * If you use critical path avoid usage of dependencies between different levels of tasks
 *
 * WARNNG: It ignore milestones!!!!
 * @return {*}
 */
GanttMaster.prototype.computeCriticalPath = function () {

    if (!this.tasks)
        return false;

    // do not consider grouping tasks
    var tasks = this.tasks.filter(function (t) {
        return !t.isParent()
    });

    // reset values
    for (var i = 0; i < tasks.length; i++) {
        var t = tasks[i];
        t.earlyStart = -1;
        t.earlyFinish = -1;
        t.latestStart = -1;
        t.latestFinish = -1;
        t.criticalCost = -1;
        t.isCritical = false;
    }

    // tasks whose critical cost has been calculated
    var completed = [];
    // tasks whose critical cost needs to be calculated
    var remaining = tasks.concat(); // put all tasks in remaining


    // Backflow algorithm
    // while there are tasks whose critical cost isn't calculated.
    while (remaining.length > 0) {
        var progress = false;

        // find a new task to calculate
        for (var i = 0; i < remaining.length; i++) {
            var task = remaining[i];
            var inferiorTasks = task.getInferiorTasks();

            if (containsAll(completed, inferiorTasks)) {
                // all dependencies calculated, critical cost is max dependency critical cost, plus our cost
                var critical = 0;
                for (var j = 0; j < inferiorTasks.length; j++) {
                    var t = inferiorTasks[j];
                    if (t.criticalCost > critical) {
                        critical = t.criticalCost;
                    }
                }
                task.criticalCost = critical + task.duration;
                // set task as calculated an remove
                completed.push(task);
                remaining.splice(i, 1);

                // note we are making progress
                progress = true;
            }
        }
        // If we haven't made any progress then a cycle must exist in
        // the graph and we wont be able to calculate the critical path
        if (!progress) {
            console.error("Cyclic dependency, algorithm stopped!");
            return false;
        }
    }

    // set earlyStart, earlyFinish, latestStart, latestFinish
    computeMaxCost(tasks);
    var initialNodes = initials(tasks);
    calculateEarly(initialNodes);
    calculateCritical(tasks);


    /*
     for (var i = 0; i < tasks.length; i++) {
     var t = tasks[i];
     console.debug("Task ", t.name, t.duration, t.earlyStart, t.earlyFinish, t.latestStart, t.latestFinish, t.latestStart - t.earlyStart, t.earlyStart == t.latestStart)
     }*/

    return tasks;


    function containsAll(set, targets) {
        for (var i = 0; i < targets.length; i++) {
            if (set.indexOf(targets[i]) < 0)
                return false;
        }
        return true;
    }

    function computeMaxCost(tasks) {
        var max = -1;
        for (var i = 0; i < tasks.length; i++) {
            var t = tasks[i];

            if (t.criticalCost > max)
                max = t.criticalCost;
        }
        //console.debug("Critical path length (cost): " + max);
        for (var i = 0; i < tasks.length; i++) {
            var t = tasks[i];
            t.setLatest(max);
        }
    }

    function initials(tasks) {
        var initials = [];
        for (var i = 0; i < tasks.length; i++) {
            if (!tasks[i].depends || tasks[i].depends == "")
                initials.push(tasks[i]);
        }
        return initials;
    }

    function calculateEarly(initials) {
        for (var i = 0; i < initials.length; i++) {
            var initial = initials[i];
            initial.earlyStart = 0;
            initial.earlyFinish = initial.duration;
            setEarly(initial);
        }
    }

    function setEarly(initial) {
        var completionTime = initial.earlyFinish;
        var inferiorTasks = initial.getInferiorTasks();
        for (var i = 0; i < inferiorTasks.length; i++) {
            var t = inferiorTasks[i];
            if (completionTime >= t.earlyStart) {
                t.earlyStart = completionTime;
                t.earlyFinish = completionTime + t.duration;
            }
            setEarly(t);
        }
    }

    function calculateCritical(tasks) {
        for (var i = 0; i < tasks.length; i++) {
            var t = tasks[i];
            t.isCritical = (t.earlyStart == t.latestStart)
        }
    }
};
