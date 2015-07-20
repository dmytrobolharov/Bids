<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Material_List_Menu.aspx.vb" Inherits="srmOnApp.Material_List_Menu" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YSTreeView" Assembly="YSTreeView" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title runat="server" id="PageTitle">Material Menu</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    

	    <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%" border="0">
	    <tr>
		    <td vAlign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
		    <td class="fontHead">
		        <div align="center">
			        <asp:Label Runat="server" ID="lblMenuHeader">Material</asp:Label>
		        </div>
		    </td>
	    </tr>
	    </table>
	    <cc1:YSTreeView id="YSTreeView1" runat="server"></cc1:YSTreeView>    
    </form>
</body>
</html>

