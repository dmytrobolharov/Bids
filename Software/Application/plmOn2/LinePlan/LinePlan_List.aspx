<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinePlan_List.aspx.vb" Inherits="plmOnApp.LinePlan_List" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
 	<title runat="server" id="PageTitle">Line Plan</title>
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
    <FRAMESET cols="150,*" bordercolor="#ebebeb">
		<FRAME SRC="<%=URLMenu%>" NAME="menu" SCROLLING="auto" marginheight="0" marginwidth="0" >
		<frame src="<%=URLMain%>" name="main" scrolling="auto" marginheight="0" marginwidth="0" >
	</FRAMESET>
</html>
