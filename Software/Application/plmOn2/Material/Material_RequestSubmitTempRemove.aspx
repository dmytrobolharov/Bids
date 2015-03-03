﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Material_RequestSubmitTempRemove.aspx.vb" Inherits="plmOnApp.Material_RequestSubmitTempRemove" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc2" TagName="Material_Header" Src="Material_Header.ascx" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Remove Template Items</title>
	<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
    <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
<body>
    <form id="form1" runat="server">
      <wc1:Color_Wait ID="Color_Wait" runat="server" />
        <table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
	        height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
	        <tr>
		        <td width="25" height="50">&nbsp;</td>
		        <td>
                    <table cellSpacing="0" cellPadding="0" width="100%" border="0">
	                    <tr>
		                    <td width="25" height="50">&nbsp;<img src="../System/icons/icon_delete.gif" /></td>
		                    <td><span class="fontHead">&nbsp;<asp:Label ID="lblSelTemp" runat="server" Text="Please select template items to be removed..."></asp:Label></span></td>
	                    </tr>
                    </table>
		        </td>
	        </tr>
        </table>		
            <cc1:ScrollingGrid ID="sgMaterialTemplate" runat="server" Height="475px" 
            Width="580px">
                <asp:datagrid id="dgMaterialSubmitTemplate" runat="server" BorderStyle="NotSet" AllowSorting="false"
                 AutoGenerateColumns="false" DataKeyField="MaterialRequestSubmitItemID"  
                 BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" 
                CellSpacing="0">
                    <PagerStyle />
                    <AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
                    <ItemStyle Height="20px" CssClass="font"></ItemStyle>
                    <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
					<Columns>
					    <asp:TemplateColumn HeaderStyle-Width="20" ItemStyle-Width="20">
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
			            <asp:imagebutton id="btnRemove" runat="server" ></asp:imagebutton>
			            <asp:imagebutton id="btnClose" runat="server" OnClientClick="return btnClose_Click()" ></asp:imagebutton>
		            </td>
		            <td align="center">&nbsp;</td>
	            </tr>
            </table>
        <asp:HiddenField ID="hdnXmlFiles" runat="server" />    
    </form>
            <script language="javascript">
                function btnClose_Click() {
                    <%= strExitScript %>
                    return false;
                }
            </script>
</body>
</html>
