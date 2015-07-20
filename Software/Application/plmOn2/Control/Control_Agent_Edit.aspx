<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_Agent_Edit.aspx.vb"
    Inherits="plmOnApp.Control_Agent_Edit" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title>Agent</title>
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
<body>
    <form id="Form1" method="post" runat="server">
    <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%"
        border="0">
        <tr>
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td width="100%">
                <cc2:ConfirmedImageButton ID="btnSaveUser" runat="server" 
                    Message="NONE"></cc2:ConfirmedImageButton>
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
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td valign="top" bgcolor="#ffffff">
                <table height="100%" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td valign="top" colspan="2" height="75">
                            <asp:Label ID="lblAgentName" runat="server" Font-Names="Tahoma,Verdana" Font-Size="XX-Large"
                                ForeColor="#E0E0E0"></asp:Label>&nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" width="300">
                            <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td style="width: 12px" width="12">
                                        &nbsp;
                                    </td>
                                    <td class="fontHead" width="100">
                                        &nbsp;<asp:Label ID="lblPartnerName" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        &nbsp;
                                        <asp:TextBox ID="txtAgentName" runat="server" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 12px" width="12">
                                        &nbsp;
                                    </td>
                                    <td class="fontHead" width="100">
                                        &nbsp;<asp:Label ID="lblAddress" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        &nbsp;
                                        <asp:TextBox ID="txtAddress1" runat="server" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 12px" width="12">
                                        &nbsp;
                                    </td>
                                    <td class="fontHead" width="100">
                                        &nbsp;
                                    </td>
                                    <td>
                                        &nbsp;
                                        <asp:TextBox ID="txtAddress2" runat="server" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 12px" width="12">
                                        &nbsp;
                                    </td>
                                    <td class="fontHead" width="100">
                                        &nbsp;<asp:Label ID="lblCity" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        &nbsp;
                                        <asp:TextBox ID="txtCity" runat="server" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 12px" width="12">
                                        &nbsp;
                                    </td>
                                    <td class="fontHead" width="100">
                                        &nbsp;<asp:Label ID="lblState" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        &nbsp;
                                        <asp:TextBox ID="txtState" runat="server" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 12px" width="12">
                                        &nbsp;
                                    </td>
                                    <td class="fontHead" width="100">
                                        &nbsp;<asp:Label ID="lblPostal" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        &nbsp;
                                        <asp:TextBox ID="txtPostalCode" runat="server" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 12px" width="12">
                                        &nbsp;
                                    </td>
                                    <td class="fontHead" width="100">
                                        &nbsp;<asp:Label ID="lblCountry" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        &nbsp;
                                        <asp:DropDownList ID="ddlCountry" runat="server" Width="200px">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td valign="top" width="452">
                            <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td width="10">
                                        &nbsp;
                                    </td>
                                    <td class="fontHead" width="100">
                                        &nbsp;<asp:Label ID="lblPhone" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        &nbsp;
                                        <asp:TextBox ID="txtPhone" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="10">
                                    </td>
                                    <td class="fontHead" width="100">
                                        &nbsp;<asp:Label ID="lblFax" runat="server"></asp:Label>.
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
                                        &nbsp;<asp:Label ID="lblWeb" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        &nbsp;
                                        <asp:TextBox ID="txtWebSite" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="10">
                                    </td>
                                    <td class="fontHead" width="100">
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td width="10">
                                        &nbsp;
                                    </td>
                                    <td class="fontHead" width="100">
                                        &nbsp;<asp:Label ID="lblUseName" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        &nbsp;
                                        <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="10">
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
                                        &nbsp;<asp:Label ID="lblActive" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        &nbsp;
                                        <asp:CheckBox ID="cbActive" runat="server"></asp:CheckBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <br>
                <cc1:YSTabView ID="YSTabView1" runat="server"></cc1:YSTabView>
                <asp:Panel ID="pnlContact" runat="server">
                    <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%"
                        border="0">
                        <tr>
                            <td valign="middle" align="center" width="10">
                                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                            </td>
                            <td width="100%">
                                <cc2:BWImageButton ID="btnAddContact" runat="server" >
                                </cc2:BWImageButton>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                    <table cellspacing="0" cellpadding="0" width="100%" border="0">
                        <tr>
                            <td valign="top" colspan="2">
                                <asp:DataList ID="AgentDataList" runat="server" Width="800" OnDeleteCommand="AgentDataList_DeleteCommand"
                                    OnCancelCommand="AgentDataList_CancelCommand" OnUpdateCommand="AgentDataList_UpdateCommand"
                                    OnEditCommand="AgentDataList_EditCommand" DataKeyField="AgentContactID" BackColor="White"
                                    BorderWidth="0px">
                                    <HeaderTemplate>
                                        <table bordercolor="#999999" cellspacing="0" cellpadding="0" width="100%" border="0"
                                            height="22">
                                            <tr class="TableHeaderOver">
                                                <td class="fontHead" width="20">
                                                    &nbsp;
                                                </td>
                                                <td class="fontHead" width="200">
                                                    <asp:Label ID="lblContactName" runat="server"><%#GetSystemText("Contact Name")%></asp:Label>
                                                </td>
                                                <td class="fontHead" width="100">
                                                    <asp:Label ID="lblTitleH" runat="server"><%#GetSystemText("Title")%></asp:Label>
                                                </td>
                                                <td class="fontHead" width="100">
                                                    <asp:Label ID="lblPhoneH" runat="server"><%#GetSystemText("Phone No.")%></asp:Label>
                                                </td>
                                                <td class="fontHead" width="100">
                                                    <asp:Label ID="lblMobileH" runat="server"><%#GetSystemText("Mobile No.")%></asp:Label>
                                                </td>
                                                <td class="fontHead" width="100">
                                                    <asp:Label ID="lblEmailH" runat="server"><%#GetSystemText("Email")%></asp:Label>
                                                </td>
                                                <td class="fontHead" width="100">
                                                    <asp:Label ID="lblPrefLangH" runat="server"><%#GetSystemText("Preferred Lang")%></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                    <EditItemStyle BorderWidth="0px"></EditItemStyle>
                                    <AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
                                    <FooterTemplate>
                                    </FooterTemplate>
                                    <ItemStyle BackColor="White"></ItemStyle>
                                    <ItemTemplate>
                                        <table width="100%">
                                            <tr>
                                                <td class="fontHead" width="20">
                                                    <asp:LinkButton ID="Linkbutton1" runat="Server" CommandName="edit" Text='<IMG border="0" alt="edit" src="../System/Icons/icon_edit.gif">'></asp:LinkButton>
                                                </td>
                                                <td class="font" width="205">
                                                    <%#Container.DataItem("FULLNAME")%>
                                                </td>
                                                <td class="font" width="105">
                                                    <%#Container.DataItem("Title")%>
                                                </td>
                                                <td class="font" width="105">
                                                    <%#Container.DataItem("PhoneNumber")%>
                                                </td>
                                                <td class="font" width="105">
                                                    <%#Container.DataItem("MobileNumber")%>
                                                </td>
                                                <td class="font" width="100">
                                                    <%#Container.DataItem("Email")%>
                                                </td>
                                                <td class="font" width="100">
                                                    <%#Container.DataItem("PreferredLang")%>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
                                            <tr>
                                                <td valign="middle" align="center" width="10">
                                                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                                                </td>
                                                <td width="500">
                                                    <asp:LinkButton ID="Linkbutton2" runat="Server" CommandName="update" 
                                                        NAME="Linkbutton2"></asp:LinkButton>
                                                    <cc2:ConfirmedLinkButton ID="Linkbutton4" runat="Server" Message='<%#GetSystemText(""Are you sure you want to delete this contact?"")%>'
                                                        CommandName="delete" 
                                                        NAME="Linkbutton4"></cc2:ConfirmedLinkButton>
                                                    <asp:LinkButton ID="Linkbutton3" runat="Server" CommandName="cancel" 
                                                        NAME="Linkbutton3"></asp:LinkButton>
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                        <table height="25" cellspacing="0" cellpadding="0" width="100%" bgcolor="gray" border="0">
                                            <tr>
                                                <td width="10">
                                                    &nbsp;
                                                </td>
                                                <td class="fontHead">
                                                    <font color="white">
                                                        <asp:Label ID="lblEditContact" Text='<%#GetSystemText("Edit Contact")%>:' runat="server"></asp:Label>
                                                        <asp:Label ID="lblContactName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "FullName").ToString  %>'>
                                                        </asp:Label></font>
                                                </td>
                                            </tr>
                                        </table>
                                        <table cellspacing="1" cellpadding="1" width="800" border="0">
                                            <tr>
                                                <td width="10">
                                                    &nbsp;
                                                </td>
                                                <td class="fontHead" width="125">
                                                    <asp:Label ID="lblFirstName" runat="server"><%#GetSystemText("First Name")%></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtFirstName" TabIndex="1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "FirstName").ToString  %>'>
                                                    </asp:TextBox>
                                                </td>
                                                <td width="10">
                                                    &nbsp;
                                                </td>
                                                <td class="fontHead" width="125">
                                                    <asp:Label ID="lblPhoneE" runat="server"><%#GetSystemText("Phone No.")%></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtPhoneNumber" TabIndex="4" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "PhoneNumber").ToString  %>'>
                                                    </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="10">
                                                    &nbsp;
                                                </td>
                                                <td class="fontHead" width="125">
                                                    <asp:Label ID="lblLastName" runat="server"><%#GetSystemText("Last Name")%></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtLastName" TabIndex="2" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Lastname").ToString  %>'>
                                                    </asp:TextBox>
                                                </td>
                                                <td width="10">
                                                    &nbsp;
                                                </td>
                                                <td class="fontHead" width="125">
                                                    <asp:Label ID="lblMobileE" runat="server"><%#GetSystemText("Mobile No.")%></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtMobileNumber" TabIndex="5" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "MobileNumber").ToString  %>'>
                                                    </asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="10">
                                                    &nbsp;
                                                </td>
                                                <td class="fontHead" width="125">
                                                    <asp:Label ID="lblTitleE" runat="server"><%#GetSystemText("Title")%></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtTitle" TabIndex="3" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Title").ToString  %>'>
                                                    </asp:TextBox>
                                                </td>
                                                <td width="10">
                                                    &nbsp;
                                                </td>
                                                <td class="fontHead" width="125">
                                                    <asp:Label ID="lblEmailE" runat="server"><%#GetSystemText("Email")%></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtEmail" TabIndex="6" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Email").ToString  %>'>
                                                    </asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </EditItemTemplate>
                                </asp:DataList>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
    </table>
    <asp:DataList ID="VendorDataList" runat="server" Width="800" BorderWidth="0px" BackColor="White"
        DataKeyField="VendorID">
        <HeaderTemplate>
            <table bordercolor="#999999" cellspacing="0" cellpadding="0" width="100%" border="0"
                height="22">
                <tr class="TableHeaderOver">
                    <td class="fontHead" width="20">
                        &nbsp;
                    </td>
                    <td class="fontHead" width="200">
                        <asp:Label ID="lblContactNameV" runat="server"><%#GetSystemText("Contact Name")%></asp:Label>
                    </td>
                    <td class="fontHead" width="100">
                        <asp:Label ID="lblTitleV" runat="server"><%#GetSystemText("Title")%></asp:Label>
                    </td>
                    <td class="fontHead" width="100">
                        <asp:Label ID="lblPhoneV" runat="server"><%#GetSystemText("Phone No.")%></asp:Label>
                    </td>
                    <td class="fontHead" width="100">
                        <asp:Label ID="lblMobileV" runat="server"><%#GetSystemText( "Mobile No.")%></asp:Label>
                    </td>
                    <td class="fontHead" width="100">
                        <asp:Label ID="lblEmailV" runat="server"><%#GetSystemText( "Email")%></asp:Label>
                    </td>
                </tr>
            </table>
        </HeaderTemplate>
        <EditItemStyle BorderWidth="0px"></EditItemStyle>
        <AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
        <FooterTemplate>
        </FooterTemplate>
        <ItemStyle BackColor="White"></ItemStyle>
        <ItemTemplate>
            <table width="100%">
                <tr>
                    <td class="fontHead" width="20">
                    </td>
                    <td class="font" width="205">
                        <%#Container.DataItem("FULLNAME")%>
                    </td>
                    <td class="font" width="105">
                        <%#Container.DataItem("Title")%>
                    </td>
                    <td class="font" width="105">
                        <%#Container.DataItem("PhoneNumber")%>
                    </td>
                    <td class="font" width="105">
                        <%#Container.DataItem("MobileNumber")%>
                    </td>
                    <td class="font" width="100">
                        <%#Container.DataItem("Email")%>
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList>
    </form>
</body>
</html>
