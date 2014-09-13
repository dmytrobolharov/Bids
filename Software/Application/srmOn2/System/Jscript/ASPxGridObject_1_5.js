/* 
   ASPxGrid Suite by Developer Express

   Copyright (c) 2000-2003 Developer Express Inc  
   ALL RIGHTS RESERVED

   The entire contents of this file is protected by U.S. and   
   International Copyright Laws. Unauthorized reproduction,     
   reverse-engineering, and distribution of all or any portion of   
   the code contained in this file is strictly prohibited and may  
   result in severe civil and criminal penalties and will be        
   prosecuted to the maximum extent possible under the law.
*/

function ASPxGridObject(name){
	this.name = name;	
	this.clientSide = false;	
	this.pageSize = 0;	
	this.rowCount = 0;	
	this.offsetX = 0;
	this.offsetY = 0;
	this.selectedBackColor = "";
	this.selectedForeColor = "";
	this.focusedBorderStyle = "";
	this.focusedBorderColor = "";
	this.savedCellsColors = new Array();
	this.savedCellsTopBorders = new Array();
	this.savedCellsBottomBorders = new Array();
	this.columnsInfo = new Array();
	this.groupColumns = new Array(); 
	this.visibleColumns = new Array(); 
	this.focusedIndex = -1;
	this.firstRowIndex = 0;
	this.focusedTR = null;
	this.arrowImgWidth = 0;
	this.pageSizeImg = null;
	this.pageSizeButtonId = "";
	this.rowsExpanded = null;
	this.rowsSelected = null;
	this.savedSelectedColors = null;
	this.selectedRows = null;
	this.firstGroupIndentOffset = 0;
	this.controlMode = "Browse";
	this.borderCollapse = true;	
	this.multiSelection = false;
	this.showPreview = false;
	
	this.showGroupPanel = true;
	this.showFooter = false;
	this.statusBarCount = 0;
	
	this.showFocusedBorder = false;
	this.showArrowsOnDragging = true;
	this.postBackOnFocusedChanged = false;
	this.postBackOnRowDblClick = true;
	
	this.readOnly = false;
	this.allowInsert = true;
	this.allowEdit = true;
	this.allowDelete = true;
	this.confirmDelete = true;
	this.confirmDeleteMessage = "Delete record?";
	
	this.img1x1 = "";
	this.imgIndicator = "";
	this.imgEBExpand = "";
	this.imgEBCollapse = "";
	this.imgNBOk = "";
	this.imgNBChPS = "";	
	
	this.InitializeSelection = ASPxGridObject.InitializeSelection;
	this.HideSelection = ASPxGridObject.HideSelection;
	this.ShowSelection = ASPxGridObject.ShowSelection;	
	this.GetTopRowLevel = ASPxGridObject.GetTopRowLevel;
	this.HideFocus = ASPxGridObject.HideFocus;
	this.ShowFocus = ASPxGridObject.ShowFocus;
	this.SetFocusedRowBorder = ASPxGridObject.SetFocusedRowBorder;
	this.RestoreFocusedRowBorder = ASPxGridObject.RestoreFocusedRowBorder;
	this.InvertRowSelection = ASPxGridObject.InvertRowSelection;
	this.FillSelectedInput = ASPxGridObject.FillSelectedInput;
	this.ClearSelection = ASPxGridObject.ClearSelection;
	this.MoveTo = ASPxGridObject.MoveTo;
	this.MoveBy = ASPxGridObject.MoveBy;
	this.GetTargetHeaderInfo = ASPxGridObject.GetTargetHeaderInfo;
	this.GetTargetGroupedHeaderInfo = ASPxGridObject.GetTargetGroupedHeaderInfo;
	this.EditPageSize = ASPxGridObject.EditPageSize;
	this.CancelPageSize = ASPxGridObject.CancelPageSize;	
	this.GetColumnByIndex = ASPxGridObject.GetColumnByIndex;	
	this.GetRowsHeight = ASPxGridObject.GetRowsHeight;	
	this.GetResizingHeaderInfo = ASPxGridObject.GetResizingHeaderInfo;
	this.ProcessExpBtn = ASPxGridObject.ProcessExpBtn;
	this.ProcessExpTR = ASPxGridObject.ProcessExpTR;
	this.GetRowLevel = ASPxGridObject.GetRowLevel;	
	this.FillExpandedInput = ASPxGridObject.FillExpandedInput;		
	this.SetChildrenVisible = ASPxGridObject.SetChildrenVisible;			
}

