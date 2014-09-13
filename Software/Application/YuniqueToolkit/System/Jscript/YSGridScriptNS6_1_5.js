/* 

   Copyright (c) 2000-2003 Yunique Solutions Inc  
   ALL RIGHTS RESERVED

   The entire contents of this file is protected by U.S. and   
   International Copyright Laws. Unauthorized reproduction,     
   reverse-engineering, and distribution of all or any portion of   
   the code contained in this file is strictly prohibited and may  
   result in severe civil and criminal penalties and will be        
   prosecuted to the maximum extent possible under the law.
*/

var leftBtnPressed = 1;
var columnSizingEdge = 5;
var ns6 = navigator.userAgent.toLowerCase().indexOf("netscape6") >= 0;
var ns7 = navigator.userAgent.toLowerCase().indexOf("netscape/7") >= 0;
var mozilla = navigator.userAgent.toLowerCase().indexOf("gecko") >-1 && !ns6 && !ns7 ;

function clearColumnSizingState(){
	curSizing = false;
	curSzLn = null;
	curX = 0;
	curRszHdr = null;
	curColInd = -1;
	curDragAct = 0;
}

function clearResizingCursor(){
	curRszCrsrHdr = null;
	curRszCrsr = "";
}

function clearDragState(){
	curGridName = "";
	curDragEl = null;
	curColInd = -1;
	curDragAct = 0;
	curX = 0;
	curY = 0;		
	curTargetHdr = null;
	curArrUp = null;
	curArrDown = null; 
	curArrUpX = -1;
	curArrUpY = -1;
	curArrDownX = -1;
	curArrDownY = -1;
}

function clearHotTrackState(){
	hotTrackElement = null;
	hotTrackSavedBackColor = "";
	hotTrackSavedBorderColor = "";
	hotTrackHeader = null;
}

function initializeEnableFlags(){
	curEnblHdrClick = false;
	curEnblHdrDrag = false;
	curEnblGroup = false;
	curEnblClmnMove = false;
	curEnblClmnSize = false;
	curShowArr = false;
}

function replaceDblColon(_str){
	var _indexOf = _str.indexOf("::");
	if(_indexOf == -1){
		return _str;
	}
	else{
		var _str1 = _str.substr(0, _indexOf + 1);		
		var _str2 = _str.substr(_indexOf + 2, _str.length);
		return _str1 + replaceDblColon(_str2);
	}
}

function fillKeyState(evt, gridName){
	document.getElementById(gridName + "ShiftPressed").value = evt.shiftKey;
	document.getElementById(gridName + "CtrlPressed").value = evt.ctrlKey;
}

function getButton(evt){
	var btn = evt.target;		
	while(btn != null && (btn.tagName != "TD" || btn.id == ""))
		btn = btn.parentNode;	
	return btn;
}

function getGridName(btn){
	var _indexOf = btn.id.indexOf("~");
	if(_indexOf != -1)
		return btn.id.substr(0, _indexOf);			
	return "";
}


function YSGridMDown(evt){		
	var tr = evt.target.parentNode;
	for(i = 0; i < 2; i ++)	{	
		if(tr.tagName != "TR")
			tr = tr.parentNode;
	}	
	if(tr.id != undefined){
		var previewClicked = false; 
		if(tr.id.indexOf("~preview") != -1){
			tr = tr.previousSibling;			
			previewClicked = true;
		}
		var indexOf_TR_ = tr.id.indexOf("~TR~");
		if(indexOf_TR_ == -1)
			indexOf_TR_ = tr.id.indexOf("~GTR~");
		if(indexOf_TR_ != -1)
			return OnTRCl(evt, tr, tr.id.substr(0, indexOf_TR_), previewClicked);
	}	
	
	var header = evt.target;	
	while(header != null && (header.tagName != "TD" || header.id == "")){
		header = header.parentNode;
	}
	if(header != null && header.id != undefined){		
		var headerPrefix = "~CH~";
		var indexOf_Header_ = header.id.indexOf(headerPrefix);
		if(indexOf_Header_ == -1){
			headerPrefix = "~GH~";
			indexOf_Header_ = header.id.indexOf(headerPrefix);
		}
		if(indexOf_Header_ != -1){
			var gridName = header.id.substr(0, indexOf_Header_);
			var hdrInd = header.id.substr(indexOf_Header_ + ("~CH~").length, header.id.length);			
			return OnHMDown(evt, header, gridName, hdrInd, headerPrefix);
		}
	}
	return true;
}

