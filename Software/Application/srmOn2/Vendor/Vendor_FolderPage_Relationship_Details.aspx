<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Vendor_FolderPage_Relationship_Details.aspx.vb" Inherits="srmOnApp.Vendor_FolderPage_Relationship_Details" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <cc1:YSTabView id="YSTabView1" runat="server"></cc1:YSTabView>
    <iframe id="iVendor" name="iVendor" width="100%" height="95%" runat="server" ></iframe>
    <script type="text/javascript">
        document.getElementById("iVendor").height = (document.documentElement.clientHeight || window.innerHeight)-21;
    </script>
    </form>
</body>
</html>
