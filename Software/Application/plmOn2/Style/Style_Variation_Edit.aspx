<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Variation_Edit.aspx.vb" Inherits="plmOnApp.Style_Variation_Edit" %>
<%@ Register TagPrefix="uc1" TagName="Style_Variation" Src="Style_Variation.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>Variation</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-1.6.2.min.js"></script>
        <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-ui-1.8.21.custom.min.js"></script>
        <script language="javascript" type="text/javascript" src="../System/Jscript/jquery.ui.core.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="400"><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" OnClientClick="return btnClose_Click()" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table height="10" cellSpacing="0" cellpadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Names="Tahoma,Verdana" Font-Size="XX-Large">Variation Folder...</asp:label></td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td valign="top"><asp:datalist id="dlVariation" runat="server" RepeatDirection="Horizontal" DataKeyField="Variation" ItemStyle-CssClass="draggable droppable">
							<ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
								VerticalAlign="Top" BackColor="White"></ItemStyle>
							<ItemTemplate>
								<table class="TableHeader" height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
									<tr valign="middle">
										<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
										<td>
											<asp:TextBox id="txtVariation" CssClass="fontHead" runat="server" Text='<%# string.Concat("Variation " + DataBinder.Eval(Container.DataItem, "Variation").ToString) %>'>
											</asp:TextBox>
                                        </td>
									</tr>
								</table>
								<asp:PlaceHolder id="pnlVariation" runat="server"></asp:PlaceHolder>
                                <table class="TableHeader" cellSpacing="0" cellpadding="0" width="100%" border="0">
                                    <tr>
                                        <td valign="middle" align="center" width="11"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
                                        <td width="50%">
                                            <asp:Label runat="server" ID="lblSort" Text='<%# GetUserText("Sort") %>'></asp:Label>
                                        </td>
                                        <td width="40%">
                                            <asp:TextBox runat="server" ID="txtSort" Width="95%" Text='<%# DataBinder.Eval(Container.DataItem, "Sort").ToString  %>'></asp:TextBox>
                                            <asp:HiddenField runat="server" ID="hdnSort" Value='<%# DataBinder.Eval(Container.DataItem, "Sort").ToString  %>'></asp:HiddenField>
                                        </td>
                                    </tr>
                                </table>
							</ItemTemplate>
							<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
						</asp:datalist>
                   </td>
				</tr>
			</table>
			
		</form>
	</body>

    <script type="text/javascript">
        $(function () {
            $(".draggable").draggable({
                helper: 'clone',
                snap: '.ui-droppable',
                snapMode: 'outer'
            });

            $(".droppable").droppable({
                accept: '.draggable',
                tolerance: 'intersect',
                drop: function (event, ui) {
                    $(ui.draggable).insertBefore($(this));
                    processRowDrop(this);
                }
            });

        });

        $('input[name*="txtSort"]').bind('blur', function () {
            sortRows(this);
        });

        function processRowDrop(sender) {
            var tableCells = $(sender).closest('tr').children('td');

            for (var i = 0, currentCell; currentCell = tableCells[i]; i++) {
                /** Recalculating sorts */
                var sortInput = $(currentCell).find('input[name*="txtSort"]');
                var hdnInput = $(currentCell).find('input[name*="hdnSort"]');
                var newSort = (i+1).toString(); // Generating the new sort for it
                newSort = "0000" + newSort;
                newSort = newSort.substr(newSort.length - 4, 4);
                sortInput.val(newSort);
                hdnInput.val(newSort);
            }
        }

        function sortRows(txtSort) {
            var draggingCell = $(txtSort).closest("td[class*='draggable']"); // Getting the current table cell
            var hdnOldSort = draggingCell.find('input[name*="hdnSort"]');
            var strNewSort = $(txtSort).val();
            var strOldSort = hdnOldSort.val();
            var newSort = parseInt(strNewSort, 10);
            var oldSort = parseInt(strOldSort, 10)
            
            // Checking, if sort was changed
            if (newSort == oldSort) {
                // Setting the consistent value in the textbox
                var strNewSort = "0000" + newSort.toString();
                strNewSort = strNewSort.substr(strNewSort.length - 4, 4); // Rough implementation of RIGHT
                $(txtSort).val(strNewSort);
                return;
            }

            // If the sort was changed, begining replacing
            var currentRow = $(draggingCell).closest('tr') // Getting the current row
            if (isNaN(newSort)) {
                newSort = 0;
            }
            // Checking all the cells in the row
            var wasInserted = false;
            var tableCells = currentRow.children('td');
            for (var i = 0, currentCell; currentCell = tableCells[i]; i++) {
                // Getting the sort from row
                var txtCurrentSort = $(currentCell).find('input[name*="txtSort"]');
                var currentSort = parseInt($(txtCurrentSort).val(), 10);
                if (isNaN(currentSort)) {
                    currentSort = 0;
                }
                // Searching for the row with the sort, bigger then entered by user
                if (currentSort > newSort) {
                    draggingCell.insertBefore($(currentCell)); // And inserting our row before it
                    wasInserted = true;
                    break;
                }
            }
            var lastCell = currentRow.children('td:last');
            if (!wasInserted && draggingCell.html() != lastCell.html()) { // If edited item now has the bigger sort of all, we inserting it at the end of the table
                draggingCell.insertAfter(lastCell);
            }

            // Setting the consistent value in the textbox
            var strNewSort = "0000" + newSort.toString();
            strNewSort = strNewSort.substr(strNewSort.length - 4, 4); // Rough implementation of RIGHT
            $(txtSort).val(strNewSort);
            // Changing the hidden value
            hdnOldSort.val(strNewSort);
            $(txtSort).focus();
        }

        </script>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
</html>
