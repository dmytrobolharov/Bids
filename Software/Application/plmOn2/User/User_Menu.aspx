<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="User_Menu.aspx.vb" Inherits="plmOnApp.User_Menu" %>

<%@ Register Assembly="YsTreeView" Namespace="Yunique.WebControls.YsTreeView" TagPrefix="cc1" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
	<head>
		<title runat="server" id="PageTitle">User Menu</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
	</head>

	<body>
		<form id="Form1" method="post" runat="server">
        <cc1:YsTreeView ID="YsTreeView1" runat="server" />
		</form>
	</body>
</html>
