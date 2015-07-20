<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_StylePage_NewQuotationsLibrary.aspx.vb" Inherits="plmOnApp.Sourcing_StylePage_NewQuotationsLibrary" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title runat="server" id="thePageTitle">Quotation Palette</title>
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
	<frameset cols="240,*" frameborder="yes" bordercolor="#dbd7d0" >
		<frame name="QuoteMenu" src="<%=URLMenu%>" scrolling="yes" marginheight="0" marginwidth="0" >
		<frame name="QuoteMain" src="<%=URLMain%>" scrolling="auto" marginheight="0" marginwidth="0" >
		<%--<frame name="QuotePartner" src="<%=URLPartner%>" scrolling="auto" marginheight="0" marginwidth="0" >
	--%></frameset>
</html>


