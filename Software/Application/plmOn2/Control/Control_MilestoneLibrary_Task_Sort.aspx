<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_MilestoneLibrary_Task_Sort.aspx.vb" Inherits="plmOnApp.Control_MilestoneLibrary_Task_Sort" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title>Sort</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
    <meta content="JavaScript" name="vs_defaultClientScript" />
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link rel="stylesheet" href="../System/CSS/jquery.ui.core.css" />
    <link rel="stylesheet" href="../System/CSS/jquery.ui.theme.css" />
    <link href="../System/CSS/jquery-sortable.css" rel="stylesheet" />
    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="../System/Jscript/jquery.ui.core.js"></script>
    <script type="text/javascript" src="../System/Jscript/jquery.ui.widget.js"></script>
    <script type="text/javascript" src="../System/Jscript/jquery.ui.mouse.js"></script>
    <script type="text/javascript" src="../System/Jscript/jquery.ui.sortable.js"></script>    
    <script type="text/javascript" src="../System/Jscript/jquery-ui-1.10.3.custom.min.js"></script>
    <script type="text/javascript" src="../System/Jscript/jquery.tablednd.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <style type="text/css">
            .dropimage
            {
            	background-image: url('../System/Icons/dragndrop.jpg');
            	background-repeat:no-repeat;
            	background-position:center;
            	padding: 7px;
            }
            
        </style>
</head>
<body>
    <form id="Form1" method="post" runat="server">
    <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tbody>
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                </td>
                <td valign="middle" align="left">
                    <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"></cc1:ConfirmedImageButton>
                </td>                
            </tr>
        </tbody>
    </table>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45"
        cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:Label>
            </td>
        </tr>
    </table>
    <asp:Panel ID="pnlSort" runat="server">
        <table cellspacing="0" cellpadding="0" border="0">
            <tr valign="middle">
                <td width="150">
                    <asp:Label ID="lblSortBy" CssClass="font" runat="server" Font-Bold="True"></asp:Label>&nbsp;
                    <asp:DropDownList ID="ddlSortBy" runat="server">
                    </asp:DropDownList>
                </td>
                <td>
                    <cc1:ConfirmedImageButton ID="btnSort" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:DataGrid ID="DataGrid1" runat="server" Width="300px" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
        PageSize="100" AutoGenerateColumns="False" DataKeyField="MilestoneItemID">
        <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
        <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
        <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
        <Columns>
            <asp:TemplateColumn ItemStyle-CssClass="dropimage">
                <HeaderTemplate>
                </HeaderTemplate>
                <ItemTemplate>
                </ItemTemplate>
            </asp:TemplateColumn>            
        </Columns>
    </asp:DataGrid>
    <script type="text/javascript">

        $(".TableHeader").addClass("nodrag");
        $(".TableHeader").addClass("nodrop");
        $('input[name*="txtSort"]').bind('blur', function () {
            sortRows(this);
        });

        $(document).ready(function () {
            $("#DataGrid1").tableDnD({
                onDrop: processRowDrop,
                onCancel: repaintRows,
                onDragClass: null,
                onDragStyle: { "background-color": "#6495ED", "cursor": "url(../System/Cursor/closedhand.cur)" }
            })
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

        function processRowDrop(table, row) {
            repaintRows(table, row);
            for (var i = 1, currentRow; currentRow = table.rows[i]; i++) {
                /** Recalculating sorts */
                var sortInput = $(currentRow).find('input[name*="txtSort"]'); // Getting the txtSort for current row
                var hdnSort = $(currentRow).find('input[name*="hdnSort"]');
                var newSort = parseInt(i, 10).toString(); // Generating the new sort for it
                newSort = newSort.substr(newSort.length - 4, 4); // Rough implementation of RIGHT
                sortInput.val(newSort);
                hdnSort.val(newSort);
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
            var strNewSort = parseInt(newSort, 10).toString();
            strNewSort = strNewSort.substr(strNewSort.length - 4, 4); // Rough implementation of RIGHT
            $(txtSort).val(strNewSort);
            // Changing the hidden value
            hdnOldSort.val(strNewSort);
            // Repainting the table
            // repaintRows($("#DataGrid1").get(0), draggingRow);
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