<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Planning_Folder.aspx.vb" Inherits="plmOnApp.Planning_Folder" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle"></title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<script language="JavaScript">
		<!--
			if (window.screen) {
				var aw = screen.availWidth;
				var ah = screen.availHeight;
				window.moveTo(0, 0);
				window.resizeTo(aw, ah);
			}
			
			if (self != top) top.location.replace(self.location);

			var isFirstLoad = true;

			function loadFirsOption() {
			    if ('<%= strIsRedirect %>' == 1 && isFirstLoad == true) {

			        window.top.main.location.href = window.top.menu.document.getElementById('tv_1').href + '&UPDPR=<%=UPDPR%>';
                    isFirstLoad = false;
			    }
            }

            function reloadPage(url) {
                window.location.href = url;
            }
		//-->
		</script>
	</HEAD>
	<FRAMESET cols="250,*" bordercolor="#dbd7d0" id="frameset">
		<FRAME SRC="<%=URLMenu%>" NAME="menu" id="menu" SCROLLING=auto marginheight=0 marginwidth=0 onload="loadFirsOption()">
		<frame name="main" src="<%=URLMain%>" scrolling="auto" marginheight=0 marginwidth=0>
	</FRAMESET>
</HTML>