function CellColor(foreColor, backColor){
	this.foreColor = foreColor;
	this.backColor = backColor;
}

function CellBorder(style, color){
	this.style = style;
	this.color = color;
}

function ASPxGridColumn(index, type){
	this.index = index;
	this.type = type;
}

function ASPxGridColumnInfo(index, minWidth, enableHeaderClick, enableHeaderDragging, enableGrouping, enableColumnMoving, enableColumnSizing){
	this.index = index;
	this.minWidth = minWidth;
	
	this.enableHeaderClick = enableHeaderClick;
	this.enableHeaderDragging = enableHeaderDragging;
	this.enableGrouping = enableGrouping;
	this.enableColumnMoving = enableColumnMoving;		
	this.enableColumnSizing = enableColumnSizing;
}

function ArrayClear(array){
	while(array.length > 0){
		array.pop();
	}
}

function ArrayIndexOf(array, item){
	for(var i = 0; i < array.length; i ++){
		if(array[i] == item)
			return i;
	}
	return -1;
}

function ArrayRemove(array, element){
	for(var i = 0; i < array.length; i++){
		if(array[i] == element){
			for(var j = i; j < array.length - 1; j++){
				array[j] = array[j + 1];
			}
			array.pop();
			return;
		}
	}
}

ASPxGridObject.InitializeSelection = function(){	
	for(var i = 0; i < this.selectedRows.length; i ++){
		var tr = document.getElementById(this.selectedRows[i]);
		if(tr != null)
			this.InvertRowSelection(tr, false, false, false);
	}
	this.FillSelectedInput();
}

ASPxGridObject.SetIndicatorFocused = function(td){
	var img = td.firstChild.rows[0].cells[0].firstChild;
	if(img != null && img.tagName == "IMG")
		img.src = this.imgIndicator;
}

ASPxGridObject.SetIndicatorUnfocused = function(td){
	var img = td.firstChild.rows[0].cells[0].firstChild;
	if(img != null && img.tagName == "IMG")
		img.src = this.img1x1;
}

ASPxGridObject.HideSelection = function(tr, rowIndex){		
	var rowLevel = this.GetRowLevel(tr);
	var restoringArray = this.multiSelection ? this.savedSelectedColors[rowIndex] : this.savedCellsColors;
	if(rowLevel < this.groupColumns.length){
		var offset = 1;
		while(this.visibleColumns[this.visibleColumns.length - offset].type == "RowBtnColumn")
			offset ++;
		var cell = tr.cells[tr.cells.length - offset];
		cell.style.color = restoringArray[0].foreColor;
		cell.style.backgroundColor = restoringArray[0].backColor;		
	}
	else{		
		var dataColumnIndex = 0;
		for(var i = 0; i < this.visibleColumns.length; i ++){
			if(this.visibleColumns[i].type == "DataColumn" || this.visibleColumns[i].type == "TemplateColumn"){
				tr.cells[i].style.color = restoringArray[dataColumnIndex].foreColor;
				tr.cells[i].style.backgroundColor = restoringArray[dataColumnIndex].backColor;
				dataColumnIndex ++;
			}
		}
	}
	ArrayClear(restoringArray);
}

ASPxGridObject.ShowSelection = function(tr, rowIndex){	
	var rowLevel = this.GetRowLevel(tr);	
	var savingArray = this.savedCellsColors;
	if(this.multiSelection){
		savingArray = new Array();
		this.savedSelectedColors[rowIndex] = savingArray;
	}
	if(rowLevel < this.groupColumns.length){				
		var offset = 1;
		while(this.visibleColumns[this.visibleColumns.length - offset].type == "RowBtnColumn")
			offset ++;		
		var cell = tr.cells[tr.cells.length - offset];
		savingArray.push(new CellColor(cell.style.color, cell.style.backgroundColor));
		cell.style.color = this.selectedForeColor;
		cell.style.backgroundColor = this.selectedBackColor;
	}
	else{					
		for(var i = 0; i < this.visibleColumns.length; i ++){
			if(this.visibleColumns[i].type == "DataColumn" || this.visibleColumns[i].type == "TemplateColumn"){			
				savingArray.push(new CellColor(tr.cells[i].style.color, tr.cells[i].style.backgroundColor));
				tr.cells[i].style.color = this.selectedForeColor;
				tr.cells[i].style.backgroundColor = this.selectedBackColor;
			}	
		}
	}	
}

