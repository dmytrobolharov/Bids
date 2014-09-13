<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_UserProfileFolder.aspx.vb"
    Inherits="plmOnApp.Control_UserProfileFolder" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title runat="server" id="PageTitle"></title>
</head>
<frameset cols="180,*" bordercolor="#dbd7d0">
		<frame name="profilemenu" src="<%=URLMenu%>" scrolling="yes" marginheight="0" marginwidth="0" >
		<frame name="profilemain" src="<%=URLMain%>" scrolling="auto" marginheight="0" marginwidth="0" >
	</frameset>
</html>
