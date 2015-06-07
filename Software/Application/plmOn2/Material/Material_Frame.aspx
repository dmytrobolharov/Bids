<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_Frame.aspx.vb" Inherits="plmOnApp.Material_Frame" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <title id="htmlHeader" runat="server" >Material</title>
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
    <meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
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
  <FRAMESET  cols = "150,*" bordercolor=#DBD7D0>
     <FRAME SRC="<%=URLMenu%>" NAME="menu" SCROLLING=yes marginheight=0 marginwidth=0 >
     <frame name="main" src="<%=URLMain%>" scrolling="auto" marginheight=0 marginwidth=0 > 
  </FRAMESET>