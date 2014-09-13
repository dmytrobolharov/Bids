<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Change_Folder.aspx.vb" Inherits="plmOnApp.Change_Folder" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE runat="server" id="PageTitle">Change Folder</TITLE>
		<script language="JavaScript">
		<!--
		    if (window.screen) {
		        var aw = screen.availWidth;
		        var ah = screen.availHeight;
		        window.moveTo(0, 0);
		        window.resizeTo(aw, ah);
		    }

		    if (self != top) top.location.replace(self.location);				
			
		//-->
		</script>
	</HEAD>
	<FRAMESET cols="150,*" frameborder="yes" bordercolor="#dbd7d0">
		<FRAME SRC="<%=URLMenu%>" NAME="menu" scrolling="auto" marginheight=0 marginwidth=0 >
		<frame name="main" src="<%=URLMain%>" scrolling="auto" marginheight=0 marginwidth=0 >
	</FRAMESET>
</HTML>
