<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Vendor_Folder.aspx.vb" Inherits="plmOnApp.Vendor_Folder" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle"></title>
		
        <script language="JavaScript">
		<!--
			if (window.screen) {
				var aw = screen.availWidth;
				var ah = screen.availHeight;
				window.moveTo(0, 0);
				window.resizeTo(aw, ah);
            }
			//self.focus();
            //if (self != top) top.location.replace(self.location);
            window.opener.top.frames['dbody'].frames['menu'].location.reload(true);
		//-->
		</script>
	</HEAD>
	<FRAMESET id="frameContainer" cols="150,*" bordercolor="#dbd7d0" onload="self.focus()">
		<FRAME SRC="<%=URLMenu%>" name="menu" scrolling="yes" marginheight=0 marginwidth=0 >
		<frame name="main" src="<%=URLMain%>" scrolling="yes" marginheight=0 marginwidth=0 >
	</FRAMESET>
</HTML>
