<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Body_List_Menu.aspx.vb" Inherits="plmOnApp.Body_List_Menu" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Body Menu</title>
    <LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
			<cc1:ystreeview id="YSTreeView1" runat="server"></cc1:ystreeview>					
    </form>
</body>
</html>
