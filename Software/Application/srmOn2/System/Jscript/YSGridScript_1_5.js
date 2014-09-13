/* 
   YSGrid Suite by Developer Express

   Copyright (c) 2000-2003 Developer Express Inc  
   ALL RIGHTS RESERVED

   The entire contents of this file is protected by U.S. and   
   International Copyright Laws. Unauthorized reproduction,     
   reverse-engineering, and distribution of all or any portion of   
   the code contained in this file is strictly prohibited and may  
   result in severe civil and criminal penalties and will be        
   prosecuted to the maximum extent possible under the law.
*/

leftBtnPressed = 1;
columnSizingEdge = 5;

function clearColumnSizingState(){
	curGridName = "";
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

function fillKeyState(gridName){
	document.all(gridName + "ShiftPressed").value = event.shiftKey;
	document.all(gridName + "CtrlPressed").value = event.ctrlKey;
}

function isScrollableElement(curEl){
	return curEl.style.overflow == "scroll" || curEl.style.overflowX == "scroll" || curEl.style.overflowY == "scroll" || curEl.style.overflow == "auto" || curEl.style.overflowX == "auto" || curEl.style.overflowY == "auto";
}

function isStaticElement(curEl){
	return !(curEl.style.position == "absolute" || curEl.style.position == "relative" || isScrollableElement(curEl));
}

function absoluteX(curEl, gridName, correctPos, correctionNeeded){
    var posX = 0;
    if(curEl != null){
		if(curEl.offsetParent != null){		
			var nestedCorrectPos = correctionNeeded && (correctPos || curEl.id == gridName + "Table");
			posX = absoluteX(curEl.offsetParent, gridName, nestedCorrectPos, correctionNeeded);
			if(curEl.clientWidth != 0 && (!correctPos || isStaticElement(curEl))) 
				posX += curEl.offsetLeft;
			if(!correctPos && isScrollableElement(curEl))
				posX -= curEl.scrollLeft;
		}
		else{
			posX = curEl.offsetLeft;
		}
	}
    return posX;
}

function absoluteY(curEl, gridName, correctPos){
    var posY = 0;    
    if(curEl.offsetParent != null){
		var nestedCorrectPos = correctPos || curEl.id == gridName + "Table";
		posY = absoluteY(curEl.offsetParent, gridName, nestedCorrectPos);
        if(curEl.clientHeight != 0 && (!correctPos || isStaticElement(curEl))) 
            posY += curEl.offsetTop;
        if(!correctPos && isScrollableElement(curEl))
			posY -= curEl.scrollTop;
    }
    else{
        posY = curEl.offsetTop;
    }
    return posY;
}

function showDragHeader(header, drgHdr, isGrouped, gridName, borderCollapse){
	drgHdr.style.visibility = "visible";					
	drgHdr.style.posLeft = absoluteX(header, gridName, false, true) + (isGrouped && borderCollapse ? 0 : 1);
	drgHdr.style.posTop = absoluteY(header, gridName, false) + (isGrouped && borderCollapse ? 0 : 1);			
	var align = header.align;
	if(align == "")
		align = header.parentElement.align;
	drgHdr.align = align;					
	var savedBorderColor = drgHdr.children[0].style.borderColor;
	drgHdr.innerHTML = header.innerHTML;					
	drgHdr.children[0].style.borderColor = savedBorderColor;
	drgHdr.style.posWidth = header.offsetWidth - (isGrouped ? 0 : (borderCollapse ? 1 : 2)); 
	drgHdr.style.posHeight = header.offsetHeight - (isGrouped ? 0 : (borderCollapse ? 1 : 2)); 
}

function startDragHeader(gridName, header, hdrInd, isGrouped, borderCollapse){
	try{
		while(header != null && (header.tagName != "TD" || header.id == "")){
			header = header.parentElement;
		}		
		if(header != null){
			var drgHdr = document.all(gridName + "~DH~" + hdrInd);						
			CheckPageSizeEdit(gridName);									
			endHotTrack();
			showDragHeader(header, drgHdr, isGrouped, gridName, borderCollapse);	
			curGridName = gridName;
			curColInd = hdrInd;
			curX = (event.clientX + document.body.scrollLeft);
			curY = (event.clientY + document.body.scrollTop);		
			curDragEl = drgHdr;
			curDragAct = (isGrouped) ? 10001 : 10000;				
			curArrUp = document.all(gridName + "arrowup");		
			curArrDown = document.all(gridName + "arrowdown"); 			
		}		
	}
	catch(e){
	}
}

function startColumnSizing(gridName, gridObj, header){
	curSzLn = document.all(gridName + "sizerline");		
	if(curSzLn != null){
		endHotTrack();
		curGridName = gridName;		
		curDragAct = 10000;		
		curX = (event.clientX + document.body.scrollLeft) - absoluteX(curSzLn.offsetParent, gridName, false, true) - 2;
		curSzLn.style.cursor = "e-resize";
		curSzLn.style.visibility = "visible";		
		curSzLn.style.posLeft = curX;
		curSzLn.style.posTop = absoluteY(header, gridName, false);
		curSzLn.style.posWidth = 1; 
		var scroller = document.all(gridName + "scroller");
		if(scroller != null)
			curSzLn.style.posHeight = scroller.offsetHeight; 
		else
			curSzLn.style.posHeight = gridObj.GetRowsHeight(header.parentElement.parentElement); 
	}
}

function endColumnSizing(){
	curSzLn.style.cursor = "default";
	curSzLn.style.visibility = "hidden";
	clearColumnSizingState();
}

function endColumnDragging(){
	curDragEl.style.visibility = "hidden";
	clearDragState();
}

function endHotTrackHdr(){	
	if(hotTrackElement != null){
		hotTrackElement.children[0].style.borderColor = hotTrackSavedBorderColor;
		hotTrackElement.style.visibility = "hidden";
		hotTrackElement.style.posLeft = 0;
		hotTrackElement.style.posTop = 0;			
		clearHotTrackState();		
	}
}

function startHotTrackHdr(header, element, borderColor){	
	if(hotTrackElement != null && hotTrackElement != element)
		endHotTrack();
	if(hotTrackElement == null){		
		hotTrackElement = element;
		hotTrackSavedBorderColor = hotTrackElement.children[0].style.borderColor;
		hotTrackElement.children[0].style.borderColor = borderColor;
		hotTrackHeader = header;
	}
}

function OnTMMove(){
	checkHotTrackHdrCoords();
	if(curSzLn != null){
		if((event.button & leftBtnPressed) != 0){
			newX = (event.clientX + document.body.scrollLeft) - absoluteX(curSzLn.offsetParent, curGridName, false, true) - 2;
			if(newX < curRszHdr.x + curRszHdr.minWidth)
				newX = curRszHdr.x + curRszHdr.minWidth;
			distanceX = (newX - curX);
			if(distanceX != 0){				
				curX = newX;
				curSzLn.style.posLeft += distanceX;
				curDragAct = 4;
			}
		}
		else{
			endColumnSizing();
		}
	}
}

function OnTMUp(){
	if(curSzLn != null){	
		if(curDragAct == 4)
			__doPostBack(replaceDblColon(curGridName), "RESIZECOLUMN:CH:" + curRszHdr.columnIndex + ":" + (curX - curRszHdr.x - curRszHdr.width));
		endColumnSizing();
	}
}

function OnHMMove(){		
	OnHMMoveHT(false, false, "", "");
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

function OnHMMoveHT(hotTrack, flatStyle, color1, color2){		
	if(curSzLn == null && curDragEl == null){
		var header;
		if(hotTrackHeader != null){
			header = hotTrackHeader;
		}
		else{
			header = event.srcElement;
			while(header != null && (header.tagName != "TD" || header.id == "" || header.id.indexOf("~CH~") == -1 && header.id.indexOf("~GH~") == -1 && header.id.indexOf("~DH~") == -1)){
				header = header.parentElement;
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
							var drgHdr = document.all(gridName + "~DH~" + hdrInd)							
							showDragHeader(header, drgHdr, isGrouped, gridName, gridObj.borderCollapse);
							startHotTrackHdr(header, drgHdr, color2);
						}
						else{
							startHotTrackBtn(header.children[0], false, color1, color2)
						}				
					}				
					if(!isGrouped){
						var clientX = event.clientX + document.body.scrollLeft;
						curRszHdr = gridObj.GetResizingHeaderInfo(header, hdrInd, clientX);
						if(curRszHdr != null){
							showResizingCursor(event.srcElement);
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

function OnGBCl(){	
	var header = event.srcElement;
	while(header != null && (header.tagName != "TD" || header.id == "")){
		header = header.parentElement;
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

function OnHMDown(){			
	var header;
	if(hotTrackHeader != null){
		header = hotTrackHeader;
	}
	else{
		header = event.srcElement;
		while(header != null && (header.tagName != "TD" || header.id == "")){
			header = header.parentElement;
		}
	}
	if(header != null && (header.id.indexOf("~CH~") != -1 || header.id.indexOf("~GH~") != -1)){
		var _indexOf = header.id.indexOf("~");
		if(_indexOf != -1){
			var gridName = header.id.substr(0, _indexOf);		
			var hdrInd = header.id.substr(_indexOf + ("~CH~").length, header.id.length);
			var gridObj = __YSGridCollection.Get(gridName);
			if(gridObj != null){
				if(curSizing){
					startColumnSizing(gridName, gridObj, header, hdrInd);
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
						var isGrouped = header.id.indexOf("~GH~") != -1;						
						startDragHeader(gridName, header, hdrInd, isGrouped, gridObj.borderCollapse);
						event.srcElement.onmouseup = OnDHMUp;
						event.cancelBubble = true;	
					}
				}	
			}		
		}
	}
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
    curArrUp.style.posLeft = curArrUpX;    
    curArrUp.style.posTop = curArrUpY;
    curArrDown.style.posLeft = curArrDownX;
    curArrDown.style.posTop = curArrDownY;

    curArrUp.style.visibility = "visible";
    curArrDown.style.visibility = "visible";
}

function hideArrows(){
	if(curArrUp != null)
		curArrUp.style.visibility = "hidden";
	if(curArrDown)
		curArrDown.style.visibility = "hidden";
}

function OnDHMMove(){
	OnHMMoveHT(false, false, "", "");
}

function OnDHMDown(){	
	if(!(event.srcElement.id.indexOf("~GB~") >= 0 || event.srcElement.id.indexOf("~UB~") >= 0 || event.srcElement.parentElement != null && (event.srcElement.parentElement.id.indexOf("~GB~") >= 0 || event.srcElement.parentElement.id.indexOf("~UB~") >= 0)))
		OnHMDown();
}

function OnDHMUp(){	
	try	{
		if(event.srcElement.id.indexOf("~GB~") >= 0 || event.srcElement.id.indexOf("~UB~") >= 0 || event.srcElement.parentElement != null && (event.srcElement.parentElement.id.indexOf("~GB~") >= 0 || event.srcElement.parentElement.id.indexOf("~UB~") >= 0)){
			OnGBCl();
		}
		else{			
			var header = curDragEl;		
			if(header != null){
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
						fillKeyState(curGridName);
						__doPostBack(replaceDblColon(curGridName), "SORT:CH:" + curColInd + ":0");
					}
				}		
				endColumnDragging();
			}
		}
	}
	catch(e){
	}	
}

function checkHotTrackHdrCoords(){
	if(hotTrackHeader != null){
		var headerX = absoluteX(hotTrackHeader);
		var headerY = absoluteY(hotTrackHeader);
		var mouseX = event.clientX + document.body.scrollLeft;
		var mouseY = event.clientY + document.body.scrollTop;
		if(mouseX < headerX || mouseX > headerX + hotTrackHeader.offsetWidth || mouseY < headerY || mouseY > headerY + hotTrackHeader.offsetHeight)
			endHotTrack();
	}
}

function OnDHMOut(){	
	if(curDragEl != null){
		if(!curEnblHdrDrag){
			curDragEl.style.visibility = "hidden";
			clearDragState();
		}
	}
	else{
		checkHotTrackHdrCoords();
	}
}

function OnMMove(gridName){			
	if(curDragEl != null && curEnblHdrDrag){
		var header;
		header = curDragEl;				
		if(curDragAct == 10000)
			curDragAct = 2;
		if(curDragAct == 10001)
			curDragAct = 3;
		newX = (event.clientX + document.body.scrollLeft);
		newY = (event.clientY + document.body.scrollTop);
		distanceX = (newX - curX);
		distanceY = (newY - curY);
		curX = newX;
		curY = newY;

		header.style.pixelLeft += distanceX;
		header.style.pixelTop += distanceY;    

		var gridObj = __YSGridCollection.Get(curGridName);
		curTargetHdr = null;
		if(gridObj != null && curDragAct == 2 && curEnblClmnMove || curDragAct == 3 && curEnblGroup)
			curTargetHdr = gridObj.GetTargetHeaderInfo(header.offsetLeft + header.offsetWidth / 2, header.offsetTop + header.offsetHeight / 2, curColInd);
		if(curTargetHdr == null && curEnblGroup && gridObj != null)
			curTargetHdr = gridObj.GetTargetGroupedHeaderInfo(header.offsetLeft + header.offsetWidth / 2, header.offsetTop + header.offsetHeight / 2, curColInd);
		if(curShowArr){				
			updateArrowsPos(gridObj.arrowImgWidth);				
			if(curTargetHdr == null)
				hideArrows();
			else
				showArrows();				
		}		
		return false;
	}
	else{
		if(savedDocumentMouseMove != null)
			return savedDocumentMouseMove();
	}
	return true;
}

function OnEBCl(){		
	event.cancelBubble = true;	
	var button = event.srcElement;
	while(button != null && (button.tagName != "TD" || button.id == "")){
		button = button.parentElement;
	}
	if(button != null){
		var _indexOf = button.id.indexOf("~");
		if(_indexOf != -1){
			var gridName = button.id.substr(0, _indexOf);		
			var gridObj = __YSGridCollection.Get(gridName);
			if(gridObj != null && gridObj.rowsExpanded != null && gridObj.controlMode == "Browse")
				gridObj.ProcessExpBtn(button);	
			else
				__doPostBack(replaceDblColon(gridName), "EXPAND:EB:" + button.id + ":0");
		}
	}
}

function OnRBNoneCl(){
	event.cancelBubble = true;	
}

function rbGetButton(){
	var button = event.srcElement;
	while(button != null && (button.tagName != "TD" || button.id == "")){
		button = button.parentElement;
	}
	return button;
}

function rbGetGridName(button){
	var _indexOf = button.id.indexOf("~");
	if(_indexOf != -1)
		return button.id.substr(0, _indexOf);			
	return "";
}

function OnRBInsCl(){
	event.cancelBubble = true;	
	var button = rbGetButton();
	if(button != null){
		var gridName = rbGetGridName(button);			
		var gridObj = __YSGridCollection.Get(gridName);
		if(gridObj != null && !gridObj.readOnly && gridObj.allowInsert)
			__doPostBack(replaceDblColon(gridName), "INSERT:RB:" + button.id + ":0");
	}
}

function OnRBAppCl(){
	event.cancelBubble = true;	
	var button = rbGetButton();
	if(button != null){
		var gridName = rbGetGridName(button);			
		var gridObj = __YSGridCollection.Get(gridName);
		if(gridObj != null && !gridObj.readOnly && gridObj.allowInsert)
			__doPostBack(replaceDblColon(gridName), "APPEND:RB:-1:0");
	}
}

function OnRBEditCl(){
	event.cancelBubble = true;	
	var button = rbGetButton();
	if(button != null){
		var gridName = rbGetGridName(button);
		var gridObj = __YSGridCollection.Get(gridName);
		if(gridObj != null && !gridObj.readOnly && gridObj.allowEdit)
			__doPostBack(replaceDblColon(gridName), "STARTEDIT:RB:" + button.id + ":0");
	}
}

function OnRBCancelCl(){
	event.cancelBubble = true;	
	var button = rbGetButton();
	if(button != null){
		var gridName = rbGetGridName(button);			
		__doPostBack(replaceDblColon(gridName), "CANCELEDIT:RB:0:0");
	}
}

function DoDeleteRow(gridName, rowId, buttonId){
	CheckPageSizeEdit(gridName);		
	var gridObj = __YSGridCollection.Get(gridName);
	if(gridObj != null && gridObj.allowDelete){		
		if(!gridObj.confirmDelete || confirm(gridObj.confirmDeleteMessage))
			__doPostBack(replaceDblColon(gridName), "DELETE:" + (rowId != "-1" ? "RB" : "BB") + ":" + rowId + ":" + buttonId);
	}
}

function OnRBDelCl(){	
	event.cancelBubble = true;	
	var button = rbGetButton();
	if(button != null){
		var gridName = rbGetGridName(button);
		DoDeleteRow(gridName, button.id, "0");
	}
}

function OnRBOkCl(){
	event.cancelBubble = true;	
	var button = rbGetButton();
	if(button != null){
		var gridName = rbGetGridName(button);	
		__doPostBack(replaceDblColon(gridName), "POSTEDIT:RB:0:0");
	}
}

function OnRBMoveToCl(){		
	event.cancelBubble = true;	
	var button = rbGetButton();
	
	if(button != null){
		var gridName = rbGetGridName(button);
		CheckPageSizeEdit(gridName);			
		var gridObj = __YSGridCollection.Get(gridName);
		var rowId = button.id.substr(button.id.indexOf("~") + ("~LI~").length, button.id.length);			
		var tr = document.all(gridName + "~TR~" + rowId);						
		if(tr == null)				
			tr = document.all(gridName + "~GTR~" + rowId);				
		if(tr != null && !(document.all(gridName + "State").value == "Edit" && document.all(gridName + "FocusedRow").value == tr.id)){				
			if(gridObj != null && !gridObj.postBackOnFocusedChanged && document.all(gridName + "State").value != "Edit"){
				gridObj.MoveTo(tr, true, !event.ctrlKey, event.shiftKey);
			}
			else{
				fillKeyState(gridName);
				__doPostBack(replaceDblColon(gridName), "MOVETO:RB:" + tr.id + ":0");
			}
		}
	}
}

function GetRowID(tr){
	var isGroupRow = tr.id.indexOf("~GTR~") != -1;
	var rowId = ((isGroupRow) ? tr.id.substr(tr.id.indexOf("~") + ("~GTR~").length, tr.id.length) : tr.id.substr(tr.id.indexOf("~") + ("~TR~").length, tr.id.length));
	return rowId;
}

function OnTRCl(){
	var td;
	td = event.srcElement;
	if(td.tagName!="TD")
		td=td.parentElement;
	var tr;
	tr = td.parentElement;	
	var _indexOf = tr.id.indexOf("~preview");	
	var previewClicked = false; 
	if(_indexOf != -1){
		tr = document.all(tr.id.substr(0, _indexOf));		
		previewClicked = true;
	}
	_indexOf = tr.id.indexOf("~");	
	if(_indexOf != -1){
		var gridName = tr.id.substr(0, _indexOf);		
		CheckPageSizeEdit(gridName);
		var gridObj = __YSGridCollection.Get(gridName);		
		if(gridObj != null){
			try{				
				if(!(document.all(gridName + "State").value == "Edit" && document.all(gridName + "FocusedRow").value == tr.id)){
					if(document.all(gridName + "State").value == "Edit"){
						__doPostBack(replaceDblColon(gridName), "MOVETO:RR:" + tr.id + ":0");
						return;
					}					
					var isGroupRow = tr.id.indexOf("~GTR~") != -1;					
					if(document.all(gridName + "FocusedRow").value == tr.id && (!gridObj.multiSelection || !event.ctrlKey) && !previewClicked){
						if(gridObj.postBackOnRowDblClick){
							if(isGroupRow){
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
							gridObj.MoveTo(tr, true, !event.ctrlKey, event.shiftKey);
						}
						else{
							fillKeyState(gridName);
							__doPostBack(replaceDblColon(gridName), "MOVETO:RR:" + tr.id + ":0");						
						}
					}	
				}
			}
			catch(e){
			}	
		}
	}
}

function MoveBy(gridName, direction, buttonId){
	CheckPageSizeEdit(gridName);
	var gridObj = __YSGridCollection.Get(gridName);
	if(gridObj != null && document.all(gridName + "State").value != "Edit" && !gridObj.postBackOnFocusedChanged){
		try{
			var newtrId = gridObj.MoveBy(direction, event.ctrlKey, event.shiftKey);
			if(newtrId != "")
				return;
		}
		catch(e){
		}
	}
	fillKeyState(gridName);
	__doPostBack(replaceDblColon(gridName), ((direction) ? "NEXT" : "PREV") + ":BB:0:" + buttonId);
}

function OnBBFirstCl(gridName, buttonId){
	fillKeyState(gridName);
	__doPostBack(replaceDblColon(gridName), "FIRST:BB:0:" + buttonId);
}

function OnBBPrevPageCl(gridName, buttonId){
	fillKeyState(gridName);
	__doPostBack(replaceDblColon(gridName), "PREVPAGE:BB:0:" + buttonId);
}

function OnBBPrevCl(gridName, buttonId){
	MoveBy(gridName, false, buttonId);	
}

function OnBBNextCl(gridName, buttonId){
	MoveBy(gridName, true, buttonId);	
}

function OnBBNextPageCl(gridName, buttonId){	
	fillKeyState(gridName);
	__doPostBack(replaceDblColon(gridName), "NEXTPAGE:BB:0:" + buttonId);
}

function OnBBLastCl(gridName, buttonId){
	fillKeyState(gridName);
	__doPostBack(replaceDblColon(gridName), "LAST:BB:0:" + buttonId);
}

function CancelPageSize(gridName){
	try	{		
		var gridObj = __YSGridCollection.Get(gridName);
		if(gridObj != null){
			gridObj.CancelPageSize();		
		}
		document.all(gridName + "State").value = "";
	}
	catch(e){
	}	
}

function ApplyPageSize(gridName, buttonId){
	var reg = /^[0-9]+$/;
	if(!reg.test(document.all(gridName + "PageSizeEdit" + buttonId).value))
		alert("The size of page must be an integer number");
	else
		__doPostBack(replaceDblColon(gridName), "CHANGEPAGESIZE:BB:" + document.all(gridName + "PageSizeEdit" + buttonId).value + ":" + buttonId);
}

function CheckPageSizeEdit(gridName){
	if(document.all(gridName + "State").value == "ChangingPageSize")
		CancelPageSize(gridName);
}

function OnBBChPSCl(gridName, buttonId){
	try	{	
		var gridObj = __YSGridCollection.Get(gridName);
		if(gridObj != null){			
			if(document.all(gridName + "State").value == "ChangingPageSize" && gridObj.pageSizeButtonId == buttonId){
				ApplyPageSize(gridName, buttonId);
			}
			else{			
				CheckPageSizeEdit(gridName);			
				gridObj.EditPageSize(event.srcElement, buttonId);
				document.all(gridName + "State").value = "ChangingPageSize";
			}
		}
	}
	catch(e){
	}
}

function OnEChPgSzKPrs(gridName, buttonId){
	if(event.keyCode == 27)
		CancelPageSize(gridName);
	if(event.keyCode == 13){
		ApplyPageSize(gridName, buttonId);	
		return false;
	}
	return true;
}

function OnBBInsCl(gridName, buttonId){		
	var gridObj = __YSGridCollection.Get(gridName);
	if(gridObj != null && !gridObj.readOnly && gridObj.allowInsert)
		__doPostBack(replaceDblColon(gridName), "INSERT:BB:-1:" + buttonId);
}

function OnBBAppCl(gridName, buttonId){		
	var gridObj = __YSGridCollection.Get(gridName);
	if(gridObj != null && !gridObj.readOnly && gridObj.allowInsert)
		__doPostBack(replaceDblColon(gridName), "APPEND:BB:-1:" + buttonId);
}

function OnBBEditCl(gridName, buttonId){		
	var gridObj = __YSGridCollection.Get(gridName);		
	if(gridObj != null && !gridObj.readOnly && gridObj.allowEdit)
		__doPostBack(replaceDblColon(gridName), "STARTEDIT:BB:-1:" + buttonId);
}

function OnBBDelCl(gridName, buttonId){
	DoDeleteRow(gridName, "-1", buttonId);	
}

function OnBBRefreshCl(gridName, buttonId){
	__doPostBack(replaceDblColon(gridName), "REFRESH:BB:0:" + buttonId);
}

function OnBBOkCl(gridName, buttonId){
	__doPostBack(replaceDblColon(gridName), "POSTEDIT:BB:0:" + buttonId);
}

function OnBBCancelCl(gridName, buttonId){
	__doPostBack(replaceDblColon(gridName), "CANCELEDIT:BB:0:" + buttonId);
}

function OnEGoToPgKPrs(gridName, buttonId){
	if(event.keyCode == 13){
		OnBBGoToPageCl(gridName, buttonId);
		return false;
	}
	return true;
}

function OnBBGoToPageCl(gridName, buttonId){	
	__doPostBack(replaceDblColon(gridName), "GOTOPAGE:BB:" + document.all(gridName + "GoToPageEdit" + buttonId).value + ":" + buttonId);
}

function OnBBGoToPageIndCl(gridName, pageIndex, buttonId){	
	__doPostBack(replaceDblColon(gridName), "GOTOPAGE:PI:" + pageIndex + ":" + buttonId);
}

function OnBBSelPgCh(select, gridName, buttonId){
	__doPostBack(replaceDblColon(gridName), "GOTOPAGE:BB:" + select.value + ":" + buttonId);
}

function OnBBSrchCl(gridName, buttonId){
	var edit = document.all(gridName + "SearchEdit" + buttonId)
	if(edit != null){
		if(edit.value != "")
			__doPostBack(replaceDblColon(gridName), "SEARCH:BB:" + document.all(gridName + "SearchSelect" + buttonId).value + ":" + edit.value);
		else
			edit.focus();
	}	
}

function OnBBCustom(gridName, buttonId){	
	__doPostBack(replaceDblColon(gridName), "CUSTOM:BB:0:" + buttonId);
}

function OnESrchKPrs(gridName, buttonId){
	if(event.keyCode == 13){
		__doPostBack(replaceDblColon(gridName), "SEARCH:BB:" + document.all(gridName + "SearchSelect" + buttonId).value + ":" + document.all(gridName + "SearchEdit" + buttonId).value);
		return false;
	}
	return true;
}

function OnSBCl(gridName, columnIndex){
	var edit = document.all(gridName + "SearchEdit" + columnIndex);
	if(edit != null){
		if(edit.value != "")
			__doPostBack(replaceDblColon(gridName), "SEARCH:SB:" + columnIndex + ":" + edit.value);
		else
			edit.focus();
	}
}

function OnSBEKPrs(gridName, columnIndex){
	if(event.keyCode == 13){
		__doPostBack(replaceDblColon(gridName), "SEARCH:SB:" + columnIndex + ":" + document.all(gridName + "SearchEdit" + columnIndex).value);
		return false;
	}
	return true;
}

function OnScroll(gridName){	
	var scrollLeftInput = document.all(gridName + "ScrollLeft");
	if(scrollLeftInput != null)
		scrollLeftInput.value = document.all(gridName + "scroller").scrollLeft;
	var scrollTopInput = document.all(gridName + "ScrollTop");
	if(scrollTopInput != null)
		scrollTopInput.value = document.all(gridName + "scroller").scrollTop;
}

function endHotTrackBtn(){
	if(hotTrackElement != null){
		hotTrackElement.style.backgroundColor = hotTrackSavedBackColor;
		hotTrackElement.style.borderColor = hotTrackSavedBorderColor;
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


function OnBMMove(flatStyle, color1, color2){
	var button = event.srcElement;
	while(button != null && button.tagName != "TD"){
		button = button.parentElement;
	}
	startHotTrackBtn(button, flatStyle, color1, color2);
}

function OnBMOut(){
	endHotTrack();
}

var savedDocumentMouseMoveAssigned;
if(!savedDocumentMouseMoveAssigned){
	savedDocumentMouseMoveAssigned = true;
	savedDocumentMouseMove = document.onmousemove;
	document.onmousemove = OnMMove;
}
else{
	if(__YSGridCollection != null)
		__YSGridCollection.Clear();
}
clearDragState();
clearResizingCursor();
clearColumnSizingState();
clearHotTrackState();