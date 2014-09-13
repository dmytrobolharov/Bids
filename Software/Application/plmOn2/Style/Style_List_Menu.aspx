<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_List_Menu.aspx.vb" Inherits="plmOnApp.Style_List_Menu" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title></title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
        <script src="../System/Jscript/jquery-1.6.2.min.js" type="text/javascript"></script>
        <script type="text/javascript">

            $(document).ready(function () {

                $('a').each(function () {

                    if (($(this).attr('href')).indexOf("Style_List_Search") != -1) {

                        $(this).click(function () {
                            var hrefTB = parent.frames[1].window.location.href;
                            var oldHref = $(this).attr('href');
                            if (hrefTB.indexOf("Style_List_Search") != -1) {
                                $(this).attr('href', oldHref.replace(/\?TB=[A-z0-9]{1}/gi, hrefTB.substr(hrefTB.indexOf("?TB="), 5)));
                            }
                        });

                    }

                });

            });

            function redirectRight() {
            

            }
        </script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<cc1:ystreeview id="YSTreeView1" runat="server"></cc1:ystreeview></form>
	</body>
</html>
