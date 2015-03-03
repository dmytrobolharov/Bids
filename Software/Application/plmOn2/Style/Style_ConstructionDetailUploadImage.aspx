<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_ConstructionDetailUploadImage.aspx.vb" Inherits="plmOnApp.Style.ConstructionDetail.Style_ConstructionDetailUploadImage" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
	<title id="tlUploadImage" runat="server">Process Detail Upload Image</title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
</head>
<body>
    <form id="form1" runat="server">
        <table  class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
            <tr>
                <td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
                <td align="left">
                   <cc1:confirmedimagebutton id="btnUpload" runat="server"   Message="NONE" />&nbsp;<cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()" />
                </td>
            </tr>
        </table>  
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
		    <tr>
			    <td>&nbsp;<asp:Label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:Label></td>
		    </tr>
	    </table>
        <table cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <td width="10%">
                    &nbsp;
                </td>
                <td valign="top" width="90%">
                    <br /><br /><br />
                    <table cellspacing="0" cellpadding="0" width="400" border="0">
                        <tr>
                            <td class="fontHead" valign="top" width="100">
                               <asp:Label ID="lblNImageFile" runat="server"></asp:Label>:
                            </td>
                            <td class="font">
                                <input class="font" id="txtImagePath" type="file" style="width:280px" name="txtImagePath" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <br /><br /><br /><br />

                </td>
            </tr>
        </table> 	    
	    
	    
 
    </form>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
