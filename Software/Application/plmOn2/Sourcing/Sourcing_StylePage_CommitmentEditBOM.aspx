<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_StylePage_CommitmentEditBOM.aspx.vb" Inherits="plmOnApp.Sourcing_StylePage_CommitmentEditBOM" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc2" TagName="QuotationEdit_CommentsAttachments" Src="Sourcing_StylePage_QuotationEdit_CommentsAttachments.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Sourcing_Partner_Header" Src="Sourcing_Partner_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Sourcing_WorkflowStatus_Commitment" Src="~/Sourcing/Sourcing_WorkflowStatus_Commitment.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title runat="server" id="pgTitle">Quotation View</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid_Y.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
    <script language="javascript" type="text/javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
    <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-1.6.2.min.js"></script>
    <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-ui-1.8.21.custom.min.js"></script>
</head>
<body>
    <form id="Form1" runat="server">
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

    <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td valign="middle" align="center" width="10">
                <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
            </td>
            <td width="100%">
                <%--<cc1:ConfirmedImageButton ID="btnCommit" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton>--%>
                <cc1:BWImageButton ID="btnGoToStyle" runat="server"></cc1:BWImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" OnClientClick="window.parent.close();"></cc1:ConfirmedImageButton>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <table height="100%" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td valign="top" height="25">
                <asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="Large" ForeColor="#E0E0E0"></asp:Label>
            </td>
        </tr>
    </table>
    
    <uc1:Sourcing_WorkflowStatus_Commitment ID="Sourcing_WorkflowStatus_Commitment1" runat="server" />
    <%--<uc1:Sourcing_Partner_Header ID="Sourcing_Partner_Header1" runat="server"></uc1:Sourcing_Partner_Header>--%>

    <asp:Panel ID="pnlBOMOptions" runat="server">
        <table class="TableHeader CollapsibleHeader" height="30" cellspacing="0" cellpadding="0" width="100%"
            border="0">
            <tr>
                <td>
                    <table cellpadding="0" cellspacing="0">
                        <tr>
                            <td valign="middle" align="center" width="10">
                                <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
                            </td>
                            <td width="20">
                                <asp:ImageButton ID="imgBtnToggleOption" OnClientClick="return toggleSectionVisibility(this);" runat="server"
                                    ImageUrl="../System/Icons/icon_Down.gif"></asp:ImageButton>
                            </td>
                            <td valign="middle" align="center" style="padding: 0 10px;">
                                <asp:Label ID="lblBOMOptions" runat="server" Text="BOM & Options"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div id="divBOMOptionContent" class="Collapsible" style="display: block">
            <cc3:YSTabView ID="YSTabView1" runat="server" />
            <asp:PlaceHolder ID="PlaceHolderSummary" runat="server"></asp:PlaceHolder>
        </div>
    </asp:Panel>    
    </form>
</body>
<script language="javascript" type="text/javascript">
		    var frm = document.forms['form1'];

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

            // For toggling the expandable items to state, in which they were before postback
		    $("input[id*='hdnIsExpanded']").each(function () {
		        var collapsibleDiv = $(this).closest(".CollapsibleHeader").nextAll(".Collapsible")[0];
		        var btnToggle = $(this).siblings("input[id*='BtnToggle']");
		        if (collapsibleDiv != null && $(btnToggle)[0] != null) {
		            if (($(this).val() == 'false' && $(collapsibleDiv).is(":visible")) ||
                        ($(this).val() == 'true' && !$(collapsibleDiv).is(":visible"))
                        ) {
		                btnToggle.click();
		            }
		        }
		    });            
</script>
</html>
