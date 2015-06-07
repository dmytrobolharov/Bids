<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_User_Edit.aspx.vb"
    Inherits="plmOnApp.Control_User_Edit" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Control Panel</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="Form1" method="post" runat="server">
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
        height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                &nbsp;
                <asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
                    ForeColor="#E0E0E0"></asp:Label>
            </td>
        </tr>
    </table>
    <br>
    <cc3:YSTabView ID="YSTabView1" runat="server"></cc3:YSTabView>
    <asp:Panel runat="server" ID="pnlOptions">
        <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
            border="0" runat="server">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                </td>
                <td>
                    <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnSaveNew" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                    <cc1:BWImageButton ID="btnPassword" runat="server" NavigateUrl="Control_User_Edit_Password.aspx" WindowName="Control_User_Edit_Password"
                        WindowWidth="600px" WindowHeight="250px" Location="False" MenuBar="False" Resizable="False"
                        ScrollBars="False" Status="False" ToolBar="False"></cc1:BWImageButton>
                    <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" CausesValidation="False" OnClientClick="return btnClose_Click()"></cc1:ConfirmedImageButton>
                </td>
                <td class="FontHead" align="right" width="75">
                </td>
                <td width="40">
                </td>
                <td>
                </td>
            </tr>
        </table>
        <table cellspacing="2" cellpadding="0" width="100%" border="0">
            <tr>
                <td>
                    <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel runat="server" ID="pnlPermissions">
        <asp:DataList ID="dlFolders" runat="server" BorderWidth="1px" BorderStyle="Solid"
            BorderColor="Silver" Width="100%">
            <ItemStyle BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray" BackColor="White">
            </ItemStyle>
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
                <asp:DataList ID="dlFolderType" runat="server" Width="100%" BorderColor="Silver"
                    BorderStyle="Solid" BorderWidth="1px" OnItemDataBound="dlFolderType_ItemDataBound">
                    <AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
                    <ItemStyle BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray" BackColor="White">
                    </ItemStyle>
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
    </asp:Panel>
    <asp:Panel runat="server" ID="pnlGroups">
        <br>
        <table class="TableHeader" id="Table1" cellspacing="0" cellpadding="0" width="100%"
            border="0" runat="server">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                </td>
                <td>
                    <cc1:BWImageButton ID="btnAddToGroup" runat="server" 
                        NavigateUrl="Control_User_AddToGroup.aspx" WindowName="Control_User_AddToGroup"
                        WindowWidth="400px" WindowHeight="250px" Location="False" MenuBar="False" Resizable="False"
                        ScrollBars="False" Status="False" ToolBar="False"></cc1:BWImageButton>
                </td>
            </tr>
        </table>
        <asp:DataGrid ID="dgGroups" runat="server" BorderWidth="1px" BorderStyle="Solid"
            BorderColor="#E0E0E0" AutoGenerateColumns="False" PageSize="100" EnableViewState="true">
            <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
            <ItemStyle CssClass="ItemTemplate"></ItemStyle>
            <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
            <Columns>
                <asp:TemplateColumn>
                    <ItemStyle Width="200px"></ItemStyle>
                    <HeaderTemplate>
                        <asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("GroupName")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblGroupName"><%#GetSystemText("GroupName")%></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <ItemStyle Width="200px"></ItemStyle>
                    <HeaderTemplate>
                        <asp:Label runat="server" CssClass="fontHead" ID="Label2"><%#GetSystemText("Status")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblStatus"><%#GetSystemText("Status")%></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
            </Columns>
        </asp:DataGrid>
    </asp:Panel>
    </form>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
