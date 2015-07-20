<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Material_Group_Frame.aspx.vb" Inherits="plmOnApp.Material_Group_Frame" %>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Material</title>
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
</head>
  <FRAMESET  cols = "150,*" frameborder=yes bordercolor=#DBD7D0>
     <FRAME SRC="<%=URLMenu%>" NAME="menu" SCROLLING=yes marginheight=0 marginwidth=0 >
     <frame name="main" src="<%=URLMain%>" scrolling="auto" marginheight=0 marginwidth=0 > 
  </FRAMESET>
  