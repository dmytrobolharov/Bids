/**
* Attention!
* This is the vital part of Enhanced Costing 2012. Do not try to use it somewhere else, and do not try to change it,
* if you don't need to change both view and edit mode of costsheets (Style_CostSheetItem_Import.aspx and
* Style_CostSheetItem_Import_Edit.aspx).
**/

/**************************** COLLAPSING AND EXPANDING *****************************/

/* Collapsing and expanding data grids. If there are non-collapsible tables in the hierarchy use
the class 'nodata'. For not collapsible rows use class 'nocollapse'. TableHeaderYellow also isn't collapsing */
function collapseTable(sender) {
	var table = $(sender).closest("table:not([class*='nodata'])");
	var btnCollapse = table.find("img[id*='imgCollapse']");
	var btnExpand = table.find("img[id*='imgExpand']");
	var hdnIsExpanded = table.find("input[id*='hdnIsExpanded']"); // Marking, if table is expanded, for postback reasons
	btnCollapse.hide();
	btnExpand.show();
	table.find("tr:not([class*='TableHeaderYellow']):not([class*='nocollapse'])").hide();
	if (hdnIsExpanded != undefined) {
		hdnIsExpanded.val("False");
	}
}

function expandTable(sender) {
	var table = $(sender).closest("table:not([class*='nodata'])");
	var btnCollapse = table.find("img[id*='imgCollapse']");
	var btnExpand = table.find("img[id*='imgExpand']");
	var hdnIsExpanded = table.find("input[id*='hdnIsExpanded']"); // Marking, if table is expanded, for postback reasons
	btnCollapse.show();
	btnExpand.hide();
	table.find("tr:not([class*='TableHeaderYellow']):not([class*='nocollapse'])").show();
	if (hdnIsExpanded != undefined) {
		hdnIsExpanded.val("True");
	}
}

/* Function, which will create header and buttons 'Collapse' and 'Expand' for given collapsible section.
 * This will work if rows of collapsible section all have similar CSS class, and the first row of the section also has
 * class SectionStart.
 */
function insertCollapsibleClassHeaderRow(className, sectionHeader) {
	var btnCollapseClass = "<img id='imgCollapseClass" + className + "' alt='Collapse' src='../System/Icons/icon_Down.gif' onclick='collapseClass(this, \"" + className + "\");' style='cursor:pointer;' />"
	var btnExpandClass = "<img id='imgExpandClass" + className + "' alt='Expand' src='../System/Icons/icon_Next.gif' onclick='expandClass(this, \"" + className + "\");' style='display: none;cursor:pointer;'/>"
	var classLabel = "<span class='fontHead'>" + sectionHeader + "</span>"
	// First row of collapsible section (already exists)
	var classFirstRow = $("#UnitsCosting [class*='" + className + "'][class*='SectionStart']");
	// Header of collapsible section (has to be generated dynamically)
	var classHeaderRow = '<TR style="HEIGHT: 25px" id="CollapsibleHeader_' + className + '" class="TableHeader">' +
	'<TD class="AttributesItem" style="border-right-style:none;">' + btnCollapseClass + btnExpandClass + classLabel + '</TD> ' +
	'<TD class="SystemCostsheetItem">&nbsp;</TD>' +
	'<TD class="CostsheetItem">&nbsp;</TD>' +
	'<TD class="CostsheetItem">&nbsp;</TD>' +
	'<TD class="CostsheetItem">&nbsp;</TD></TR>';
	$(classFirstRow).before(classHeaderRow);
}

/* Collapse section with given classname */
function collapseClass(sender, className) {
	var hideRows = $("#UnitsCosting tr[class*='" + className + "']");
	// Hiding unit delimiters within section
	hideRows.each(function () {
		if ($(this).hasClass("GridGroupEnd")) {
			$(this).next().hide();
		}
	});
	var showBtn = $(sender).closest('td').find("img[id*='imgExpandClass']");
	var hideBtn = $(sender);
	hideRows.hide();
	showBtn.show();
	hideBtn.hide();

	// Processing value rows, which should be visible, when section collapsed, according to WI #12295
	var valueCells = $("#UnitsCosting tr[class*='SectionValue'][class*='" + className + "'] > td");
	var headerCells = $("#UnitsCosting tr[id='CollapsibleHeader_" + className + "'] > td");
	for (var i = 1; i < headerCells.length; i++) {
	    $(headerCells[i]).html($(valueCells[i]).html());
        $(valueCells[i]).html("&nbsp;");
	}
}

/* Expand section with given classname */
function expandClass(sender, className) {
	var showRows = $("#UnitsCosting tr[class*='" + className + "']");
	// Showing unit delimiters within section
	showRows.each(function () {
		if ($(this).hasClass("GridGroupEnd")) {
			$(this).next().show();
		}
	});
	var showBtn = $(sender)
	var hideBtn = $(sender).closest('td').find("img[id*='imgCollapseClass']");
	showRows.show();
	showBtn.hide();
	hideBtn.show();

	// Processing value rows, which should be invisible, when section expanded, according to WI #12295
	var valueCells = $("#UnitsCosting tr[class*='SectionValue'][class*='" + className + "'] > td");
	var headerCells = $("#UnitsCosting tr[id='CollapsibleHeader_" + className + "'] > td");
	for (var i = 1; i < headerCells.length; i++) {
	    $(valueCells[i]).html($(headerCells[i]).html());
	    $(headerCells[i]).html("&nbsp;");
	}
}
/* Collapse all collapsible sections on the page */
function collapseAll() {

    $("img[id*='imgCollapse']").each(function () {
        if ($(this).is(":visible")) {
            $(this).click(); 
        } 
    });
	// Hide 'collapse all' button
	$("#imgMasterExpand").show();
	$("#imgMasterCollapse").hide();
}

