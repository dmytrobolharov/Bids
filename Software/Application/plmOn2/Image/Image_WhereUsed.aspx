<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Image_WhereUsed.aspx.vb" Inherits="plmOnApp.Image_WhereUsed" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc1" TagName="ImageHeader" Src="Image_Header.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/jquery-ui.css" type="text/css" rel="stylesheet" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <style type="text/css">
         #RadGridStyles .rgMasterTable td, #RadGridMaterials .rgMasterTable td, #RadGridImageCatalog .rgMasterTable td {
            border-color: #ddd !important;
         }
         
        th.rgHeaderYPLM, th.rgHeader {
            padding: 0 0px !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server" EnablePageMethods="true" EnablePartialRendering="true">
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
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td valign="top">
                <cc1:ConfirmedImageButton ID="btnBatchUpdate" runat="server" CausesValidation="false" Message="NONE" OnClientClick="return ShowMessage();"></cc1:ConfirmedImageButton>
            </td>
            <td>
            </td>
        </tr>
    </table>
    <div style="background-color: #cddeee; height: 10px"></div>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:Label>
            </td>
        </tr>
    </table>    
    <uc1:ImageHeader runat="server" ID="ctrImageHeader" />

    <cc2:YSTabView ID="YSTabView1" runat="server"></cc2:YSTabView>
    <table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0" style="padding-top: 5px;">
        <tr>
            <td class="search-cell">
                <asp:PlaceHolder ID="plhControlsHolder" runat="server" EnableViewState="False"></asp:PlaceHolder>
            </td>
            <td valign="middle" width="100%">
                <table id="Table3" height="45">
                    <tr>
                        <td valign="middle">
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
            <td width="100" runat="server" id="tdCheckAll"><label><input type="checkbox" runat="server" id="chkCheckAll" onclick="CheckAll(this, 'chkStyleSelect')" /><%= GetSystemText("Select All")%></label></td>
            <td width="100" runat="server" id="tdThumbnail">
                <asp:CheckBox runat="server" id="chbThumbnail" AutoPostBack="true" />
            </td>
            <td width="20">
                <asp:ImageButton ID="btnImgFirst" runat="server"></asp:ImageButton>
            </td>
            <td width="20">
                <asp:ImageButton ID="btnImgPrevious" runat="server"></asp:ImageButton>
            </td>
            <td nowrap align="center" width="125">
                <asp:Label ID="lblCounts" runat="server" CssClass="fontHead"></asp:Label>
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
            <td nowrap height="25">
                <div align="left">
                    <b>
                        <asp:Label ID="lblRecordCount" Visible="true" runat="server"></asp:Label>&nbsp;
                        <asp:Label ID="lblRecordFound" runat="server" />
                    </b>
                </div>
            </td>
            <td align="left">
                <asp:RadioButtonList ID="rbViewType" RepeatDirection="Horizontal" runat="server" AutoPostBack="true">
                    <asp:ListItem Text="Thumb View" Value="T"></asp:ListItem>
                    <asp:ListItem Text="List View" Value="L" Selected="True"></asp:ListItem>
                </asp:RadioButtonList>
            </td>
            <td width="110" align="right">
                <asp:Label ID="lblRecordPerPage" runat="server" CssClass="fontHead"></asp:Label>
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
                <asp:Button ID="btnGo" runat="server" CssClass="fontHead" Text="GO"></asp:Button>
            </td>
        </tr>
    </table>
    <asp:Panel ID="pnlStyles" runat="server">                     
        <asp:PlaceHolder runat="server" ID="plhStylesGrid"></asp:PlaceHolder>
        <asp:Label ID="SortOrder" runat="server" Visible="False"></asp:Label>                    
        <asp:DataList ID="dlStyles" runat="server" DataKeyField="StyleID" RepeatDirection="Horizontal" RepeatLayout="Flow" RepeatColumns="0" ItemStyle-VerticalAlign="Top" ItemStyle-Width="300px">
        <ItemTemplate>
            <table class="TableHeader" style="border: 1px solid #ccc;" cellspacing="0" cellpadding="0" width="100%">
                    <tr>
                        <td>
                            <cc1:BWImageButton ImageUrl='<%# GetImagePath("btn_goto.gif", Me.UserProperties.PrefLang) %>' NavigateUrl='<%# String.Format("Image_StyleGoTo.aspx?SID={0}&SYID={1}", Eval("StyleID").ToString, Eval("SeasonYearID").ToString) %>'
                                WindowWidth='320' Resizable="false" ScrollBars="true" Status="true" WindowHeight='500' OnClientClick="return false;" ID="btnGoTo" runat="server" />
                            <asp:CheckBox ID="chkStyleSelect" runat="server" Text='<%# GetSystemText("Select Style") & "..." %>' />                                            
                        </td>
                    </tr>                                
            </table>
            <table style="border:1px solid gainsboro;" cellspacing="0" bordercolor="gainsboro" cellpadding="0" width="100%">
                <tbody>
                    <tr>
                        <td height="300" width="300" colspan="2">
                            <p align="center">
                                <asp:Image runat="server" ImageUrl='<%#GetImageStreamPath("280", Eval("DesignSketchVersion").ToString, Eval("DesignSketchID").ToString) %>' />
                            </p>
                        </td>
                    </tr>
                </tbody>
            </table>
            <asp:PlaceHolder ID="phStyleInfo" runat="server"></asp:PlaceHolder>
        </ItemTemplate>
    </asp:DataList>
    <div id="style-dialog-message" style="display: none;"><p><%= GetSystemText("You are about to update the version of the image in ") & "{N}" & GetSystemText(" styles. Are you sure you want to continue")%>?</p></div>
    </asp:Panel>
    <asp:Panel runat="server" ID="pnlMaterial">
        <asp:PlaceHolder runat="server" ID="plhMaterialsGrid"></asp:PlaceHolder>
        <asp:DataList ID="dlMaterials" runat="server" RepeatDirection="Horizontal" RepeatColumns="8" EnableViewState="True"
            DataKeyField="MaterialID">
            <ItemStyle BorderWidth="1px" BorderStyle="Solid" BackColor="White" BorderColor="Gainsboro" VerticalAlign="Top">
            </ItemStyle>
            <ItemTemplate>                                
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="lblMessage" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label align="left" ID="lblMaterialData" runat="server" AssociatedControlID="materialCheck" Width='<%#ImageWidth.Value%>'
                                Height='<%#ImageWidth.Value%>' Style='<%# String.Format("display: block; background-image:url({0})", GetImageStreamPath(ImageWidth.Value, Eval("MaterialImageVersion").ToString, Eval("MaterialImageID").ToString))%>'>
                                <asp:CheckBox ID="materialCheck" runat="server" />
                            </asp:Label>
                            <asp:PlaceHolder ID="plhHeaderItem" runat="server"></asp:PlaceHolder>
                            <br />
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:DataList>
        <div id="materials-dialog-message" style="display: none;"><p><%= GetSystemText("You are about to update the version of the image in ") & "{N}" & GetSystemText(" Materials. Are you sure you want to continue")%>?</p></div>
    </asp:Panel>
    <asp:Panel runat="server" ID="pnlImageCatalog">
        <asp:PlaceHolder runat="server" ID="plhImageCatalogGrid"></asp:PlaceHolder>
        <asp:DataList ID="dlImageCatalog" runat="server" RepeatDirection="Horizontal" RepeatColumns="8" EnableViewState="True"
            DataKeyField="ImageCatalogID">
            <ItemStyle BorderWidth="1px" BorderStyle="Solid" BackColor="White" BorderColor="Gainsboro" VerticalAlign="Top">
            </ItemStyle>
            <ItemTemplate>                                
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="lblMessage" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label align="left" ID="lblImageCatalogData" runat="server" AssociatedControlID="ImageCatalogCheck" Width='<%#ImageWidth.Value%>'
                                Height='<%#ImageWidth.Value%>' Style='<%# String.Format("display: block; background-image:url({0})", GetImageStreamPath(ImageWidth.Value, Eval("CatalogImageVersion").ToString, Eval("CatalogImageID").ToString))%>'>
                                <asp:CheckBox ID="ImageCatalogCheck" runat="server" />
                            </asp:Label>
                            <asp:PlaceHolder ID="plhHeaderItem" runat="server"></asp:PlaceHolder>
                            <br />
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:DataList>
        <div id="catalog-dialog-message" style="display: none;"><p><%= GetSystemText("You are about to update the version of the image in ") & "{N}" & GetSystemText(" Image Catalogs. Are you sure you want to continue")%>?</p></div>
    </asp:Panel>

    <script type="text/javascript" src="../System/Jscript/jquery-ui-1.10.3.custom.min.js"></script>
    <script type="text/javascript" language="javascript">
        var frm = document.forms['form1'];
        function CheckAll(checkAllBox, name) {
            var actVar = checkAllBox.checked;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf(name) != -1)
                    e.checked = actVar;
            }
        }

        function ShowMessage() {
            if (($("#RadGridStyles tbody :checked").length > 0 || $("#dlStyles :checked").length > 0) ||
                ($("#RadGridMaterials tbody :checked").length > 0 || $("#dlMaterials :checked").length > 0) ||
                ($("#RadGridImageCatalog tbody :checked").length > 0 || $("#dlImageCatalog :checked").length > 0)
                ) {
            
                $("#style-dialog-message p").text($("#style-dialog-message p").text().replace("{N}", $("#RadGridStyles tbody :checked").length + $("#dlStyles :checked").length));
                $("#materials-dialog-message p").text($("#materials-dialog-message p").text().replace("{N}", $("#RadGridMaterials tbody :checked").length + $("#dlMaterials :checked").length));
                $("#catalog-dialog-message p").text($("#catalog-dialog-message p").text().replace("{N}", $("#RadGridImageCatalog tbody :checked").length + $("#dlImageCatalog :checked").length));
            
                $('<%= MessageName %>').dialog({
                    modal: true,
                    resizable: false,
                    buttons: {
                        Yes: function () {
                            <%= GetPostBackEventReference(btnBatchUpdate) %>;
                            $(this).dialog("close");
                        },
                        No: function () {
                            $(this).dialog("close");
                        }
                    }
                });
            }
            return false;
        }
    </script>

    </form>
    <script type="text/javascript">

        function RadGridStyles_ColumnHidden(sender, eventArgs) {
            var tableColumns = $find("RadGridStyles").get_masterTableView().get_columns();
            var hiddenColumns = new Array();
            for (var i = 0; i < tableColumns.length; i++) {
                if (tableColumns[i].get_visible() == false) {
                    hiddenColumns.push(tableColumns[i].get_uniqueName());
                }
            }
            var strHiddenColumns = hiddenColumns.join();
            PageMethods.SaveHiddenColumns('RadGridStyles', '<%= aspxPageName %>', strHiddenColumns, '<%= UserProperties.TeamID %>', '<%= UserProperties.Username %>');
        }

        function RadGridStyles_ColumnShown(sender, eventArgs) {
            var tableColumns = $find("RadGridStyles").get_masterTableView().get_columns();
            var hiddenColumns = new Array();
            for (var i = 0; i < tableColumns.length; i++) {
                if (tableColumns[i].get_visible() == false) {
                    hiddenColumns.push(tableColumns[i].get_uniqueName());
                }
            }
            var strHiddenColumns = hiddenColumns.join();
            PageMethods.SaveHiddenColumns('RadGridStyles', '<%= aspxPageName %>', strHiddenColumns, '<%= UserProperties.TeamID %>', '<%= UserProperties.Username %>');
        }

        function RadGridMaterials_ColumnHidden(sender, eventArgs) {
            var tableColumns = $find("RadGridMaterials").get_masterTableView().get_columns();
            var hiddenColumns = new Array();
            for (var i = 0; i < tableColumns.length; i++) {
                if (tableColumns[i].get_visible() == false) {
                    hiddenColumns.push(tableColumns[i].get_uniqueName());
                }
            }
            var strHiddenColumns = hiddenColumns.join();
            PageMethods.SaveHiddenColumns('RadGridMaterials', '<%= aspxPageName %>', strHiddenColumns, '<%= UserProperties.TeamID %>', '<%= UserProperties.Username %>');
        }

        function RadGridMaterials_ColumnShown(sender, eventArgs) {
            var tableColumns = $find("RadGridMaterials").get_masterTableView().get_columns();
            var hiddenColumns = new Array();
            for (var i = 0; i < tableColumns.length; i++) {
                if (tableColumns[i].get_visible() == false) {
                    hiddenColumns.push(tableColumns[i].get_uniqueName());
                }
            }
            var strHiddenColumns = hiddenColumns.join();
            PageMethods.SaveHiddenColumns('RadGridMaterials', '<%= aspxPageName %>', strHiddenColumns, '<%= UserProperties.TeamID %>', '<%= UserProperties.Username %>');
        }

        function RadGridImageCatalog_ColumnHidden(sender, eventArgs) {
            var tableColumns = $find("RadGridImageCatalog").get_masterTableView().get_columns();
            var hiddenColumns = new Array();
            for (var i = 0; i < tableColumns.length; i++) {
                if (tableColumns[i].get_visible() == false) {
                    hiddenColumns.push(tableColumns[i].get_uniqueName());
                }
            }
            var strHiddenColumns = hiddenColumns.join();
            PageMethods.SaveHiddenColumns('RadGridImageCatalog', '<%= aspxPageName %>', strHiddenColumns, '<%= UserProperties.TeamID %>', '<%= UserProperties.Username %>');
        }

        function RadGridImageCatalog_ColumnShown(sender, eventArgs) {
            var tableColumns = $find("RadGridImageCatalog").get_masterTableView().get_columns();
            var hiddenColumns = new Array();
            for (var i = 0; i < tableColumns.length; i++) {
                if (tableColumns[i].get_visible() == false) {
                    hiddenColumns.push(tableColumns[i].get_uniqueName());
                }
            }
            var strHiddenColumns = hiddenColumns.join();
            PageMethods.SaveHiddenColumns('RadGridImageCatalog', '<%= aspxPageName %>', strHiddenColumns, '<%= UserProperties.TeamID %>', '<%= UserProperties.Username %>');
        }

    </script>
</body>
</html>
