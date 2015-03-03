<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_DesignDetail_MultigridCustom.aspx.vb" Inherits="plmOnApp.Style.DesignDetail.Style_DesignDetail_MultigridCustom" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow" Src="Style_Workflow.ascx" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">

<html>
	<head>
		<title>Multi-grid Custom Page</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
	    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
	</head>
	<body>
        <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<uc1:style_workflow id="Style_Workflow1" runat="server"></uc1:style_workflow>
			<asp:panel id="pnlChange" runat="server">
				<uc1:Style_Change_Alert id="Style_Change_Alert2" runat="server"></uc1:Style_Change_Alert>
			</asp:panel>
			<uc2:style_header id=Style_Header1 runat="server" StyleID='<%Request("SID")%>'>
			</uc2:style_header>
			<table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
				</tr>
			</table>
			<table cellspacing="2" cellpadding="0" width="100%" border="0">
                <tr>
                    <td>
                        <asp:PlaceHolder ID="plhHeaderControlsHolder" runat="server"></asp:PlaceHolder>
                    </td>
                </tr>
            </table>
			<table cellspacing="2" cellpadding="0" width="100%" border="0">
                <tr>
                    <td>
                        <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
                    </td>
                </tr>
            </table>

            <asp:datalist id="DataList1" runat="server" DataKeyField="ImageID" RepeatColumns="4" RepeatDirection="Horizontal"
				EnableViewState="True" Width="100%">
				<ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
					VerticalAlign="Top" BackColor="White"></ItemStyle>
				<ItemTemplate>
					<table borderColor="silver" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff"
						border="0">
						<tr>
							<td valign="top" bgColor="#ffffff" height="150">
								<cc1:BWImageButton id="imgDesign" runat="server"></cc1:BWImageButton></td>
						</tr>
						<tr>
							<td>
								<INPUT id=txtImageVersion type=hidden value='<%# DataBinder.Eval(Container.DataItem, "ImageVersion") %>' runat="server">
								<INPUT id=txtImageID type=hidden value='<%# DataBinder.Eval(Container.DataItem, "ImageID") %>' runat="server"></td>
						</tr>
					</table>
				</ItemTemplate>
				<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
			</asp:datalist>
			<BR>
			<table id="Table5" height="24" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_left.gif"></td>
					<td class="TableBar" valign="middle" align="center" width="20"><IMG src="../System/icons/icon_changeobject.gif"></td>
					<td class="TableBar">
						<asp:label id="lblCreatedBy" runat="server" CssClass="fontHead" ForeColor="Gray"></asp:label>&nbsp;/
						<asp:label id="lblModifiedBy" runat="server" CssClass="fontHead"></asp:label></td>
					<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_right.gif"></td>
				</tr>
			</table>
		</form>
	</body>
</html>

