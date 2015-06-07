<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_DesignDetailForm.aspx.vb" Inherits="srmOnApp.Style_DesignDetailForm" %>

<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow" Src="Style_Workflow.ascx" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="uc3" TagName="Style_WorkflowItem" Src="Style_WorkFlowItem.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Design Detail</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<uc1:style_workflow id="Style_Workflow1" runat="server"></uc1:style_workflow>
			<asp:panel id="pnlChange" runat="server">
				<uc1:Style_Change_Alert id="Style_Change_Alert2" runat="server"></uc1:Style_Change_Alert>
			</asp:panel>
			<uc2:style_header id="Style_Header1" runat="server">
			</uc2:style_header>
		    <table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
			    <tr>
				    <td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
			    </tr>
		    </table>
		    <uc3:Style_WorkflowItem id="Style_WorkflowItem1" runat="server" />
		    			
			<asp:datalist id="DataList1" runat="server" DataKeyField="ImageID" RepeatColumns="1" RepeatDirection="Horizontal"
				EnableViewState="True" Width="100%">
				<ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
					VerticalAlign="Top" CssClass="font" BackColor="White">
				</ItemStyle>
				<AlternatingItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
					VerticalAlign="Top" CssClass="font" BackColor="AliceBlue">
				</AlternatingItemStyle>	


				<ItemTemplate>
					<table style="border-color:silver" cellspacing="2" cellpadding="2" width="100%" border="0">
						<tr>
							<td valign="top" style="height:150; width:300px">
								<cc1:BWImageButton id="imgDesign" runat="server"></cc1:BWImageButton>
							</td>
							<td valign="top" style="height:150;" class="font">
								<asp:Label ID="lblComment" runat="server" Width="100%" Height="100%">
								</asp:Label>
								<br />
								<asp:HiddenField ID="txtImageVersion" runat="server" />
								<asp:HiddenField ID="txtImageID" runat="server" />
							</td>
						</tr>

					</table>
				</ItemTemplate>
				<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
			</asp:datalist>
			<br/>
			<table id="Table5" height="24" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="7"><img alt="" src="../System/Images/table_bar_left.gif" /></td>
					<td class="TableBar" valign="middle" align="center" width="20"><img alt="" src="../System/icons/icon_changeobject.gif" /></td>
					<td class="TableBar">
						<asp:label id="lblCreatedBy" runat="server" CssClass="fontHead" ForeColor="Gray"></asp:label>&nbsp;/
						<asp:label id="lblModifiedBy" runat="server" CssClass="fontHead"></asp:label></td>
					<td valign="middle" align="center" width="7"><img alt="" src="../System/Images/table_bar_right.gif" /></td>
				</tr>
			</table>
		</form>
	</body>
</html>


