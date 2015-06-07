<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_NBOL_Template_Edit.aspx.vb" Inherits="plmOnApp.Control_NBOL_Template_Edit" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Control Panel</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid_Y.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
    <style type="text/css">
    .rightAlign, .rightAlign input
    {
    	text-align:right !important;
    }
    #RadGridTplData.RadGrid_YPLM .rgHoveredRow td { background-image: none !important; background-color: #508FE2 !important; }
    #RadGridTplData .rgRowYPLMBlueE td.font { padding: 2px 10px 2px 4px; } 
    </style>
</head>
<body>
    <form id="form1" runat="server" defaultbutton="imgBtnSearch">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js"></asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js"></asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js"></asp:ScriptReference>
        </Scripts>
        <CdnSettings TelerikCdn="Disabled" />
    </telerik:RadScriptManager>
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server">
        <StyleSheets>
            <telerik:StyleSheetReference Path="../System/CSS/RadCalendar.YPLM.css" />
            <telerik:StyleSheetReference Path="../System/CSS/RadComboBox.YPLM.css" />
            <telerik:StyleSheetReference Path="../System/CSS/RadGrid.YPLM.css" />
            <telerik:StyleSheetReference Path="../System/CSS/RadInput.YPLM.css" />
        </StyleSheets>
        <CdnSettings TelerikCdn="Disabled" />
    </telerik:RadStyleSheetManager>
    <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1" />
    <table id="Table1" class="TableHeader TableFloatHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3"><asp:ImageButton ID="ImageButton2" runat="server"
                    ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px" TabIndex="0" />
            </td>
            <td>
            <cc1:bwimagebutton id="btnWhereUsed" runat="server" WindowName="BOLTemplateWhereUsed"></cc1:bwimagebutton>
                <cc1:ConfirmedImageButton ID="btnSave" Visible="true" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                 <cc1:ConfirmedImageButton ID="btnSaveClose" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnSaveNew" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnDelete" Visible="true" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" Visible="true" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"></cc1:ConfirmedImageButton>                
            </td>
            <td class="FontHead" align="right" width="75">
            </td>
            <td width="40">
            </td>
            <td>
            </td>
        </tr>
    </table>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45"
        cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
        <td width="10">
                    &nbsp;
                </td>
            <td>
                &nbsp;<asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:Label>
            </td>
        </tr>
    </table>
    <table id="TableEdit" style="border-bottom: orange thin solid; background-color: white" cellspacing="2" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr>
        <td width="25">
                    &nbsp;
                </td>
            <td>
                <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
            </td>
            <td valign="top">
                <table cellspacing="0" cellpadding="0" width="400" border="0" style="background-color: White">
                    <tr><td>
                        <table><tr>
                        <td class="fontHead" valign="top" width="150">
                            <asp:Label ID="lblImageFile" runat="server"></asp:Label>:
                        </td>
                        <td class="font" align="right">
                            <input class="font" id="txtImagePath" type="file" name="txtImagePath" runat="server" />
                        </td>
                        </tr></table>
                    </td></tr>
                    <tr><td>
                        <table><tr>
                        <td class="font">
                            <br />
                            <cc1:BWImageButton ID="imgFeature" runat="server" />
                        </td>
                        <td valign="bottom">
                            <cc1:ConfirmedImageButton ID="btnImageRemove" runat="server" />
                        </td>
                        </tr></table>
                    </td></tr>
                </table>
            </td>
        </tr>
        <tr height="20">
            <td></td>
        </tr>
    </table>
    <table id="Table2" class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3"><asp:ImageButton ID="ImageButton1" runat="server"
                    ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px" TabIndex="0" />
            </td>
            <td>
                <cc1:BWImageButton ID="btnTabAddOp" Visible="true" runat="server"></cc1:BWImageButton>
                <cc1:BWImageButton ID="btnTabAddMacro" Visible="true" runat="server"></cc1:BWImageButton>
                <cc1:BWImageButton ID="btnTabCopy" Visible="true" runat="server"></cc1:BWImageButton>
                <cc1:BWImageButton ID="btnSort" runat="server" WindowHeight="400px" WindowWidth="600px"></cc1:BWImageButton>
                <cc1:ConfirmedImageButton ID="btnRemove" Visible="true" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
            </td>
            <td class="FontHead" align="right" width="75">
            </td>
            <td width="40">
            </td>
            <td>
            </td>
        </tr>
    </table>
    <table id="Table4" height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
        <tr>
            <td>
                <asp:PlaceHolder ID="plhSearchControl" runat="server" EnableViewState="False"></asp:PlaceHolder>
            </td>
            <td valign="top" width="100%">
                <table height="45">
                    <tr>
                        <td>
                            <asp:ImageButton ID="imgBtnSearch" runat="server"></asp:ImageButton>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:PlaceHolder runat="server" ID="plhTemplateData"></asp:PlaceHolder>
    <asp:Label ID="SortOrder" runat="server" Visible="False"></asp:Label>
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td valign="top">
            </td>
        </tr>
    </table>
    </form>
