<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_Workflow_Edit_DivisionStyleType.aspx.vb" Inherits="plmOnApp.Control_Workflow_Edit_DivisionStyleType" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%--@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Control Panel</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
    <style type="text/css">
    .rightAlign 
    {
    	text-align:right;
    }
    
    </style>
</head>
<body style="background-color: white">
    <form id="form1" runat="server">

    <telerik:RadScriptManager ID="RadScriptManager1" runat="server" >
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js"></asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js"></asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js"></asp:ScriptReference>
        </Scripts>
        <CdnSettings TelerikCdn="Disabled" />
    </telerik:RadScriptManager>
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" Runat="server">
        <StyleSheets>
            <telerik:StyleSheetReference Path="../System/CSS/RadCalendar.YPLM.css" />
            <telerik:StyleSheetReference Path="../System/CSS/RadComboBox.YPLM.css" />
            <telerik:StyleSheetReference Path="../System/CSS/RadGrid.YPLM.css" />
            <telerik:StyleSheetReference Path="../System/CSS/RadInput.YPLM.css" />
        </StyleSheets>
        <CdnSettings TelerikCdn="Disabled" />
    </telerik:RadStyleSheetManager>
    <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1" />

    <div>
        <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                </td>
                <td>
                    <cc1:ConfirmedImageButton ID="btnSaveOnly" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" CausesValidation="false" OnClientClick="return btnClose_Click()"></cc1:ConfirmedImageButton>
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
        <table cellspacing="2" cellpadding="0"  border="0" style="background-color: white">
            <tr>
                <td>
                    <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
                </td>
            </tr>
        </table>
        <table cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <td valign="top">
                </td>
            </tr>
        </table>
    </div>

    <table class="TableHeader" id="Table1" cellspacing="0" cellpadding="0" width="100%" height="30" border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td>
                <asp:Label ID="lblDivisionalConfig" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <%--<cc2:YSTabView ID="YSTabView" runat="server"></cc2:YSTabView>--%>
    <asp:DataGrid ID="DataGrid1" runat="server" AllowSorting="True" DataKeyField="DivisionID" AutoGenerateColumns="false">
        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
        <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
        <PagerStyle Visible="False"></PagerStyle>
        <Columns>
            <asp:TemplateColumn>
                <HeaderStyle Width="130" />
                <ItemStyle CssClass="names" />
                <ItemTemplate>
                    <img runat="server" id="imgToggler" onclick='<%# String.Format("toggleRows(this, &#39;{0}&#39;)", Eval("DivisionID").ToString)%>'
                        style="cursor: pointer" src="../System/Icons/icon_Down.gif" alt="" />
                    <asp:Label runat="server" ID="lblName" Text='<%# Eval("Name") %>'></asp:Label>
                    <asp:HiddenField runat="server" ID="hdnDivisionID" Value='<%# Eval("DivisionID") %>' />
                    <asp:HiddenField runat="server" ID="hdnStyleTypeID" Value='<%# Eval("StyleTypeID") %>' />
                    <asp:HiddenField runat="server" ID="hdnRowName" Value='<%#Convert.ToString(Eval("Name")) %>'/>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn>
                <HeaderStyle Width="120" HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                <HeaderTemplate><asp:Label ID="lblFilter" runat="server" Text='<%# GetSystemText("Filter") %>' ></asp:Label></HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="chkFilter" divisionid='<%# Eval("DivisionID") %>' runat="server" Checked='<%# Eval("Filter") %>' />
                </ItemTemplate>
            </asp:TemplateColumn>
        </Columns>
    </asp:DataGrid>
    <asp:Label ID="SortOrder" runat="server" Visible="False"></asp:Label>
    </form>

    <script type="text/javascript" language="javascript">
        $("#DataGrid1 td:first").css({border: 'none', visibility: 'hidden'});
        $(".TableHeader input[id*=chkFilter]").change(function () { $("span[divisionid='" + $(this).parent().attr("divisionid") + "'] input[id*=chkFilter]").attr('checked', this.checked); })

        function toggleRows(img, style_category) {
            if ($(img).closest("tr").nextUntil(".TableHeader").toggle().is(":visible")) {
                img.src = "../System/Icons/icon_Down.gif";
            } else {
                img.src = "../System/Icons/icon_Next.gif";
            }
        }
    </script>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
