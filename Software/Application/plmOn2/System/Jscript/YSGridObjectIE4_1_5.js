

function YSGridObject(name){
	this.name = name;	
	this.clientSide = false;	
	this.pageSize = 0;	
	this.rowCount = 0;	
	this.offsetX = 0;
	this.offsetY = 0;
	this.selectedBackColor = "";
	this.selectedForeColor = "";
	this.savedCellsColors = new Array();
	this.columnsInfo = new Array();
	this.groupColumns = new Array();
	this.visibleColumns = new Array();
	this.focusedIndex = -1;
	this.firstRowIndex = 0;
	this.focusedTR = null;
	this.arrowImgWidth = 0;
	this.pageSizeImg = null;
	this.pageSizeButtonId = "";	
	this.rowsSelected = null;
	this.savedSelectedColors = null;
	this.selectedRows = null;
	this.controlMode = "Browse";
	this.multiSelection = false;
	this.showPreview = false;
	
	this.showGroupPanel = true;
	this.showFooter = false;
	this.statusBarCount = 0;
	
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
	this.imgNBOk = "";
	this.imgNBChPS = "";	

	this.InitializeSelection = YSGridObject.InitializeSelection;
	this.HideSelection = YSGridObject.HideSelection;
	this.ShowSelection = YSGridObject.ShowSelection;
	this.HideFocus = YSGridObject.HideFocus;
	this.ShowFocus = YSGridObject.ShowFocus;	
	this.InvertRowSelection = YSGridObject.InvertRowSelection;
	this.FillSelectedInput = YSGridObject.FillSelectedInput;
	this.ClearSelection = YSGridObject.ClearSelection;	
	this.MoveTo = YSGridObject.MoveTo;
	this.MoveBy = YSGridObject.MoveBy;
	this.GetTargetHeaderInfo = YSGridObject.GetTargetHeaderInfo;
	this.GetTargetGroupedHeaderInfo = YSGridObject.GetTargetGroupedHeaderInfo;
	this.EditPageSize = YSGridObject.EditPageSize;
	this.CancelPageSize = YSGridObject.CancelPageSize;	
	this.GetColumnByIndex = YSGridObject.GetColumnByIndex;	
	this.GetRowsHeight = YSGridObject.GetRowsHeight;	
	this.GetResizingHeaderInfo = YSGridObject.GetResizingHeaderInfo;
	this.GetRowLevel = YSGridObject.GetRowLevel;	
}

function CellColor(foreColor, backColor){
	this.foreColor = foreColor;
	this.backColor = backColor;
}

function YSGridColumn(index, type){
	this.index = index;
	this.type = type;
}

function YSGridColumnInfo(index, minWidth, enableHeaderClick, enableHeaderDragging, enableGrouping, enableColumnMoving, enableColumnSizing){
	this.index = index;
	this.minWidth = minWidth;
	
	this.enableHeaderClick = enableHeaderClick;
	this.enableHeaderDragging = enableHeaderDragging;
	this.enableGrouping = enableGrouping;
	this.enableColumnMoving = enableColumnMoving;		
	this.enableColumnSizing = enableColumnSizing;
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
			array[j] = null;
			return;
		}
	}
}

YSGridObject.InitializeSelection = function(){	
	for(var i = 0; i < this.selectedRows.length; i ++){
		var tr = document.all(this.selectedRows[i]);
		if(tr != null)
			this.InvertRowSelection(tr, false, false, false);
	}
	this.FillSelectedInput();
}

YSGridObject.SetIndicatorFocused = function(td){
	var img = td.children[0].rows[0].cells[0].children[0];
	if(img != null && img.tagName == "IMG")
		img.src = this.imgIndicator;
}

YSGridObject.SetIndicatorUnfocused = function(td){
	var img = td.children[0].rows[0].cells[0].children[0];
	if(img != null && img.tagName == "IMG")
		img.src = this.img1x1;
}

YSGridObject.GetRowLevel = function(tr){
	var indexOf = tr.id.indexOf("~");
	var substr = tr.id.substr(indexOf + 1, tr.id.length);
	indexOf = substr.indexOf("~");
	substr = substr.substr(indexOf + 1, tr.id.length);
	indexOf = substr.indexOf("~");
	return Number(substr.substr(0, indexOf));	
}

