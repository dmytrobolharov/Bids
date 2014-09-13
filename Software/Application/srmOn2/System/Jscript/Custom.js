
function radioButtonClearAll(objName){
	var frm = document.form1 ;
	for(i=0;i< frm.length;i++){
		e=frm.elements[i];
		if ( e.type=='radio' && e.name.indexOf(objName) != -1 )
			e.checked= false;
	}
}



function keyPressed(TB,sctrlName,e) {
if (sctrlName == '') {   
sctrlName = 'DataGrid1';
}
//alert(sctrlName);
var tblGrid = document.getElementById(sctrlName); 
var rowcount = tblGrid.rows.length; 
var TBID = document.getElementById(TB); 
var key; 
var strForwardSlash = /\//; 
if (window.event) { e = window.event; } 
key = e.keyCode; 
if (key == 112){ 
if (document.selection) { 
if (document.selection.createRange) {
TBID.selection = document.selection.createRange(); 
TBID.selection.text = ''; 
} } 
var strInputValue = TBID.value; 
if (!strForwardSlash.test(strInputValue)) { 
strInputValue += ' 1/8'; 
strInputValue = strInputValue.replace('- ', '-'); 
TBID.value = strInputValue; } 
return false; 
} 
if (key == 113){ 
if (document.selection) { 
if (document.selection.createRange) {
TBID.selection = document.selection.createRange(); 
TBID.selection.text = ''; 
} } 
var strInputValue = TBID.value; 
if (!strForwardSlash.test(strInputValue)) { 
strInputValue += ' 1/4'; 
strInputValue = strInputValue.replace('- ', '-'); 
TBID.value = strInputValue; } 
return false; 
} 
if (key == 114){ 
if (document.selection) { 
if (document.selection.createRange) {
TBID.selection = document.selection.createRange(); 
TBID.selection.text = ''; 
} } 
var strInputValue = TBID.value; 
if (!strForwardSlash.test(strInputValue))  { 
strInputValue += ' 3/8'; 
strInputValue = strInputValue.replace('- ', '-'); 
TBID.value = strInputValue; } 
return false; 
} 
if (key == 115){ 
if (document.selection) { 
if (document.selection.createRange) {
TBID.selection = document.selection.createRange(); 
TBID.selection.text = ''; 
} } 
var strInputValue = TBID.value; 
if (!strForwardSlash.test(strInputValue)) { 
strInputValue += ' 1/2'; 
strInputValue = strInputValue.replace('- ', '-'); 
TBID.value = strInputValue; } 
return false; 
} 
if (key == 116){ 
if (document.selection) { 
if (document.selection.createRange) {
TBID.selection = document.selection.createRange(); 
TBID.selection.text = ''; 
} } 
var strInputValue = TBID.value; 
if (!strForwardSlash.test(strInputValue))  { 
strInputValue += ' 5/8'; 
strInputValue = strInputValue.replace('- ', '-'); 
TBID.value = strInputValue; } 
return false; 
} 
if (key == 117){ 
if (document.selection) { 
if (document.selection.createRange) {
TBID.selection = document.selection.createRange(); 
TBID.selection.text = ''; 
} } 
var strInputValue = TBID.value; 
if (!strForwardSlash.test(strInputValue)) { 
strInputValue += ' 3/4'; 
strInputValue = strInputValue.replace('- ', '-'); 
TBID.value = strInputValue; } 
return false; 
} 
if (key == 118){ 
if (document.selection) { 
if (document.selection.createRange) {
TBID.selection = document.selection.createRange(); 
TBID.selection.text = ''; 
} } 
var strInputValue = TBID.value; 
if (!strForwardSlash.test(strInputValue)) { 
strInputValue += ' 7/8'; 
strInputValue = strInputValue.replace('- ', '-'); 
TBID.value = strInputValue; } 
return false; 
} 
if (key == 37 || key == 38 || key == 39 || key == 40 || key == 13){ 
for (Index=1;Index<rowcount;Index++){ 
for (childIndex=0;childIndex < tblGrid.rows[Index].cells.length; childIndex++){ 
if (tblGrid.rows[Index].cells[childIndex].children[0] != null){ 
if (tblGrid.rows[Index].cells[childIndex].children[0].id == TBID.id){ 
if (key == 40 || key == 13){ 
if (tblGrid.rows[Index + 1] != null){ 
if (tblGrid.rows[Index + 1].cells[childIndex].children[0] != null){ 
if (tblGrid.rows[Index + 1].cells[childIndex].children[0].type == 'text'){ 
tblGrid.rows[Index + 1].cells[childIndex].children[0].focus(); 
tblGrid.rows[Index + 1].cells[childIndex].children[0].select(); 
return false; 
} } } } 
if (key == 38){ 
if (tblGrid.rows[Index - 1] != null){ 
if (tblGrid.rows[Index - 1].cells[childIndex].children[0] != null){ 
if (tblGrid.rows[Index - 1].cells[childIndex].children[0].type == 'text'){ 
tblGrid.rows[Index - 1].cells[childIndex].children[0].focus(); 
tblGrid.rows[Index - 1].cells[childIndex].children[0].select(); 
return false; 
} } } } 
if (key == 37 && (childIndex != 0)) { 
if ((tblGrid.rows[Index].cells[childIndex - 1].children[0]) != null) { 
if (tblGrid.rows[Index].cells[childIndex - 1].children[0].type == 'text') { 
if (tblGrid.rows[Index].cells[childIndex - 1].children[0].value != '') { 
var cPos = getCaretPos(tblGrid.rows[Index].cells[childIndex - 1].children[0], 'left'); 
if (cPos) { 
tblGrid.rows[Index].cells[childIndex - 1].children[0].focus(); 
return false; } 
else { return false; }  } 
tblGrid.rows[Index].cells[childIndex - 1].children[0].focus(); 
return false; 
} } } 
if (key == 39) { 
if (tblGrid.rows[Index].cells[childIndex + 1] != null){ 
if ((tblGrid.rows[Index].cells[childIndex + 1].children[0]) != null) { 
if (tblGrid.rows[Index].cells[childIndex + 1].children[0].type == 'text') { 
if (tblGrid.rows[Index].cells[childIndex + 1].children[0].value != '') { 
var cPosR = getCaretPos(tblGrid.rows[Index].cells[childIndex + 1].children[0], 'right'); 
if (cPosR) { 
tblGrid.rows[Index].cells[childIndex + 1].children[0].focus(); 
return false; } 
else { return false; }  } 
tblGrid.rows[Index].cells[childIndex + 1].children[0].focus(); 
return false; 
} } } } 
} } } } } } 
function getCaretPos(control, way) { 
var movement; 
if (way == 'left') { movement = -1; } else { movement = 1; } 
if (control.createTextRange) { 
control.caretPos = document.selection.createRange().duplicate(); 
if (control.caretPos.move('character', movement) != '') {return false;} else {return true;} 
} } 