ASPxGridObject.RestoreFocusedRowBorder = function(tr, rowLevel, topBorder, saveLeftRight, savingArray){	
	if(rowLevel < this.groupColumns.length && rowLevel != -2){				
		var offset = 1;
		if(rowLevel != -1){
			while(this.visibleColumns[this.visibleColumns.length - offset].type == "RowBtnColumn")
				offset ++;
		}
		var savingArrayOffset = 0;
		var cell = tr.cells[tr.cells.length - offset];
		if(saveLeftRight){
			cell.style.borderLeftStyle = savingArray[savingArrayOffset].style;
			cell.style.borderLeftColor = savingArray[savingArrayOffset].color;		
			savingArrayOffset ++;
		}
		if(topBorder){
			cell.style.borderTopStyle = savingArray[savingArrayOffset].style;
			cell.style.borderTopColor = savingArray[savingArrayOffset].color;		
		}
		else{
			cell.style.borderBottomStyle = savingArray[savingArrayOffset].style;
			cell.style.borderBottomColor = savingArray[savingArrayOffset].color;		
		}
		if(saveLeftRight){
			savingArrayOffset ++;
			cell.style.borderRightStyle = savingArray[savingArrayOffset].style;
			cell.style.borderRightColor = savingArray[savingArrayOffset].color;					
		}
	}
	else{		
		var dataColInd = 0;
		var firstColumn = true;
		var savingArrayOffset = 0;
		var lastColInd = -1;
		var curColInd = 0;
		for(var i = 0; i < this.visibleColumns.length; i ++){
			if(this.visibleColumns[i].type == "DataColumn" || this.visibleColumns[i].type == "TemplateColumn"){
				var cell = tr.cells[curColInd];
				if(saveLeftRight && firstColumn){
					cell.style.borderLeftStyle = savingArray[dataColInd + savingArrayOffset].style;
					cell.style.borderLeftColor = savingArray[dataColInd + savingArrayOffset].color;		
					firstColumn = false;
					savingArrayOffset ++;
				}
				if(topBorder){
					cell.style.borderTopStyle = savingArray[dataColInd + savingArrayOffset].style;
					cell.style.borderTopColor = savingArray[dataColInd + savingArrayOffset].color;					
				}
				else{
					cell.style.borderBottomStyle = savingArray[dataColInd + savingArrayOffset].style;
					cell.style.borderBottomColor = savingArray[dataColInd + savingArrayOffset].color;
				}
				dataColInd ++;
				lastColInd = curColInd;
			}
			if(rowLevel != -2 || this.visibleColumns[i].type != "IndentColumn")
				curColInd ++;
		}
		if(saveLeftRight && lastColInd >= 0){
			tr.cells[lastColInd].style.borderRightStyle = savingArray[dataColInd + savingArrayOffset].style;
			tr.cells[lastColInd].style.borderRightColor = savingArray[dataColInd + savingArrayOffset].color;
		}
	}
}

