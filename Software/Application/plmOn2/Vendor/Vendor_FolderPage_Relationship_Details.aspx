<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Vendor_FolderPage_Relationship_Details.aspx.vb" Inherits="plmOnApp.Vendor_FolderPage_Relationship_Details" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/GoogleMap.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>
    <script type="text/javascript" src="../System/Jscript/GoogleMap.js"></script>   
</head>
<body>
    <form id="form1" runat="server">
    <cc1:YSTabView id="YSTabView1" runat="server"></cc1:YSTabView>
    <iframe id="iVendor" name="iVendor" width="100%" height="95%" runat="server"></iframe>
 
    <div id="divGoogleMap" style="height:550px; width:1000px; position: relative; background-color: rgb(229, 227, 223); display:none;"></div>
    </form>
</body>
</html>