/* Expand all collapsible sections on the page */
function expandAll() {
    $("img[id*='imgExpand']").each(function () {
        if ($(this).is(":visible")) {
            $(this).click(); 
        } 
    });
	// Hide 'collapse all' button
	$("#imgMasterCollapse").show();
	$("#imgMasterExpand").hide();
}

/* Makes the sender's table (BOM, BOL, Additional) to be expanded after the postback is sent and page is refreshed. This is done through
 * setting value for table's hidden field, which will be checked by the script on the page after postback.
 */
function expandTableAfterPostback(sender) {
	var table = $(sender).closest("table:not([class*='nodata'])");
	var hdnIsExpanded = table.find("input[id*='hdnIsExpanded']");
	hdnIsExpanded.val("True");
}

/******************************* INPLACE EDITOR *******************************/

function showInplaceEditor(sender) {
	var inputName = $(sender).attr('id').replace("lbl", "txt");
	var inputCell = $(sender).closest('td');
	var editInput = $(inputCell).find("input[id*='" + inputName + "']");
	editInput.bind("blur", function () { hideInplaceEditor(this); })
	editInput.val($(sender).text());
	$(sender).hide();
	editInput.show();
	editInput.focus();
}

function hideInplaceEditor(sender) {
	var labelName = $(sender).attr('id').replace("txt", "lbl");
	var labelCell = $(sender).closest('td');
	var labelSpan = $(labelCell).find("span[id*='" + labelName + "']");
	labelSpan.text($(sender).val());
	$(sender).hide();
	$(sender).unbind("blur");
	labelSpan.show();
}

/*********************COSTING EDIT MODE SPECIAL FUNCTIONS************************/

// Copies values from hidden field of DutyPercentSource windowbox (if there are any) to DutyPercent textfields with the same class.
function CopyValuesFromWindowboxes() {
	for (var i = 1; i <= 3; i++) {
		// Windowbox from source row
		var currentWindowbox = $("#UnitsCosting tr[class*='DutySource'] input[name*='widCost" + i.toString() + "']");
		// Textbox from destination row
		var currentTextbox = $("#UnitsCosting tr[class*='DutyPercent'] input[name*='txtCost" + i.toString() + "']");
		// Copying the value, if there is any
		var currentVal = currentWindowbox.val();
		if (currentVal != "" && currentVal != null && currentVal.indexOf("%")> -1) {
			currentTextbox.val(currentVal);
		}
	}
	DutyPercentSetReadOnly();
}

// If HTS Code isn't empty, Duty % should be disabled
function DutyPercentSetReadOnly() {
	for (var i = 1; i <= 3; i++) {
		// Windowbox from source row
		var currentHTSInput = $("#UnitsCosting tr[class*='DutySource'] input[name*='txtCost" + i.toString() + "']");
		// Textbox from destination row
		var currentDutyInput = $("#UnitsCosting tr[class*='DutyPercent'] input[name*='txtCost" + i.toString() + "']");
		// Copying the value, if there is any
		var currentHTS = currentHTSInput.val();

		if (currentHTS != "" && currentHTS != null) {
			currentDutyInput.get(0).readOnly = true;
		} else {
			currentDutyInput.get(0).readOnly = false;
		}
	}
}

/* Custom validator, which marks field as required only if all the costings are 0 */

function ValidateRequiredRowElement(sender, args) {
	var hasNotNullCosts = false;
	var minLength = 0;
	var maxLength = 50;
	// List of all costings for current row
	var costingInputList = $(sender).closest("tr[class*='font']").find("input[name*='txtCost']:not([name*='txtCostSystem'])");
	var currentCost = "0"
	// Checking, if there's at least one costing, which isn't null
	for (var i = 0, currentCostInput; currentCostInput = costingInputList[i]; i++) {
		currentCost = $(currentCostInput).val();
		if (!IsValueZero(currentCost)) {
			hasNotNullCosts = true;
			break;
		}
	}
	// If there's at least one not-null costing, the code and description are both required
	if (hasNotNullCosts) {
		minLength = 1;
	}

	args.IsValid = (args.Value.length >= minLength && args.Value.length <= maxLength);
}

function IsValueZero(value) {
	// Finding all digits, except for zero. If there's no such a digits -- decimal is 0.
	var digits = value.toString().replace(/[^1-9]/g, "").toString();
	if (digits.length == 0) {
		return true;
	}
	return false;
}

/******************************* GENERAL DESIGN ***********************************/

/* Make GridArea div to take all the free height on the window, but no more */
function resizeGridScrollArea() {
	var gridScrollArea = $("#GridArea");
	var windowHeight = $(window).height();
	var formHeight = $("#Form1").height();
	var minHeight = 100;
	// Calculating, how much free space we have on the window for grid area
	var diff = windowHeight - (formHeight - gridScrollArea.height());

	if (diff > minHeight) {
		gridScrollArea.height(diff);
	} else {
		gridScrollArea.height(minHeight);
	}
}