<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_Menu.aspx.vb" Inherits="plmOnApp.Control_Menu" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title>Control</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <style type="text/css">
            .btnSearchControl
            {
                position: relative;
                top: 8px;
            }
            .tbSearchControl
            {
                margin-left: 10px;
            }
        </style>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
            <asp:TextBox ID="tbSearch" runat="server" CssClass="tbSearchControl"/>
            <asp:ImageButton ID="btnSearchWorkflow" runat="server" CssClass="btnSearchControl" OnClientClick="return redirectPage()"/>
			<cc1:YSTreeView id="YSTreeView1" runat="server"></cc1:YSTreeView>
            <script>
                $(document).ready(function () {
                    $('#tbSearch').keydown(function (event) {
                        if (event.keyCode == 13) {
                            redirectPage();
                            return false;
                        }
                    });
                });
                function redirectPage() {
                    var strSearch = document.getElementById('tbSearch').value
                    window.location.href = 'Control_Menu.aspx?S=' + strSearch
                    return false
                }
                
            </script>
		</form>
	</body>
</HTML>
