<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Component_Add_Selected.aspx.vb" Inherits="plmOnApp.Style.Material.Style_Component_Add_Selected" %>
<%@ Register TagPrefix="uc1" TagName="ctrl_Style_Component_Add_Selected" Src="Style_Component_Add_Selected.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Style</title>
		
		
		<link
		
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	</head>
	<BODY onLoad="window.setTimeout(&quot;location.href='javascript:window.location.reload();'&quot;,10000)">
		<form id="Form1" method="post" runat="server">
			<table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td height="20"></td>
				</tr>
			</table>
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr bgColor="#ffffff">
					<td valign="top"><asp:datagrid id="dgComponent" runat="server" BorderColor="Silver" AutoGenerateColumns="false"
							ShowHeader="False" Width="100%">
							<Columns>
								<asp:TemplateColumn>
									<ItemTemplate>
										<table cellspacing="0" cellpadding="0" width="100%" border="0">
											<tr class="TableHeader">
												<td width="10" bgColor="white" height="24"></td>
												<td class="fontHead" bgColor="white"><%# DataBinder.Eval(Container.DataItem, "ComponentDescription") %> </td>
											</tr>
										</table>
										<uc1:ctrl_Style_Component_Add_Selected id="Style_Component1" runat="server" MaterialSource='<%# MaterialDataSource(DataBinder.Eval(Container.DataItem, "ComponentTypeID")) %>' CTID='<%# DataBinder.Eval(Container.DataItem, "ComponentTypeID") %>' SID='<%# Request.Querystring("SID") %>' SN='<%# Request.Querystring("SN") %>'>
										</uc1:ctrl_Style_Component_Add_Selected>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid></td>
					<td valign="top"></td>
				</tr>
			</table>
		</form>
	</BODY>
</html>
