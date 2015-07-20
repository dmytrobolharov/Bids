<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Desktop_Folder.aspx.vb" Inherits="YuniFace.Desktop_Folder" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
	<script language="javascript">
	    function DoTheRefresh() {
	        location.reload();
	    }
	    function DoTheMenuRefresh() {
	        menu.src = menu.src;
	    }
	</script>
	</HEAD>
	<FRAMESET cols="250,*" frameborder="yes" bordercolor="#dbd7d0">
		<frame src="<%=URLMenu%>" name="menu" scrolling="auto" marginheight="0" marginwidth="0" />
		<frame src="<%=URLMain%>" name="main" scrolling="auto" marginheight="0" marginwidth="0" />
	</FRAMESET>
</HTML>