YSGridObject.HideSelection = function(tr, rowIndex){	
	var rowLevel = this.GetRowLevel(tr);
	var restoringArray = this.multiSelection ? this.savedSelectedColors[rowIndex] : this.savedCellsColors;
	if(rowLevel < this.groupColumns.length){
		var offset = 1;
		while(this.visibleColumns[this.visibleColumns.length - offset].type == "RowBtnColumn")
			offset ++;
		tr.cells[tr.cells.length - offset].style.color = restoringArray[0].foreColor;
		tr.cells[tr.cells.length - offset].style.backgroundColor = restoringArray[0].backColor;		
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
	restoringArray = new Array();	
}

YSGridObject.ShowSelection = function(tr, rowIndex){	
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
		savingArray[savingArray.length] = new CellColor(tr.cells[tr.cells.length - offset].style.color, tr.cells[tr.cells.length - offset].style.backgroundColor);
		tr.cells[tr.cells.length - offset].style.color = this.selectedForeColor;
		tr.cells[tr.cells.length - offset].style.backgroundColor = this.selectedBackColor;
	}
	else{					
		for(var i = 0; i < this.visibleColumns.length; i ++){
			if(this.visibleColumns[i].type == "DataColumn" || this.visibleColumns[i].type == "TemplateColumn"){
				savingArray[savingArray.length] = new CellColor(tr.cells[i].style.color, tr.cells[i].style.backgroundColor);
				tr.cells[i].style.color = this.selectedForeColor;
				tr.cells[i].style.backgroundColor = this.selectedBackColor;
			}	
		}
	}
}

YSGridObject.HideFocus = function(tr){		
	if(this.visibleColumns[0].type == "IndicatorColumn")			
		this.SetIndicatorUnfocused(tr.cells[0]);			
}

YSGridObject.ShowFocus = function(tr){	
	var rowLevel = this.GetRowLevel(tr);	
	if(this.visibleColumns[0].type == "IndicatorColumn")			
		this.SetIndicatorFocused(tr.cells[0]);			
	
	var scroller = document.all(this.name + "scroller");
	if(scroller != null && tr.offsetTop + tr.offsetHeight > scroller.scrollTop + scroller.clientHeight)
		scroller.scrollTop = tr.offsetTop + tr.offsetHeight - scroller.clientHeight;
	if(scroller != null && tr.offsetTop < scroller.scrollTop)
		scroller.scrollTop = tr.offsetTop;
}

