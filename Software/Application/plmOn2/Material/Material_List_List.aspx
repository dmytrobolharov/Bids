<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_List_List.aspx.vb" Inherits="plmOnApp.Material_List_List" %>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title>WebForm3</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<table width="100%" height="27" border="0" cellpadding="0" cellspacing="0" class="TableHeader">
				<tr>
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td class="fontHead"><asp:Label ID="lblMaterialList" runat="server" Text="Material List"></asp:Label></td>
				</tr>
			</table>
			<TABLE id="Table1" cellSpacing="1" cellPadding="0" width="100%" border="0">
				<TR>
					<TD vAlign="top" width="550">
						<TABLE class="ToolbarShort" id="Table2" height="20" cellSpacing="0" cellPadding="0" width="100%"
							border="0">
							<TR class="fontHead">
								<TD align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<TD>
									<DIV align="left">&nbsp;
										<asp:label id="lblCurrentIndex" Runat="server" Visible="False" Text="0"></asp:label><asp:label id="lblPageSize" Runat="server" Visible="False" Text="20"></asp:label></DIV>
								</TD>
								<TD width="20">
						            <DIV align="center"><asp:imagebutton id="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif" OnClick="ShowFirstPage"></asp:imagebutton></DIV>
					            </TD>
					            <TD width="20">
						            <DIV align="center"><asp:imagebutton id="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif" OnClick="ShowPreviousPage"></asp:imagebutton></DIV>
					            </TD>
					            <TD width="150">
						            <DIV align="center"><asp:label id="lblCounts" CssClass="plaintable" Runat="server"></asp:label></DIV>
					            </TD>
					            <TD width="20">
						            <DIV align="center"><asp:imagebutton id="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif" OnClick="ShowNextPage"></asp:imagebutton></DIV>
					            </TD>
					            <TD width="20">
						            <DIV align="center"><asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif" OnClick="ShowLastPage"></asp:imagebutton></DIV>
					            </TD>
					            <TD>
						        <DIV align="left"><B><asp:label id="lblRecordCount" Runat="server" Visible="true"></asp:label>&nbsp;<asp:Label ID="lblRecordsFound" runat="server" Text="Records Found"></asp:Label></B></DIV>
						         </B></TD>
							</TR>
						</TABLE>
						<asp:datalist id="DataList1" runat="server" DataKeyField="MaterialID" RepeatColumns="5" OnItemCommand="DataList1_ItemCommand"
							OnItemDataBound="DataList1_ItemDataBound" RepeatDirection="Horizontal" Width="100%" EnableViewState="True">
							<ItemStyle HorizontalAlign="Left" VerticalAlign="Top"></ItemStyle>
							<ItemTemplate>
								<TABLE borderColor="silver" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
									border="1">
									<TR>
										<TD vAlign="top" width="200" bgColor="#ffffff" height="150"></TD>
									</TR>
								</TABLE>
							</ItemTemplate>
							<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
						</asp:datalist>
					</TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
