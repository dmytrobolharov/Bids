<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_New.aspx.vb" Inherits="plmOnApp.Style_New" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register Src="../System/Control/WaitControl.ascx" TagName="Color_Wait" TagPrefix="wc1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
<head runat="server">
    <title>Style New</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
    <script language="JavaScript">
		    <!--

        if (window.screen) {
            var aw = screen.availWidth;
            var ah = screen.availHeight;
            window.moveTo(0, 0);
            window.resizeTo(aw, ah);
        }

        //if (self != top) top.location.replace(self.location);	

        self.focus();

		    //-->
    </script>
</head>
<body>
    <div id="fixed_icons">
        <a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help"
            target="_blank" id="yHelp"></a>
    </div>
    <form id="Form1" method="post" runat="server">
    <wc1:Color_Wait ID="Color_Wait" runat="server" />
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td>
                <asp:ImageButton ID="btnSaveStyle" runat="server"></asp:ImageButton><cc1:ConfirmedImageButton
                    ID="imgBtnNext" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" CausesValidation="False">
                </cc1:ConfirmedImageButton>
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
                                <asp:Label ID="lblStyleHeaderNew" runat="server" Font-Names="Tahoma,Verdana" Font-Size="XX-Large"
                                    ForeColor="#E0E0E0">New Style...</asp:Label></div>
                        </td>
                    </tr>
                </table>
                <asp:Panel runat="server" ID="NumberNewPanel">
                    <table cellspacing="0" cellpadding="0" width="100%" border="0">
                        <tr valign="top">
                            <td width="10">
                                &nbsp;
                            </td>
                            <td class="fontHead" width="150px">
                                <%= GetSystemText("No. of Styles")%>
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                </td>
                                <td class="fontHead">
                                <asp:DropDownList runat="server" ID="NoStyles" Width="150">
                                    <asp:ListItem Value="1" Text="1" Selected="True"></asp:ListItem>
                                    <asp:ListItem Value="2" Text="2"></asp:ListItem>
                                    <asp:ListItem Value="3" Text="3"></asp:ListItem>
                                    <asp:ListItem Value="4" Text="4"></asp:ListItem>
                                    <asp:ListItem Value="5" Text="5"></asp:ListItem>
                                    <asp:ListItem Value="10" Text="10"></asp:ListItem>
                                    <asp:ListItem Value="15" Text="15"></asp:ListItem>
                                    <asp:ListItem Value="20" Text="20"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr valign="top">
                            <td width="10">
                                &nbsp;
                            </td>
                            <td class="fontHead" width="150px">
                                <%= GetSystemText("Calendar")%>
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                </td>
                                <td class="fontHead">
                                <asp:DropDownList runat="server" ID="Calendar" Width="150">
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                    <br />
                </asp:Panel>
                <asp:Panel ID="pnlStyle" runat="server">
                    <table height="100" cellspacing="0" cellpadding="0" width="100%" border="0">
                        <tr valign="top">
                            <td width="10">
                                &nbsp;
                            </td>
                            <td>
                                <asp:PlaceHolder ID="plhControlsHolder" runat="server" EnableViewState="False"></asp:PlaceHolder>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <table height="100" cellspacing="0" cellpadding="0" width="100%" background="../System/Images/MiddleFill.jpg"
                    border="0">
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