ASPxGridObject.SetFocusedRowBorder = function(tr, rowLevel, topBorder, saveLeftRight, savingArray){	
	if(rowLevel < this.groupColumns.length && rowLevel != -2){
		var offset = 1;
		if(rowLevel != -1){
			while(this.visibleColumns[this.visibleColumns.length - offset].type == "RowBtnColumn")
				offset ++;
		}	
		var cell = tr.cells[tr.cells.length - offset];
		if(saveLeftRight){
			savingArray.push(new CellBorder(cell.style.borderLeftStyle, cell.style.borderLeftColor));
			cell.style.borderLeftStyle = this.focusedBorderStyle;
			cell.style.borderLeftColor = this.focusedBorderColor;
		}
		if(topBorder){
			savingArray.push(new CellBorder(cell.style.borderTopStyle, cell.style.borderTopColor));
			cell.style.borderTopStyle = this.focusedBorderStyle;
			cell.style.borderTopColor = this.focusedBorderColor;
		}
		else{
			savingArray.push(new CellBorder(cell.style.borderBottomStyle, cell.style.borderBottomColor));
			cell.style.borderBottomStyle = this.focusedBorderStyle;
			cell.style.borderBottomColor = this.focusedBorderColor;
		}
		if(saveLeftRight){
			savingArray.push(new CellBorder(cell.style.borderRightStyle, cell.style.borderRightColor));
			cell.style.borderRightStyle = this.focusedBorderStyle;
			cell.style.borderRightColor = this.focusedBorderColor;
		}
	}
	else{
		var firstColumn = true;		
		var lastColInd = -1;			
		var curColInd = 0;
		for(var i = 0; i < this.visibleColumns.length; i ++){			
			if(this.visibleColumns[i].type == "DataColumn" || this.visibleColumns[i].type == "TemplateColumn"){			
				var cell = tr.cells[curColInd];
				if(saveLeftRight && firstColumn){
					savingArray.push(new CellBorder(cell.style.borderLeftStyle, cell.style.borderLeftColor));
					cell.style.borderLeftStyle = this.focusedBorderStyle;
					cell.style.borderLeftColor = this.focusedBorderColor;
					firstColumn = false;
				}
				if(topBorder){
					savingArray.push(new CellBorder(cell.style.borderTopStyle, cell.style.borderTopColor));
					cell.style.borderTopStyle = this.focusedBorderStyle;
					cell.style.borderTopColor = this.focusedBorderColor;
				}
				else{
					savingArray.push(new CellBorder(cell.style.borderBottomStyle, cell.style.borderBottomColor));
					cell.style.borderBottomStyle = this.focusedBorderStyle;
					cell.style.borderBottomColor = this.focusedBorderColor;
				}
				lastColInd = curColInd;
			}	
			if(rowLevel != -2 || this.visibleColumns[i].type != "IndentColumn")
				curColInd ++;
		}
		if(saveLeftRight && lastColInd >= 0){
			savingArray.push(new CellBorder(tr.cells[lastColInd].style.borderRightStyle, tr.cells[lastColInd].style.borderRightColor));
			tr.cells[lastColInd].style.borderRightStyle = this.focusedBorderStyle;
			tr.cells[lastColInd].style.borderRightColor = this.focusedBorderColor;
		}
	}
}

ASPxGridObject.GetTopRowLevel = function(topBorderTR){
	if(ArrayIndexOf(topBorderTR.parentNode.childNodes, topBorderTR) < this.firstRowIndex)
		return -2;
	else if(topBorderTR.id.indexOf("~preview") >= 0)
		return -1;
	else	
		return this.GetRowLevel(topBorderTR);
}

ASPxGridObject.HideFocus = function(tr){		
	if(this.visibleColumns[0].type == "IndicatorColumn")			
		this.SetIndicatorUnfocused(tr.cells[0]);		
	
	if(this.showFocusedBorder){
		var rowLevel = this.GetRowLevel(tr);
		this.RestoreFocusedRowBorder(tr, rowLevel, false, true, this.savedCellsBottomBorders);
		if(this.borderCollapse){
			var topBorderTR = tr.previousSibling;
			if(topBorderTR != null)
				this.RestoreFocusedRowBorder(topBorderTR, this.GetTopRowLevel(topBorderTR), false, false, this.savedCellsTopBorders);
		}
		else{
			this.RestoreFocusedRowBorder(tr, rowLevel, true, false, this.savedCellsTopBorders);
		}
		
		ArrayClear(this.savedCellsTopBorders);
		ArrayClear(this.savedCellsBottomBorders);
	}
}

