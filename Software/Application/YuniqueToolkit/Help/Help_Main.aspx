<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Help_Main.aspx.vb" Inherits="YuniFace.Help_Main" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        /*Default font for the RadEditor
        body
        { 
            font-family: Tahoma !important; 
            font-size: 12px !important;
        }
        */
        .col1
        {
            float: left;
            margin: 0;            
            line-height: 15px;
        }
    </style>
</head>
<body>
    <form id="frmMain" runat="server">
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
        <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
                </td>
                <td valign="top" width="250">
                    <cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ToolTip="Save"></cc1:confirmedimagebutton>
                    <cc1:confirmedimagebutton id="btnEdit" runat="server"  Message="NONE" ToolTip="Edit"></cc1:confirmedimagebutton>
                    <cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" ToolTip="Close"></cc1:confirmedimagebutton>
                    <cc1:confirmedimagebutton id="btnNewLang" runat="server"  Message="NONE" ToolTip="New Language"></cc1:confirmedimagebutton>
                </td>
                <td width="75" align="left">
                    <table class="TableHeader" id="toolsubbar" cellspacing="0" cellpadding="0" border="0" runat="server">
                        <tr align="left" valign="middle">
                            <td valign="middle"><asp:Label ID="lblLang" runat="server" Text="Language: "></asp:Label></td>
                            <td><telerik:RadComboBox runat="server" ID="cmbCulture" autopostback="true" height="150px" MarkFirstMatch="true" HighlightTemplatedItems="true" OnItemDataBound="cmbCulture_ItemDataBound">
                                <ItemTemplate>
                                <div class="col1"><%#DataBinder.Eval(Container.DataItem, "HelpLang")%>
                                                 <%#DataBinder.Eval(Container.DataItem, "CultureLanguage")%></div>
                                </ItemTemplate>
                                </telerik:RadComboBox></td>
                        </tr>
                    </table>
                </td>
                <td align="right">&nbsp;</td>
            </tr>
        </table>
        <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
            <tr>
                <td>
                    <div style="font-family: Tahoma, Verdana, Helvetica, sans-serif; font-size: x-large; color: #808080"> 
                        &nbsp; 
                        <asp:Label ID="lblHeader" runat="server"></asp:Label>:&nbsp;
                        <asp:Label ID="lblTitle" runat="server" Text="" Width="800"></asp:Label>
                    </div>
                </td>
            </tr>
        </table>
        <table border="0" width="100%" style="background-color: #FFFFFF; padding: 4px">
            <!-- Display Panel -->
            <asp:Panel ID="pnlDisplay" runat="server" BackColor="Black">
            <tr>
                <td>&nbsp;</td>
                <td><asp:Label ID="lblContent" runat="server" Text="" Width="800"></asp:Label></td>
            </tr>
            </asp:Panel>
            <!-- Edit Panel -->
            <asp:Panel ID="pnlEdit" runat="server">
            <tr>
                <td>&nbsp;</td>
                <td><b>Title: </b>&nbsp;<asp:TextBox ID="txtWikiTitle" runat="server" Width="800" ToolTip="Wiki Title"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                    <telerik:RadEditor ID="WikiEditor" runat="server" Skin="Office2010Blue" OnClientLoad="EditorLoad" ToolsFile="../System/Schema/BasicTools.xml" EditModes="Design,Preview" ContentFilters="FixUlBoldItalic, FixEnclosingP, IECleanAnchors, MozEmStrong, ConvertToXhtml, EncodeScripts, OptimizeSpans, ConvertCharactersToEntities">
                        <SpellCheckSettings DictionaryPath="~/System/Localization/RadSpell" />
                        <ExportSettings OpenInNewWindow="true" />
                    </telerik:RadEditor>
                </td>
            </tr>
            </asp:Panel>
       </table>

    <script type="text/javascript">
        function EditorLoad(sender, args) {
            var wikieditor = $find("<%= WikiEditor.ClientID %>");

            var editorwidth = "1000px";
            var editorheight = screen.height - 350;
            wikieditor.setSize(editorwidth, editorheight);
        }
    </script>
     </form>
</body>
</html>