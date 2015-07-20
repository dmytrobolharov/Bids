<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="YuniFace._Default1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head id="Head1" runat="server">
        <title runat="server" id="PageTitle"></title>
	    <script language="JavaScript">
		    <!--
	        var test = "a";
			     if (window.screen) {
				    var aw = screen.availWidth;
				    var ah = screen.availHeight;
				    window.moveTo(0, 0);
				    window.resizeTo(aw, ah);
			    }

			    if (self != top) top.location.replace(self.location);
                //window.onbeforeunload = function() { return "You may choose the follow options."; }
			    function ClearEvent() {
			        window.onbeforeunload = null;
			    }
		    //-->
		    </script>    
        
    </head>

	<frameset rows="70,*" cols="*" frameborder="NO" border="0" framespacing="0" bordercolor="#dbd7d0">
		<frame src="<%=URLTop%>" name="dtop" scrolling="no" noresize>
		<frame src="<%=URLBody%>" name="dbody" scrolling="auto" marginheight=0 marginwidth=0 >
	</frameset>
</html>
