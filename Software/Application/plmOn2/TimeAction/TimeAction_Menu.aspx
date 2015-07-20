<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TimeAction_Menu.aspx.vb" Inherits="plmOnApp.TimeAction_Menu" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title></title>
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
<%--		<style >


            BODY {
	            color: #fff;
	            height: 100px;
	            padding: 10px;
	            /* For WebKit (Safari, Google Chrome etc) */
	            background: -webkit-gradient(linear, left top, left bottom, from(#DEE8F4), to(#fff));
	            /* For Mozilla/Gecko (Firefox etc) */
	            background: -moz-linear-gradient(top, #DEE8F4, #fff);
	            /* For Internet Explorer 5.5 - 7 */
	            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr=#DEE8F4, endColorstr=#FFFFFFFF);
	            /* For Internet Explorer 8 */
	            -ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr=#DEE8F4, endColorstr=#FFFFFFFF)";
            }


		</style>--%>
		
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
        <div>
	        <cc1:YSTreeView id="YSTreeView1" runat="server"></cc1:YSTreeView>
        </div>
		</form>
	</body>
</HTML>