function isScrollableElement(curEl){
	return curEl.style.overflow == "scroll" || curEl.style.overflowX == "scroll" || curEl.style.overflowY == "scroll" || curEl.style.overflow == "auto" || curEl.style.overflowX == "auto" || curEl.style.overflowY == "auto";
}

function isStaticElement(curEl){
	return !(curEl.style.position == "absolute" || curEl.style.position == "relative");
}

function absoluteX(curEl, gridName, correctPos, correctionNeeded){
    posX = 0;
    if(curEl.offsetParent != null){
		var nestedCorrectPos = correctPos || curEl.id == gridName + "Table";
        posX += absoluteX(curEl.offsetParent, gridName, nestedCorrectPos, correctionNeeded);
		if(!correctPos || isStaticElement(curEl)) 
            posX += curEl.offsetLeft;
    }
    else{
		posX += curEl.offsetLeft;
	}
    return posX;
}

function absoluteY(curEl, gridName, correctPos){
    posY = 0;    
    if(curEl.offsetParent != null){
		var nestedCorrectPos = correctPos || curEl.id == gridName + "Table";
        posY += absoluteY(curEl.offsetParent, gridName, nestedCorrectPos);
		if(!correctPos || isStaticElement(curEl)) 
            posY += curEl.offsetTop;
    }
    else{
		posY += curEl.offsetTop;
	}
    return posY;
}

function OnGBCl(evt){	
	var header = evt.target;
	while(header != null && (header.tagName != "TD" || header.id == "")){
		header = header.parentNode;
	}	
	if(header != null){		
		var _indexOf = header.id.indexOf("~");
		if(_indexOf != -1){
			var gridName = header.id.substr(0, _indexOf);		
			var hdrInd = header.id.substr(_indexOf + ("~GB~").length, header.id.length);
			var gridObj = __YSGridCollection.Get(gridName);
			if(gridObj != null){				
				var column = gridObj.GetColumnByIndex(hdrInd);
				if(column != null && column.enableGrouping){
					if(header.id.indexOf("~GB~") != -1)
						__doPostBack(replaceDblColon(gridName), "GROUP:GB:" + hdrInd + ":-1");
					else
						__doPostBack(replaceDblColon(gridName), "UNGROUP:GB:" + hdrInd + ":-1");
				}
			}
		}
	}
}

function getLeftCorrection(isGrouped){
	if(mozilla)
		return isGrouped ? -1 : 0;
	if(ns7)
		return isGrouped ? 0 : 1;
	return 0;
}

function getTopCorrection(isGrouped){
	if(mozilla)
		return -1;		
	if(ns7)
		return 0;
	return 0;
}

function showDragHeader(header, drgHdr, isGrouped, borderCollapse){
	drgHdr.style.visibility = "visible";		
	drgHdr.style.left = absoluteX(header) + getLeftCorrection(isGrouped);
	drgHdr.style.top = absoluteY(header) + getTopCorrection(isGrouped);
	drgHdr.innerHTML = header.innerHTML;					
	drgHdr.style.width = header.offsetWidth - ((mozilla || ns7) && isGrouped ? 1 : 2); 
	drgHdr.style.height = header.offsetHeight - ((mozilla || ns7) && isGrouped ? 1 : 2); 
}

function startHotTrackHdr(header, element, borderColor){		
	if(hotTrackElement != null && hotTrackElement != element)
		endHotTrack();
	if(hotTrackElement == null){				
		hotTrackElement = element;
		hotTrackSavedBorderColor = hotTrackElement.style.borderColor;
		hotTrackElement.style.borderColor = borderColor;
		hotTrackHeader = header;
	}
}

function endHotTrackHdr(){	
	if(hotTrackElement != null){
		hotTrackElement.style.borderColor = hotTrackSavedBorderColor;
		hotTrackElement.style.visibility = "hidden";
		hotTrackElement.style.posLeft = 0;
		hotTrackElement.style.posTop = 0;			
		clearHotTrackState();		
	}
}

