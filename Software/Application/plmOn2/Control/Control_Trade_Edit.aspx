<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_Trade_Edit.aspx.vb"
    Inherits="plmOnApp.Control_Trade_Edit" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title>Style_Main</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>

    <script language="javascript">
        function calendar(sTxtBoxName) {
            windowDatePicker = window.open("../System/Control/month_popup.aspx?txtbox=" + sTxtBoxName, "dp", "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=200,height=180,left=375,top=200");
            windowDatePicker.focus();
        }
    </script>

</head>
<body ms_positioning="GridLayout">
    <form id="Form1" method="post" runat="server">
    <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%"
        border="0">
        <tr>
            <td width="100%">
                &nbsp;
                <cc2:ConfirmedImageButton ID="btnSaveUser" runat="server" Message="NONE" >
                </cc2:ConfirmedImageButton>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="#cddeee"
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
    <table height="100%" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td valign="top" bgcolor="#ffffff">
                <table height="100%" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td valign="top" align="right" colspan="2" height="75">
                            <asp:Label ID="lblFullName" runat="server" ForeColor="#E0E0E0" Font-Size="XX-Large"
                                Font-Names="Tahoma,Verdana"></asp:Label>&nbsp;
                        </td>
                        <td valign="top" bgcolor="whitesmoke" height="75">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" width="300">
                            <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td width="10">
                                        &nbsp;
                                    </td>
                                    <td class="fontHead" width="100">
                                        &nbsp;<asp:Label ID="lblCompanyName" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        &nbsp;
                                        <asp:TextBox ID="txtCompanyName" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="10">
                                        &nbsp;
                                    </td>
                                    <td class="fontHead" width="100">
                                        &nbsp;<asp:Label ID="lblAddress" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        &nbsp;
                                        <asp:TextBox ID="txtAddress1" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="10">
                                        &nbsp;
                                    </td>
                                    <td class="fontHead" width="100">
                                        &nbsp;
                                    </td>
                                    <td>
                                        &nbsp;
                                        <asp:TextBox ID="txtAddress2" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="10">
                                        &nbsp;
                                    </td>
                                    <td class="fontHead" width="100">
                                        &nbsp;<asp:Label ID="lblCity" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        &nbsp;
                                        <asp:TextBox ID="txtCity" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="10">
                                        &nbsp;
                                    </td>
                                    <td class="fontHead" width="100">
                                        &nbsp;<asp:Label ID="lblState" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        &nbsp;
                                        <asp:TextBox ID="txtState" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="10">
                                        &nbsp;
                                    </td>
                                    <td class="fontHead" width="100">
                                        &nbsp;<asp:Label ID="lblZip" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        &nbsp;
                                        <asp:TextBox ID="txtZip" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="10">
                                        &nbsp;
                                    </td>
                                    <td class="fontHead" width="100">
                                        &nbsp;<asp:Label ID="lblCountry" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        &nbsp;
                                        <asp:TextBox ID="txtCountry" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="10">
                                    </td>
                                    <td class="fontHead" width="100">
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="10">
                                    </td>
                                    <td class="fontHead" width="100">
                                        <asp:Label ID="lblPhone" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        &nbsp;
                                        <asp:TextBox ID="txtPhone" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="10">
                                        &nbsp;
                                    </td>
                                    <td class="fontHead" width="100">
                                        &nbsp;<asp:Label ID="lblFax" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        &nbsp;
                                        <asp:TextBox ID="txtFax" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="10">
                                    </td>
                                    <td class="fontHead" width="100">
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td valign="top" width="300">
                            <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td width="10">
                                        &nbsp;
                                    </td>
                                    <td class="fontHead" width="100">
                                        &nbsp;<asp:Label ID="lblUserName" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        &nbsp;
                                        <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="10">
                                        &nbsp;
                                    </td>
                                    <td class="fontHead" width="100">
                                        &nbsp;<asp:Label ID="lblPassword" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        &nbsp;
                                        <asp:TextBox ID="txtPassword" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="10">
                                    </td>
                                    <td class="fontHead" width="100">
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="10">
                                    </td>
                                    <td class="fontHead" width="100">
                                        <asp:Label ID="lblTradeType" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        &nbsp;
                                        <asp:DropDownList ID="dlTradeType" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td class="fontHead">
                                        &nbsp;<asp:Label ID="lblActive" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        &nbsp;
                                        <asp:CheckBox ID="cbActive" runat="server"></asp:CheckBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="10">
                                        &nbsp;
                                    </td>
                                    <td class="fontHead" width="100">
                                        &nbsp;
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                            </table>
                            <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr class="fontHead">
                                    <td width="20" height="20">
                                        &nbsp;
                                    </td>
                                    <td height="20">
                                        <asp:Label ID="lblContactName" runat="server"></asp:Label>
                                    </td>
                                    <td height="20">
                                        <asp:Label ID="lblContactTitle" runat="server"></asp:Label>
                                    </td>
                                    <td height="20">
                                        <asp:Label ID="lblContactEmail" runat="server"></asp:Label>
                                    </td>
                                    <td height="20">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td width="20">
                                        &nbsp;
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtContactName1" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtContactTitle1" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtContactEmail1" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td width="20">
                                        &nbsp;
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtContactName2" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtContactTitle2" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtContactEmail2" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td width="20">
                                        &nbsp;
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtContactName3" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtContactTitle3" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtContactEmail3" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td width="20">
                                        &nbsp;
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtContactName4" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtContactTitle4" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtContactEmail4" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                            </table>
                            <br>
                        </td>
                        <td valign="top" width="30%" bgcolor="whitesmoke">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            &nbsp;
                        </td>
                        <td valign="top">
                            &nbsp;
                        </td>
                        <td valign="top" bgcolor="whitesmoke">
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
