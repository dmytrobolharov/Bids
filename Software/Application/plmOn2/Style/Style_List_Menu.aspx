<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_List_Menu.aspx.vb" Inherits="plmOnApp.Style_List_Menu" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title></title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
        <script src="../System/Jscript/jquery-1.6.2.min.js" type="text/javascript"></script>
        <script type="text/javascript">
            jQuery(document).ready(function ($) {
                var hrefs = document.getElementsByTagName("a");
                var ifSilh = <%= IsSilhouette %>
                for(var i = 0; i < hrefs.length; i++){
                    var ref = hrefs.item(i);
                    if (ref.id.indexOf("nav") != -1){
                        ref.href = ref.href + "&Silho=" + ifSilh
                        
                    }
                }
            });
            function MenuRefresh () { 
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
            };
        </script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<cc1:ystreeview id="YSTreeView1" runat="server"></cc1:ystreeview></form>
	</body>
</html>