function OnHMDown(evt, header, gridName, hdrInd, headerPrefix){
	try{
		var gridObj = __YSGridCollection.Get(gridName);
		if(gridObj != null){			
			if(curSizing){				
				curSzLn = document.getElementById(gridName + "sizerline");		
				if(curSzLn != null){					
					endHotTrack();
					curGridName = gridName;		
					curDragAct = 10000;		
					curX = (evt.clientX + window.pageXOffset);
					curSzLn.style.cursor = "e-resize";
					curSzLn.style.visibility = "visible";		
					curSzLn.style.left = curX;
					curSzLn.style.top = absoluteY(header);
					curSzLn.style.width = 1; 
					var scroller = document.getElementById(gridName + "scroller");					
					if(scroller != null)
						curSzLn.style.height = scroller.offsetHeight; 
					else
						curSzLn.style.height = gridObj.GetRowsHeight(header.parentNode.parentNode); 
				}
			}
			else{				
				initializeEnableFlags();				
				var column = gridObj.GetColumnByIndex(hdrInd);
				if(column != null){
					curEnblHdrClick = column.enableHeaderClick;
					curEnblHdrDrag = column.enableHeaderDragging;
					curEnblGroup = column.enableGrouping;
					curEnblClmnMove = column.enableColumnMoving;							
					curEnblClmnSize = column.enableColumnSizing;
				}
				curShowArr = gridObj.showArrowsOnDragging;							
				if(curEnblHdrClick || curEnblHdrDrag){			
					var dragHdr = document.getElementById(gridName + "~DH~" + hdrInd);					
					CheckPageSizeEdit(gridName);		
					endHotTrack();
					var isGrouped = headerPrefix == "~GH~";
					showDragHeader(header, dragHdr, isGrouped, gridObj.borderCollapse);
					curDragAct = isGrouped ? 10001 : 10000;
					curGridName = gridName;
					curColInd = hdrInd;
					curX = (evt.clientX + window.pageXOffset);
					curY = (evt.clientY + window.pageYOffset);		
					curDragEl = dragHdr;			
					curArrUp = document.getElementById(gridName + "arrowup");		
					curArrDown = document.getElementById(gridName + "arrowdown"); 
				}
			}
		}
	}
	catch(e){
	}
	return false;
}

function updateArrowsPos(arrowImgWidth){
	if(curTargetHdr != null){
        curArrUpX = curTargetHdr.x - arrowImgWidth / 2;                
        curArrUpY = curTargetHdr.y + curTargetHdr.height;
        curArrDownX = curTargetHdr.x - arrowImgWidth / 2;
        curArrDownY = curTargetHdr.y - arrowImgWidth;
	}
}

function showArrows(){
    curArrUp.style.left = curArrUpX;    
    curArrUp.style.top = curArrUpY;
    curArrDown.style.left = curArrDownX;
    curArrDown.style.top = curArrDownY;

    curArrUp.style.visibility = "visible";
    curArrDown.style.visibility = "visible";
}

function hideArrows(){
    curArrUp.style.visibility = "hidden";
    curArrDown.style.visibility = "hidden";
}

function OnHMMove(evt){		
	OnHMMoveHT(evt, false, false, "", "");
}

function showResizingCursor(hdr){
	if(curRszCrsrHdr == null || curRszCrsrHdr != hdr){
		if(curRszCrsrHdr != null)
			hideResizingCursor();
		curRszCrsrHdr = hdr;
		curRszCrsr = hdr.style.cursor;
		hdr.style.cursor = "e-resize";
	}
}

function hideResizingCursor(){
	if(curRszCrsrHdr != null)
		curRszCrsrHdr.style.cursor = curRszCrsr;
	clearResizingCursor();
}

function OnHMMoveHT(evt, hotTrack, flatStyle, color1, color2){		
	if(curSzLn == null && curDragEl == null){
		var header;
		if(hotTrackHeader != null){
			header = hotTrackHeader;
		}
		else{
			header = evt.target;
			while(header != null && (header.tagName != "TD" || header.id == "" || header.id.indexOf("~CH~") == -1 && header.id.indexOf("~GH~") == -1 && header.id.indexOf("~DH~") == -1)){
				header = header.parentNode;
			}
		}		
		if(header != null){
			var _indexOf = header.id.indexOf("~");
			if(_indexOf != -1){
				var gridName = header.id.substr(0, _indexOf);		
				var gridObj = __YSGridCollection.Get(gridName);
				if(gridObj != null){
					var hdrInd = header.id.substr(_indexOf + ("~CH~").length, header.id.length);				
					var isGrouped = header.id.indexOf("~GH~") != -1;
					if(hotTrack && hotTrackHeader != header){
						if(flatStyle){						
							var drgHdr = document.getElementById(gridName + "~DH~" + hdrInd);							
							showDragHeader(header, drgHdr, isGrouped, gridObj.borderCollapse);
							startHotTrackHdr(header, drgHdr, color2);
						}
						else{
							startHotTrackBtn(header.firstChild, false, color1, color2)
						}				
					}										
					if(!isGrouped){
						var clientX = evt.clientX + window.pageXOffset;
						curRszHdr = gridObj.GetResizingHeaderInfo(header, hdrInd, clientX);
						if(curRszHdr != null){							
							showResizingCursor(evt.target);
							curSizing = true;
						}
						else{
							hideResizingCursor();
							curSizing = false;
						}
					}
				}
			}			
		}
	}
}

