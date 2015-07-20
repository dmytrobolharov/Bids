<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Calendar_Page_Menu.aspx.vb" Inherits="plmOnApp.Calendar_Page_Menu" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
    <title>Calendar</title>

		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
  
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<cc1:ystreeview id="YSTreeView1" runat="server"></cc1:ystreeview>
           </form>
	</body>
</html>
