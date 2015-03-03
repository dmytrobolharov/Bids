<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_Seasonality.aspx.vb" Inherits="plmOnApp.Style_Seasonality" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register src="Style_Header.ascx" tagname="Style_Header" tagprefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Seasonality</title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
    <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
<body>
    <form id="form1" runat="server">

			<table class="TableHeader" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr valign="middle" height="25">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Seasonality</asp:label></td>
				</tr>
			</table>
			<table height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr class="TableHeader">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="20"><asp:imagebutton id="imbBtnExpand" runat="server" ImageUrl="../System/Icons/icon_Next.gif" ToolTip="Show Material Header..."></asp:imagebutton><asp:imagebutton id="imgBtnCollapse" runat="server" ImageUrl="../System/Icons/icon_Down.gif" ToolTip="Hide Material Header..."></asp:imagebutton></td>
					<td class="fontHead">&nbsp;
						<asp:label id="lblMaterialDetail" runat="server" Visible =false  ></asp:label></td>
				</tr>
			</table>
 
			<asp:panel id="Panel1" runat="server" CssClass="font" BorderWidth="0" BackColor="#ffffff" Width="100%">
				<table height="45" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
					<tr>
						<td width="900">
                            <uc1:Style_Header ID="Style_Header1" runat="server" />
                        </td>
					
						<td>&nbsp;</td>
					</tr>
				</table>
			</asp:panel>
			
            <asp:datagrid id="dgSampleRequest" runat="server" BorderStyle="NotSet" AllowSorting="true"
                 AutoGenerateColumns="false" 
                 BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" 
                CellSpacing="0">
				<PagerStyle />
				<AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
			</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>



    </form>
</body>
</html>
