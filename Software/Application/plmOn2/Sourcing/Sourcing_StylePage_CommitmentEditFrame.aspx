<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_StylePage_CommitmentEditFrame.aspx.vb" Inherits="plmOnApp.Sourcing_StylePage_CommitmentEditFrame" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title runat="server" id="PageTitle">Sourcing</title>
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
<frameset cols="200,*" frameborder="yes" bordercolor="#dbd7d0" onload="self.focus()">
	<FRAME SRC="<%=URLMenu%>" NAME="menu" SCROLLING=no marginheight=0 marginwidth=0 >
	<frame name="main" src="<%=URLMain%>" scrolling="auto" marginheight=0 marginwidth=0 >
</frameset>
</html>
