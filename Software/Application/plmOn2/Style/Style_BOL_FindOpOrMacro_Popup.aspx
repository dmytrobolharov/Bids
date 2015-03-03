<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_BOL_FindOpOrMacro_Popup.aspx.vb" Inherits="plmOnApp.Style.BOL.Style_BOL_FindOpOrMacro_Popup" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
	<title id="tlFindOpOrMacro" runat="server">Select Operation or Macro</title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
</head>
<body>
    <form id="form1" runat="server">
        <table  class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
            <tr>
                <td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
                <td align="left">
                   <cc1:confirmedimagebutton id="btnClose" runat="server" OnClientClick="return btnClose_Click()"  Message="NONE" />
                </td>
            </tr>
        </table>  
	    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45" width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
		    <tr>
			    <td>&nbsp;<asp:Label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:Label></td>
		    </tr>
	    </table>
        <table cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr height="80">
                <td class="fontHead" align="center">
                    &nbsp;<%=GetSystemText("There are operation and macro with this code") & "!"%>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <cc1:ConfirmedImageButton ID="btnAddOperation" runat="server" Message="NONE" />&nbsp;
                    <cc1:ConfirmedImageButton ID="btnAddMacro" runat="server" Message="NONE" />
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
