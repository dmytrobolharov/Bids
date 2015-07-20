<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="BatchQ_Menu.aspx.vb" Inherits="plmOnApp.BatchQ_Menu" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head id="Head1" runat="server">
		    <title runat="server" id="PageTitle">Batch Queue</title>
		    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
		    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
		    
            <script type="text/JavaScript">
            <!--
            function timedRefresh(timeoutPeriod) {
	            setTimeout("location.reload(true);",timeoutPeriod);
            }
            //   -->
            </script>		    
    </head>

    <body onload="JavaScript:timedRefresh(60000);">
	    <form id="Form1" method="post" runat="server">
		    <cc1:YSTreeView id="YSTreeView1" runat="server"></cc1:YSTreeView>
	    </form>
    </body>
</html>
