<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="BatchQueue_Folder.aspx.vb" Inherits="plmOnApp.BatchQueue_Folder" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
	<head>
		<title runat="server" id="PageTitle">Compliance Folder</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1" />
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1" />
		<meta name="vs_defaultClientScript" content="JavaScript" />
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5" />
		<script language="JavaScript">
		    if (window.screen) {
		        var aw = screen.availWidth;
		        var ah = screen.availHeight;
		        window.moveTo(0, 0);
		        window.resizeTo(aw, ah);
		    }

		    //if (self != top) top.location.replace(self.location);				
		</script>
	</head>
	
	<frameset cols="150,*" frameborder="yes" bordercolor="#dbd7d0">
		<frame SRC="<%=URLMenu%>" name="menu" scrolling="no" marginheight="0" marginwidth="0" />
		<frame name="main" src="<%=URLMain%>" scrolling="auto" marginheight="0" marginwidth="0" />
	</frameset>
</html>
