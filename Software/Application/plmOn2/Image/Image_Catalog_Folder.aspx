<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Image_Catalog_Folder.aspx.vb" Inherits="plmOnApp.Image_Catalog_Folder" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<head runat="server">
		<title></title>
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
	</head>
	<FRAMESET cols="150,*" bordercolor="#dbd7d0" onload="self.focus()">
		<FRAME SRC="<%=URLMenu%>" NAME="menu" SCROLLING="auto" marginheight=0 marginwidth=0 >
		<frame name="main" src="<%=URLMain%>" scrolling="auto" marginheight=0 marginwidth=0 >
	</FRAMESET>
</HTML>
