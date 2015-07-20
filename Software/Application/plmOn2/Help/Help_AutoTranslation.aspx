<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Help_AutoTranslation.aspx.vb" Inherits="plmOnApp.Help_AutoTranslation" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
    <style type="text/css">
        html, body, form
        {
            height: 100%;
            margin: 0px;
            padding:0px;
        }
    </style> 
</head>
<body>
    <form id="frmAutoTranslation" runat="server">
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
            <td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
            <td valign="top"><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ToolTip="Save"></cc1:confirmedimagebutton>
                             <cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" ToolTip="Close"></cc1:confirmedimagebutton>
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
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                <asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:Label>
            </td>
        </tr>
    </table>
    <telerik:RadSplitter ID="RadSplitter1" runat="server" Orientation="Vertical" width="2000px" Height="100%" OnClientLoad="SplitterLoaded">
        <telerik:RadPane ID="transFrom" runat="server" width="1000px" height="100%" Scrolling="Both">
            <div style="padding:10px 10px 10px 10px;">
                <h1><asp:Label ID="lblTransFromTitle" runat="server" Text="" EnableViewState="False"></asp:Label></h1>
                    <asp:Label ID="lblTransFromContent" runat="server" Text="" EnableViewState="False"></asp:Label>
            </div>
        </telerik:RadPane>
        <telerik:RadSplitBar ID="RadSplitBar1" runat="server" CollapseMode="Both" EnableResize="True">
        </telerik:RadSplitBar>
        <telerik:RadPane ID="WikiEdit" runat="server" width="1000px" height="100%" Scrolling="Both">
            <div style="padding:10px 10px 10px 10px;">
                <table>
                    <tr>
                        <td><b>Title: </b></td>
                        <td><asp:TextBox ID="txtWikiTitle" runat="server" Width="750px" ToolTip="Wiki Title"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <telerik:RadEditor ID="WikiEditor" runat="server" Skin="Office2010Blue" ToolsFile="../System/Schema/BasicTools.xml" EditModes="Design,Preview" ContentFilters="FixUlBoldItalic, FixEnclosingP, IECleanAnchors, MozEmStrong, ConvertToXhtml, EncodeScripts, OptimizeSpans, ConvertCharactersToEntities">
                                <SpellCheckSettings DictionaryPath="~/System/Localization/RadSpell" />
                                <ExportSettings OpenInNewWindow="true" />
                            </telerik:RadEditor>
                        </td>
                    </tr>
                </table>
            </div>
        </telerik:RadPane>
    </telerik:RadSplitter>
    <script type="text/javascript">
        //Initially Resize the RadSplitter according to its content
        //Set RadSplitter1 event to OnClientLoad="SplitterLoaded"
        function SplitterLoaded(splitter, arg) {
            //Get Splitter WxH
            var splitter = $find("<%= RadSplitter1.ClientID %>");
            var splitterHeight = splitter.get_height();

            //Set Editor WxH
            var wikieditor = $find("<%= WikiEditor.ClientID %>");
            wikieditor.setSize(900, splitterHeight - 150);
        }  
    </script>
    </form>
</body>
</html>
