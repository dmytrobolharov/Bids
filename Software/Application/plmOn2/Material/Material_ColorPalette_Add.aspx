<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Material_ColorPalette_Add.aspx.vb" Inherits="plmOnApp.Material_ColorPalette_Add" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title><%= GetSystemText("Material")%></title>
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>

	<frameset cols="400,400" frameborder="yes" bordercolor="#dbd7d0" >
		<frame name="colorpalette" src="<%=URLColorPalette%>" scrolling="auto" marginheight="0" marginwidth="0" >
		<frame name="materialcolors" src="<%=URLMaterialColors%>" scrolling="auto" marginheight="0" marginwidth="0" >
	</frameset>

</html>