function OnMMove(evt){	
	try	{		
		checkHotTrackHdrCoords(evt);
		if(curDragEl != null || curSzLn != null){
			if(curDragEl == null){					
				newX = (evt.clientX + window.pageXOffset);
				if(newX < curRszHdr.x + curRszHdr.minWidth)
					newX = curRszHdr.x + curRszHdr.minWidth;
				distanceX = (newX - curX);
				if(distanceX != 0){				
					curX = newX;
					curSzLn.style.left = curSzLn.offsetLeft + distanceX;
					curDragAct = 4;
				}				
			}
			else{
				if(curEnblHdrDrag){			
					var header;
					header=curDragEl;				
					if(curDragAct == 10000)
						curDragAct = 2;
					if(curDragAct == 10001)
						curDragAct = 3;
					newX = (evt.clientX + window.pageXOffset);
					newY = (evt.clientY + window.pageYOffset);
					distanceX = (newX - curX);
					distanceY = (newY - curY);
					curX = newX;
					curY = newY;

					header.style.left = header.offsetLeft + distanceX;
					header.style.top = header.offsetTop + distanceY;    	
					
					var gridObj = __YSGridCollection.Get(curGridName);
					if(gridObj != null){										
						curTargetHdr	= null;
						if(curDragAct == 2 && curEnblClmnMove || curDragAct == 3 && curEnblGroup)
							curTargetHdr = gridObj.GetTargetHeaderInfo(header.offsetLeft + header.offsetWidth / 2, header.offsetTop + header.offsetHeight / 2, curColInd);
						if(curTargetHdr == null && curEnblGroup){
							curTargetHdr = gridObj.GetTargetGroupedHeaderInfo(header.offsetLeft + header.offsetWidth / 2, header.offsetTop + header.offsetHeight / 2, curColInd);
						}
						if(curShowArr){
							updateArrowsPos(gridObj.arrowImgWidth);
							if(curTargetHdr == null)
								hideArrows();
							else
								showArrows();
						}
					}
				}
			}
		}		
		if(savedDocumentMouseMove != null)
			savedDocumentMouseMove();
	}
	catch(e){
	}
}

function OnDHMMove(evt){
	OnHMMoveHT(evt, false, false, "", "");
}

function OnDHMDown(evt){	
	if(!(evt.target.id != null && (evt.target.id.indexOf("~GB~") >= 0 || evt.target.id.indexOf("~UB~") >= 0) || evt.target.parentNode != null && evt.target.parentNode.id != null && (evt.target.parentNode.id.indexOf("~GB~") >= 0 || evt.target.parentNode.id.indexOf("~UB~") >= 0))){
		if(hotTrackHeader != null){		
			var headerPrefix = "~CH~";
			var indexOf_Header_ = hotTrackHeader.id.indexOf(headerPrefix);
			if(indexOf_Header_ == -1){
				headerPrefix = "~GH~";
				indexOf_Header_ = hotTrackHeader.id.indexOf(headerPrefix);
			}
			if(indexOf_Header_ != -1){
				var gridName = hotTrackHeader.id.substr(0, indexOf_Header_);
				var hdrInd = hotTrackHeader.id.substr(indexOf_Header_ + ("~CH~").length, hotTrackHeader.id.length);			
				OnHMDown(evt, hotTrackHeader, gridName, hdrInd, headerPrefix);
			}
		}
	}
}

