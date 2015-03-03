﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Vendor_FolderPage_Relationship_Remove.aspx.vb" Inherits="plmOnApp.Vendor_FolderPage_Relationship_Remove" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
	<title id="tlRemoveRelationship" runat="server">Remove Relationship</title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
<body>
    <form id="form1" runat="server">
		<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
			runat="server">
			<tr valign="middle">
				<td valign="middle" align="center" width="10"><img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
				<td>
                     <cc1:confirmedimagebutton id="btnDelete" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
                     <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton>
				</td>
			</tr>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
			<tr>
				<td>&nbsp;<asp:Label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Add Relationship</asp:Label></td>
			</tr>
		</table>
		
        <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
            <tr valign="middle">
	            <td valign="middle" align="center" width="10"><img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
	            <td width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></td>
	            <td width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></td>
	            <td nowrap="nowrap" align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></td>
	            <td width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></td>
	            <td width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></td>
	            <td width="10">&nbsp;</td>
	            <td nowrap="nowrap" ><asp:label id="RecordCount" runat="server" CssClass="fontHead"></asp:label></td>
	            <td class="fontHead" align="right" width="110">
                <asp:Label ID="lblRecordsPerPage" runat="server" ></asp:Label></td>
	            <td width="25">
	                <asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
			            <asp:ListItem Value="5">5</asp:ListItem>
			            <asp:ListItem Value="10">10</asp:ListItem>
			            <asp:ListItem Value="15">15</asp:ListItem>
			            <asp:ListItem Value="20">20</asp:ListItem>
			            <asp:ListItem Value="25">25</asp:ListItem>
			            <asp:ListItem Value="30">30</asp:ListItem>
			            <asp:ListItem Value="40">40</asp:ListItem>
			            <asp:ListItem Value="50" Selected="True">50</asp:ListItem>
		            </asp:dropdownlist>
	            </td>
	            <td width="10"><asp:button id="btnGo" onclick="RePage" runat="server" CssClass="fontHead" ></asp:button></td>
            </tr>
        </table>

        <asp:datagrid id="DataGrid1" runat="server" AllowSorting="False" DataKeyField="TradePartnerRelationshipID">
	        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
	        <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
	        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
	        <PagerStyle Visible="False"></PagerStyle>
             <Columns>
                <asp:TemplateColumn>
                    <HeaderTemplate >
                        <input type="checkbox" id="checkAll" onClick="CheckAll(this);" runat="server" name="checkAll">
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="chkDelete" runat="server"></asp:CheckBox>
                    </ItemTemplate>
                </asp:TemplateColumn>
            </Columns>	        
        </asp:datagrid>   
        <asp:label id="SortOrder" runat="server" Visible="False"></asp:label>		
		
    </form>
    
	<script type="text/javascript" language="javascript">
	    var frm = document.form1;
	    function CheckAll(checkAllBox) {
	        var actVar = checkAllBox.checked;
	        for (i = 0; i < frm.length; i++) {
	            e = frm.elements[i];
	            if (e.type == 'checkbox' && e.name.indexOf("chkDelete") != -1)
	                e.checked = actVar;
	        }
	    }
	</script>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
