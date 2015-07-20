<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow" Src="Style_Workflow.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Component_Where.aspx.vb" Inherits="plmOnApp.Style.Material.Style_Component_Where" %>
<%@ Register TagPrefix="uc1" TagName="ctrl_Style_Component_Where" Src="Style_Component_Where.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Style</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<uc1:style_workflow id="Style_Workflow1" runat="server"></uc1:style_workflow><uc2:style_header id=Style_Header1 runat="server" StyleID='<%Request("SID")%>'>
			</uc2:style_header>
			<table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
				</tr>
			</table>
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr bgColor="#ffffff">
					<td valign="top"><asp:datagrid id="dgStyletype" runat="server" Width="100%" ShowHeader="False" AutoGenerateColumns="false"
							BorderColor="Silver">
							<Columns>
								<asp:TemplateColumn>
									<ItemTemplate>
										<table cellspacing="0" cellpadding="0" width="100%" border="0">
											<tr class="TableHeader">
												<td width="10" bgColor="white" height="24"></td>
												<td class="fontHead" bgColor="white"><%#GetSystemText("Version No")%>.
													<%# DataBinder.Eval(Container.DataItem, "MChange") %>
												</td>
											</tr>
										</table>
										<uc1:ctrl_Style_Component_Where id="Ctrl_Style_Component_Where1" runat="server" MV='<%# DataBinder.Eval(Container.DataItem, "MChange") %>' MTID='<%# Request.Querystring("MTID") %>'>
										</uc1:ctrl_Style_Component_Where>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid></td>
				</tr>
			</table>
		</form>
	</body>
</html>
