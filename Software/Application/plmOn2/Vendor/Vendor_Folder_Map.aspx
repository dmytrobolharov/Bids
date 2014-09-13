<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Vendor_Folder_Map.aspx.vb" Inherits="plmOnApp.Vendor_Folder_Map" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Map</title> 
    <link href="../System/CSS/GoogleMap.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>
    <script type="text/javascript" src="../System/Jscript/GoogleMap.js"></script>

</head>
<body>
    <form id="form1" runat="server">
        <table style="border: none; background-color: white" height="45"
            cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
            <tr>
                <td valign="middle">
                    <asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:Label>&nbsp;
                </td>
                <td valign="top" height="50">
                </td>
            </tr>
        </table>
         <div id="divGoogleMap" style="height: 800px; width:1050px; position: relative; background-color: rgb(229, 227, 223);"></div>
    </form>
</body>
</html>
