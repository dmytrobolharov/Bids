<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_Override_SPX.aspx.vb" Inherits="YuniFace.Control_Override_SPX" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
	<title runat="server" id="PageTitle"></title>
	<script language="javascript">
	    function DoTheRefresh() {
	        location.reload();
	    }
	</script>
	</HEAD>
	<FRAMESET cols="180,*" frameborder="yes" bordercolor="#dbd7d0">
		<FRAME NAME="spxmenu" SRC="<%=URLMenu%>" SCROLLING=yes marginheight=0 marginwidth=0 >
		<frame name="spxmain" src="<%=URLMain%>" scrolling="auto" marginheight=0 marginwidth=0 >
	</FRAMESET>
</HTML>
