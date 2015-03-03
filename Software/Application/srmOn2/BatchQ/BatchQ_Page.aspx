<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="BatchQ_Page.aspx.vb" Inherits="srmOnApp.BatchQ_Page" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
	<title>Job</title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:imagebutton id="btnInvSearch" runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px" />
        <asp:placeholder id="phNav" runat="server"></asp:placeholder>
		<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
			runat="server">
			<tr vAlign="middle">
				<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
				<td><cc1:confirmedimagebutton 
						    id="btnNew" runat="server" Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
						    id="btnSave" runat="server" Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
						    id="btnDelete" runat="server" Message="NONE"></cc1:confirmedimagebutton></td>
				<td>&nbsp;</td>
			</tr>
		</table>    
		
		<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
			height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
			<tr>
				<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#666666" 
                        Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
			</tr>
		</table>

        <table cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr vAlign="top">
				<td>
                    <table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
			            height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
			            <tr>
				            <td><asp:placeholder id="plhXMLForm" runat="server"></asp:placeholder> </td>
			            </tr>
		            </table>
					<asp:datagrid id="DataGrid1" runat="server" AllowSorting="false"  DataKeyField="BatchQueuePageID">
						<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
						<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
						<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
						<PagerStyle Visible="False"></PagerStyle>
					</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
			    </td>
			</tr>
		</TABLE>
				
    </div>
    
		
    </form>
</body>
</html>
