<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Image_Folder.aspx.vb" Inherits="plmOnApp.Image_Folder" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
        <title id="htmlHeader" runat="server" >Image</title>
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
	<FRAMESET cols="150,*" bordercolor="#dbd7d0" onload="self.focus()">
		<FRAME SRC="<%=URLMenu%>" NAME="menu" SCROLLING="auto" marginheight=0 marginwidth=0 >
		<frame name="main" src="<%=URLMain%>" scrolling="auto" marginheight=0 marginwidth=0 >
	</FRAMESET>
</HTML>
