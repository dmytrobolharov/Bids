<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_Page_TradePartner.aspx.vb" Inherits="plmOnApp.Sourcing_Page_TradePartner" %>
<%@ Register src="Sourcing_Header.ascx" tagname="Sourcing_Header" tagprefix="hc1" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid_Y.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server" defaultbutton="imgBtnSearch" defaultfocus="form1">
    <table class="TableHeader" id="Table1" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td valign="top">
                <cc1:BWImageButton ID="btnTPAdd" runat="server"></cc1:BWImageButton>
                <cc1:BWImageButton ID="btnTPRemove" runat="server"></cc1:BWImageButton>
                 <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>
            </td>
        </tr>
    </table>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="25"
        cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                <asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="Large" Font-Names="Tahoma,Verdana"></asp:Label>
            </td>
        </tr>
    </table>    
    <table class="TableHeader CollapsibleHeader" height="25" cellspacing="0" cellpadding="0" width="100%"
        border="0">
         <tr>
            <td>
                <div >
                   <hc1:Sourcing_Header id="Sourcing_Header" runat="server" ></hc1:Sourcing_Header>
                </div>
            </td>           
         </tr>
        </table>       
    <table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
        <tr>
            <td>
                <asp:PlaceHolder ID="plhSearchControlsHolder" runat="server" EnableViewState="False"></asp:PlaceHolder>
            </td>
            <td width="100%" valign="top">
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
    <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff"
        border="0">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td width="16">
            </td>
            <td class="fontHead" width="100">
                <asp:Label ID="lblThumbnail" runat="server"></asp:Label>
            </td>
            <td width="20">
                <asp:ImageButton ID="btnImgFirst" runat="server"></asp:ImageButton>
            </td>
            <td width="20">
                <asp:ImageButton ID="btnImgPrevious" runat="server"></asp:ImageButton>
            </td>
            <td nowrap align="center" width="125">
                <asp:Label ID="lblPageCount" runat="server" CssClass="fontHead"></asp:Label>
            </td>
            <td width="20">
                <asp:ImageButton ID="btnImgNext" runat="server"></asp:ImageButton>
            </td>
            <td width="20">
                <asp:ImageButton ID="btnImgLast" runat="server" ToolTip="Last"></asp:ImageButton>
            </td>
            <td width="10">
                &nbsp;
            </td>
            <td nowrap>
                <asp:Label ID="RecordCount" runat="server" CssClass="font"></asp:Label>
            </td>
            <td class="fontHead" align="right" width="110">
                <asp:Label ID="lblRecordsPerPage" runat="server"></asp:Label>
            </td>
            <td width="25">
                <asp:DropDownList ID="ps" runat="server" CssClass="fontHead">
                    <asp:ListItem Value="5">5</asp:ListItem>
                    <asp:ListItem Value="10">10</asp:ListItem>
                    <asp:ListItem Value="15">15</asp:ListItem>
                    <asp:ListItem Value="20">20</asp:ListItem>
                    <asp:ListItem Value="25">25</asp:ListItem>
                    <asp:ListItem Value="30">30</asp:ListItem>
                    <asp:ListItem Value="40">40</asp:ListItem>
                    <asp:ListItem Value="50" Selected="True">50</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td width="10">
                <asp:Button ID="Button1" OnClick="RePage" runat="server" CssClass="fontHead"></asp:Button>
            </td>
        </tr>
    </table>
    <asp:DataGrid ID="DataGrid1" runat="server" DataKeyField="SourcingTradePartnerID" BorderStyle="Solid"
        BorderWidth="1px">
        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
        <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
        <PagerStyle Visible="False"></PagerStyle>
    </asp:DataGrid>
    <asp:Label ID="SortOrder" runat="server" Visible="False"></asp:Label>
    </form>
    <script type="text/javascript">
        var frm = document.forms['form1'];

        function toggleSectionVisibility(sender) {           
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
      /*  $("input[id*='hdnIsExpanded']").each(function () {
            var collapsibleDiv = $(this).closest(".CollapsibleHeader").nextAll(".Collapsible")[0];
            var btnToggle = $(this).siblings("input[id*='BtnToggle']");
            if (collapsibleDiv != null && $(btnToggle)[0] != null) {
                if (($(this).val() == 'false' && $(collapsibleDiv).is(":visible")) ||
                        ($(this).val() == 'true' && !$(collapsibleDiv).is(":visible"))
                        ) {
                    btnToggle.click();
                }
            }
        });*/
        
    </script>
</body>
</html>
