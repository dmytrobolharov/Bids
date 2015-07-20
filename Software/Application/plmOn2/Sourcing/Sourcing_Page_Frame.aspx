<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_Page_Frame.aspx.vb" Inherits="plmOnApp.Sourcing_Page_Frame" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>

<frameset cols="200,*" bordercolor="#ebebeb">     
	<frame src='<%="Sourcing_Page_FrameMenu.aspx?CST=" & _CustomSourcing & "&SHID=" & _SourcingHeaderID%>' name="menu" scrolling="yes" marginheight="0" marginwidth="0" />
	<frame name="main" id="mainF" src='<%= _MainFrameLink %>' scrolling="auto" marginheight="0" marginwidth="0" />
</frameset>

</html>
