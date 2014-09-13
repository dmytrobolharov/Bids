<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_SizeClass_List.aspx.vb" Inherits="plmOnApp.Control_SizeClass_List" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Size Class List</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
</head>
<body>
    <form id="Form1" method="post" runat="server" onkeypress="if(event.keyCode==13) {document.getElementById('btnImgSearch').click(); return false}">
   <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3"><asp:ImageButton ID="btnInvSearch"
                    runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px" TabIndex="0" />
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btmImgNewSize" runat="server" 
                    Message="NONE" CausesValidation="False"></cc1:ConfirmedImageButton>
                </cc1:ConfirmedImageButton><cc1:ConfirmedImageButton ID="btnClose"
                        runat="server"  Message="NONE" Visible="false"
                        CausesValidation="False"></cc1:ConfirmedImageButton>
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
            <td valign="middle">
                &nbsp;<asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
                    ForeColor="#E0E0E0">Size Class Library</asp:Label>
            </td>
        </tr>
    </table>
    <table class="TableHeader" height="20" cellspacing="0" cellpadding="0" width="100%"
        border="0">
        <tr class="fontHead">
            <td align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td class="fontHead" width="50">
                <div align="right">
                    <asp:Label ID="lblSearch" runat="server"></asp:Label></div>
            </td>
            <td width="75">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="font"></asp:TextBox>
            </td>
            <td width="10">
                <asp:ImageButton ID="btnImgSearch" runat="server" ImageUrl="../System/Icons/icon_search.gif"
                    CausesValidation="False"></asp:ImageButton>
            </td>
            <td>
                <div align="left">
                    &nbsp;
                    <asp:Label ID="lblCurrentIndex" Text="0" Visible="False" runat="server"></asp:Label><asp:Label
                        ID="lblPageSize" Text="24" Visible="False" runat="server"></asp:Label></div>
            </td>
            <td width="20">
                <div align="center">
                    <asp:imagebutton id="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:imagebutton></div>
            </td>
            <td width="20">
                <div align="center">
                    <asp:imagebutton id="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:imagebutton></div>
            </td>
            <td width="150">
                <div align="center">
                    <asp:Label ID="lblCounts" runat="server" CssClass="plaintable"></asp:Label></div>
            </td>
            <td width="20">
                <div align="center">
                    <asp:imagebutton id="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:imagebutton></div>
            </td>
            <td width="20">
                <div align="center">
                    <asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:imagebutton></div>
            </td>
            <td>
                <div align="left">
                    <b>
                        <asp:Label ID="lblRecordCount" runat="server" Visible="true"></asp:Label>&nbsp;<asp:Label
                            ID="lblRecCount" runat="server" Visible="true">Records Found</asp:Label></b></div>
                </B>
            </td>
        </tr>
    </table>
    <asp:Panel ID="pnlNew" runat="server">
        <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                </td>
                <td width="500">
                    <asp:LinkButton ID="btnAddSize" runat="Server" >
								<IMG border="0" id="imgAdd" runat="Server" alt="Save"  width="85" height="24"></asp:LinkButton>
                    <asp:LinkButton ID="btnAddClose" runat="Server" CausesValidation="False" >
								<IMG border="0" id="imgAddClose" runat="Server" alt="Cancel" width="85" height="24"></asp:LinkButton>
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
        </table>
        <table cellspacing="1" cellpadding="1" width="100%" bgcolor="whitesmoke" border="0">
            <tr>
                <td valign="top" width="400">
                    <table cellspacing="0" cellpadding="0" width="400" border="0">
                        <tr>
                            <td width="10">
                                &nbsp;
                            </td>
                            <td class="fontHead" valign="top" width="100">
                                <asp:Label ID="lblSize" runat="server"></asp:Label>
                            </td>
                            <td class="font">
                                <asp:TextBox ID="txtSizeNEW" runat="server" MaxLength="60"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rvSize" runat="server" CssClass="fontHead" ControlToValidate="txtSizeNEW"
                                    Display="Dynamic" ErrorMessage="*" ></asp:RequiredFieldValidator>
                            </td>
                         </tr>   
                    </table>
                </td>                
                <td></td>
            </tr>
        </table>
    </asp:Panel>
    <asp:DataList ID="DataList1" runat="server" Width="100%" BorderWidth="1px" BorderStyle="Solid"
        BorderColor="WhiteSmoke" BackColor="White" DataKeyField="SizeClassGuidID" OnEditCommand="DataList_EditCommand"
        OnUpdateCommand="DataList_UpdateCommand" OnCancelCommand="DataList_CancelCommand"
        OnDeleteCommand="DataList_DeleteCommand">
        <HeaderTemplate>
            <table bordercolor="#999999" cellspacing="0" cellpadding="0" width="100%" border="0">
                <tr class="Toolbar">
                    <td class="fontHead" width="20" height="20">
                        &nbsp;
                    </td>
                    <td class="fontHead" width="75"><asp:Label ID="lblCode" runat="server"><%#GetSystemText("Size class")%></asp:Label></td> 
                     <td class="fontHead" width="75"><asp:Label ID="Label5" runat="server"><%#GetSystemText("Created By")%></asp:Label></td>
                     <td class="fontHead" width="75"><asp:Label ID="Label6" runat="server"><%#GetSystemText("Created Date")%></asp:Label></td>                   
                     <td class="fontHead" width="75"><asp:Label ID="Label3" runat="server"><%#GetSystemText("Modifyed By")%></asp:Label></td>
                     <td class="fontHead" width="75"><asp:Label ID="Label4" runat="server"><%#GetSystemText("Modifyed Date")%></asp:Label></td>
                </tr>
            </table>
        </HeaderTemplate>
        <AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
        <FooterTemplate>
        </FooterTemplate>
        <ItemStyle BackColor="White"></ItemStyle>
        <ItemTemplate>
            <table width="100%">
                <tr>
                    <td width="20" height="20">
                        <asp:LinkButton ID="btnEdit" runat="Server" Text='<IMG border="0" alt="edit" src="../System/Icons/icon_edit.gif">'
                            CommandName="edit" CausesValidation="false" Visible="<%#intAccessModify%>">
                        </asp:LinkButton>
                    </td>
                    <td class="font" width="75"><asp:Label runat="server" ID="txtSizeClass"><%#Container.DataItem("SizeClass")%></asp:Label></td>
                    <td class="font" width="75"><asp:Label runat="server" ID="Label7"><%#Container.DataItem("Cuser")%></asp:Label></td>
                    <td class="font" width="75"><asp:Label runat="server" ID="Label8"><%#Container.DataItem("Cdate")%></asp:Label></td>
                    <td class="font" width="75"><asp:Label runat="server" ID="Label1"><%#Container.DataItem("Muser")%></asp:Label></td>
                    <td class="font" width="75"><asp:Label runat="server" ID="Label2"><%#Container.DataItem("Mdate")%></asp:Label></td>
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
                        <asp:LinkButton ID="btnSave" runat="Server" 
                            CommandName="update" Visible="<%#intAccessModify%>">
                        </asp:LinkButton>
                        <cc1:ConfirmedLinkButton ID="btnDelete" runat="Server" Message='<%#GetSystemText("Are you sure you want to Delete this Size Class?")%>'
                            Text='<IMG border="0" alt="Delete"  CommandName="delete"
                            Visible="<%#intAccessDelete%>">
                        </cc1:ConfirmedLinkButton>
                        <asp:LinkButton ID="btnCancel" runat="Server" 
                            CommandName="cancel" CausesValidation="false"></asp:LinkButton>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
            <table cellspacing="1" cellpadding="1" width="100%" bgcolor="whitesmoke" border="0">
                <tr>
                    <td valign="top" width="400">
                        <table cellspacing="0" cellpadding="0" width="400" border="0">
                            <tr>
                                <td width="10">
                                    &nbsp;
                                </td>
                                <td class="fontHead" valign="top" width="100">
                                    <asp:Label ID="lblSizeClass" runat="server"><%#GetSystemText("Size Class")%>:</asp:Label>
                                </td>
                                <td class="font">
                                    <asp:TextBox ID="txtSizeClassEdit" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "SizeClass").ToString  %>'></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rvPOMCodeEdit" runat="server" CssClass="fontHead" ToolTip ="Size Class Required"
                                        ErrorMessage="*" Display="Dynamic" ControlToValidate="txtSizeClassEdit"></asp:RequiredFieldValidator>
                                </td>                                
                             </tr>   
                        </table>
                    </td>
                   
                    <td></td>
                </tr>
            </table>
            <table cellspacing="0" cellpadding="0" width="100%" bgcolor="whitesmoke" border="0">
                <tr>
                    <td width="20">
                        &nbsp;
                    </td>
                    <td class="font" width="100">
                        <asp:Label ID="lblCreatedBy" runat="server"><%#GetSystemText("Created By")%>:</asp:Label>
                    </td>
                    <td class="font">
                        <asp:Label ID="lblCData" runat="server" Text='<%# Container.DataItem("CUser").ToString  &amp; " &nbsp; " &amp; Container.DataItem("CDate").ToString %>'>
                        </asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="20" bgcolor="whitesmoke">
                        &nbsp;
                    </td>
                    <td class="font" width="100">
                        <asp:Label ID="lblModifiedBy" runat="server"><%#GetSystemText("Modified By")%>:</asp:Label>
                    </td>
                    <td class="font">
                        <asp:Label ID="lblMData" runat="server" Text='<%# Container.DataItem("MUser").ToString &amp; " &nbsp; " &amp; Container.DataItem("MDate").ToString %>'>
                        </asp:Label>
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
    </asp:DataList>
    </form>
    
    </script>
</body>
</html>
