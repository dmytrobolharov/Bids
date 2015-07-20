<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Planning_Folder_Storyboards_List_Edit.aspx.vb" Inherits="plmOnApp.Planning_Folder_Storyboards_List_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register Src="Planning_Header.ascx" TagName="Planning_Header" TagPrefix="hc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head id="Head1" runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/jquery-ui-1.10.3.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
    <style type="text/css">
        .confirm-dialog {
        	display: none;        	
        }
        
        .confirm-dialog p {
        	font-size: 14px;
        }
    </style>
</head>
<body>
<div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="form1" runat="server">
    <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td valign="middle" align="left">
                 <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnSaveClose" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"></cc1:ConfirmedImageButton>
            </td>
        </tr>
    </table>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45"
        cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:Label>
            </td>
        </tr>
    </table>
    <hc1:planning_header id="PlanningHeader" runat="server" />
    <br />
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                <asp:DataGrid ID="DataGrid1" runat="server" AllowSorting="False" DataKeyField="ImageCatalogID">
                    <AlternatingItemStyle Height="20px" Wrap="true" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                    <ItemStyle Height="20px" Wrap="true" CssClass="ItemTemplate"></ItemStyle>
                    <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                    <PagerStyle Visible="False"></PagerStyle>
                </asp:DataGrid>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        $('input[name*="txtSort"]').bind('blur', function () {
            sortRows(this);
        });

        /** Changing the background color to make the table look consistent */
        function repaintRows(table, row) {
            for (var i = 1, currentRow; currentRow = table.rows[i]; i++) {
                if (i % 2 == 0) {
                    $(currentRow).css("background-color", "aliceblue");  // Alternating item style
                } else {
                    $(currentRow).css("background-color", "white");  // Item style
                }
            }
        }

        /** Rearranges the rows after the manual change of sort */
        function sortRows(txtSort) {
            var draggingRow = $(txtSort).closest('tr'); // Getting the current table row
            var hdnOldSort = draggingRow.find('input[name*="hdnSort"]');
            // Checking, if sort was changed
            var strNewSort = $(txtSort).val();
            var strOldSort = hdnOldSort.val();
            if (parseInt(strNewSort, 10) == parseInt(strOldSort, 10)) {
                $(txtSort).val(strOldSort);
                return;
            }
            // If the sort was changed, begining replacing
            var newSort = parseInt(strNewSort, 10); // Getting the changed row sort (as integer)
            var currentTable = $(txtSort).closest('table'); // Getting the current table
            if (isNaN(newSort)) {
                newSort = 0;
            }
            // Checking all the rows in the table
            var allRows = currentTable.get(0).rows;
            var wasInserted = false;

            var lastRowVal = parseInt(currentTable.find('tr:last').find('input[name*="txtSort"]').val(), 10);
            var lastRow = currentTable.find('tr:last');

            if (newSort == lastRowVal && draggingRow.html() != lastRow.html()) {
                draggingRow.insertAfter(currentTable.find('tr:last')); // And inserting our row before it
                wasInserted = true;

            }
            if (newSort > lastRowVal && draggingRow.html() != lastRow.html()) {
                draggingRow.insertAfter(currentTable.find('tr:last')); // And inserting our row before it
                wasInserted = true;

            }
            if (!wasInserted) {
                for (var i = 0, currentRow; currentRow = allRows[i]; i++) {
                    // Getting the sort from row
                    var txtCurrentSort = $(currentRow).find('input[name*="txtSort"]');
                    var currentSort = parseInt($(txtCurrentSort).val(), 10);
                    if (isNaN(currentSort)) {
                        currentSort = 0;
                    }

                    if (currentSort == newSort && newSort == parseInt($(currentRow).find('input[name*="hdnSort"]').val(), 10)) {
                        if (newSort > parseInt(strOldSort, 10)) {
                            draggingRow.insertAfter($(currentRow));
                        }

                        if (newSort < parseInt(strOldSort, 10)) {
                            draggingRow.insertBefore($(currentRow));
                        }
                        wasInserted = true;
                        break;
                    }
                    // Searching for the row with the sort, bigger then entered by user
                    if (currentSort > newSort) {
                        draggingRow.insertBefore($(currentRow)); // And inserting our row before it
                        wasInserted = true;
                        break;
                    }
                }
            }

            var lastRow = currentTable.find('tr:last');
            if (!wasInserted && draggingRow.html() != lastRow.html()) { // If edited item now has the bigger sort of all, we inserting it at the end of the table
                var lastRow = currentTable.find('tr:last');
                draggingRow.insertAfter(lastRow);
            }

            // Setting the consistent value in the textbox
            var strNewSort = "0000" + newSort.toString();
            strNewSort = strNewSort.substr(strNewSort.length - 4, 4); // Rough implementation of RIGHT
            $(txtSort).val(strNewSort);
            processRowDrop($("#DataGrid1").get(0), draggingRow);
            // Centering the element on screen
            var rowTop = draggingRow.offset().top;
            var documentHeight = $(document).height();
            var windowHeight = $(window).height();
            if ((documentHeight - rowTop) < windowHeight / 2) {
                $(document).scrollTop(draggingRow.offset().top);
            } else {
                $(document).scrollTop(draggingRow.offset().top - windowHeight / 2);
            }
            $(txtSort).focus();
        }
    </script>
    </form>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
