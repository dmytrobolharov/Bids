<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Body_Frame.aspx.vb" Inherits="plmOnApp.Body_Frame" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title id="htmlHeader" runat="server" ></title>
		<script language="JavaScript">
			<!--

			if (window.screen) {
				var aw = screen.availWidth;
				var ah = screen.availHeight;
				window.moveTo(0, 0);
				window.resizeTo(aw, ah);
			}

			//if (self != top) top.location.replace(self.location);	

			self.focus();

			//-->
		</script>
    
</head>
	<FRAMESET cols="150,*" bordercolor="#ebebeb">
		<FRAME SRC="<%=URLMenu%>" NAME="menu" SCROLLING="auto" marginheight=0 marginwidth=0 >
		<frame name="main" src="<%=URLMain%>" scrolling="auto" marginheight=0 marginwidth=0 >
	</FRAMESET>
	
</html>