function OnDHMUp(evt){	
	try	{	
		if(evt.target.id != null && (evt.target.id.indexOf("~GB~") >= 0 || evt.target.id.indexOf("~UB~") >= 0) || evt.target.parentNode != null && evt.target.parentNode.id != null && (evt.target.parentNode.id.indexOf("~GB~") >= 0 || evt.target.parentNode.id.indexOf("~UB~") >= 0)){
			OnGBCl();
		}
		else{			
			if(curSzLn != null){
				if(curDragAct == 4)			
					__doPostBack(replaceDblColon(curGridName), "RESIZECOLUMN:CH:" + curRszHdr.columnIndex + ":" + (curX - curRszHdr.x - curRszHdr.width));
				curSzLn.style.cursor = "default";
				curSzLn.style.visibility = "hidden";
				clearColumnSizingState();
			}
			else{
				if(curDragEl != null){	
					var header = curDragEl;
					var gridObj = __YSGridCollection.Get(curGridName);			
					if(curDragAct == 2 || curDragAct == 3){	
						if(curShowArr)
							hideArrows();						
						if(curTargetHdr != null){	
							if(curTargetHdr.inGroupingPanel){
								if(curEnblGroup && curTargetHdr.columnIndex != curColInd)
									__doPostBack(replaceDblColon(curGridName), "GROUP:CH:" + curColInd + ":" + curTargetHdr.targetIndex);
							}
							else{
								if(curDragAct == 3){
									if(curEnblGroup)
										__doPostBack(replaceDblColon(curGridName), "UNGROUP:CH:" + curColInd + ":" + curTargetHdr.targetIndex);
								}
								else{
									if(curEnblClmnMove && curTargetHdr.columnIndex != curColInd)
										__doPostBack(replaceDblColon(curGridName), "MOVECOLUMN:CH:" + curColInd + ":" + curTargetHdr.targetIndex);
								}
							}			
						}	
					}
					else{				
						if(curEnblHdrClick){
							fillKeyState(evt, curGridName);
							__doPostBack(replaceDblColon(curGridName), "SORT:CH:" + curColInd + ":0");
						}
					}
					header.style.visibility = "hidden";				
					clearDragState();		
				}
			}
		}
		if(savedDocumentMouseUp != null)
			savedDocumentMouseUp();
	}
	catch(e){
	}	
}

function checkHotTrackHdrCoords(evt){
	if(hotTrackHeader != null){
		var headerX = absoluteX(hotTrackHeader);
		var headerY = absoluteY(hotTrackHeader);
		var mouseX = evt.clientX + window.pageXOffset;
		var mouseY = evt.clientY + window.pageYOffset;
		if(mouseX < headerX || mouseX > headerX + hotTrackHeader.offsetWidth || mouseY < headerY || mouseY > headerY + hotTrackHeader.offsetHeight)
			endHotTrack();
	}
}

function OnEBCl(evt){	
	var btn = getButton(evt);
	if(btn != null){		
		var gridName = getGridName(btn);
		var gridObj = __YSGridCollection.Get(gridName);
		if(gridObj != null && gridObj.rowsExpanded != null && gridObj.controlMode == "Browse")
			gridObj.ProcessExpBtn(btn);	
		else
			__doPostBack(replaceDblColon(gridName), "EXPAND:EB:" + btn.id + ":0");
	}
	return false;
}

function OnRBInsCl(evt){	
	var btn = getButton(evt);
	if(btn != null){		
		var gridName = getGridName(btn);
		var gridObj = __YSGridCollection.Get(gridName);
		if(gridObj != null && !gridObj.readOnly && gridObj.allowInsert)
			__doPostBack(replaceDblColon(gridName), "INSERT:RB:" + btn.id + ":0");
	}
	return false;
}

function OnRBAppCl(evt){	
	var btn = getButton(evt);
	if(btn != null){		
		var gridName = getGridName(btn);
		var gridObj = __YSGridCollection.Get(gridName);
		if(gridObj != null && !gridObj.readOnly && gridObj.allowInsert)
			__doPostBack(replaceDblColon(gridName), "APPEND:RB:-1:0");
	}
	return false;
}

function OnRBEditCl(evt){
	var btn = getButton(evt);
	if(btn != null){		
		var gridName = getGridName(btn);
		var gridObj = __YSGridCollection.Get(gridName);
		if(gridObj != null && !gridObj.readOnly && gridObj.allowEdit)
			__doPostBack(replaceDblColon(gridName), "STARTEDIT:RB:" + btn.id + ":0");
	}
	return false;
}

function OnRBCancelCl(evt){
	var btn = getButton(evt);
	if(btn != null){		
		var gridName = getGridName(btn);
		__doPostBack(replaceDblColon(gridName), "CANCELEDIT:RB:0:0");		
	}
	return false;
}

function DoDeleteRow(gridName, rowId, buttonId){
	CheckPageSizeEdit(gridName);		
	var gridObj = __YSGridCollection.Get(gridName);
	if(gridObj != null && gridObj.allowDelete){
		if(!gridObj.confirmDelete || confirm(gridObj.confirmDeleteMessage))
			__doPostBack(replaceDblColon(gridName), "DELETE:" + (rowId == "-1" ? "BB" : "RB") + ":" + rowId + ":" + buttonId);
	}
}

function OnRBDelCl(evt){
	var btn = getButton(evt);
	if(btn != null){		
		var gridName = getGridName(btn);
		DoDeleteRow(gridName, btn.id, "0");
	}
	return false;
}

