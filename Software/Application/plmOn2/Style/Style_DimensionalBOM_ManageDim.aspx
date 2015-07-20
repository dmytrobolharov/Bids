<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_DimensionalBOM_ManageDim.aspx.vb" Inherits="plmOnApp.Style.DimensionalBOM.Style_DimensionalBOM_ManageDim" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>ManageByDimension</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server">

			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><asp:ImageButton 
					    id="btnSave" runat="server" TabIndex="100"></asp:ImageButton><asp:ImageButton
					    id="btnClose" runat="server" TabIndex="101" OnClientClick="return btnClose_Click()"></asp:ImageButton></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">ManageByDimension</asp:label></td>
				</tr>
			</table>
           
		    <asp:datagrid id="DataGrid1" runat="server" AllowSorting="True" DataKeyField="StyleBOMItemID">
			    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
			    <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
			    <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
			    <PagerStyle Visible="False"></PagerStyle>                
		    </asp:datagrid>
		    <asp:label id="SortOrder" runat="server" Visible="False"></asp:label>			    
    </form>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
