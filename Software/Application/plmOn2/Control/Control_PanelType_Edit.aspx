<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_PanelType_Edit.aspx.vb" Inherits="plmOnApp.Control_PanelType_Edit" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Control Panel Folder</title>
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
        <script type="text/javascript" src="../System/Jscript/jquery-1.8.3.min.js"></script>
        <script type="text/javascript" src="../System/Jscript/jquery-ui-1.10.3.custom.min.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="Table1" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>
					    <cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
					    <cc1:confirmedimagebutton id="btnRemove" runat="server" Message="NONE" CausesValidation="false" ></cc1:confirmedimagebutton>
					</td>
					<td class="FontHead" align="right" width="75"></td>
					<td width="40"></td>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:label></td>
				</tr>
			</table>
			<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR bgColor="#ffffff">
					<TD vAlign="top"><asp:datagrid id="DataGrid1" runat="server" BorderColor="#E0E0E0" PageSize="100" AllowSorting="True"
							DataKeyField="ControlPanelTypeID" BackColor="White">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
						</asp:datagrid>
						<TABLE cellSpacing="2" cellPadding="0" width="500" border="0">
							<TR class="fontHead">
								<TD width="10">&nbsp;</TD>
								<TD noWrap width="85">
                                    <asp:Label ID="lblNumOfRows" runat="server"></asp:Label></TD>
								<TD width="35"><asp:dropdownlist id="dpNewRow" runat="server" CssClass="fontHead">
										<asp:ListItem Value="1" Selected="True">1</asp:ListItem>
										<asp:ListItem Value="2">2</asp:ListItem>
										<asp:ListItem Value="3">3</asp:ListItem>
										<asp:ListItem Value="4">4</asp:ListItem>
										<asp:ListItem Value="5">5</asp:ListItem>
										<asp:ListItem Value="10">10</asp:ListItem>
										<asp:ListItem Value="15">15</asp:ListItem>
										<asp:ListItem Value="20">20</asp:ListItem>
									</asp:dropdownlist></TD>
								<TD width="300"><cc1:confirmedimagebutton id="btnAddRow" runat="server" Message="NONE" ></cc1:confirmedimagebutton></TD>
							</TR>
						</TABLE>
						<asp:label id="SortOrder" runat="server" Visible="False"></asp:label></TD>
				</TR>
			</TABLE>
		<SCRIPT language="javascript">
			var frm = document.Form1 ;
			function CheckAll( checkAllBox )
			{
			var actVar = checkAllBox.checked ;
			for(i=0;i< frm.length;i++)
			{
				e=frm.elements[i];
				if (e.type == 'checkbox' && e.name.indexOf("chbControlPanelTypeID") != -1)
				e.checked= actVar ;
			}
			}
			$("input[id$=txtSort]").change(function () {
			    var value = $(this).val();
			    $(this).val(pad(value.replace(/\D/g, ''), 3));
			});

			function pad(str, max) {
			    str = str.toString();
			    return str.length < max ? pad("0" + str, max) : str;
			}
		</SCRIPT>
		</form>
	</body>
</HTML>
