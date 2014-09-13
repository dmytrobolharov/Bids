<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_PlanningType_Sort.aspx.vb" Inherits="plmOnApp.Control_PlanningType_Sort" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Sort</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
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
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TBODY>
					<TR vAlign="middle">
						<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
						<TD vAlign="middle" align="left" width="400"><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="Confirmedimagebutton1" runat="server" 
								Message="NONE"></cc1:confirmedimagebutton></TD>
						<TD></TD>
					</TR>
				</TBODY>
			</TABLE>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:label></td>
				</tr>
			</table>
			<table border="0">
				<tr vAlign="middle">
					<td align="right">
						<table>
							<tr vAlign="middle">
								<td><asp:label id="lblSortBy" CssClass="fontHead" Runat="server"></asp:label></td>
								<td><asp:dropdownlist id="ddlSortBy" Runat="server">
													
									</asp:dropdownlist></td>
								<td><cc1:confirmedimagebutton id="btnSort" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td><asp:datagrid id="DataGrid1" runat="server" EnableViewState="true" AutoGenerateColumns="False"
							BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" DataKeyField="PlanningTypeID">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
							<Columns>
                                <asp:TemplateColumn ItemStyle-CssClass="dropimage">
						            <HeaderTemplate>
						            </HeaderTemplate>
						            <ItemTemplate>
						            </ItemTemplate>
					            </asp:TemplateColumn>
								<asp:TemplateColumn>
									<ItemStyle Width="40px"></ItemStyle>
									<HeaderTemplate>
										<asp:Label runat="server" CssClass="fontHead" ID="label3"><%#GetSystemText("Code")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label runat="server" ID="lblCustomCode"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<ItemStyle Width="200px"></ItemStyle>
									<HeaderTemplate>
										<asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("Name")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label runat="server" ID="lblCustomName"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<ItemStyle Width="40px"></ItemStyle>
									<HeaderTemplate>
										<asp:Label runat="server" CssClass="fontHead" ID="label4"><%#GetSystemText("Active")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label runat="server" ID="lblCustomActive"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<ItemStyle Width="40px"></ItemStyle>
									<HeaderTemplate>
										<asp:Label runat="server" CssClass="fontHead" ID="Label2"><%#GetSystemText("Sort")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox Runat="server" ID="txtSort" Width="40" MaxLength="5"></asp:TextBox>
                                        <asp:HiddenField runat="server" ID="hdnSort" />
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid></td>
				</tr>
			</table>
		</form>
	</body>
</HTML>

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
         if (!wasInserted && draggingRow.html() != lastRow.html()) { // If edited item now has the bigger sort of all, we inserting it at the end of the table
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
             $(document).scrollTop(draggingRow.offset().top - windowHeight / 2);
         }
         $(txtSort).focus();
     }
</script>