ASPxGridObject.ShowFocus = function(tr){	
	var rowLevel = this.GetRowLevel(tr);	
	if(this.visibleColumns[0].type == "IndicatorColumn")			
		this.SetIndicatorFocused(tr.cells[0]);			
	
	if(this.showFocusedBorder){
		this.SetFocusedRowBorder(tr, rowLevel, false, true, this.savedCellsBottomBorders);	
		if(this.borderCollapse){
			var topBorderTR = tr.previousSibling;
			if(topBorderTR != null)		
				this.SetFocusedRowBorder(topBorderTR, this.GetTopRowLevel(topBorderTR), false, false, this.savedCellsTopBorders);
		}
		else{
			this.SetFocusedRowBorder(tr, rowLevel, true, false, this.savedCellsTopBorders);
		}
	}
	
	var scroller = document.getElementById(this.name + "scroller");
	if(scroller != null && tr.offsetTop + tr.offsetHeight > scroller.scrollTop + scroller.clientHeight)
		scroller.scrollTop = tr.offsetTop + tr.offsetHeight - scroller.clientHeight;
	if(scroller != null && tr.offsetTop < scroller.scrollTop)
		scroller.scrollTop = tr.offsetTop;
}

ASPxGridObject.InvertRowSelection = function(tr, value, applyValue, synchronize){
	var rowIndex = ArrayIndexOf(tr.parentNode.childNodes, tr) - this.firstRowIndex;	
	if(!applyValue || this.rowsSelected[rowIndex] != value){
		this.rowsSelected[rowIndex] = !this.rowsSelected[rowIndex];
		if(this.rowsSelected[rowIndex]){		
			if(synchronize)
				this.selectedRows.push(tr.id);
			this.ShowSelection(tr, rowIndex);		
		}
		else{
			if(synchronize)
				ArrayRemove(this.selectedRows, tr.id);
			this.HideSelection(tr, rowIndex);	
		}
		if(synchronize)
			this.FillSelectedInput();
	}
}

ASPxGridObject.ClearSelection = function(rowsCollection){
	for(var i = 0; i < this.rowsSelected.length; i ++){
		if(this.rowsSelected[i]){
			this.InvertRowSelection(rowsCollection[i + this.firstRowIndex], false, false, false);
		}
	}
	ArrayClear(this.selectedRows);
	this.FillSelectedInput();
}

ASPxGridObject.FillSelectedInput = function(){	
	var input = document.getElementById(this.name + "SelectedRows");	
	if(input != null){
		input.value = "";
		for(var i = 0; i < this.selectedRows.length; i ++){
			if(input.value != "")
				input.value += ";";
			input.value += this.selectedRows[i];	
		}
	}	
}

ASPxGridObject.MoveTo = function(tr, changeSelection, clearPrevSelection, selectRange){
	if(tr != this.focusedTR){		
		var rowsCollection = tr.parentNode.childNodes;
		if(this.focusedTR != null){
			this.HideFocus(this.focusedTR);			
			if(this.multiSelection){
				if(clearPrevSelection)
					this.ClearSelection(rowsCollection);
			}
			else{
				this.HideSelection(this.focusedTR, this.focusedIndex - this.firstRowIndex);	
			}
		}
		var prevFocusedIndex = this.focusedIndex;		
		this.focusedTR = tr;	
		this.focusedIndex = ArrayIndexOf(rowsCollection, tr);		
		if(this.multiSelection && selectRange && prevFocusedIndex >= 0 && this.focusedIndex >= 0){
			var firstIndex = prevFocusedIndex < this.focusedIndex ? prevFocusedIndex : this.focusedIndex;
			var lastIndex = prevFocusedIndex < this.focusedIndex ? this.focusedIndex + 1 : prevFocusedIndex + 1;
			for(var i = firstIndex; i < lastIndex; i ++){
				this.InvertRowSelection(rowsCollection[i], true, true, true);
			}
		}
		if(this.focusedTR != null){
			if(this.multiSelection){
				if(changeSelection && !selectRange)
					this.InvertRowSelection(this.focusedTR, false, false, true);
			}
			else{
				this.ShowSelection(this.focusedTR, this.focusedIndex - this.firstRowIndex);	
			}
			this.ShowFocus(this.focusedTR);		
			document.getElementById(this.name + "FocusedRow").value = this.focusedTR.id;
		}
		else
			document.getElementById(this.name + "FocusedRow").value = "";
	}		
	else{
		if(this.multiSelection && !clearPrevSelection && this.focusedTR != null){
			this.InvertRowSelection(this.focusedTR, false, false, true);
		}
	}
}

