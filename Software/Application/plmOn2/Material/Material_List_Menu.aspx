<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_List_Menu.aspx.vb" Inherits="plmOnApp.Material_List_Menu" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title></title>
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <script src="../System/Jscript/jquery-1.6.2.min.js" type="text/javascript"></script>        
        <script>
                    $(document).ready(function () {

                        $('a').each(function () {

                            if (($(this).attr('href')).indexOf("SVSID") != -1) {

                                $(this).click(function () {
                                    var hrefTB = parent.frames[1].window.location.href;
                                    var oldHref = $(this).attr('href');
                                    if (hrefTB.indexOf("Material_List_Grid") != -1) {
                                        $(this).attr('href', oldHref.replace(/\?TB=[A-z0-9]{1}/gi, hrefTB.substr(hrefTB.indexOf("?TB="), 5)));
                                    }
                                });

                            }

                        });

                    });

                    function redirectRight() {


                    }
        </script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<cc1:YSTreeView id="YSTreeView1" runat="server"></cc1:YSTreeView>
		</form>
	</body>
</HTML>
