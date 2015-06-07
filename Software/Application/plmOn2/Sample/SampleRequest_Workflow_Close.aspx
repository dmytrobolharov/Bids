<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Close.aspx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Close" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
  <head>
     <title runat="server" id="PageTitle"></title>
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
    <meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
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
		<script language='javascript'>
		
			function trimAll(sString) {  
				while (sString.substring(0,1) == ' ') {
					sString = sString.substring(1, sString.length);     
				}
				while (sString.substring(sString.length-1, sString.length) == ' ') {
					sString = sString.substring(0,sString.length-1);     
				}
				return sString; 
			}


			var c=0 ; var d ;  
			try  { d = window.opener.parent["main"].document.location.href  ;  } catch (err) {  c=1; }
	        
			try {   
				if (c==0) {   
					d = trimAll(d);  
					if  (d.charAt ( d.length - 1 ) == '#' )  {  d = d.substr(0, d.length - 1) ;  }   
					top.window.opener.top.frames['main'].document.location.replace(d) ;  
				}   
			} catch(err) { }    
	        
			window.close()
		</script>
		
		
  </head>
  <body MS_POSITIONING="GridLayout">

    <form id="Form1" method="post" runat="server">

    </form>

  </body>
</html>