ASPxGridObject.GetTargetHeaderInfo = function(x, y, currentColIndex){			
	var headerpanel = document.getElementById(this.name + "headerpanel");	
	if(headerpanel != null){
		var headerpanelX = absoluteX(headerpanel, this.name, false, true);		
		var headerpanelY = absoluteY(headerpanel, this.name, false);				
		if(x > headerpanelX && x < headerpanelX + headerpanel.offsetWidth && y > headerpanelY && y < headerpanelY + headerpanel.offsetHeight){
			var targetIndex = 0;			
			var headerIndex = 0;			
			for(var i = 0; i < this.visibleColumns.length; i ++){
				if(this.visibleColumns[i].type != "" && this.visibleColumns[i].type != "IndentColumn"){
					var header = headerpanel.cells[headerIndex];
					if(header != null){
						var headerX = absoluteX(header, this.name, false, true);
						if(x > headerX && x < headerX + header.offsetWidth){
							var before = x <= headerX + header.offsetWidth / 2;
							var targetX = header.offsetLeft + (before ? 0 : header.offsetWidth)
							var scroller = document.getElementById(this.name + "scroller");	
							if((this.visibleColumns[i].type == "DataColumn" || this.visibleColumns[i].type == "TemplateColumn") && (scroller == null || scroller.scrollLeft == null || targetX > scroller.scrollLeft && targetX < scroller.scrollLeft + scroller.offsetWidth)){
								var targetHeaderInfo = new Object();							
								targetHeaderInfo.x = headerX + (before ? 0 : header.offsetWidth);
								targetHeaderInfo.y = absoluteY(header, this.name, false);								
								targetHeaderInfo.height = header.offsetHeight;
								targetHeaderInfo.columnIndex = this.visibleColumns[i].index;							
								targetHeaderInfo.targetIndex = before ? targetIndex : targetIndex + 1;
								targetHeaderInfo.inGroupingPanel = false;
								return targetHeaderInfo;
							}
							else
								return null;
						}
						else{
							if((this.visibleColumns[i].type == "DataColumn" || this.visibleColumns[i].type == "TemplateColumn" || this.visibleColumns[i].type == "RowBtnColumn") && this.visibleColumns[i].index != currentColIndex)
								targetIndex++;							
						}
					}
					headerIndex ++;
				}
			}
		}
	}
	return null;
}

ASPxGridObject.GetTargetGroupedHeaderInfo = function(x, y, currentColIndex){	
	var grouppanel = document.getElementById(this.name + "grouppanel");	
	if(grouppanel != null){		
		var grouppanelX = absoluteX(grouppanel, this.name, false, true);
		var grouppanelY = absoluteY(grouppanel, this.name, false);
		if(x > grouppanelX && x < grouppanelX + grouppanel.offsetWidth && y > grouppanelY && y < grouppanelY + grouppanel.offsetHeight){
			if(this.groupColumns.length == 0){
				var targetHeaderInfo = new Object();
				targetHeaderInfo.x = grouppanelX;
				targetHeaderInfo.y = grouppanelY;
				targetHeaderInfo.height = grouppanel.offsetHeight;
				targetHeaderInfo.columnIndex = -1;
				targetHeaderInfo.targetIndex = 0;
				targetHeaderInfo.inGroupingPanel = true;
				return targetHeaderInfo;				
			}
			else{					
				var targetIndex = 0;
				var groupHeaders = grouppanel.cells[0].firstChild.rows[0].cells[1].firstChild.rows[0];
				for(var i = 0; i < groupHeaders.cells.length; i ++){					
					var header = groupHeaders.cells[i];
					if(header != null){
						var headerX = absoluteX(header, this.name, false, true);
						if((x > headerX && x < headerX + header.offsetWidth) || (i == groupHeaders.cells.length - 1)){
							var before = x <= headerX + header.offsetWidth / 2;
							var targetHeaderInfo = new Object();
							targetHeaderInfo.x = headerX + (before ? 0 : header.offsetWidth);
							targetHeaderInfo.y = absoluteY(header, this.name, false);							
							targetHeaderInfo.height = header.offsetHeight;
							targetHeaderInfo.columnIndex = this.groupColumns[i];
							targetHeaderInfo.targetIndex = before ? targetIndex : targetIndex + 1;
							targetHeaderInfo.inGroupingPanel = true;
							return targetHeaderInfo;
						}
						else{
							if(this.groupColumns[i] != currentColIndex)
								targetIndex++;
						}
					}
				}				
			}
		}
	}
	return null;
}

