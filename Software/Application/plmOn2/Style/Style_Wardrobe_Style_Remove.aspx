<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_Wardrobe_Style_Remove.aspx.vb"
    Inherits="plmOnApp.Style.Wardrobe.Style_Wardrobe_Style_Remove" %>

<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server" defaultbutton="imgbtnSearch">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td valign="top">
                <cc1:confirmedimagebutton id="btnSave" runat="server" message="NONE"></cc1:confirmedimagebutton>
                <cc1:confirmedimagebutton id="btnClose" runat="server" message="NONE" onclientclick="return btnClose_Click()"></cc1:confirmedimagebutton>
            </td>
            <td width="75">
                &nbsp;
            </td>
            <td align="right">
            </td>
        </tr>
    </table>
    <table height="10" cellspacing="0" cellpadding="0" width="100%" bgcolor="#cddeee"
        border="0">
        <tr>
            <td>
            </td>
        </tr>
    </table>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
        height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                <asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large"
                    Font-Names="Tahoma,Verdana"></asp:Label>
            </td>
        </tr>
    </table>
    <asp:Panel runat="server" ID="pnlMain">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
            <tr>
                <td>
                    &nbsp;<asp:Label id="Label1" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
                        ForeColor="#E0E0E0"></asp:Label>
                </td>
            </tr>
        </table>
        <cc3:ystabview id="YSTabView1" runat="server"></cc3:ystabview>
        <table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
            <tr>
                <td>
                    <asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder>
                </td>
                <td width="100%" valign="top">
                    <table id="Table3" height="45">
                        <tr>
                            <td>
                                <asp:imagebutton id="imgBtnSearch" runat="server">
                                </asp:imagebutton>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <telerik:radscriptmanager id="RadScriptManager1" runat="server">
                <Scripts>
                    <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js"></asp:ScriptReference>
                    <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js"></asp:ScriptReference>
                    <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js"></asp:ScriptReference>
                </Scripts>
                <CdnSettings TelerikCdn="Disabled" />
            </telerik:radscriptmanager>
        <telerik:radstylesheetmanager id="RadStyleSheetManager1" runat="server">
                <StyleSheets>
                    <telerik:StyleSheetReference Path="../System/CSS/RadCalendar.YPLM.css" />
                    <telerik:StyleSheetReference Path="../System/CSS/RadComboBox.YPLM.css" />
                    <telerik:StyleSheetReference Path="../System/CSS/RadGrid.YPLM.css" />
                    <telerik:StyleSheetReference Path="../System/CSS/RadInput.YPLM.css" />
                </StyleSheets>
                <CdnSettings TelerikCdn="Disabled" />
            </telerik:radstylesheetmanager>
        <telerik:radajaxmanager runat="server" id="RadAjaxManager1" />
        <asp:PlaceHolder id="phStyle" runat="server"></asp:PlaceHolder>
        <asp:PlaceHolder id="phStyleGrid" runat="server"></asp:PlaceHolder>
        <input id="hiddenSearchSQL" type="hidden" value="" name="hiddenSearchSQL" runat="server" />
    </asp:Panel>
    </form>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
    <script language="javascript">
        $(document).ready(function () {
            $("[id$=_chbSelect], [id$=_chbSelectAll]").attr('checked', false);
        });
    </script>
</body>
</html>
