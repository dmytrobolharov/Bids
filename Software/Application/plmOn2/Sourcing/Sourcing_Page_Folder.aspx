<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_Page_Folder.aspx.vb" Inherits="plmOnApp.Sourcing_Page_Folder" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<frameset cols="150,*" frameborder="yes" bordercolor="#dbd7d0" onload="self.focus()">
	<FRAME SRC="Sourcing_Page_Menu.aspx" NAME="menu" SCROLLING=no marginheight=0 marginwidth=0 >
	<frame name="main" src="Sourcing_Page_List_Search.aspx?TID=<%= Me.UserProperties.TeamID %>" scrolling="auto" marginheight=0 marginwidth=0 >
</frameset>
</html>
