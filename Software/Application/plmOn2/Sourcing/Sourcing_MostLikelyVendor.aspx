<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_MostLikelyVendor.aspx.vb" Inherits="plmOnApp.Sourcing_MostLikelyVendor" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- 
using: 
Style_Sourcing_MostlikelyVendor_Default.xml
spx_StyleSourcing_MostLikelyVendor_SELECT
-->
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title runat="server" id="PageTitle">Most Likely Vendor</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet"/>
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script>
    function btnClose_Click() {
        <%= strExitScript %>
        return false;
    }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        
        
        <table class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" border="0">
		<tr valign="middle" height="25">
		    <td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
			<td><asp:ImageButton id="btnSave" runat="server"  /><asp:ImageButton id="btnClose" 
			runat="server" OnClientClick="return btnClose_Click();" /></td>
		</tr>
		</table>
					
					
        
         <table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
			height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
			<tr>
				<TD width="900">&nbsp;&nbsp;
					<asp:label id="lbHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" 
					Font-Names="Tahoma,Verdana">Most Likely Vendor</asp:label></TD>
			</tr>
		</table>		
         <br/><br/>
        <asp:datagrid id="DataGrid1" runat="server" BackColor="White" 
            BorderColor="#E0E0E0" PageSize="100" AllowSorting="True" DataKeyField="StyleSeasonYearID">
            <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
            <ItemStyle CssClass="ItemTemplate"></ItemStyle>
            <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
            <PagerStyle Visible="False"></PagerStyle>
        </asp:datagrid>    
    </div>
    </form>
</body>
</html>
