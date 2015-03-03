<%@ Page Language="vb" AutoEventWireup="false" Codebehind="LinePlanningColor_Allocation.aspx.vb" Inherits="plmOnApp.LinePlanningColor_Allocation" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Color</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>
						<cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton>
					</td>
				</tr>
			</table>
			<table height="10" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="35" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblMaterialHeader" runat="server" ForeColor="Gray" 
                            Font-Size="Medium" Font-Names="Tahoma,Verdana"></asp:label></td>
				</tr>
			</table>
			
            <table>
                <tr>
                    <td><asp:DropDownList ID="ddlLinePlanAttribute1" runat="server" AutoPostBack="True"  /></td>
                    <td><asp:DropDownList ID="ddlLinePlanAttribute2" runat="server" AutoPostBack="True"  /></td>
                    <td><asp:DropDownList ID="ddlLinePlanAttribute3" runat="server" AutoPostBack="True"  /></td>
                    <td><asp:DropDownList ID="ddlLinePlanAttribute4" runat="server" AutoPostBack="True"  /></td>
                    <td><asp:ImageButton ID="btnGo" runat="server" ImageUrl="../System/Icons/icon_go.gif" /></td>
                    <td></td>
                </tr>
            </table>
			
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr bgColor="#ffffff">
					<td vAlign="top" width="600">
					    <asp:datagrid id="DataGrid1" runat="server" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
							PageSize="100" AutoGenerateColumns="False" Width="400px">
							<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<input type="checkbox" id="checkAll" onClick="CheckAll(this);" runat="server" name="checkAll">
									</HeaderTemplate>
									<ItemTemplate>
										<asp:CheckBox id="chkSelect" runat="server"></asp:CheckBox>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<div align="left">
											<asp:Label id="lblLinePlanAttributeHeader1" Text='<%#GetSystemText("Level 1")%>' runat="server" /></div>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblLinePlanAttribute1" runat="server" />
									</ItemTemplate>
								</asp:TemplateColumn>
																<asp:TemplateColumn>
									<HeaderTemplate>
										<div align="left">
											<asp:Label id="lblLinePlanAttributeHeader2" Text='<%#GetSystemText("Level 2")%>' runat="server" /></div>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblLinePlanAttribute2" runat="server" />
									</ItemTemplate>
								</asp:TemplateColumn>
																<asp:TemplateColumn>
									<HeaderTemplate>
										<div align="left">
											<asp:Label id="lblLinePlanAttributeHeader3" Text='<%#GetSystemText("Level 3")%>' runat="server" /></div>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblLinePlanAttribute3" runat="server" />
									</ItemTemplate>
								</asp:TemplateColumn>
																<asp:TemplateColumn>
									<HeaderTemplate>
										<div align="left">
											<asp:Label id="lblLinePlanAttributeHeader4" Text='<%#GetSystemText("Level 4")%>' runat="server" /></div>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblLinePlanAttribute4" runat="server" />
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid></td>
					<td vAlign="top">&nbsp;</td>
				</tr>
			</table>
		</form>
		<SCRIPT language="javascript">
			var frm = document.Form1 ;
			function CheckAll( checkAllBox )
			{
			var actVar = checkAllBox.checked ;
			for(i=0;i< frm.length;i++)
			{
				e=frm.elements[i];
				if ( e.type=='checkbox' && e.name.indexOf("chkSelect") != -1 )
				e.checked= actVar ;
			}
			}
		</SCRIPT>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</HTML>
