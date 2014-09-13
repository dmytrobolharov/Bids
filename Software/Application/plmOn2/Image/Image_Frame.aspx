<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Image_Frame.aspx.vb" Inherits="plmOnApp.Image_Frame" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title runat="server" id="PageTitle"></title>
</head>
<frameset cols="180,*" bordercolor="#dbd7d0">
	<frame NAME="imagemenu" src='<%=String.Format("Image_ControlMenu.aspx?IID={0}", Request.QueryString("IID"))%>' scrolling="yes" marginheight="0" marginwidth="0">
	<frame name="imagemain" src='<%=String.Format("Image_Edit.aspx?IWTIID=10000000-0000-0000-0000-000000000000&IID={0}", Request.QueryString("IID"))%>' scrolling="auto" marginheight="0" marginwidth="0">
</frameset>
</html>
