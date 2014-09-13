<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_NBOL_Machinery_New.aspx.vb" Inherits="plmOnApp.Control_NBOL_Machinery_New" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Control</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <style type="text/css">
        .rightAlign
        {
        	text-align: right;
        }
    </style>
</head>
<body style="background-color: #ffffff;">
    <form id="form1" runat="server">
    <div>
        <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                </td>
                <td>
                    <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" CausesValidation="False"></cc1:ConfirmedImageButton>
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
                    &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:Label>
                </td>
            </tr>
        </table>
        <br />
        <table height="90%" cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <td valign="top" bgcolor="#ffffff">
                    <table height="100" cellspacing="0" cellpadding="0" width="100%" border="0">
                        <tr valign="top">
                            <td width="25">
                                &nbsp;
                            </td>
                            <td>
                                <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
                            </td>
                        </tr>
                    </table>
                </td>
                <td width="10%">
                    &nbsp;
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>