<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_Link_Colorway_Select.aspx.vb" Inherits="plmOnApp.Material_Link_Colorway_Select" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>
			<%= Me.strColorway %>
		</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><asp:imagebutton 
					    id="btnInvSearch" runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px"></asp:imagebutton><cc1:confirmedimagebutton 
                        id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton></td>
					<td width="75">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</TABLE>
			<table class="TableHeaderGreen" height="25" cellSpacing="0" cellPadding="0" width="100%"
				border="0">
				<tr>
					<td width="10">&nbsp;</td>
					<td><asp:Label ID="lblMaterialSelected" runat="server" Text="Material Selected"></asp:Label></td>
				</tr>
			</table>
			<table height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td bgColor="#ffffff">
						<asp:Image Runat="server" ID="imgMaterial"></asp:Image>
					</td>
				</tr>
				<tr>
					<td bgColor="#ffffff"><asp:label id="lblMaterial" runat="server" CssClass="font"></asp:label></td>
				</tr>
			</table>
			<table cellSpacing="1" cellPadding="1" width="100%" border="0">
				<tr>
					<td vAlign="top" bgColor="#ffffff">
						<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td width="10">&nbsp;</td>
								<td><asp:Label ID="lblSelected" runat="server" Text="Selected"></asp:Label>								
									<%= strColor %>
								</td>
							</tr>
						</table>
						<TABLE id="Table1" borderColor="silver" height="100" cellSpacing="0" cellPadding="0" width="65"
							align="center" border="1">
							<TR>
								<TD id="tdHex" runat="server"><asp:imagebutton id="Imagebutton1" runat="server" Width="65px" CommandName="ColorChip"></asp:imagebutton></TD>
							</TR>
							<TR height="15">
								<TD bgColor="#ffffff"><FONT color="#000000" size="1"><asp:label id="lblHdColorCode" runat="server"></asp:label></FONT></TD>
							</TR>
							<TR height="15">
								<TD bgColor="#ffffff"><FONT color="#000000" size="1"><asp:label id="lblHdColorName" runat="server"></asp:label></FONT></TD>
							</TR>
						</TABLE>
					</td>
				</tr>
			</table>
			<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td width="10">&nbsp;</td>
					<td><asp:Label ID="lblAvailable" runat="server" Text="Available"></asp:Label>						
						<%= strColor %>
					</td>
				</tr>
			</table>
			
			
			
			<table height="15" cellSpacing="0" cellpadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhSearchControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td width="100%" valign="top">
						<table id="Table3" height="45">
							<tr>
								<td>
									<asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>			
			
			<br />
						
			<asp:checkbox id="chkAllColor" runat="server"></asp:checkbox><asp:Label ID="lblApplytoAll" runat="server" Text="Apply to All"></asp:Label>			
			<%= strColorway %>
			
			
			<asp:datagrid id="dgColors" runat="server" DataKeyField="MaterialColorID" AutoGenerateColumns="False" ShowHeader="False" 
			    AllowPaging="False" >
				<AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font"></ItemStyle>
				<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn>
						<ItemStyle Width="50px"></ItemStyle>
						<ItemTemplate>
						    <asp:ImageButton id="imgColor" runat="server" CommandName="Select" />
							<input id="txtColorPaletteID" type="hidden" runat="server" />
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
				<PagerStyle Visible="False"></PagerStyle>
			</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
			
			
            </form>
            <script language="javascript">
            function btnClose_Click() {
                <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</HTML>
