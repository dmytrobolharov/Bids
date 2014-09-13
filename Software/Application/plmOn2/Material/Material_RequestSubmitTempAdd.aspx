﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Material_RequestSubmitTempAdd.aspx.vb" Inherits="plmOnApp.Material_RequestSubmitTempAdd" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc2" TagName="Material_Header" Src="Material_Header.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Select Template Items</title>
	<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
    <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
</head>
<body>
    <form id="form1" runat="server">

        <table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
	        height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
	        <tr>
		        <td width="25" height="50">&nbsp;</td>
		        <td>
                    <table cellSpacing="0" cellPadding="0" width="100%" border="0">
	                    <tr>
		                    <td width="25" height="50">&nbsp;<img src="../System/icons/icon_form_new.gif" /></td>
		                    <td><span class="fontHead">&nbsp;<asp:Label ID="lblSelTemp" runat="server" Text="Please Select Available Template Items..."></asp:Label></span></td>
	                    </tr>
                    </table>
		        </td>
	        </tr>
        </table>		
            <cc1:ScrollingGrid ID="sgMaterialTemplate" runat="server" Height="475px" 
            Width="580px">
                <asp:datagrid id="dgMaterialSubmitTemplate" runat="server" BorderStyle="NotSet" AllowSorting="true"
                 AutoGenerateColumns="false"  DataKeyField="MaterialRequestWorkflowItemID" 
                 BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" 
                CellSpacing="0">
                    <PagerStyle />
                    <AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
                    <ItemStyle Height="20px" CssClass="font"></ItemStyle>
                    <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                    <Columns>
					    <asp:TemplateColumn>
					        <ItemTemplate>
					            <asp:CheckBox  runat="server" ID="chkSelect" />
					        </ItemTemplate>
					    </asp:TemplateColumn>
					</Columns> 
                </asp:datagrid>
        </cc1:ScrollingGrid>
        <asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
            <table style="BORDER-TOP: gray thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: gainsboro" height="40" cellSpacing="0" cellPadding="0" width="100%" bgColor="gainsboro" border="0">
	            <tr>
		            <td align="center" width="50">&nbsp;</td>
		            <td align="center" width="500">
			            <asp:imagebutton id="btnSave" runat="server" ></asp:imagebutton>
			            <asp:imagebutton id="btnClose" runat="server" ></asp:imagebutton>
		            </td>
		            <td align="center">&nbsp;</td>
	            </tr>
            </table>
    <asp:HiddenField ID="hdnXmlFiles" runat="server" />
    </form>
</body>
</html>
