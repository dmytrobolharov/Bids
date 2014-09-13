<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Color_Library.aspx.vb" Inherits="plmOnApp.Color_Library" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title runat="server" id="thePageTitle">Color Library</title>
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
</head>
	<frameset cols="240,700,300" frameborder="yes" bordercolor="#dbd7d0" >
		<frame name="colormenu" src="<%=URLMenu%>" scrolling="yes" marginheight="0" marginwidth="0" >
		<frame name="colorlibrary" src="<%=URLSearch%>" scrolling="auto" marginheight="0" marginwidth="0" >
		<frame name="colorpalette" src="<%=URLPending%>" scrolling="auto" marginheight="0" marginwidth="0" >
	</frameset>
</html>


