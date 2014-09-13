<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Desk_Folder.aspx.vb" Inherits="plmOnApp.Desk_Folder" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
	</HEAD>
	<FRAMESET cols='<%=request.querystring("MW")%>,*' bordercolor="#dbd7d0" border="1px">
		<FRAME SRC="<%=URLMenu%>" NAME="menu" scrolling="auto" marginheight=0 marginwidth=0 >
		<frame name="main" src="<%=URLMain%>" scrolling="auto" marginheight=0 marginwidth=0 >
	</FRAMESET>
</HTML>
