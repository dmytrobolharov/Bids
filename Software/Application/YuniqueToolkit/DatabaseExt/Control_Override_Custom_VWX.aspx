<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_Override_Custom_VWX.aspx.vb" Inherits="YuniFace.Control_Override_Custom_VWX" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
	<title runat="server" id="PageTitle"></title>
	</head>
	<frameset cols="180,*" frameborder="yes" bordercolor="#dbd7d0">
		<frame name="vwxmenu" src="<%=URLMenu%>" scrolling="yes" marginheight="0" marginwidth="0" />
		<frame name="vwxmain" src="<%=URLMain%>" scrolling="auto" marginheight="0" marginwidth="0" />
	</frameset>
</html>
