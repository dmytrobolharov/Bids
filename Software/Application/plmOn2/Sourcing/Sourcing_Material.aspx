<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_Material.aspx.vb" Inherits="plmOnApp.Sourcing_Material" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
		<title runat="server" id="PageTitle">Material</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
</head>
<body>
    <form id="form1" runat="server">
    
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnCopy" runat="server" Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnRemove" runat="server" Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						</td>
					<td class="FontHead" align="right" width="75"></td>
					<td width="40"></td>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Material Summary</asp:label></td>
				</tr>
			</table>
			<table cellSpacing="2" cellPadding="0" width="100%" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top"></td>
				</tr>
			</table>
			<table>
			<tr>
			<td>
        	<asp:datagrid id="dgMaterial" runat="server"
                DataKeyField="StyleMaterialID" AutoGenerateColumns="False" 
                 BorderWidth="1px" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" 
                    Caption=" ">
				<PagerStyle />
				<AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
			</asp:datagrid>				
			
			</td>
			</tr>
			<tr>
			<td align="right">
			
        	<asp:datagrid id="dgMaterialCost" runat="server" BorderStyle="NotSet" 
                 BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" 
                CellSpacing="0" ShowHeader="False">
				<PagerStyle />
				<AlternatingItemStyle Height="20px" CssClass="fontHead"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="fontHead"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="TableHeaderGreen"></HeaderStyle>
			</asp:datagrid>			
			</td>
			</tr>
			</table>

    
					
    </form>
</body>
</html>