function OnRBOkCl(evt){
	var btn = getButton(evt);
	if(btn != null){		
		var gridName = getGridName(btn);
		__doPostBack(replaceDblColon(gridName), "POSTEDIT:RB:0:0");
	}
	return false;
}

function OnRBMoveToCl(evt){	
	var button = getButton(evt);
	if(button != null){		
		var gridName = getGridName(button);
		CheckPageSizeEdit(gridName);			
		var gridObj = __YSGridCollection.Get(gridName);
		if(gridObj != null){
			var rowId = button.id.substr(button.id.indexOf("~") + ("~LI~").length, button.id.length);
			var tr = document.getElementById(gridName + "~TR~" + rowId);
			if(tr == null)				
				tr = document.getElementById(gridName + "~GTR~" + rowId);				
			if(tr != null && !(document.getElementById(gridName + "State").value == "Edit" && document.getElementById(gridName + "FocusedRow").value == tr.id)){		
				if(gridObj != null && !gridObj.postBackOnFocusedChanged && document.getElementById(gridName + "State").value != "Edit"){
					gridObj.MoveTo(tr, true, !evt.ctrlKey, evt.shiftKey);
				}
				else{
					fillKeyState(evt, gridName);
					__doPostBack(replaceDblColon(gridName), "MOVETO:RB:" + tr.id + ":0");
				}
			}
		}	
	}
	return false;
}

function OnTRCl(evt, tr, gridName, previewClicked){
	var td;
	td = evt.target;
	while(td != null && td.tagName != "TD"){
		td = td.parentNode;
	}	
	if(td != null){
		CheckPageSizeEdit(gridName);		
		var gridObj = __YSGridCollection.Get(gridName);		
		if(gridObj != null){
			try{	
				if(!(document.getElementById(gridName + "State").value == "Edit" && document.getElementById(gridName + "FocusedRow").value == tr.id)){		
					if(document.getElementById(gridName + "State").value == "Edit"){
						__doPostBack(replaceDblColon(gridName), "MOVETO:RR:" + tr.id + ":0");
						return;
					}
					var isGroupRow = tr.id.indexOf("~GTR~") != -1;
					if(document.getElementById(gridName + "FocusedRow").value == tr.id && (!gridObj.multiSelection || !evt.ctrlKey) && !previewClicked){
						if(gridObj.postBackOnRowDblClick){
							if(isGroupRow){
								var gridObj = __YSGridCollection.Get(gridName);
								if(gridObj.rowsExpanded != null)
									gridObj.ProcessExpTR(tr);	
								else
									__doPostBack(replaceDblColon(gridName), "EXPAND:RR:" + tr.id + ":0");
							}
							else{
								if(!gridObj.readOnly && gridObj.allowEdit)
									__doPostBack(replaceDblColon(gridName), "STARTEDIT:RR:" + tr.id + ":" + td.id);
							}
							return;
						}
					}
					else{
						if(!gridObj.postBackOnFocusedChanged){							
							gridObj.MoveTo(tr, true, !evt.ctrlKey, evt.shiftKey);
						}
						else{
							fillKeyState(evt, gridName);
							__doPostBack(replaceDblColon(gridName), "MOVETO:RR:" + tr.id + ":0");
						}
					}	
				}
				else{
					return true;
				}
			}
			catch(e){
			}	
		}
	}
}

function MoveBy(evt, direction, gridName, buttonId){		
	CheckPageSizeEdit(gridName);
	var gridObj = __YSGridCollection.Get(gridName);
	if(document.getElementById(gridName + "State").value != "Edit" && !gridObj.postBackOnFocusedChanged){
		try{
			var newtrId = gridObj.MoveBy(direction, evt.ctrlKey, evt.shiftKey);
			if(newtrId != "")
				return;
		}
		catch(e){
		}
	}
	fillKeyState(evt, gridName);
	__doPostBack(replaceDblColon(gridName), ((direction) ? "NEXT" : "PREV") + ":BB:0:" + buttonId);
}

function OnBBFirstCl(evt, gridName, buttonId){
	fillKeyState(evt, gridName);
	__doPostBack(replaceDblColon(gridName), "FIRST:BB:0:" + buttonId);
	return false;
}

function OnBBPrevPageCl(evt, gridName, buttonId){
	fillKeyState(evt, gridName);
	__doPostBack(replaceDblColon(gridName), "PREVPAGE:BB:0:" + buttonId);
	return false;
}

