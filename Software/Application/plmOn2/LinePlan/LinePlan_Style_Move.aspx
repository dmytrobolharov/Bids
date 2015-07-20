<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinePlan_Style_Move.aspx.vb" Inherits="plmOnApp.LinePlan_Style_Move" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">
<html>
<head runat="server">
    <title></title>
        <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet"/>
</head>
<body>
    <form id="form1" runat="server">

	    <table class="tableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
		    runat="server">
		    <tr vAlign="middle">
			    <td vAlign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
			    <td>
				    <asp:ImageButton id="btnNext" runat="server"></asp:ImageButton></td>
		    </tr>
	    </table>
	    <br /><br />
		<table width="100%" bgColor="#ffffff" border="0" class="CodeBlockGreen">
			<tr>
				<td>&nbsp;</td>
				<td><asp:label id="lblOptions" runat="server" CssClass="fontHead"></asp:label></td>
				<td>&nbsp;</td>
			</tr>			
			<tr>
				<td width="10">&nbsp;</td>
				<td><asp:radiobuttonlist id="rbMoveType" runat="server" CssClass="fontHead" AutoPostBack="False">
					</asp:radiobuttonlist></td>
				<td width="50">&nbsp;</td>
			</tr>
		</table>
		
    </form>
</body>
</html>
