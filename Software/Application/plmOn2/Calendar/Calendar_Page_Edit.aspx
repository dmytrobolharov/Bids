<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Calendar_Page_Edit.aspx.vb" Inherits="plmOnApp.Calendar_Page_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register Src="../System/Control/WaitControl.ascx" TagName="Color_Wait" TagPrefix="wc1" %>
<%@ Register Src="Calendar_Header.ascx" TagName="Calendar_Header" TagPrefix="hc1" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <script language="javascript" type="text/javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
    <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-1.6.2.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
            </td>
            <td valign="top">
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" Visible="false" Message="NONE">
                </cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"></cc1:ConfirmedImageButton>
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
    <table class="TableHeader CollapsibleHeader" height="25" cellspacing="0" cellpadding="0"
        width="100%" border="0">
        <tr>
            <td valign="middle" align="center" width="10">
                <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
            </td>
            <td width="20" valign="bottom">
                <asp:ImageButton ID="imgBtnToggleBOMs" OnClientClick="return toggleSectionVisibility(this);"
                    runat="server" ImageUrl="../System/Icons/icon_Next.gif"></asp:ImageButton>
            </td>
            <td align="left" valign="middle">
                <asp:Label ID="lblCalendar" runat="server"><%= getCalendarHeaderName()%></asp:Label>&nbsp;&nbsp;
            </td>
        </tr>
    </table>
    <div class="Collapsible">
        <hc1:Calendar_Header id="Calendar_Header" runat="server">
        </hc1:Calendar_Header>
    </div>
    
    <br />
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
        Font-Size="8pt" Height="100%" ProcessingMode="Remote" Width="100%" 
        PromptAreaCollapsed="true" ShowParameterPrompts="True" BorderColor="Gray" 
        BorderStyle="Solid" BorderWidth="0px" DocumentMapCollapsed="True"
        ShowBackButton="true" BackColor="WhiteSmoke" 
        ToolBarItemHoverBackColor="GhostWhite" 
        ToolBarItemPressedHoverBackColor="Gainsboro" SizeToReportContent="True">
    </rsweb:ReportViewer>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    </form>
        <script type="text/javascript">
            function toggleSectionVisibility(sender) {
                var collapsibleDiv = $(sender).closest(".CollapsibleHeader").nextAll(".Collapsible")[0];
                var hdnCollapsibleStatus = $(sender).siblings("input[id*='hdnIsExpanded']");

                if (collapsibleDiv != null) {
                    // Saving status of collapsed section to hidden field
                    if ($(collapsibleDiv).is(":visible")) {
                        $(collapsibleDiv).hide();
                        sender.src = '../System/Icons/icon_Next.gif'
                        if ($(hdnCollapsibleStatus)[0] != null) {
                            hdnCollapsibleStatus.val("false");
                        }
                    } else {
                        $(collapsibleDiv).show();
                        sender.src = '../System/Icons/icon_Down.gif'
                        if ($(hdnCollapsibleStatus)[0] != null) {
                            hdnCollapsibleStatus.val("true");
                        }
                    }
                }

                return false;
            }

            $(".Collapsible").hide();
    </script>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
