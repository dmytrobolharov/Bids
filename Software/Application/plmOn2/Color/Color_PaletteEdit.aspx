<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Color_PaletteEdit.aspx.vb" Inherits="plmOnApp.Color_PaletteEdit" %>

<%@ Register TagPrefix="CuteWebUI" Namespace="CuteWebUI" Assembly="CuteWebUI.AjaxUploader" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>
<%@ Register src="../System/Control/SystemPageActiveUser.ascx" tagname="SystemPageActiveUser" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title runat="server" id="PageTitle">Color Edit</title>
    <link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/Grid.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/Tree.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script>
    function btnClose_Click() {
        <%= strExitScript %>
        return false;
    }
    </script>
</head>
<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="form1" runat="server">
    <wc1:Color_Wait ID="Color_Wait" runat="server" />

    <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" height="25"
        border="0">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnSave" runat="server"  Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:BWImageButton ID="btnSeason" runat="server"></cc1:BWImageButton>
                <cc1:BWImageButton ID="btnImage" runat="server"></cc1:BWImageButton>
                
                <cc1:BWImageButton ID="btnRGB" runat="server"></cc1:BWImageButton>
                <cc1:ConfirmedImageButton ID="btnRemove" runat="server"></cc1:ConfirmedImageButton>
                <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click();"></cc1:ConfirmedImageButton>
            </td>
            <td>
            </td>
        </tr>
    </table>
    <%--<uc1:SystemPageActiveUser ID="SystemPageActiveUser1" runat="server" />--%>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
        height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                &nbsp;<asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
                    ForeColor="#E0E0E0">Color Chip</asp:Label>
            </td>
        </tr>
    </table>
    <table cellspacing="0" bgcolor="White" border="0" cellpadding="0" width="100%">
        <tr>
            <td>
                <table cellspacing="2" cellpadding="0">
                    <tr>
                        <td valign="top" bgcolor="White">
                            <table height="26" cellspacing="0" cellpadding="0" width="100%" border="0" bgcolor="White">
                                <tr>
                                    <td valign="bottom">
                                        <cc2:YSTabView ID="tabSubmit" runat="server"></cc2:YSTabView>
                                    </td>
                                </tr>
                            </table>
                            <table cellspacing="0" cellpadding="0" width="100%">
                                <tr>
                                    <td valign="top" width="100" height="100">
                                        <table height="25" cellspacing="0" cellpadding="0" width="100%" style='border-color: Gainsboro;
                                            border-width: 1px; border-style: Solid;'>
                                            <tr class="TableHeader">
                                                <td valign="middle" align="center" width="10">
                                                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
                                                </td>
                                                <td class="fontHead">
                                                    <asp:Label ID="lblColorChip" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                        <asp:Image ID="imgColor" runat="server" />
                                    </td>
                                    <td valign="top">
                                        <table height="25" cellspacing="0" cellpadding="0" width="100%" style='border-color: Gainsboro;
                                            border-width: 1px; border-style: Solid;'>
                                            <tr class="TableHeader">
                                                <td valign="middle" align="center" width="10">
                                                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
                                                </td>
                                                <td class="fontHead">
                                                    <asp:Label ID="lblComments" runat="server">Comments</asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                        <table cellpadding="0" cellspacing="2">
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtColorPaletteComment" runat="server" Height="100px" Width="395px"
                                                        TextMode="MultiLine"></asp:TextBox>
                                                    <asp:HiddenField ID="hdnColorPaletteComment" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <table cellspacing="0" width="400" cellpadding="0" style="border: 1px solid #F0F0F0;
                                background-color: #FFFFFF;">
                                <tr>
                                    <td valign="top">
                                        <table cellspacing="1" cellpadding="0" width="100%" border="0">
                                            <tr>
                                                <td class="fontHead">
                                                    <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td valign="top">
                            <table height="26" cellspacing="0" cellpadding="0" width="100%" border="0" bgcolor="White">
                                <tr>
                                    <td valign="bottom" bgcolor="White">
                                        <cc2:YSTabView ID="tabComment" runat="server"></cc2:YSTabView>
                                    </td>
                                </tr>
                            </table>
                            <asp:Panel ID="pnlSeasonYear" runat="server">
                                <table cellspacing="0" width="450" cellpadding="0" style="border: 1px solid #F0F0F0;
                                    background-color: #FFFFFF;">
                                    <tr>
                                        <td height="400" align="left" valign="top">
                                            <table cellspacing="0" width="450" cellpadding="0" style="border: 1px solid #F0F0F0;
                                                background-color: #FFFFFF;">
                                                <tr>
                                                    <td height="400" align="left" valign="top">
                                                        <asp:PlaceHolder ID="plhSeasonYear" runat="server"></asp:PlaceHolder>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <asp:Panel ID="pnlComment" runat="server">
                                <table cellspacing="0" width="450" cellpadding="0" style="border: 1px solid #F0F0F0;
                                    background-color: #FFFFFF;">
                                    <tr>
                                        <td height="400" align="left" valign="top">
                                            <asp:PlaceHolder ID="plhComments" runat="server"></asp:PlaceHolder>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <asp:Panel ID="pnlAttachment" runat="server">
                                <table cellspacing="0" width="450" cellpadding="0" style="border: 1px solid #F0F0F0;
                                    background-color: #FFFFFF;">
                                    <tr>
                                        <td height="400" align="left" valign="top">
                                            <asp:PlaceHolder ID="plhAttachment" runat="server"></asp:PlaceHolder>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            
<%--                            <asp:Panel ID="pnlEventLog" runat="server">
                                <table cellspacing="0" width="450" cellpadding="0" style="border: 1px solid #F0F0F0;
                                    background-color: #FFFFFF;">
                                    <tr>
                                        <td height="400" align="left" valign="top">
                                            <table cellspacing="0" width="450" cellpadding="0" style="border: 1px solid #F0F0F0;
                                                background-color: #FFFFFF;">
                                                <tr>
                                                    <td height="400" align="left" valign="top">
                                                        <asp:PlaceHolder ID="plhEventLog" runat="server"></asp:PlaceHolder>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>--%>
                            <asp:Panel ID="pnlMulti" runat="server">
                                <table cellspacing="0" width="450" cellpadding="0" style="border: 1px solid #F0F0F0;
                                    background-color: #FFFFFF;">
                                    <tr>
                                        <td height="400" align="left" valign="top">
                                            <asp:PlaceHolder ID="plhMultipleAttachments" runat="server"></asp:PlaceHolder>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    
    </form>
</body>
</html>
