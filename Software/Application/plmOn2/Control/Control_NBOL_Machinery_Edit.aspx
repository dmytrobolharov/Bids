<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_NBOL_Machinery_Edit.aspx.vb" Inherits="plmOnApp.Control_NBOL_Machinery_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Control Panel</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
        <style type="text/css">
    .rightAlign 
    {
    	text-align:right;
    }
    
    </style>
</head>
<body style="background-color: white">
    <form id="form1" runat="server">
    <div>
        <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                </td>
                <td>
                    <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnSaveClose" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnSaveNew" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnDelete" runat="server" CausesValidation="false"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" CausesValidation="false" OnClientClick="return btnClose_Click()"></cc1:ConfirmedImageButton>
                </td>
                <td class="FontHead" align="right" width="75">
                </td>
                <td width="40">
                </td>
                <td>
                </td>
            </tr>
        </table>
        <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45"
            cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
            <tr>
            <td width="10">
                    &nbsp;
                </td>
                <td>
                    &nbsp;<asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:Label>
                </td>
            </tr>
        </table>
        <table cellspacing="2" cellpadding="0" width="100%" border="0">
            <tr>
            <td width="25">
                    &nbsp;
                </td>
                <td>
                    <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
                </td>
                <td valign="top">
                    <table cellspacing="0" cellpadding="0" width="300" border="0" style="background-color: White">
                        <tr>
                            <td class="fontHead" valign="top" width="100">
                                <asp:Label ID="lblImageFile" runat="server"></asp:Label>:
                            </td>
                            <td class="font">
                                <input class="font" id="txtImagePath" type="file" name="txtImagePath" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="font" width="50">
                                <br />
                                <cc1:BWImageButton ID="imgFeature" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <cc1:ConfirmedImageButton ID="btnImageRemove" runat="server" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>        
        <table cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <td valign="top">
                </td>
            </tr>
        </table>
    </div>    
    </form>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
