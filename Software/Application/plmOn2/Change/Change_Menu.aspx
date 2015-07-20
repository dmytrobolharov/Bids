<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Change_Menu.aspx.vb" Inherits="plmOnApp.Change_Menu" %>

<%@ Register Assembly="YsTreeView" Namespace="Yunique.WebControls.YsTreeView" TagPrefix="cc1" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
	<head>
		<title runat="server" id="PageTitle">Change Menu</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
        <script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
	</head>

	<body>
		<form id="Form1" method="post" runat="server">
        <cc1:YsTreeView ID="YsTreeView1" runat="server" />        
		</form>
		
		<script type="text/javascript">
		    function CalendarForcePostBack(textbox, date) {
		        var start = date,
                    end = new Date(start.getFullYear(), start.getMonth(), start.getDate() + 1),
                    format = function (d) { return d.getFullYear() + "-" + ("0" + (d.getMonth() + 1)).slice(-2) + "-" + ("0" + d.getDate()).slice(-2); };
		        
		        window.parent.main.location = "../../Change/<%= ChangeMainURL %>" + "&start=" + format(start) + "&end=" + format(end);
		    }
        </script>
	</body>
</html>
