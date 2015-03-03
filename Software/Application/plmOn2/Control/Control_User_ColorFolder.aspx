<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_User_ColorFolder.aspx.vb"
    Inherits="plmOnApp.Control_User_ColorFolder" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title>User Access</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
</head>
<body>
    <form onkeypress="if(event.keyCode==13) {document.getElementById('btnImgSearch').click(); return false}"
    id="Form1" method="post" runat="server">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3"><asp:ImageButton ID="btnInvSearch"
                    TabIndex="0" runat="server" Height="0px" Width="0px" ImageUrl="../System/icons/1x1.gif">
                </asp:ImageButton>
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:BWImageButton ID="btnLockFolder" runat="server"></cc1:BWImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"></cc1:ConfirmedImageButton>
            </td>
            <td class="FontHead" align="right" width="75">
            </td>
            <td width="40">
            </td>
            <td>
            </td>
        </tr>
    </table>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
        height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td align="right" width="40">
                <asp:Image ID="iconLock" runat="server" ImageUrl="../System/Icons/icon_lock32.gif">
                </asp:Image>
            </td>
            <td>
                &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large"
                    Font-Names="Tahoma,Verdana"></asp:Label>
            </td>
        </tr>
    </table>
    <asp:DataList ID="dlType" runat="server" Width="100%" BorderColor="Silver" BorderStyle="Solid"
        BorderWidth="1px">
        <AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
        <FooterTemplate>
        </FooterTemplate>
        <ItemStyle BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray" BackColor="White">
        </ItemStyle>
        <ItemTemplate>
            <table width="100%">
                <tr>
                    <td width="20">
                        <asp:Image ID="iconStatus" runat="server"></asp:Image>
                    </td>
                    <td class="fontHead" width="200">
                        <%#Container.DataItem("ColorFolder")%>
                    </td>
                    <td width="125">
                        <asp:RadioButtonList ID="rbAccess" runat="server" Width="200px" OnSelectedIndexChanged="SelectedIndexChanged"
                            RepeatDirection="Horizontal" AutoPostBack="True" CssClass="fontHead">
                            
                        </asp:RadioButtonList>
                    </td>
                    <td>
                        <asp:Panel ID="pnlPartial" runat="server">
                            <asp:CheckBox ID="cbAccessView" runat="server" OnCheckedChanged="SelectedIndexChanged"
                                AutoPostBack="True" CssClass="fontHead" Text='<%#GetSystemText("View") %>'></asp:CheckBox>
                            <asp:CheckBox ID="cbAccessCreate" runat="server" CssClass="fontHead" Text='<%#GetSystemText("Create") %>'>
                            </asp:CheckBox>
                            <asp:CheckBox ID="cbAccessModify" runat="server" CssClass="fontHead" Text='<%#GetSystemText("Modify") %>'>
                            </asp:CheckBox>
                            <asp:CheckBox ID="cbAccessDelete" runat="server" CssClass="fontHead" Text='<%#GetSystemText("Delete") %>' ForeColor="Red">

                            </asp:CheckBox>
                            <asp:CheckBox ID="cbAccessPrint" runat="server" CssClass="fontHead" Text='<%#GetSystemText("Print") %>'>
                            </asp:CheckBox>
                        </asp:Panel>
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList></form>

    <script language="javascript">
        var frm = document.Form1;
        function CheckAll(checkAllBox) {
            var actVar = checkAllBox.checked;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf("chkDelete") != -1)
                    e.checked = actVar;
            }
        }
    </script>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
    <asp:Label ID="lblWarning" runat="server" CssClass="fontHead"></asp:Label>
</body>
</html>
