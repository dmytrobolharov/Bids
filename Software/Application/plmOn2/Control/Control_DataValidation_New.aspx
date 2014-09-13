﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_DataValidation_New.aspx.vb" Inherits="plmOnApp.Control_DataValidation_New" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
    <head>
        <title runat="server" id="PageTitle">New Lookup Table</title>
        <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    </head>
    <body ms_positioning="GridLayout">
        <form id="Form1" method="post" runat="server">
        <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
            border="0" runat="server">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                </td>
                <td width="80">
                    <cc1:ConfirmedImageButton ID="btnSave" runat="server" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_add.gif"
                        Message="NONE"></cc1:ConfirmedImageButton>
                </td>
                <td>
                    <cc1:ConfirmedImageButton ID="btnClose" runat="server" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_close.gif"
                        Message="NONE" CausesValidation="False"></cc1:ConfirmedImageButton>
                </td>
            </tr>
        </table>
        <table height="25" cellspacing="0" cellpadding="0" width="100%" bgcolor="#cddeee"
            border="0">
            <tr>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
        </table>
        <table height="90%" cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <td valign="top" bgcolor="#ffffff">
                    <table cellspacing="0" cellpadding="0" width="100%" border="0">
                        <tr>
                            <td>
                                <div align="right">
                                    <asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="XX-Large"
                                        Font-Names="Tahoma,Verdana"></asp:Label>
                                </div>
                            </td>
                        </tr>
                    </table>
                    <asp:Panel ID="pnlEditControls" runat="server">
                        <table height="100" cellspacing="0" cellpadding="0" width="100%" border="0">
                            <tr valign="top">
                                <td width="10">
                                    &nbsp;
                                </td>
                                <td>
                                    <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <table height="100" cellspacing="0" cellpadding="0" width="100%" background="../System/Images/MiddleFill.jpg" border="0">
                        <tr valign="top">
                            <td width="33%">
                            </td>
                            <td width="33%">
                            </td>
                            <td width="33%">
                            </td>
                        </tr>
                    </table>
                </td>
                <td width="10%" bgcolor="#f5f5f5">
                    &nbsp;
                </td>
            </tr>
        </table>
        </form>
    </body>
</html>