function OnBBPrevCl(evt, gridName, buttonId){
	MoveBy(evt, false, gridName, buttonId);	
	return false;
}

function OnBBNextCl(evt, gridName, buttonId){	
	MoveBy(evt, true, gridName, buttonId);	
	return false;
}

function OnBBNextPageCl(evt, gridName, buttonId){	
	fillKeyState(evt, gridName);
	__doPostBack(replaceDblColon(gridName), "NEXTPAGE:BB:0:" + buttonId);
	return false;
}

function OnBBLastCl(evt, gridName, buttonId){
	fillKeyState(evt, gridName);
	__doPostBack(replaceDblColon(gridName), "LAST:BB:0:" + buttonId);
	return false;
}

function CancelPageSize(gridName){
	try	{		
		var gridObj = __YSGridCollection.Get(gridName);
		if(gridObj != null){
			gridObj.CancelPageSize();		
		}
		document.getElementById(gridName + "State").value = "";
	}
	catch(e){
	}	
}

function ApplyPageSize(gridName, buttonId){	
	var reg = /^[0-9]+$/;
	if(!reg.test(document.getElementById(gridName + "PageSizeEdit" + buttonId).value)){
		alert("The size of page must be an integer number");
	}
	else{			
		__doPostBack(replaceDblColon(gridName), "CHANGEPAGESIZE:BB:" + document.getElementById(gridName + "PageSizeEdit" + buttonId).value + ":" + buttonId);
	}
}

function CheckPageSizeEdit(gridName){	
	if(document.getElementById(gridName + "State").value == "ChangingPageSize")
		CancelPageSize(gridName);
}

function OnBBChPSCl(evt, gridName, buttonId){
	try	{		
		var gridObj = __YSGridCollection.Get(gridName);
		if(gridObj != null){
			if(document.getElementById(gridName + "State").value == "ChangingPageSize" && gridObj.pageSizeButtonId == buttonId){
				ApplyPageSize(gridName, buttonId);
			}
			else{
				CheckPageSizeEdit(gridName);			
				gridObj.EditPageSize(evt.target, buttonId);
				document.getElementById(gridName + "State").value = "ChangingPageSize";
			}
		}
	}
	catch(e){
	}
	return false;
}

function OnBBInsCl(gridName, buttonId){
	var gridObj = __YSGridCollection.Get(gridName);	
	if(gridObj != null && !gridObj.readOnly && gridObj.allowInsert)
		__doPostBack(replaceDblColon(gridName), "INSERT:BB:-1:" + buttonId);
	return false;
}

function OnBBAppCl(gridName, buttonId){
	var gridObj = __YSGridCollection.Get(gridName);	
	if(gridObj != null && !gridObj.readOnly && gridObj.allowInsert)
		__doPostBack(replaceDblColon(gridName), "APPEND:BB:-1:" + buttonId);
	return false;
}

function OnBBEditCl(gridName, buttonId){	
	var gridObj = __YSGridCollection.Get(gridName);		
	if(gridObj != null && !gridObj.readOnly && gridObj.allowEdit)
		__doPostBack(replaceDblColon(gridName), "STARTEDIT:BB:-1:" + buttonId);
	return false;
}

function OnBBDelCl(gridName, buttonId){
	DoDeleteRow(gridName, "-1", buttonId);
	return false;
}

function OnBBRefreshCl(gridName, buttonId){
	__doPostBack(replaceDblColon(gridName), "REFRESH:BB:0:" + buttonId);
	return false;
}

function OnBBOkCl(gridName, buttonId){
	__doPostBack(replaceDblColon(gridName), "POSTEDIT:BB:0:" + buttonId);
	return false;
}

function OnBBCancelCl(gridName, buttonId){	
	__doPostBack(replaceDblColon(gridName), "CANCELEDIT:BB:0:" + buttonId);
	return false;		
}

function OnBBGoToPageCl(gridName, buttonId){	
	__doPostBack(replaceDblColon(gridName), "GOTOPAGE:BB:" + document.getElementById(gridName + "GoToPageEdit" + buttonId).value + ":" + buttonId);
}

function OnBBGoToPageIndCl(gridName, pageIndex, buttonId){	
	__doPostBack(replaceDblColon(gridName), "GOTOPAGE:PI:" + pageIndex + ":" + buttonId);
}

function OnBBSelPgCh(select, gridName, buttonId){
	__doPostBack(replaceDblColon(gridName), "GOTOPAGE:BB:" + select.value + ":" + buttonId);
}

