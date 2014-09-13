<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_UserProfile_Permission.aspx.vb" Inherits="plmOnApp.Control_UserProfile_Permission" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Permission Summary</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45"
            cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
            <tr>
                <td>
                    &nbsp;
                    <asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:Label>
                </td>
            </tr>
        </table>
        <br />
        <asp:DataList ID="dlFolders" runat="server" BorderWidth="1px" BorderStyle="Solid" BorderColor="Silver"
            Width="100%">
            <ItemStyle BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray" BackColor="White"></ItemStyle>
            <ItemTemplate>
                <table style="border-bottom: LightGray thin solid; border-left-style: none; background-color: white"
                    height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
                    <tr>
                        <td>
                            &nbsp; <font size="4"><b>
                                <asp:Label ID="lblFolderType" runat="server"><%#GetSystemText("FolderType")%></asp:Label></font></b>
                        </td>
                    </tr>
                </table>
                <asp:DataList ID="dlFolderType" runat="server" Width="100%" BorderColor="Silver" BorderStyle="Solid"
                    BorderWidth="1px" OnItemDataBound="dlFolderType_ItemDataBound">
                    <AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
                    <ItemStyle BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray" BackColor="White"></ItemStyle>
                    <HeaderTemplate>
                        <table>
                            <tr>
                                <td width="20">
                                </td>
                                <td class="fontHead" width="200">
                                </td>
                                <td class="fontHead" width="100">
                                  <asp:Label ID="lblAccessType" runat="server"><%#GetSystemText("AccessType")%></asp:Label>
                                </td>
                                <td class="fontHead" width="40" id="tdViewHeader" runat="server">
                                  <asp:Label ID="lblView" runat="server"><%#GetSystemText("View")%></asp:Label>
                                </td>
                                <td class="fontHead" width="40" id="tdCreateHeader" runat="server">
                                    <asp:Label ID="lblCreate" runat="server"><%#GetSystemText("Create")%></asp:Label>
                                </td>
                                <td class="fontHead" width="40" id="tdModifyHeader" runat="server">
                                    <asp:Label ID="lblModify" runat="server"><%#GetSystemText("Modify")%></asp:Label>
                                </td>
                                <td class="fontHead" width="40" id="tdRemoveHeader" runat="server">
                                    <asp:Label ID="lblRemove" runat="server"><%#GetSystemText("Remove")%></asp:Label>
                                </td>
                                <td class="fontHead" width="40" id="tdDeleteHeader" runat="server">
                                   <asp:Label ID="lblDelete" runat="server"><%#GetSystemText("Delete")%></asp:Label>
                                </td>
                                <td class="fontHead" width="40" id="tdPrintHeader" runat="server">
                                    <asp:Label ID="lblPrint" runat="server"><%#GetSystemText("Print")%></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <table>
                            <tr>
                                <td width="20">
                                    <asp:Image ID="iconStatus" runat="server"></asp:Image>
                                </td>
                                <td width="200">
                                    <asp:Label ID="lblTypeDescription" runat="server" CssClass="fontHead"><%#GetSystemText("Type Description")%></asp:Label>
                                </td>
                                <td width="100">
                                    <asp:Label runat="server" ID="lblAccessType" CssClass="font"></asp:Label>
                                </td>
                                <td width="40" id="tdView" runat="server">
                                    <asp:TextBox ID="txtAccessView" ReadOnly="true" CssClass="font" runat="server" Width="30"
                                        BorderColor="LightGray" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox>
                                </td>
                                <td width="40" id="tdCreate" runat="server">
                                    <asp:TextBox ID="txtAccessCreate" ReadOnly="true" CssClass="font" runat="server"
                                        Width="30" BorderColor="LightGray" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox>
                                </td>
                                <td width="40" id="tdModify" runat="server">
                                    <asp:TextBox ID="txtAccessModify" ReadOnly="true" CssClass="font" runat="server"
                                        Width="30" BorderColor="LightGray" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox>
                                </td>
                                <td width="40" id="tdRemove" runat="server">
                                    <asp:TextBox ID="txtAccessRemove" ReadOnly="true" CssClass="font" runat="server"
                                        Width="30" BorderColor="LightGray" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox>
                                </td>
                                <td width="40" id="tdDelete" runat="server">
                                    <asp:TextBox ID="txtAccessDelete" ReadOnly="true" CssClass="font" runat="server"
                                        Width="30" BorderColor="LightGray" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox>
                                </td>
                                <td width="40" id="tdPrint" runat="server">
                                    <asp:TextBox ID="txtAccessPrint" ReadOnly="true" CssClass="font" runat="server" Width="30"
                                        BorderColor="LightGray" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:DataList>
            </ItemTemplate>
        </asp:DataList>
    </form>
</body>
</html>