ASPxGridObject.EditPageSize = function(img, buttonId){	
	var edit;
	edit = document.getElementById(this.name + "PageSizeEdit" + buttonId);
	edit.disabled = false;
	edit.focus();
	if(img.tagName != "IMG")
		img = img.childNodes[0];
	img.src = this.imgNBOk;	
	this.pageSizeImg = img;
	this.pageSizeButtonId = buttonId;
}

ASPxGridObject.CancelPageSize = function(){
	var edit = document.getElementById(this.name + "PageSizeEdit" + this.pageSizeButtonId);
	edit.value = this.pageSize;
	edit.disabled = true;	
	this.pageSizeImg.src = this.imgNBChPS;
	this.pageSizeButtonId = "";
}



ASPxGridObject.MoveBy = function(direction, ctrlKey, shiftKey){
	var newtr = null;
	if(this.focusedIndex >= 0){			
		var oldFocused = document.getElementById(document.getElementById(this.name + "FocusedRow").value);		
		var maxIndex =  this.rowCount + this.firstRowIndex - 1  + (this.showPreview ? this.rowCount - 1 : 0);		
		if(direction && this.focusedIndex < maxIndex){
			newtr = oldFocused;
			do{
				newtr = newtr.nextSibling;
				if(this.showPreview)
					newtr = newtr.nextSibling;
			}while(newtr.style.display == "none" && ArrayIndexOf(newtr.parentNode.childNodes, newtr) < maxIndex);
			if(newtr.style.display == "none")
				newtr = null;
		}
		if(!direction && this.focusedIndex > this.firstRowIndex){
			newtr = oldFocused;
			do{
				newtr = newtr.previousSibling;
				if(this.showPreview)
					newtr = newtr.previousSibling;
			}while(newtr.style.display == "none" && ArrayIndexOf(newtr.parentNode.childNodes, newtr) > this.firstRowIndex);
			if(newtr.style.display == "none")
				newtr = null;		
		}		
		if(newtr != null)
			this.MoveTo(newtr, !ctrlKey, !ctrlKey && !shiftKey, shiftKey);
	}	
	return (newtr != null) ? newtr.id : "";
}

ASPxGridObject.GetColumnByIndex = function(columnIndex){
	for(var i = 0; i < this.columnsInfo.length; i ++){
		if(this.columnsInfo[i].index == columnIndex)
			return this.columnsInfo[i];
	}
	return null;
}

ASPxGridObject.GetRowsHeight = function(table){
	var startIndex = 0;
	if(this.showGroupPanel)
		startIndex ++;
	var endIndex = table.rows.length;
	if(this.showFooter)
		endIndex --;
	endIndex -= this.statusBarCount;
	var height = 0;
	if(table != null){		
		for(var i = startIndex; i < endIndex; i ++){
			height += table.rows[i].offsetHeight;
		}
	}	
	return height;
}

ASPxGridObject.GetResizingHeaderInfo = function(header, columnIndex, x){
	var headerAbsoluteX = absoluteX(header, this.name, false, false);	
	var leftEdge = headerAbsoluteX;
	var rightEdge = headerAbsoluteX + header.offsetWidth;
	if((leftEdge < (x + columnSizingEdge) && leftEdge > (x - columnSizingEdge)) || (rightEdge < (x + columnSizingEdge) && rightEdge > (x - columnSizingEdge))){
		if(leftEdge > (x - columnSizingEdge)){
			columnIndex = -1;
			var headerIndex = ArrayIndexOf(header.parentNode.childNodes, header);
			if(headerIndex > 0){
				header = header.parentNode.childNodes[headerIndex - 1];
				var _indexOf = header.id.indexOf("~");
					if(_indexOf != -1)					
						columnIndex = header.id.substr(_indexOf + ("~CH~").length, header.id.length);
			}
		}		
		if(columnIndex >= 0){
			var column = this.GetColumnByIndex(columnIndex);
			if(column != null && column.enableColumnSizing){
				var resizingHeader = header;
				var resizingHeaderInfo = new Object();
				resizingHeaderInfo.x = absoluteX(resizingHeader, this.name, false, true);
				resizingHeaderInfo.width = resizingHeader.offsetWidth;
				resizingHeaderInfo.minWidth = column.minWidth;
				resizingHeaderInfo.columnIndex = column.index;
				return resizingHeaderInfo;
			}
		}
	}	
	return null;
}

