<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Material_Add_Core_Select.aspx.vb" Inherits="plmOnApp.Style.Material.Style_Material_Add_Core_Select" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>

<!--
Material_Core_Default.xml
Material_CoreItem_Default.xml
-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>Material Group</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    	<script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
		<link href="../System/CSS/Tree.css" rel="stylesheet" type="text/css" />
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
					<td class="FontHead" align="right" width="75"></td>
					<td width="40"></td>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:label></td>
				</tr>
			</table>
			<table cellSpacing="2" cellpadding="0" width="100%" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="top"></td>
				</tr>
			</table>
		
		<cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview>
		
		<asp:Panel runat="server"  ID="pnlMat" >
		    <br /><br />
        	<asp:datagrid id="dgMaterial" runat="server"
                DataKeyField="MaterialCoreItemID" AutoGenerateColumns="False" 
                 BorderWidth="1px" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" 
                    Caption=" ">
				<PagerStyle />
				<AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
				<Columns>
				    <asp:TemplateColumn>
				        <HeaderTemplate>
				            <input type="checkbox" onclick="SelectAll(this);" />
				        </HeaderTemplate>
				        <ItemTemplate>
				            <asp:CheckBox runat ="server" id="chkSelect" />
				        </ItemTemplate>
				    </asp:TemplateColumn>
				</Columns>
			</asp:datagrid>				
        </asp:Panel>			
        
        <asp:Panel ID="pnlColor" runat="server">
            <br /><br />
            <asp:datagrid id="dgColor" runat="server" DataKeyField="StyleMaterialGroupItemColorTempID" AutoGenerateColumns="False" 
                 BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" Visible="true">
				<PagerStyle />
				<AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font"></ItemStyle>
				<HeaderStyle Height="25px" CssClass="fontHead"></HeaderStyle>
				<Columns>
				    <asp:TemplateColumn Visible="false">
				        <ItemTemplate>
				            <input id="Hidden1" type="hidden" runat="server" />
				        </ItemTemplate>
				    </asp:TemplateColumn>
				</Columns>
			</asp:datagrid>	
        </asp:Panel>

			</form>
		<SCRIPT language="javascript">
			var frm = document.Form1 ;
			function SelectAll(checkAllBox)
			{
			var actVar = checkAllBox.checked ;
			for(i=0;i< frm.length;i++)
			{
				e=frm.elements[i];
				if ( e.type=='checkbox' && e.name.indexOf("chkSelect") != -1 )
				e.checked= actVar ;
			}
			}
		</SCRIPT>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</html>