function OnBBSrchCl(gridName, buttonId){	
	var edit = document.getElementById(gridName + "SearchEdit" + buttonId);
	if(edit != null){
		if(edit.value != "")
			__doPostBack(replaceDblColon(gridName), "SEARCH:BB:" + document.getElementById(gridName + "SearchSelect" + buttonId).value + ":" + edit.value);
		else
			edit.focus();
	}
}

function OnBBCustom(gridName, buttonId){	
	__doPostBack(replaceDblColon(gridName), "CUSTOM:BB:0:" + buttonId);
}

function OnSBCl(gridName, columnIndex){
	var edit = document.getElementById(gridName + "SearchEdit" + columnIndex);
	if(edit != null){
		if(edit.value != "")
			__doPostBack(replaceDblColon(gridName), "SEARCH:SB:" + columnIndex + ":" + edit.value);
		else
			edit.focus();
	}
	
}

function OnScroll(gridName){
	var scrollLeftInput = document.getElementById(gridName + "ScrollLeft");
	if(scrollLeftInput != null)
		scrollLeftInput.value = document.getElementById(gridName + "scroller").scrollLeft;
	var scrollTopInput = document.getElementById(gridName + "ScrollTop");
	if(scrollTopInput != null)
		scrollTopInput.value = document.getElementById(gridName + "scroller").scrollTop;
}

function endHotTrackBtn(){
	if(hotTrackElement != null){
		hotTrackElement.style.backgroundColor = hotTrackSavedBackColor;
		hotTrackElement.style.borderColor = hotTrackSavedBorderColor;
		hotTrackElement.style.borderLeftColor = hotTrackSavedBorderColor;
		hotTrackElement.style.borderTopColor = hotTrackSavedBorderColor;
		hotTrackElement.style.borderRightColor = hotTrackSavedBorderColor;
		hotTrackElement.style.borderBottomColor = hotTrackSavedBorderColor;
		clearHotTrackState();		
	}
}

function endHotTrack(){
	if(hotTrackHeader != null)
		endHotTrackHdr();
	else
		endHotTrackBtn();
}

function startHotTrackBtn(element, flatStyle, color1, color2){		
	if(hotTrackElement != null && hotTrackElement != element)
		endHotTrack();
	if(hotTrackElement == null){
		hotTrackElement = element;
		hotTrackSavedBackColor = hotTrackElement.style.backgroundColor;
		hotTrackSavedBorderColor = hotTrackElement.style.borderColor;
		if(flatStyle){			
			hotTrackElement.style.backgroundColor = color1;
			hotTrackElement.style.borderColor = color2;
		}
		else{		
			hotTrackElement.style.borderLeftColor = color1;
			hotTrackElement.style.borderTopColor = color1;
			hotTrackElement.style.borderRightColor = color2;
			hotTrackElement.style.borderBottomColor = color2;
		}
	}
}

function OnBMMove(button, flatStyle, color1, color2){
	while(button != null && button.tagName != "TD"){
		button = button.parentElement;
	}
	startHotTrackBtn(button, flatStyle, color1, color2);
}

function OnBMOut(){
	endHotTrack();
}

function document_OnMouseDown(evt){
	var ret;
	ret = YSGridMDown(evt);
	if(savedDocumentMouseDown != null){
		savedDocumentMouseDown();
	}
	return ret;
}

function OnInit(){
	for(var j = 0; j < document.forms.length; j ++)	{
		for(var i = 0; i < document.forms[j].elements.length; i ++){
		    if(document.forms[j].elements[i].name != undefined && document.forms[j].elements[i].name.indexOf("YSGridName") != -1){
		        var gridName = document.forms[j].elements[i].value;		        
		        var tr = document.getElementById(document.getElementById(gridName + "FocusedRow").value);
		        if(tr != null){
					document.getElementById(gridName + "SavedColor").value = tr.style.color;
					document.getElementById(gridName + "SavedBkColor").value = tr.style.backgroundColor;
					tr.style.color = document.getElementById(gridName + "SelectedColor").value;
					tr.style.backgroundColor = document.getElementById(gridName + "SelectedBkColor").value;
				}
		    }
		}
	}
}

function window_OnLoad(){
	clearDragState();
    clearColumnSizingState();
    clearResizingCursor();
    clearHotTrackState();
	savedDocumentMouseDown = document.onmousedown;
    document.onmousedown = document_OnMouseDown;
    savedDocumentMouseMove = document.onmousemove;
	document.onmousemove = OnMMove;
	savedDocumentMouseUp = document.onmouseup;
	document.onmouseup = OnDHMUp;    
    OnInit();
}

window.onload = function(){
	window_OnLoad();
}