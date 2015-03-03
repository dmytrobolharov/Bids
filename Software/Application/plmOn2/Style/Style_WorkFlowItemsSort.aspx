<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_WorkFlowItemsSort.aspx.vb"
    Inherits="plmOnApp.Style_WorkFlowItemsSort" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sort</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../System/Jscript/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="../System/Jscript/jquery.tablednd.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <style type="text/css">
        .dropimage
        {
            background-image: url('../System/Icons/dragndrop.jpg');
            background-repeat: no-repeat;
            background-position: center;
            width: 15px;
            min-width: 15px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="fixed_icons">
        <a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help"
            target="_blank" id="yHelp"></a>
    </div>
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"></cc1:ConfirmedImageButton>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <table style="border-bottom: red thin solid; border-left-style: none; background-color: white"
        height="30" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                &nbsp;<asp:Label ID="lblImageHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="Medium"
                    ForeColor="#E0E0E0">Sorting Pages...</asp:Label>
            </td>
        </tr>
    </table>
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                <asp:DataGrid ID="DataGrid1" runat="server" Width="300px" BorderColor="#E0E0E0" BorderStyle="Solid"
                    BorderWidth="1px" PageSize="100" AutoGenerateColumns="False" DataKeyField="WorkFlowItemID">
                    <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
                    <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
                    <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                    <Columns>
                        <asp:TemplateColumn ItemStyle-CssClass="dropimage" HeaderStyle-BorderWidth="0" ItemStyle-BorderWidth="0" >
                            <HeaderTemplate>&nbsp;
                            </HeaderTemplate>
                            <ItemTemplate>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn HeaderStyle-BorderWidth="0" ItemStyle-BorderWidth="0">
                            <HeaderTemplate>
                                <img alt="" src="../System/Icons/icon_link.gif" />
                            </HeaderTemplate>
                            <ItemStyle Width="20px" />
                            <ItemTemplate>
                                <img runat="server" alt="" src="../System/Icons/icon_link.gif" id="imgWorkFlowItemID"
                                    visible="false" />
                                <asp:HiddenField runat="server" ID="hdnWFItemInfo" Value='<%# Eval("WorkFlowItemName") & " (" & Eval("ItemTypeLabel") & ")" %>' />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                    </Columns>
                </asp:DataGrid>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        $(".TableHeader").addClass("nodrag");
        $(".TableHeader").addClass("nodrop");

        $('input[name*="txtSort"]').bind('blur', function () {
            sortRows(this);
        });

        $(document).ready(function () {

            var headers = $("td.TableHeader");
            var spans = $("#DataGrid1").find("span");
            for (var i = 0; i < spans.length; i++) {
                if (i < headers.length) {
                    var width = $(spans[i]).width();
                    $(headers[i]).contents().wrap("<div style='width:" + width + "px;'>", "</div>");
                }
                $(spans[i]).contents().unwrap();
            }
            $("#DataGrid1 td").first().contents().wrap("<div style='width:" + 15 + "px;'>", "</div>");

            $("#DataGrid1 tr").hover(function () {
                $(this).css("cursor", "url(../System/Cursor/openhand.cur), default");
            }, function () {
                $(this).css("cursor", "default");
            });

            $("#DataGrid1").tableDnD({
                onDrop: processRowDrop,
                onCancel: repaintRows,
                onDragClass: null,
                onDragStyle: { "background-color": "#6495ED" }
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
//                var hdnSort = $(currentRow).find('input[name*="hdnSort"]');
                var newSort = "0000" + i.toString(); // Generating the new sort for it
                newSort = newSort.substr(newSort.length - 4, 4); // Rough implementation of RIGHT
                sortInput.val(newSort);
//                hdnSort.val(newSort);
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
            // Changing the hidden value
            //hdnOldSort.val(strNewSort);
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
