<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Copy_DetailGrid.aspx.vb" Inherits="plmOnApp.Style_Copy_DetailGrid" %>
<%@ Register TagPrefix="uc1" TagName="Style_Copy_Workflow" Src="Style_Copy_Workflow.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow" Src="Style_Workflow.ascx" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Style Copy</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
		    <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" height="25" border="0">
				<tr>
					<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnConfirm" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<asp:panel id="pnlChange" runat="server">
				<uc1:Style_Change_Alert id="Style_Change_Alert2" runat="server"></uc1:Style_Change_Alert>
			</asp:panel>
			<uc2:style_header id="Style_Header1" runat="server" StyleID='<%# Request.QueryString("CSID") %>'>
			</uc2:style_header>
			<table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
				</tr>
			</table>
			<table cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td valign="top"><asp:datagrid id="DataGrid1" runat="server" DataKeyField="StyleDetailGridId" EnableViewState="False"
							BorderColor="#E0E0E0">
							<AlternatingItemStyle Height="20px"  CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle Height="25px" CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
						</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label></td>
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
                                <input id="txtImageVersion" type="hidden" value='<%# DataBinder.Eval(Container.DataItem, "ImageVersion") %>' runat="server" />
                                <input id="txtImageID" type="hidden" value='<%# DataBinder.Eval(Container.DataItem, "ImageID") %>' runat="server" />
                            </td>
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
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</html>
