<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_Request.aspx.vb" Inherits="plmOnApp.Material_Request" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<TITLE><%= GetSystemText("Material Request")%></TITLE>
		<link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
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
	<FRAMESET cols="175,*" bordercolor="#ebebeb">
		<FRAME SRC="<%=URLMenu%>" NAME="menu" SCROLLING="auto" marginheight=0 marginwidth=0 >
		<frame name="main" src="<%=URLMain%>" scrolling="auto" marginheight=0 marginwidth=0 >
	</FRAMESET>
</HTML>
