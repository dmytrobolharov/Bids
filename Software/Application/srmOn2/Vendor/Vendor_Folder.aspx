<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Vendor_Folder.aspx.vb" Inherits="srmOnApp.Vendor_Folder" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle"></title>
	</HEAD>
	<FRAMESET id="frameContainer" cols="150,*" bordercolor="#dbd7d0" onload="self.focus()">
		<FRAME SRC="<%=URLMenu%>" name="menu" scrolling="yes" marginheight=0 marginwidth=0 >
		<frame name="main" src="<%=URLMain%>" scrolling="yes" marginheight=0 marginwidth=0 >
	</FRAMESET>
</HTML>
