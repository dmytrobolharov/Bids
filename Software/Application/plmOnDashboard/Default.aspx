<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="plmOnDashboard._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Dashboard</title>
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
	<frameset cols="175,*" frameborder="yes" bordercolor="#dbd7d0">
		<frame SRC="<%=URLMenu%>" name="menu" scrolling="auto" marginheight=0 marginwidth=0 >
		<frame name="main" src="<%=URLMain%>" scrolling="auto" marginheight=0 marginwidth=0 >
	</frameset>
</html>
