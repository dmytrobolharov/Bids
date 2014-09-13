<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Trade_Frame.aspx.vb" Inherits="plmOnApp.SampleRequestTrade_Frame"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
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
				
			//-->
		</script>
	</HEAD>
	<frameset rows="40%,*">
		<FRAME NAME="top" SRC="<%=URLTop%>" SCROLLING=yes marginheight=0 marginwidth=0 >
		<frame name="botton" src="<%=URLBotton%>" scrolling="auto" marginheight=0 marginwidth=0 >
	</frameset>
</HTML>
