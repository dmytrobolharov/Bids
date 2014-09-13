<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_ColorwaySeasonal.aspx.vb" Inherits="srmOnApp.Style_ColorwaySeasonal" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow" Src="Style_Workflow.ascx" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<%@ Register TagPrefix="uc3" TagName="Style_Header" Src="Style_Header.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title runat="server" id="PageTitle">Colorway</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">

			<uc1:Style_Workflow id="Style_Workflow1" runat="server"></uc1:Style_Workflow>
		<uc3:style_header id=Style_Header1 runat="server" StyleID='<%Request("SID")%>'>
	</uc3:style_header>
	<table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
		<tr>
			<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
		</tr>
	</table>
            <br /> 
            <asp:datagrid id="dgColorway" runat="server" BorderStyle="NotSet" AllowSorting="true" DataKeyField="StyleColorID"
                 AutoGenerateColumns="false" 
                 BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" 
                cellspacing="0">
		        <PagerStyle />
		        <AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
		        <ItemStyle Height="20px" CssClass="font"></ItemStyle>
		        <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
	        </asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
			<br/>  			
								
    </form>
</body>
</html>