</body>

<script language="javascript" type="text/javascript">
    var frm = document.form1;

    function SelectAll(checkAllBox) {
        var actVar = checkAllBox.checked;
        for (i = 0; i < frm.length; i++) {
            e = frm.elements[i];
            if (e.type == 'checkbox' && e.name.indexOf("chkDelete") != -1)
                if (e.disabled == false)
                e.checked = actVar;
        }
    }
    function getElementsByNameIE(tag, name) {

        var elem = document.getElementsByTagName(tag);
        var arr = new Array();
        for (i = 0, iarr = 0; i < elem.length; i++) {
            att = elem[i].getAttribute("name");
            if (att == name) {
                arr[iarr] = elem[i];
                iarr++;
            }
        }
        return arr;
    }
    function hideUnhide(MacroParentId, trigger) {
        var h = getElementsByNameIE("tr", "hide_" + MacroParentId)
        for (var i = 0; i < h.length; i++) {
            if (h[i].style.display == 'none') {
                h[i].style.display = ''
                trigger.src = '../System/Icons/tv_minusdotst.gif'
            }
            else {
                if (h[i].style.display == '') h[i].style.display = 'none'
                trigger.src = '../System/Icons/tv_plusdotsbt.gif'
            }
        }
    }

    function expandToggleAll(expandCollapseItem) {
        var expanded = (expandCollapseItem.src.toLowerCase().indexOf("icon_next.gif") != -1);

        var dataitems = $find("<%= m_RadGridTplData.MasterTableView.ClientID %>").get_dataItems(),
            i, len = dataitems.length;
        for (i = 0; i < len; i++) {
            if (dataitems[i].get_nestedViews().length > 0) {
                dataitems[i].set_expanded(expanded);
            }
        }

        expandCollapseItem.src = expanded ? "../System/Icons/icon_Down.gif" : "../System/Icons/icon_Next.gif";
    }

    /**
    * to align operatins in macro with other operation moved then from inner table to outter one
    */
    var expands = {};

    $(".rgDetailTable").each(function () {
        var $self = $(this),
                $trigger = $self.closest("tr").prev(),
                $moved = $self.find("tbody tr[id]").hide();

        $trigger.next()
                .height(0)
                .css({ border: 0, visibility: "hidden" })
                    .children().css({border:0, padding:0}).end()
                .after($moved);

        expands[$trigger.attr("id")] = $moved;
    });

    function OnHierarchyExpanding(sender, e) {
        expands[e.get_id()].show();

        return true;
    }

    function OnHierarchyCollapsing(sender, e) {
        expands[e.get_id()].hide();

        return true;
    }  
</script>
<script language="javascript">
	function btnClose_Click() {
		<%= strExitScript %>
        return false;
    }
</script>
</html>
