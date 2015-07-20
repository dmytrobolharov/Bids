<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_BOL_Template_Category_Menu.aspx.vb" Inherits="plmOnApp.Control_BOL_Template_Category_Menu" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<HEAD>
		<title>Template Categories</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	    <LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	    <LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
		<table class="TableHeader" style="height:25" cellspacing="0" cellpadding="0" width="100%" border="0">
				    <tr>
					<td valign="middle" align="center" width="10"><img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
					<td valign="middle" align="left">
						<div>
							<asp:imagebutton id="btnInactive" runat="server" OnClick="ShowInactive" ImageUrl="../System/icons/icon_ShowInactive.gif"></asp:imagebutton>
                            &nbsp;
                            <asp:imagebutton id="btnActive" runat="server" OnClick="HideInactive" ImageUrl="../System/icons/icon_ok.gif"></asp:imagebutton>
                            &nbsp;
							<asp:imagebutton id="btnRefresh" runat="server" ImageUrl="../System/icons/icon_refresh.gif"></asp:imagebutton>
						</div>
					</td>
				    </tr>
			        </table>
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td colspan="2" align="center" style="color:#E0E0E0;font-family:Tahoma,Verdana;font-size:medium;">
					    <table class="TableHeader" style="height:25" cellspacing="0" cellpadding="0" width="100%" border="0">
				            <tr>
				                <td valign="middle" align="center" width="10"><img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
					            <td align="left" style="color:#666666;font-family:Tahoma,Verdana;font-size:medium;"><asp:Label ID="lblCDdata" runat="server"></asp:Label></td>
					        </tr>
					    </table>
					</td>
				</tr>
				<tr>
					<td>
                        &nbsp;
					</td>
					<td>
                        <cc1:YSTreeView id="YSTreeView1" runat="server"></cc1:YSTreeView>
					</td>
				</tr>
			</table>
		
		</form>
	</body>
</html>