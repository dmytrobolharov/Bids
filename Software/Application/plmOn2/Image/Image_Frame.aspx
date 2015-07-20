<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Image_Frame.aspx.vb" Inherits="plmOnApp.Image_Frame" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title runat="server" id="PageTitle"></title>
</head>
<frameset cols="180,*" bordercolor="#dbd7d0">
	<frame NAME="imagemenu" src='<%=String.Format("Image_ControlMenu.aspx?IID={0}&ICI={1}&V={2}", Request.QueryString("IID"), Request.QueryString("ICI"), Request.QueryString("V"))%>' scrolling="yes" marginheight="0" marginwidth="0">
	<frame name="imagemain" src='<%=String.Format("Image_Edit.aspx?IWTIID=10000000-0000-0000-0000-000000000000&IID={0}&ICI={1}&V={2}", Request.QueryString("IID"), Request.QueryString("ICI"), Request.QueryString("V"))%>' scrolling="auto" marginheight="0" marginwidth="0">
</frameset>
</html>
