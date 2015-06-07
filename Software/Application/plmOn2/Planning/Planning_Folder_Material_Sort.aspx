<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Planning_Folder_Material_Sort.aspx.vb" Inherits="plmOnApp.Planning_Folder_Material_Sort" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
        <title runat="server" id="PageTitle"></title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
		<meta content="JavaScript" name="vs_defaultClientScript" />
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
		
        <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />     
        <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Grid_Y.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/jquery.ui.core.css" rel="stylesheet" />
	    <link href="../System/CSS/jquery.ui.theme.css" rel="stylesheet" />
        <link href="../System/CSS/jquery-sortable.css" rel="stylesheet" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />

        <script type="text/javascript" src="../System/Jscript/jquery-1.8.0.js"></script>
        <script type="text/javascript" src="../System/Jscript/jquery.ui.core.js"></script>
	    <script type="text/javascript" src="../System/Jscript/jquery.ui.widget.js"></script>
	    <script type="text/javascript" src="../System/Jscript/jquery.ui.mouse.js"></script>
	    <script type="text/javascript" src="../System/Jscript/jquery.ui.sortable.js"></script>
        <script type="text/javascript" src="../System/Jscript/jquery-ui-1.8.21.custom.min.js"></script>
        <script type="text/javascript" src="../System/Jscript/jquery.ui.touch-punch.min.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>

        <style type="text/css">
            .dropimage
            {
            	background-image: url('../System/Icons/dragndrop.jpg');
            	background-repeat:no-repeat;
            	background-position:center;
            	width: 10px;
            }

	        li {cursor:url(../System/Cursor/openhand.cur), pointer} 
	        #sortable { list-style-type: none; margin: 0; padding: 0; }
	        #sortable li { margin: 3px 3px 3px 0; padding: 1px; float: left; width: auto; height: auto; text-align: center; vertical-align:top; }
            
        </style>

	<script type="text/javascript">
	    /** Rearranges the rows after the manual change of sort in thumbnail view */
	    function sortRows2(txtSort) {
	        var draggingRow = $(txtSort).closest('li'); // Getting the current table row
	        var hdnOldSort = draggingRow.find('input[name*="hdnsort"]');
	        // Checking, if sort was changed
	        var strNewSort = $(txtSort).val();
	        var strOldSort = hdnOldSort.val();
	        if (parseInt(strNewSort, 10) == parseInt(strOldSort, 10)) {
	            $(txtSort).val(strOldSort);
	            return;
	        }
	        // If the sort was changed, begining replacing
	        var newSort = parseInt(strNewSort, 10); // Getting the changed row sort (as integer)
	        var currentTable = $(txtSort).closest('ul'); // Getting the current table
	        if (isNaN(newSort)) {
	            newSort = 0;
	        }
	        // Checking all the rows in the table
	       // var allRows = currentTable.get(0).rows;
	        var wasInserted = false;

	        var lastRowVal = parseInt(currentTable.find('li:last').find('input[name*="txtSort"]').val(), 10);
	        var lastRow = currentTable.find('li:last');

	        if (newSort == lastRowVal && draggingRow.html() != lastRow.html()) {
	            draggingRow.insertAfter(currentTable.find('li:last')); // And inserting our row before it
	            wasInserted = true;

	        }
	        if (newSort > lastRowVal && draggingRow.html() != lastRow.html()) {
	            draggingRow.insertAfter(currentTable.find('li:last')); // And inserting our row before it
	            wasInserted = true;

	        }
	        if (!wasInserted) {
	            // for (var i = 0, currentRow; currentRow = allRows[i]; i++) {
	            $('li.ui-state-default').each(function () {
	                if (!wasInserted) {
	                    // Getting the sort from row
	                    var txtCurrentSort = $(this).find('input[name*="txtSort"]');
	                    var currentSort = parseInt($(txtCurrentSort).val(), 10);
	                    if (isNaN(currentSort)) {
	                        currentSort = 0;
	                    }

	                    if (currentSort == newSort && newSort == parseInt($(this).find('input[name*="hdnsort"]').val(), 10)) {
	                        if (newSort > parseInt(strOldSort, 10)) {
	                            draggingRow.insertAfter($(this));
	                        }

	                        if (newSort < parseInt(strOldSort, 10)) {
	                            draggingRow.insertBefore($(this));
	                        }
	                        wasInserted = true;

	                    }
	                    // Searching for the row with the sort, bigger then entered by user
	                    if (currentSort > newSort) {
	                        draggingRow.insertBefore($(this)); // And inserting our row before it
	                        wasInserted = true;

	                    }
	                }
	            });
	        }
	        

	        var lastRow = currentTable.find('li:last');
	        if (!wasInserted && draggingRow.html() != lastRow.html()) { // If edited item now has the bigger sort of all, we inserting it at the end of the table
	            var lastRow = currentTable.find('li:last');
	            draggingRow.insertAfter(lastRow);
	        }

	        // Setting the consistent value in the textbox
	        var strNewSort = "0000" + newSort.toString();
	        strNewSort = strNewSort.substr(strNewSort.length - 4, 4); // Rough implementation of RIGHT
	        $(txtSort).val(strNewSort);
	        // Changing the hidden value
	        hdnOldSort.val(strNewSort);
	        // Repainting the table
	        // repaintRows($("#DataGrid1").get(0), draggingRow);
	       // processRowDrop($("#DataGrid1").get(0), draggingRow);
	        // Centering the element on screen
	        var rowTop = draggingRow.offset().top;
	        var documentHeight = $(document).height();
	        var windowHeight = $(window).height();
	        if ((documentHeight - rowTop) < windowHeight / 2) {
	            $(document).scrollTop(draggingRow.offset().top);
	        } else {
	            $(document).scrollTop(draggingRow.offset().top - windowHeight / 2);
	        }
	        var i = 0;
	        $('li').each(function () {
	            //set new sort order for thumbnail view

	            var newSort = "0000" + (i + 1).toString()
	            newSort = newSort.substr(newSort.length - 4, 4);
	            $(this).find('table').find('input[id*="Sort"]').val(newSort);
	            $(this).find('table').find('input[name*="hdnsort"]').val(newSort);
	            i++;
	        });
	        $(txtSort).focus();
	    }

	    $(window).load(function () {
	        $('.ui-state-default').mousedown(function () { $(this).css('cursor', 'url(../System/Cursor/closedhand.cur)'); });
	        $('.ui-state-default').mouseup(function () { $(this).css('cursor', 'url(../System/Cursor/openhand.cur)'); });
            
	        //hide id field
	        $('li').each(function () {
	            $(this).find('table').find('[id*="PlanningID"]').closest('tr').hide();
	            $(this).find('table').find('[id*="SeasonYearID"]').closest('tr').hide();
	            $(this).find('table').find('[id*="PlanningMaterialID"]').closest('tr').hide();
	            $('<input type="hidden" name="hdnsort" value="' + $(this).find('table').find('input[id*="Sort"]').val() + '"/>').insertAfter($(this).find('table').find('input[id*="Sort"]'));
	        });

	        $('li').each(function () {

	            $(this).find('table').find('input[id*="Sort"]').bind('blur', function () {
	                sortRows2(this);
	            });
	        });

	        var it = 0;
	        $('li').each(function () {
	            //set new sort order for thumbnail view

	            var newSort = "0000" + (it + 1).toString()
	            newSort = newSort.substr(newSort.length - 4, 4);
	            $(this).find('table').find('input[id*="Sort"]').val(newSort);
	            $(this).find('table').find('input[id*="Sort"]').css("width", "50px");
	            $(this).find('table').find('input[name*="hdnsort"]').val(newSort);
	            it++;
	        });
	    });

	    $(function () {
	        $("#sortable").sortable({
	            stop: function (event, ui) {
	                var s = /\[\]/g;
	                var sE = /=/g;
	                document.getElementById("hdnSortOrder").value = $(this).sortable('serialize').replace(/&/g, ',').replace(s, '').replace(sE, '_');
	                document.getElementById("hdnChanged").value = '1';

	                var i = 0;
	                $('li').each(function () {
	                  //set new sort order for thumbnail view

	                    var newSort = "0000" + (i+1).toString()
	                    newSort = newSort.substr(newSort.length - 4, 4);
	                    $(this).find('table').find('input[id*="Sort"]').val(newSort);
	                    $(this).find('table').find('input[name*="hdnsort"]').val(newSort);
	                    i++;
	                });
	            }
	        });
	        $("#sortable").disableSelection();


	    });
        </script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tbody>
					<tr vAlign="middle">
						<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td vAlign="middle" align="left" width="400"><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
                        <cc1:confirmedimagebutton id="btnSaveClose" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
                        <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE"></cc1:confirmedimagebutton></td>
						<td></td>
					</tr>
				</tbody>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:label></td>
				</tr>
			</table>
			<table class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr valign="middle">
					<td width="150"><asp:label id="lblSortBy" Runat="server" CssClass="font"><b>Sort by:</b></asp:label>&nbsp;<asp:dropdownlist id="ddlSortBy" Runat="server"></asp:dropdownlist></td>
					<td><cc1:confirmedimagebutton id="btnSort" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
				</tr>
			</table>
            <asp:Repeater runat="server" id="repeater1">
                <HeaderTemplate>
                    <div class="normal">
                        <ul  id="sortable">
                </HeaderTemplate> 
                <ItemTemplate>
                </ItemTemplate>
                <FooterTemplate>
                        </ul>
                        </div>
                 </FooterTemplate>
            </asp:Repeater>
            <input type="hidden" id="hdnChanged" name="hdnChanged" value="0" />
            <input type="hidden" id="hdnSortOrder" name="hdnSortOrder" />
		</form>    
	</body>
</html>