YSGridObject.InvertRowSelection = function(tr, value, applyValue, synchronize){
	var rowIndex = ArrayIndexOf(tr.parentElement.children, tr) - this.firstRowIndex;	
	if(!applyValue || this.rowsSelected[rowIndex] != value){
		this.rowsSelected[rowIndex] = !this.rowsSelected[rowIndex];
		if(this.rowsSelected[rowIndex]){		
			if(synchronize)
				this.selectedRows[this.selectedRows.length] = tr.id;
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

YSGridObject.ClearSelection = function(rowsCollection){
	for(var i = 0; i < this.rowsSelected.length; i ++){
		if(this.rowsSelected[i]){
			this.InvertRowSelection(rowsCollection[i + this.firstRowIndex], false, false, false);
		}
	}
	this.selectedRows = new Array();
	this.FillSelectedInput();
}

YSGridObject.FillSelectedInput = function(){	
	var input = document.all(this.name + "SelectedRows");	
	if(input != null){
		input.value = "";
		for(var i = 0; i < this.selectedRows.length; i ++){
			if(input.value != "")
				input.value += ";";
			input.value += this.selectedRows[i];	
		}
	}	
}

YSGridObject.MoveTo = function(tr, changeSelection, clearPrevSelection, selectRange){			
	if(tr != this.focusedTR){		
		var rowsCollection = tr.parentElement.children;
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
			document.all(this.name + "FocusedRow").value = this.focusedTR.id;
		}
		else
			document.all(this.name + "FocusedRow").value = "";
	}		
	else{
		if(this.multiSelection && !clearPrevSelection && this.focusedTR != null){
			this.InvertRowSelection(this.focusedTR, false, false, true);
		}
	}
}

YSGridObject.GetTargetHeaderInfo = function(x, y, currentColIndex){			
	var headerpanel = document.all(this.name + "headerpanel");	
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
							var scroller = document.all(this.name + "scroller");	
							if((this.visibleColumns[i].type == "DataColumn" || this.visibleColumns[i].type == "TemplateColumn") && (scroller == null || targetX > scroller.scrollLeft && targetX < scroller.scrollLeft + scroller.offsetWidth)){
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

YSGridObject.GetTargetGroupedHeaderInfo = function(x, y, currentColIndex){	
	var grouppanel = document.all(this.name + "grouppanel");	
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
				var groupHeaders = grouppanel.cells[0].children[0].rows[0].cells[1].children[0].rows[0];
				for(var i = 0; i < groupHeaders.children.length; i ++){
					var header = groupHeaders.children[i];
					if(header != null){
						var headerX = absoluteX(header, this.name, false, true);
						if((x > headerX && x < headerX + header.offsetWidth) || (i == groupHeaders.children.length - 1)){
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

YSGridObject.EditPageSize = function(img, buttonId){	
	var edit;
	edit = document.all(this.name + "PageSizeEdit" + buttonId);
	edit.disabled = false;
	edit.focus();
	if(img.tagName != "IMG")
		img = img.children[0];
	img.src = this.imgNBOk;	
	this.pageSizeImg = img;
	this.pageSizeButtonId = buttonId;
}

YSGridObject.CancelPageSize = function(){
	var edit = document.all(this.name + "PageSizeEdit" + this.pageSizeButtonId);
	edit.value = this.pageSize;
	edit.disabled = true;	
	this.pageSizeImg.src = this.imgNBChPS;
	this.pageSizeButtonId = "";
}

YSGridObject.MoveBy = function(direction, ctrlKey, shiftKey){	
	var newtr = null;
	if(this.focusedIndex >= 0){			
		var oldFocused = document.all(document.all(this.name + "FocusedRow").value);	
		if(oldFocused != null){
			var rows = oldFocused.parentElement.children;
			var maxIndex =  this.rowCount + this.firstRowIndex - 1  + (this.showPreview ? this.rowCount - 1 : 0);
			if(direction && this.focusedIndex < maxIndex)
				newtr = rows[this.focusedIndex + (this.showPreview ? 2 : 1)];
			if(!direction && this.focusedIndex > this.firstRowIndex)
				newtr = rows[this.focusedIndex - (this.showPreview ? 2 : 1)];
			if(newtr != null)
				this.MoveTo(newtr, !ctrlKey, !ctrlKey && !shiftKey, shiftKey);		
		}
	}		
	return (newtr != null) ? newtr.id : "";
}

YSGridObject.GetColumnByIndex = function(columnIndex){
	for(var i = 0; i < this.columnsInfo.length; i ++){
		if(this.columnsInfo[i].index == columnIndex)
			return this.columnsInfo[i];
	}
	return null;
}

YSGridObject.GetRowsHeight = function(table){
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

YSGridObject.GetResizingHeaderInfo = function(header, columnIndex, x){
	var headerAbsoluteX = absoluteX(header, this.name, false, false);
	var leftEdge = headerAbsoluteX + 2;
	var rightEdge = headerAbsoluteX + 2 + header.offsetWidth;
	if((leftEdge < (x + columnSizingEdge) && leftEdge > (x - columnSizingEdge)) || (rightEdge < (x + columnSizingEdge) && rightEdge > (x - columnSizingEdge))){
		if(leftEdge > (x - columnSizingEdge)){
			columnIndex = -1;
			var headerIndex = ArrayIndexOf(header.parentElement.children, header);
			if(headerIndex > 0){
				header = header.parentElement.children[headerIndex - 1];
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
				resizingHeaderInfo.width = resizingHeader.clientWidth;
				resizingHeaderInfo.minWidth = column.minWidth;
				resizingHeaderInfo.columnIndex = column.index;
				return resizingHeaderInfo;
			}
		}
	}	
	return null;
}

YSGridCollection.Add = function (gridObject){
	this.gridObjects[this.gridObjects.length] = gridObject;
}

YSGridCollection.Get = function (name){
	for(var i = 0; i < this.gridObjects.length; i++){
		if(this.gridObjects[i].name == name) return this.gridObjects[i];
	}
	return null;
}

function YSGridCollection(){
	this.gridObjects = new Array();
	
	this.Add = YSGridCollection.Add;
	this.Get = YSGridCollection.Get;
}

var __YSGridCollection;

if(__YSGridCollection == null){
	__YSGridCollection = new YSGridCollection();
}