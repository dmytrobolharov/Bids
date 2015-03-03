<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Planning_Folder_Storyboards_List.aspx.vb" Inherits="plmOnApp.Planning_Folder_Storyboards_List" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register Src="Planning_Header.ascx" TagName="Planning_Header" TagPrefix="hc1" %>
<!DOCTYPE html "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
<head runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/jquery-ui-1.10.3.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="form1" runat="server" method="post">
    <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td valign="middle" align="left">
                <cc1:ConfirmedImageButton ID="btnEdit" runat="server" Message="NONE" CausesValidation="false" />
                <cc1:ConfirmedImageButton ID="btnNew" runat="server" Message="NONE" CausesValidation="false" />
                <cc1:ConfirmedImageButton ID="btnAddCatalog" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnRemove" runat="server" Message="NONE" />
                <cc1:ConfirmedImageButton ID="btnDelete" runat="server" Message="NONE" />
                <cc1:BWImageButton ID="btnChangeLog" runat="server" CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;">
                </cc1:BWImageButton>
            </td>
        </tr>
    </table>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
        height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large"
                    Font-Names="Tahoma,Verdana"></asp:Label>
            </td>
        </tr>
    </table>
    <hc1:Planning_Header ID="PlanningHeader" runat="server" />
    <br />
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                <asp:DataGrid ID="DataGrid1" runat="server" AllowSorting="False" DataKeyField="ImageCatalogID">
                    <AlternatingItemStyle Height="20px" Wrap="true" CssClass="AlternateItemTemplate">
                    </AlternatingItemStyle>
                    <ItemStyle Height="20px" Wrap="true" CssClass="ItemTemplate"></ItemStyle>
                    <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                    <PagerStyle Visible="False"></PagerStyle>
                    <Columns>
                        <asp:TemplateColumn HeaderStyle-BorderWidth="0" ItemStyle-BorderWidth="0">
                            <HeaderTemplate>
                                <input type="checkbox" onclick="SelectAll(this)" id="chkSelectAll" />
                            </HeaderTemplate>
                            <ItemStyle Width="20px" CssClass="SelectCheckBox" />
                            <ItemTemplate>
                                <asp:CheckBox runat="server" ID="chbSelect" />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                    </Columns>
                </asp:DataGrid>
            </td>
        </tr>
    </table>
    <script type="text/javascript" src="../System/Jscript/jquery-ui-1.10.3.custom.min.js"></script>
    </form>
    <script type="text/javascript">
        function SelectAll(chb) {
            $("[name$='chbSelect']:enabled").each(function(){ this.checked = chb.checked });
        }
    </script>
</body>
</html>
