<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Calendar_Page_Frame.aspx.vb" Inherits="plmOnApp.Calendar_Page_Frame" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>

<frameset cols="200,*" bordercolor="#ebebeb">     
	<frame src='<%="Calendar_Page_FrameMenu.aspx?CST=" & _CustomCalendar & "&CHID=" & _CalendarHeaderID%>' name="menu" scrolling="yes" marginheight="0" marginwidth="0" />
	<frame name="main" id="mainF" src='<%= _MainFrameLink %>' scrolling="auto" marginheight="0" marginwidth="0" />
</frameset>

</html>
