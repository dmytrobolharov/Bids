<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_ColorwaySeason.aspx.vb" Inherits="srmOnApp.Style_ColorwaySeason" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow" Src="Style_Workflow.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title runat="server" id="PageTitle">Colorway</title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server" style="margin:0px;">

	<uc1:Style_Workflow id="Style_Workflow1" runat="server"></uc1:Style_Workflow>
	
	<uc2:style_header id=Style_Header1 runat="server" StyleID='<%Request("SID")%>'>
	</uc2:style_header>
	<table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
		<tr>
			<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
		</tr>
	</table>
			
    <asp:datagrid id="dgSampleRequest" runat="server" BorderStyle="NotSet" AllowSorting="true"
         AutoGenerateColumns="false" 
         BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" 
        cellspacing="0">
		<PagerStyle />
		<AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
		<ItemStyle Height="20px" CssClass="font"></ItemStyle>
		<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
	</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
    <br /><br/>
	
    </form>
</body>
</html>

