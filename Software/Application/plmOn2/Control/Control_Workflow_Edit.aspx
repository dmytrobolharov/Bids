<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_Workflow_Edit.aspx.vb" Inherits="plmOnApp.Control_Workflow_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Worklflow</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
        <script src="../System/Jscript/jquery.ui.core.js"></script>
	    <script src="../System/Jscript/jquery.ui.widget.js"></script>
        <script src="../System/Jscript/jquery.ui.mouse.js"></script>
        <script src="../System/Jscript/jquery.ui.sortable.js"></script>
        <script language="javascript" type="text/javascript" src="../System/Jscript/jquery.tablednd.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
        <style type="text/css">
            .dropimage
            {
            	background-image: url('../System/Icons/dragndrop.jpg');
            	background-repeat:no-repeat;
            	background-position:center;
            	width: 10px;
            }
            
        </style>

	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td valign="middle" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="590">
					<cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnSaveClose" runat="server" Message="NONE"></cc1:confirmedimagebutton>
					<cc1:bwimagebutton id="imgAdd" runat="server" ></cc1:bwimagebutton>
					<cc1:confirmedimagebutton id="btnDelete" Message="NONE" causesvalidation="false" runat="server" ></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" CausesValidation="False" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton>
                    <cc1:confirmedimagebutton id="btnDivSType" runat="server" Message="NONE" CausesValidation="False"></cc1:confirmedimagebutton>
					</td>
					<td valign="middle" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td valign="middle" width="140"><asp:label id="lblSortBy" CssClass="font" 
                            Runat="server" Font-Bold="True" Font-Overline="False"><b>&nbsp; 
								</b></asp:label><asp:dropdownlist id="ddlSortBy" Runat="server">
							<asp:ListItem ></asp:ListItem>
						</asp:dropdownlist></td>
					<td valign="middle"><cc1:confirmedimagebutton id="btnSort" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<table cellSpacing="2" cellPadding="0" width="100%" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
				</tr>
			</table>
			<br>
			<table cellSpacing="0" cellPadding="0" border="0">
				<tr>
					<td vAlign="top"><asp:datagrid id="DataGrid1" runat="server" Width="600px" AutoGenerateColumns="False" PageSize="100"
							BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0">
							<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							<Columns>
								
                                <asp:TemplateColumn ItemStyle-CssClass="dropimage" HeaderStyle-CssClass="TableHeader">
						            <HeaderTemplate>
							
						            </HeaderTemplate>
						            <ItemTemplate>
                               
							 
						            </ItemTemplate>
					            </asp:TemplateColumn>
                                <asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
                                        <asp:Label ID="lblWorkflowHeader" runat="server"><%#GetSystemText("Workflow")%></asp:Label>	
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblWorkflow" runat="server">Label</asp:Label><INPUT id="txtWorkflow" type="hidden" runat="server">
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
                                        <asp:Label ID="lblAssignedHeader" runat="server"><%#GetSystemText("Assigned To")%></asp:Label>	
									</HeaderTemplate>
									<ItemTemplate>
										<asp:DropDownList id="dlAssignedTo" runat="server"></asp:DropDownList>
										<asp:RequiredFieldValidator id="rvAssignedTo" runat="server" CssClass="fontHead" ErrorMessage="*" ControlToValidate="dlAssignedTo"
											ToolTip="Select User..." Display="Dynamic">*</asp:RequiredFieldValidator>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="20px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
                                        <asp:Label ID="lblDaysHeader" runat="server"> <%#GetSystemText("Days")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtDays" runat="server" Width="40px" MaxLength="5"></asp:TextBox>
<%--										<asp:RegularExpressionValidator id="rvDays" runat="server" CssClass="fontHead" ErrorMessage="*" ControlToValidate="txtDays"
											ValidationExpression="^[0-9]+[0-9]{0,2}$" ToolTip="Between 0 to 999 Days" Display="Dynamic"></asp:RegularExpressionValidator>
--%>										<asp:RangeValidator id="rvDays" runat="server" CssClass="fontHead" ErrorMessage="*" ControlToValidate="txtDays"
											    Type="Integer" MinimumValue="-9999" MaximumValue="99999" ToolTip="Invalid integer format!" Display="Dynamic"></asp:RangeValidator>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="20px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
                                        <asp:Label ID="lblAlertsHeader" runat="server" ><%#GetSystemText("Alerts")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtAlerts" runat="server" Width="40px" MaxLength="5"></asp:TextBox>
<%--										<asp:RegularExpressionValidator id="rvAlerts" runat="server" CssClass="fontHead" ErrorMessage="*" ControlToValidate="txtAlerts"
											ValidationExpression="^[0-9]+[0-9]{0,2}$" ToolTip="Between 0 to 999 Days" Display="Dynamic"></asp:RegularExpressionValidator>
--%>										<asp:RangeValidator id="rvAlerts" runat="server" CssClass="fontHead" ErrorMessage="*" ControlToValidate="txtAlerts"
											    Type="Integer" MinimumValue="-9999" MaximumValue="99999" ToolTip="Invalid integer format!" Display="Dynamic"></asp:RangeValidator>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="20px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<DIV align="center">
											<asp:Label id="lblSort" runat="server"> <asp:Label ID="lblOrderHeader" runat="server"><%#GetSystemText("Order")%></asp:Label></asp:Label></DIV>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtSort" runat="Server" maxlength="2" Width="40px"></asp:TextBox>
                                         <asp:HiddenField runat="server" ID="hdnSort" Value='' />
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid></td>
				</tr>
			</table>
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
                    var newSort = "00" + i.toString(); // Generating the new sort for it
                    newSort = newSort.substr(newSort.length - 2, 2); // Rough implementation of RIGHT
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
                var strNewSort = "0" + newSort.toString();
                strNewSort = strNewSort.substr(strNewSort.length - 2, 2); // Rough implementation of RIGHT
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

        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</HTML>
