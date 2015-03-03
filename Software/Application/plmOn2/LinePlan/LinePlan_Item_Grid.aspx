<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="LinePlan_Item_Grid.aspx.vb" Inherits="plmOnApp.LinePlan_Item_Grid" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Style</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="Table1" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSaveClose" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE"></cc1:confirmedimagebutton><cc1:bwimagebutton id="btnSizeSort" runat="server"></cc1:bwimagebutton><cc1:bwimagebutton id="btnRemove" runat="server"></cc1:bwimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
					<td class="FontHead" align="right" width="75"></td>
					<td width="40"></td>
					<td></td>
				</tr>
			</table>
			<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR>
					<TD vAlign="top"><asp:datagrid id="DataGrid1" runat="server" BorderColor="#E0E0E0" PageSize="100" AllowSorting="True"
							DataKeyField="StyleID" BackColor="White">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
						</asp:datagrid>
						<asp:label id="SortOrder" runat="server" Visible="False"></asp:label></TD>
				</TR>
			</TABLE>
			<BR>
		</form>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</HTML>