ASPxGridObject.GetRowLevel = function(tr){
	var indexOf = tr.id.indexOf("~");
	var substr = tr.id.substr(indexOf + 1, tr.id.length);
	indexOf = substr.indexOf("~");
	substr = substr.substr(indexOf + 1, tr.id.length);
	indexOf = substr.indexOf("~");
	return Number(substr.substr(0, indexOf));	
}

ASPxGridObject.SetButtonExpanded = function(td){
	var img = td.firstChild.rows[0].cells[0].firstChild;
	if(img != null && img.tagName == "IMG")
		img.src = this.imgEBCollapse;
}

ASPxGridObject.SetButtonCollapsed = function(td){
	var img = td.firstChild.rows[0].cells[0].firstChild;
	if(img != null && img.tagName == "IMG")
		img.src = this.imgEBExpand;
}

ASPxGridObject.SetChildrenVisible = function(tr){
	var childrenDisplay = (this.rowsExpanded[ArrayIndexOf(tr.parentNode.childNodes, tr) - this.firstRowIndex] && tr.style.display != "none") ? "" : "none";
	var rowLevel = this.GetRowLevel(tr);
	var childRow = tr.nextSibling;
	var childRowLevel = this.GetRowLevel(childRow);
	while(childRow != null && childRowLevel > rowLevel){
		if(childRowLevel == rowLevel + 1){
			childRow.style.display = childrenDisplay;			
			this.SetChildrenVisible(childRow);
			if(childRow == this.focusedTR && childrenDisplay == "none")
				this.MoveTo(tr, false, false, false);
		}	
		childRow = childRow.nextSibling;
		childRowLevel = this.GetRowLevel(childRow);
	}
}


ASPxGridObject.ProcessExpBtn = function(button){	
	var tr = button.parentNode;
	var rowIndex = ArrayIndexOf(tr.parentNode.childNodes, tr) - this.firstRowIndex;
	this.rowsExpanded[rowIndex] = !this.rowsExpanded[rowIndex];
	this.SetChildrenVisible(tr);	
	if(this.rowsExpanded[rowIndex])
		this.SetButtonExpanded(button);
	else
		this.SetButtonCollapsed(button);
	this.FillExpandedInput(tr.parentNode);
}

ASPxGridObject.ProcessExpTR = function(tr){	
	var rowLevel = this.GetRowLevel(tr);
	this.ProcessExpBtn(tr.childNodes[rowLevel + this.firstGroupIndentOffset]);
}

ASPxGridObject.FillExpandedInput = function(rowsTable){	
	var input = document.getElementById(this.name + "ExpandedRows");	
	if(input != null && rowsTable != null){
		input.value = "";
		for(var i = 0; i < this.rowsExpanded.length; i ++){
			if(this.rowsExpanded[i]){				
				if(input.value != "")
					input.value += ";";
				input.value += rowsTable.childNodes[i + this.firstRowIndex].id;	
			}
		}
	}	
}

ASPxGridCollection.Add = function (gridObject){
	this.gridObjects.push(gridObject);
}

ASPxGridCollection.Get = function (name){
	for(var i = 0; i < this.gridObjects.length; i++){
		if(this.gridObjects[i].name == name) return this.gridObjects[i];
	}
	return null;
}

ASPxGridCollection.Clear = function (){
	while(this.gridObjects.length > 0){
		this.gridObjects.pop();
	}
}

function ASPxGridCollection(){
	this.gridObjects = new Array();
	
	this.Add = ASPxGridCollection.Add;
	this.Get = ASPxGridCollection.Get;
	this.Clear = ASPxGridCollection.Clear;
}

var __ASPxGridCollection;

if(__ASPxGridCollection == null){
	__ASPxGridCollection = new ASPxGridCollection();
}