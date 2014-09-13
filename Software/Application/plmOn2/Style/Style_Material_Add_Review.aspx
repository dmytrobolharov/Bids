<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_Material_Add_Review.aspx.vb" Inherits="plmOnApp.Style.Material.Style_Material_Add_Review" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
		<title>Material</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
		<script language="javascript" src="../System/Jscript/Custom.js"></script>
</head>
<body>
 <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="form1" runat="server">
    
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
                <tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton 
					    id="btnSave" runat="server" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_save.gif" Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
					    id="btnRemove" runat="server" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_remove.gif" CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"  Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
					    id="btnClose" runat="server" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_close.gif" CausesValidation="false"  OnClientClick="javascript:Page_ValidationActive = false;"  Message="NONE"></cc1:confirmedimagebutton></td>
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
			<table>
			<tr>
			<td>
                <asp:DataGrid ID="dgMaterial" runat="server" DataKeyField="StyleMaterialID" AutoGenerateColumns="False"
                    BorderWidth="1px" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" Caption=" ">
                    <PagerStyle />
                    <Columns>
                        <asp:TemplateColumn>
                            <HeaderStyle CssClass="TableHeaderRed" />
                            <HeaderTemplate>
                                <img src="../System/Icons/icon_delete.gif" alt="" />
                            </HeaderTemplate>
                            <ItemStyle CssClass="TableHeaderRed" />
                            <ItemTemplate>
                                <asp:CheckBox runat="server" ID="chbMaterialDEL"  />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                    </Columns>
                    <AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
                    <ItemStyle Height="20px" CssClass="font"></ItemStyle>
                    <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                </asp:DataGrid>
            </td>
			</tr>
			</table>

    
					
    </form>
</body>
</html>
