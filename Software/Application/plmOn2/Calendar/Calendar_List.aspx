<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Calendar_List.aspx.vb" Inherits="plmOnApp.Calendar_List" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE runat="server" id="PageTitle"></TITLE>
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<script language="JavaScript">
		<!--
			if (window.screen) {
				var aw = screen.availWidth;
				var ah = screen.availHeight;
				window.moveTo(0, 0);
				window.resizeTo(aw, ah);
			}
			
			//if (self != top) top.location.replace(self.location);				
			
		//-->
		</script>
	</HEAD>
	<FRAMESET cols="150,*" bordercolor="#dbd7d0">
		<FRAME SRC="<%=URLMenu%>" NAME="menu" SCROLLING="auto" marginheight=0 marginwidth=0 >
		<frame name="main" src="<%=URLMain%>" scrolling="auto" marginheight=0 marginwidth=0 >
	</FRAMESET>
</HTML>