function arrowkeyPressed(TB, sctrlName, e)
{

	if (sctrlName == '') {   
		sctrlName = 'DataGrid1';
	}
	
    //alert('Key ' + e.keyCode);
    var frm = document.Form1;
    var tblGrid = document.getElementById(sctrlName);
    
    var rowcount = tblGrid.rows.length;
    var TBID = document.getElementById(TB);    
    var key; 
    if (window.event) { e = window.event; }  
    key = e.keyCode;

	if (key == 37 || key == 38 || key == 39 || key == 40 || key == 13) {
		for (Index = 1; Index < rowcount; Index++) {
			for (childIndex = 0; childIndex < tblGrid.rows[Index].cells.length; childIndex++) {
				if (tblGrid.rows[Index].cells[childIndex].children[0] != null) {
					if (tblGrid.rows[Index].cells[childIndex].children[0].id == TBID.id) {
						if (key == 40 || key == 13) {
							if (tblGrid.rows[Index + 1] != null) {
								if (tblGrid.rows[Index + 1].cells[childIndex].children[0] != null) {
									if (tblGrid.rows[Index + 1].cells[childIndex].children[0].type == 'text') {
										tblGrid.rows[Index + 1].cells[childIndex].children[0].focus();										
										return false;
									}
								}
							}
						}
						if (key == 38) {
							if (tblGrid.rows[Index - 1] != null) {
								if (tblGrid.rows[Index - 1].cells[childIndex].children[0] != null) {
									if (tblGrid.rows[Index - 1].cells[childIndex].children[0].type == 'text') {
										tblGrid.rows[Index - 1].cells[childIndex].children[0].focus();										
										return false;
									}
								}
							}
						}
						if (key == 37 && (childIndex != 0)) {
							if ((tblGrid.rows[Index].cells[childIndex - 1].children[0]) != null) {
								if (tblGrid.rows[Index].cells[childIndex - 1].children[0].type == 'text') {
									if (tblGrid.rows[Index].cells[childIndex - 1].children[0].value != '') {
										var cPos = getCaretPos(tblGrid.rows[Index].cells[childIndex - 1].children[0], 'left');
										if (cPos) {
											tblGrid.rows[Index].cells[childIndex - 1].children[0].focus();
											return false;
										} else {
											return false;
										}
									}
									tblGrid.rows[Index].cells[childIndex - 1].children[0].focus();
									return false;
								}
							}
						}
						if (key == 39) {
							if (tblGrid.rows[Index].cells[childIndex + 1] != null) {
								if ((tblGrid.rows[Index].cells[childIndex + 1].children[0]) != null) {
									if (tblGrid.rows[Index].cells[childIndex + 1].children[0].type == 'text') {
										if (tblGrid.rows[Index].cells[childIndex + 1].children[0].value != '') {
											var cPosR = getCaretPos(tblGrid.rows[Index].cells[childIndex + 1].children[0], 'right');
											if (cPosR) {
												tblGrid.rows[Index].cells[childIndex + 1].children[0].focus();
												return false;
											} else {
												return false;
											}
										}
										tblGrid.rows[Index].cells[childIndex + 1].children[0].focus();
										return false;
									}
								}
							}
						}
					}
				}
			}
		}
	}    
}

