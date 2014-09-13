<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Help_AutoTranslation_Google.aspx.vb" Inherits="plmOnApp.Help_AutoTranslation_Google" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="frmAutoTranslation" runat="server">
    <telerik:RadScriptManager Runat="server">
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
                             <cc1:confirmedimagebutton id="btnCancel" runat="server"  Message="NONE" ToolTip="Cancel"></cc1:confirmedimagebutton>
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
    <script type="text/javascript">
        function googleSectionalElementInit() {
            new google.translate.SectionalElement({
                sectionalNodeClassName: 'goog-trans-section',
                controlNodeClassName: 'goog-trans-control',
                background: 'transparent'
            }, 'google_sectional_element');
        }

        function OnClientLoad(editor, args)
        {
            var filtersManger = editor.get_filtersManager();
            var filterComment = filtersManger.getFilterByName("IEKeepCommentsFilter");
            var filterParams = filtersManger.getFilterByName("IEKeepObjectParamsFilter");
            if (typeof (filterComment) != "undefined")
            {
                filtersManger.remove(filterComment);
            }

            if (typeof (filterParams) != "undefined") {
                filtersManger.remove(filterParams);
            }
        }


        $(document).ready(function() {
            $("div.goog-trans-control").click(function(event) {
                //event.preventDefault();
                setTimeout(function() {
                $("input[name=txtWikiTitle]").val($(lblTransToTitle).text());
                //$("input[name=txtWikiEditor]").val($(lblTransToContent).text());
                $find("WikiEditor").set_html($(lblTransToContent).text());
            }, 1000);
            })//.trigger("click");
        });

        $(document).ready(function() {
            $("#btnSave").click(function(event) {
                //event.preventDefault();
                if ($("#txtWikiTitle").val() == '' || $("#WikiEditor").val() == '') {
                    alert('Please click Translate!');
                    return false;
                }
            });
        });
    </script>
    <%--<div id="google_translate_element"></div>--%>
    <telerik:RadSplitter ID="RadSplitter1" runat="server" Orientation="Vertical" Width="1400px" height="900px">
        <telerik:RadPane ID="transFrom" runat="server" width="300px" Height="900px" Scrolling="Both">
            <div style="padding:25px 10px 10px 10px; margin:10px 10px 10px 10px;">
                <h1><asp:Label ID="lblTransFromTitle" runat="server" Text=""></asp:Label></h1>
                    <asp:Label ID="lblTransFromContent" runat="server" Text=""></asp:Label>
            </div>
        </telerik:RadPane>
        <telerik:RadSplitBar ID="RadSplitBar1" runat="server" CollapseMode="Both" EnableResize="True">
        </telerik:RadSplitBar>
        <telerik:RadPane ID="transTo" runat="server" width="300px" Height="900px" Scrolling="Both">
            <div style="padding:10px 10px 10px 10px; margin:10px 10px 10px 10px;">
                <div class="goog-trans-section" lang="<%= strCopyFrom %>" >
                    <div class="goog-trans-control"></div>
                         <h1><asp:Label ID="lblTransToTitle" runat="server" Text=""></asp:Label></h1>
                             <asp:Label ID="lblTransToContent" runat="server" Text=""></asp:Label>
                </div>
            </div>
        </telerik:RadPane>
        <telerik:RadSplitBar ID="RadSplitBar2" runat="server" CollapseMode="Both" EnableResize="True">
        </telerik:RadSplitBar>
        <telerik:RadPane ID="WikiEdit" runat="server" width="700px" Height="900px" Scrolling="Both">
            <div style="padding:25px 10px 10px 10px; margin:10px 10px 10px 10px;">
                <table>
                    <tr>
                        <td><b>Title: </b></td>
                        <td><asp:TextBox ID="txtWikiTitle" runat="server" Width="500" ToolTip="Wiki Title"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <telerik:RadEditor ID="WikiEditor" runat="server" Skin="Office2010Blue" AutoResizeHeight="true"  ToolsFile="../System/Schema/BasicTools.xml" ToolbarMode="Default" ContentAreaMode="iframe" ContentFilters="FixUlBoldItalic, FixEnclosingP, MozEmStrong, OptimizeSpans" OnClientLoad="OnClientLoad">
                                <SpellCheckSettings DictionaryPath="~/System/Localization/RadSpell" />
                                <ExportSettings OpenInNewWindow="true" />
                            </telerik:RadEditor>
                        </td>
                    </tr>
                </table>
            </div>
        </telerik:RadPane>
    </telerik:RadSplitter>
    </form>
</body>
</html>
