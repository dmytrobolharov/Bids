<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Help_New_Language.aspx.vb" Inherits="plmOnApp.Help_New_Language" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
    <style type="text/css">
        .col1
        {
            float: left;
            margin: 0;            
            line-height: 15px;
        }
    </style>
</head>
<body>
    <form id="frmNewLang" runat="server" defaultbutton="">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
    <Scripts>
        <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js">
        </asp:ScriptReference>
        <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js">
        </asp:ScriptReference>
        <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js">
        </asp:ScriptReference>
    </Scripts>
    </telerik:RadScriptManager>
    <script>
         $(document).ready(function() {
                $("#btnCreate").click(function(event) {
                    if (!$("input[name=rbLang]:checked").val()) 
                    {
                        alert('Please select the language!');
                        return false;
                    }
                });
        });
    </script>
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
            <td valign="top">
                <asp:Label ID="lblLang" runat="server" Text="Language: "></asp:Label>&nbsp;&nbsp;
                <telerik:RadComboBox runat="server" ID="cmbCulture" AutoPostBack="true" height="150px" MarkFirstMatch="true" HighlightTemplatedItems="true" OnItemDataBound="cmbCulture_ItemDataBound">
                    <ItemTemplate>
                        <div class="col1">
                            <%#DataBinder.Eval(Container.DataItem, "HelpLang")%>
                            <%#DataBinder.Eval(Container.DataItem, "CultureLanguage")%></div>
                    </ItemTemplate>
                </telerik:RadComboBox>
            </td>
            <td width="75">&nbsp;</td>
            <td align="right">&nbsp;</td>
        </tr>
    </table>
    <table height="10" cellspacing="0" cellpadding="0" width="100%" bgcolor="#cddeee" border="0">
        <tr>
            <td>&nbsp;</td>
        </tr>
    </table>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
        height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                <asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:Label>
            </td>
        </tr>
    </table>
    <table>
        <tr>
            <td width="20px">&nbsp;</td>
            <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
            <td width="20px">&nbsp;</td>
            <td>Please select language to copy <b><asp:Label ID="lblSelectedLangDesignString" runat="server" Text=""></asp:Label></b> from <b><asp:Label ID="lblSelectedLang" runat="server" Text=""></asp:Label></b></td>
            <td><asp:CheckBox ID="chkUseTranslation" runat="server" AutoPostBack="false" Text="Use translation" Checked="True" /></td>
        </tr>
        <tr>
            <td width="20px">&nbsp;</td>
            <td colspan="2"><asp:RadioButtonList ID="rbLang" runat="server" AutoPostBack="false" RepeatDirection="Vertical" DataTextField="CultureLanguage" DataValueField="CultureName">
                            </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td width="20px">&nbsp;</td>
            <td colspan="2">
                <cc1:confirmedimagebutton id="btnCreate" runat="server" message="NONE" tooltip="Create"></cc1:confirmedimagebutton>
                <cc1:confirmedimagebutton id="btnCancel" runat="server" message="NONE" tooltip="Cancel"></cc1:confirmedimagebutton>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
