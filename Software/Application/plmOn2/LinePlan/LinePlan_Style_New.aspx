<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinePlan_Style_New.aspx.vb" Inherits="plmOnApp.LinePlan_Style_New" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>New Item</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
	    <table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
		    runat="server">
		    <TR vAlign="middle">
			    <TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
			    <TD><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" ></cc1:confirmedimagebutton></TD>
		    </TR>
	    </table>
		<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
			<tr>
				<td width="100%"></td>
			</tr>
		</table>
		
		<table width="100%" bgColor="#ffffff" border="0">
			<tr>
				<td width="50">&nbsp;</td>
				<td>&nbsp;
					<asp:label id="lblOptions" runat="server" CssClass="fontHead">Please select options...</asp:label><br>
					<asp:radiobuttonlist id="rbSizeVariation" runat="server" CssClass="fontHead" AutoPostBack="True">
						<asp:ListItem Value="S">New</asp:ListItem>
						<asp:ListItem Value="V">Copy / Carry Over</asp:ListItem>
					</asp:radiobuttonlist></td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		</table>
				
    </form>
</body>
</html>
