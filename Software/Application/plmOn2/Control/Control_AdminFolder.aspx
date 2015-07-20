<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_AdminFolder.aspx.vb" Inherits="plmOnApp.Control_AdminFolder" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
	    <title runat="server" id="PageTitle"></title>
        <%--<link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>--%>
	</HEAD>
	<FRAMESET cols="198,*" bordercolor="#dbd7d0">
		<FRAME NAME="adminmenu" SRC="<%=URLMenu%>" SCROLLING=yes marginheight=0 marginwidth=0 >
		<frame name="adminmain" src="<%=URLMain%>" scrolling="auto" marginheight=0 marginwidth=0 >
	</FRAMESET>
</HTML>
