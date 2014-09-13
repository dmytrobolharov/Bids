<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Planning_StyleProperty.aspx.vb" Inherits="plmOnApp.Planning_StyleProperty" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="../Style/Style_Header.ascx" %>
<%@ Register Src="../System/Control/WaitControl.ascx" TagName="Color_Wait" TagPrefix="wc1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
<head>
    <title>Planning Item</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .BOMColorwayList {
        	width: 200px;
        }
        
        #tblSKUHeader td {
        	vertical-align: top;
        }
        
        #tblSKUHeader td td { vertical-align: middle;}
        
        .multi-sku { background-color: Yellow; }
    </style>
    <style type="text/css">
            #imgContainer
            {
                position:relative;
            }
            #imgContainer div 
            {
                position:absolute;
                left:0;
                background-color: White;
                visibility: hidden;
            }
            #imgContainer div img
            {
                width: 100%;
                max-height: 100%;
            }
        </style>
</head>
<body>
<div id="Div1"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="A1"></a></div>
    <form id="Form1" method="post" runat="server">
    <wc1:Color_Wait ID="Color_Wait" runat="server" />
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
    <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1">
    </telerik:RadAjaxManager>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
        <Windows>
            <telerik:RadWindow ID="AddSeasonalColor" runat="server" Title="Add Color" Height="500px" Width="700px"
                ReloadOnShow="true" ShowContentDuringLoad="false" NavigateUrl="Line_List_Folder_Style_SeasonalColorAdd.aspx"
                Behaviors="Close" IconUrl="../System/Icons/icon_table.gif" KeepInScreenBounds="true" Modal="true" />
        </Windows>
    </telerik:RadWindowManager>
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton><cc1:ConfirmedImageButton
                    ID="btnSaveAndClose" runat="server" Message="NONE"></cc1:ConfirmedImageButton><cc1:BWImageButton
                    ID="btnGoToStyle" runat="server"></cc1:BWImageButton><cc1:ConfirmedImageButton ID="btnDrop" runat="server">
                    </cc1:ConfirmedImageButton><cc1:ConfirmedImageButton ID="btnSetActive" runat="server"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnRemove" runat="server" Message="NONE" CausesValidation="False"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
            </td>
        </tr>
    </table>    
    <table id="TABLE1" class="TableHeaderOver" height="24" cellspacing="0" cellpadding="0" width="100%" border="0"
        runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td>
                <asp:Label ID="Label4" runat="server" CssClass="fontHead"></asp:Label>
            </td>
        </tr>
    </table>
    <table cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td width="100%">
                <uc1:Style_Header ID="Style_Header1" runat="server"></uc1:Style_Header>
            </td>            
        </tr>
    </table>
    <table bordercolor="whitesmoke" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="1">
        <tr>
            <td width="25%" align="center" valign="top">
                <table class="TableHeaderOver" height="24" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr valign="middle">
                        <td valign="middle" align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                        </td>
                        <td>
                            <asp:Label ID="Label2" runat="server" CssClass="fontHead"></asp:Label>
                        </td>
                    </tr>
                </table>
                <div id="imgContainer" align="center">
                    <div id="imgDesignBackContainer">
                        <cc1:BWImageButton id="imgDesignBack" runat="server">
                        </cc1:BWImageButton>
                    </div>
                    <div id="imgDesignContainer">
                        <cc1:BWImageButton id="imgDesign" runat="server">
                        </cc1:BWImageButton>
                    </div>
                </div>
            </td>
            <td valign="top" width="75%">
                <cc2:YSTabView runat="server" ID="YSTabView1" />
                <div style="overflow:hidden;">
                <asp:Panel runat="server" ID="pnlBOM">
                <div id="divBOM" runat="server" style="margin-top: 5px; margin-bottom: 5px; padding-left: 20px;">
                    <asp:HiddenField ID="hdnStyleBOMDimensionId" runat="server" Value="" />
                    <asp:Label ID="lblBOM" runat="server" CssClass="fontHead"></asp:Label>
                    <asp:DropDownList ID="drlStyleBOMDimensionId" runat="server" AutoPostBack="true" CssClass="font" Width="100">
                    </asp:DropDownList>
                    <cc1:BWImageButton ID="imgBtnBOMAdd" runat="server" ImageUrl="../System/Icons/icon_add.gif" Enabled="false"></cc1:BWImageButton>
                </div>
                <asp:DataList ID="dlDimBoms" runat="server" RepeatDirection="Vertical" CssClass="font" DataKeyField="DimTypeID">
                    <ItemTemplate>
                        <table cellspacing="1" cellpadding="1" width="100%">
                            <tr class="TableHeader">
                                <td>
                                    <asp:Label runat="server" ID="lblDimTypeName" class="fontHead" Text='<%# Eval("DimTypeName") %>'></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <asp:DataList ID="dlItemDim" runat="server" DataKeyField="StyleBOMDimensionItemID" BorderColor="Silver"
                            RepeatDirection="Horizontal" CellPadding="0" CellSpacing="0">
                            <ItemStyle CssClass="BOMColorway" />
                            <AlternatingItemStyle CssClass="BOMColorway" />
                            <ItemTemplate>
                                <table cellspacing="0" style="border: 1px solid gainsboro;" width="100%">
                                    <thead>
                                        <tr class="TableHeader" height="20">
                                            <th colspan="2" style="width: 75px; height:30px;">
                                                <asp:Label ID="lblDimItemName" runat="server" CssClass="fontHead"><%# Eval("DimItemName")%></asp:Label>
                                                <asp:HiddenField ID="hdnDimItemName" runat="server" Value='<%# Eval("DimItemName")%>' />
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr class="font">
                                            <td colspan="2">
                                                <asp:CheckBox ID="chbDimItemActive" runat="server" Checked='<%# Eval("DimItemActive") = 1 %>' Enabled='<%# _BOMIsEditable %>' />
                                                <asp:HiddenField ID="hdnDimItemActive" runat="server" Value='<%# Eval("DimItemActive") %>' />
                                            </td>
                                        </tr>
                                        <tr class="font" runat="server" id="trColorInfo" visible='<%# Eval("IsColor") = 1 %>'>
                                            <td width="20">
                                                <asp:Image ID="imgColorway" runat="server" Width="20" Height="20" ImageUrl='<%# GetColorStreamPath("20", Eval("ColorFolderID").ToString(), Eval("ColorPaletteID").ToString()) %>' />
                                            </td>
                                            <td style="text-align: left;" width="95%">
                                                <asp:Label ID="lblColorCode" runat="server"><%# Eval("ColorCode") %></asp:Label>
                                                <asp:HiddenField ID="hdnColorCode" runat="server" Value='<%# Eval("ColorCode")%>' />
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </ItemTemplate>
                        </asp:DataList>                        
                    </ItemTemplate>
                </asp:DataList>
                </asp:Panel>
                <asp:Panel runat="server" ID="pnlSKU">
                    <table cellpadding="0" cellspacing="0" id="tblSKUHeader">
                        <tr>
                            <asp:PlaceHolder runat="server" ID="plhSKUHeader"></asp:PlaceHolder>
                        </tr>                        
                    </table>                    
                    <div>
                        <asp:PlaceHolder runat="server" ID="plhSKUGrid" Visible="true"></asp:PlaceHolder>
                    </div>
                </asp:Panel>
                </div>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        $(window).load(function () {
            var width = 0;
            var height = 0;

            var intervalHandler;

            var hasDesignBack = false;

            hasDesignBack = $("#imgDesignBack").attr("src").indexOf("00000000-0000-0000-0000-000000000000") == -1;

            if (hasDesignBack) {
                width = Math.max($("#imgDesign").width(), $("#imgDesignBack").width());
                height = Math.max($("#imgDesign").height(), $("#imgDesignBack").height());
            }
            else {
                width = $("#imgDesign").width();
                height = $("#imgDesign").height();
            }

            $("#imgContainer")
                .mouseover(function () {
                    if (hasDesignBack) {
                        $("#imgDesignContainer").fadeOut();
                        clearInterval(intervalHandler);
                        var elementToToggle = $("#imgDesignContainer");
                        intervalHandler = setInterval(function () {
                            elementToToggle.fadeToggle()
                        }, 1200);
                    }
                })
                .mouseleave(function () {
                    if (hasDesignBack) {
                        clearInterval(intervalHandler);
                        $("#imgDesignContainer").fadeIn();
                    }
                });


            $("#imgContainer").css({
                "width": width,
                "height": height
            });

            $("#imgDesignBackContainer").css({
                "width": width,
                "height": height
            });

            $("#imgDesignContainer").css({
                "width": width,
                "height": height
            });

            $("#imgDesignContainer").css("visibility", "visible");

            if ($("#imgDesignBack").attr("src").indexOf("00000000-0000-0000-0000-000000000000") == -1) {
                $("#imgDesignBackContainer").css("visibility", "visible");
            }
        });
    </script>
    <script type="text/javascript">
        if ($("#RadGridSKUItems").length > 0) {
            //Sys.Application.add_load(function () {
            $("#pnlSKU").parent().width($("body").width() - $("#RadGridSKUItems").offset().left - 2);
            $find("RadGridSKUItems").repaint();
            //});
        }
    </script>
    </form>
    <script type="text/javascript">
        var frm = document.Form1;
        function CheckAll(checkAllBox) {
            var actVar = checkAllBox.checked;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf("chkSelect") != -1)
                    e.checked = actVar;
            }
        }

        function refreshPage() {
            document.location.href = document.location.href;
        }

        if ($("#plhSKUHeader_drlStyleSKUItemID option").length > 2) {
            $("#plhSKUHeader_drlStyleSKUItemID").addClass("multi-sku");
        }

        /** Resizing SKUItems Grid to take all the free height on the screen **/
        (function resizeGrid() {
            var changeGrid = $("#RadGridSKUItems");
            var windowHeight = $(window).height();
            var formHeight = $("#Form1").height();
            var minHeight = 100;

            // Calculating, how much free space we have on the window for grid area
            var diff = windowHeight - (formHeight - changeGrid.height());

            if (diff > minHeight) {
                changeGrid.height(diff);
            } else {
                changeGrid.height(minHeight);
            }
        })();    
    </script>
</body>
</html>
