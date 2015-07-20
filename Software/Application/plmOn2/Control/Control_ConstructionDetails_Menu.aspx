<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_ConstructionDetails_Menu.aspx.vb" Inherits="plmOnApp.Control_ConstructionDetails_Menu" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
	<head>
		<title>Construction Tree</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
	</head>
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
					<td colspan="2" >
				        <table class="TableHeader" style="height:25" cellspacing="0" cellpadding="0" width="100%" border="0">
				            <tr>
				                <td valign="middle" align="center" width="10"><img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
					            <td align="left" style="color:#666666;font-family:Tahoma,Verdana;font-size:medium;"><asp:Label ID="lblCDdata" runat="server">Process Details</asp:Label></td>
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
