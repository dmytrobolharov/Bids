<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinePlan_TempItem_StyleShowroomFrame.aspx.vb" Inherits="plmOnApp.LinePlan_TempItem_StyleShowroomFrame" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
<title runat="server" id="PageTitle"></title>
 
</head>
<frameset cols="200,*" frameborder="yes" bordercolor="#dbd7d0" onload="self.focus()">
	<frame SRC="<%=URLMenu%>" NAME="menu" SCROLLING="auto" marginheight=0 marginwidth=0  />
	<frame name="main" src="<%=URLMain%>" scrolling="auto" marginheight=0 marginwidth=0  />
</frameset>
</html>
