<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_DevelopmentMeas_Sort.aspx.vb" Inherits="plmOnApp.Style.Measurements.Style_DevelopmentMeas_Sort" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Sort</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-1.6.2.min.js"></script>
        <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-ui-1.8.21.custom.min.js"></script>
        <script language="javascript" type="text/javascript" src="../System/Jscript/jquery.tablednd.js"></script>
        <style type="text/css">
            .tDnD_whileDrag
            {
            	background-color: Black;
            }
             .dropimage
            {
            	background-image: url('../System/Icons/dragndrop.jpg');
            	background-repeat:no-repeat;
            	background-position:center;
            	width: 10px;
            }
            
        </style>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
        <div id="test"></div>
			<table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%" border="0">
				<TBODY>
					<tr valign="middle">
						<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td valign="middle" align="left" width="400"><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
						<td></td>
					</tr>
				</TBODY>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Development Sort...</asp:label></td>
				</tr>
			</table>
			<asp:Panel id="pnlSort" runat="server">
			<table cellpadding="0" cellspacing="0" border="0">
				<tr valign="middle">
					<td width="150"><asp:label id="lblSortBy" Runat="server" CssClass="font"><b>Sort by:</b></asp:label>&nbsp;<asp:dropdownlist id="ddlSortBy" Runat="server"></asp:dropdownlist></td>
					<td><cc1:confirmedimagebutton id="btnSort" runat="server" Message="NONE"></cc1:confirmedimagebutton></td>
					<td><cc1:confirmedimagebutton id="btnReset" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			</asp:Panel>
			<asp:datagrid id="DataGrid1" runat="server" Width="300px" BorderColor="#E0E0E0" BorderStyle="Solid"
				BorderWidth="1px" PageSize="100" AutoGenerateColumns="False" DataKeyField="AMLMeasPomID">
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
					<asp:TemplateColumn>
						<HeaderTemplate>
							<asp:Label id="lblPOMHeader" runat="server"><%#GetSystemText("POM")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<%# DataBinder.Eval(Container.DataItem, "RefCode").ToString%>
						</ItemTemplate>
					</asp:TemplateColumn>
                    <asp:TemplateColumn>
						<HeaderTemplate>
							<asp:Label id="lblAltHeader" runat="server"><%# GetSystemText("Alternates")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<%# DataBinder.Eval(Container.DataItem, "AlternatesCode").ToString%>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<asp:Label id="Label1" runat="server"><%#GetSystemText("Description")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<%# DataBinder.Eval(Container.DataItem, "Description").ToString%>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<asp:Label id="Label2" runat="server"><%#GetSystemText("Sort")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:TextBox Runat="server" ID="txtSort" Text='<%#DataBinder.Eval(Container.DataItem,"SortId").tostring%>' Width="40" MaxLength="4">
							</asp:TextBox>
                            <asp:HiddenField runat="server" ID="hdnSort" Value='<%#DataBinder.Eval(Container.DataItem,"SortId").tostring%>' />
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
			</asp:datagrid>
                                   
            </form>
                                                            
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
                        var hdnSort = $(currentRow).find('input[name*="hdnSort"]');
                        var newSort = i.toString(); // Generating the new sort for it
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
                    if (strNewSort == strOldSort) {
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
                    for (var i = 0, currentRow; currentRow = allRows[i]; i++) {
                        // Getting the sort from row
                        var txtCurrentSort = $(currentRow).find('input[name*="txtSort"]');
                        var currentSort = parseInt($(txtCurrentSort).val(), 10);
                        if (isNaN(currentSort)) {
                            currentSort = 0;
                        }
                        // Searching for the row with the sort, bigger then entered by user
                        if (currentSort > newSort) {
                            draggingRow.insertBefore($(currentRow)); // And inserting our row before it
                            wasInserted = true;
                            break;
                        }
                    }
                    var lastRow = currentTable.find('tr:last');
                    if (!wasInserted && draggingRow.html() != lastRow.html() ) { // If edited item now has the bigger sort of all, we inserting it at the end of the table
                        var lastRow = currentTable.find('tr:last');
                        draggingRow.insertAfter(lastRow);
                    }

                    // Setting the consistent value in the textbox
                    var strNewSort = newSort.toString();
                    $(txtSort).val(strNewSort);
                    // Changing the hidden value
                    hdnOldSort.val(strNewSort);
                    // Repainting the table
                    repaintRows($("#DataGrid1").get(0), draggingRow);
                    // Centering the element on screen
                    var rowTop = draggingRow.offset().top;
                    var documentHeight = $(document).height();
                    var windowHeight = $(window).height();
                    if ((documentHeight - rowTop) < windowHeight / 2) {
                        $(document).scrollTop(draggingRow.offset().top);
                    } else {
                        $(document).scrollTop(draggingRow.offset().top - windowHeight/2);
                    }
                    $(txtSort).focus();
                }

            </script>
	</body>
</html>
