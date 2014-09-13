<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_DimensionalBOM_BOMColorway.aspx.vb" Inherits="plmOnApp.Style.DimensionalBOM.Style_DimensionalBOM_BOMColorway" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register src="../System/Control/WaitControl.ascx" TagName="Color_Wait" TagPrefix="wc1" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Colorway</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid_Y.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/BOMColorway.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/jquery-ui.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="form1" method="post" runat="server">
    <wc1:Color_Wait ID="Color_Wait" runat="server" />

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
        <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1">
            <ClientEvents OnRequestStart="onAjaxRequestStart" OnResponseEnd="onAjaxResponseEnd" />
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="drlColorSearch">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="drlColorSearch" />
                    </UpdatedControls>
                </telerik:AjaxSetting>

                <telerik:AjaxSetting AjaxControlID="rlvTempColorsList">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rlvTempColorsList" />
                    </UpdatedControls>
                </telerik:AjaxSetting>

                <telerik:AjaxSetting AjaxControlID="btnClearTempArea">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="btnClearTempArea" />
                    </UpdatedControls>
                </telerik:AjaxSetting>

            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
            <Windows>
                <telerik:RadWindow ID="MaterialColorsMenu" runat="server" Title="Colors" Height="500px"
                    Width="800px" ReloadOnShow="true" ShowContentDuringLoad="false" 
                    NavigateUrl="Style_DimensionalBOM_BOMColorway_Add.aspx"
                    Behaviors="Close"
                    IconUrl="../System/Icons/icon_table.gif"
                    KeepInScreenBounds="true" Modal="true" />

                <telerik:RadWindow ID="SelectMaterialColor" runat="server" Title="Material Colors" Height="500px"
                    Width="800px" ReloadOnShow="true" ShowContentDuringLoad="false" 
                    NavigateUrl="Style_DimensionalBOM_BOMColorway_Select.aspx"
                    Behaviors="Close"
                    IconUrl="../System/Icons/icon_table.gif"
                    KeepInScreenBounds="true" Modal="true" />

                <telerik:RadWindow ID="SortColorways" runat="server" Title="Sort Colorways" Height="600px"
                    Width="800px" ReloadOnShow="true" ShowContentDuringLoad="false" 
                    NavigateUrl="Style_DimensionalBOM_BOMColorway_Sort.aspx"
                    Behaviors="Close"
                    IconUrl="../System/Icons/icon_table.gif"
                    KeepInScreenBounds="true" Modal="true" />

                <telerik:RadWindow ID="SortMaterials" runat="server" Title="Sort Materials" Height="600px"
                    Width="800px" ReloadOnShow="true" ShowContentDuringLoad="false" 
                    NavigateUrl="Style_DimensionalBOM_BOMColorway_Material_Sort.aspx"
                    Behaviors="Close"
                    IconUrl="../System/Icons/icon_table.gif"
                    KeepInScreenBounds="true" Modal="true" />

                <telerik:RadWindow ID="RemoveColorways" runat="server" Title="Remove Colorways" Height="600px" 
                    Width="800px" ReloadOnShow="true" ShowContentDuringLoad="false" 
                    NavigateUrl="Style_DimensionalBOM_BOMColorway_Remove.aspx"
                    Behaviors="Close" 
                    IconUrl="../System/Icons/icon_table.gif" 
                    KeepInScreenBounds="true" Modal="true" />

                <telerik:RadWindow ID="SwapColorway" runat="server" Title="Swap Colorways" Height="600px" 
                    Width="800px" ReloadOnShow="true" ShowContentDuringLoad="false" 
                    NavigateUrl="Style_DimensionalBOM_BOMColorway_Swap.aspx"
                    Behaviors="Close" 
                    IconUrl="../System/Icons/icon_table.gif" 
                    KeepInScreenBounds="true" Modal="true" />

                <telerik:RadWindow ID="ConfigBOM" runat="server" Title="Configure BOM" Height="250px" 
                    Width="600px" ReloadOnShow="true" ShowContentDuringLoad="false" 
                    NavigateUrl="Style_DimensionalBOM_Configure.aspx"
                    Behaviors="Close" 
                    IconUrl="../System/Icons/icon_table.gif" 
                    KeepInScreenBounds="true" Modal="true" />
            </Windows>
        </telerik:RadWindowManager>

    <asp:Panel ID="pnlColorMgmt" runat="server">
        <table class="TableHeader" height="20" cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <td valign="middle" align="center" width="10px"><img height="15" alt="" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
                <td width="35" style="height: 24px" runat="server" id="addTD">
                    <asp:dropdownlist id="dpNewRow" runat="server" CssClass="fontHead">
						<asp:ListItem Value="1" Selected="True">1</asp:ListItem>
						<asp:ListItem Value="2">2</asp:ListItem>
						<asp:ListItem Value="3">3</asp:ListItem>
						<asp:ListItem Value="4">4</asp:ListItem>
						<asp:ListItem Value="5">5</asp:ListItem>
						<asp:ListItem Value="10">10</asp:ListItem>
						<asp:ListItem Value="15">15</asp:ListItem>
						<asp:ListItem Value="20">20</asp:ListItem>
					</asp:dropdownlist>                   
                 </td>
                 <td style="height: 24px"> 
                    <cc1:confirmedimagebutton id="btnAdd" runat="server" Message="NONE" disabled="disabled" /> 
                    <cc1:ConfirmedImageButton ID="btnColorSave" runat="server" Message="NONE" disabled="disabled" />
                    <cc1:ConfirmedImageButton ID="btnRemove" runat="server" Message="NONE" disabled="disabled" />
                    <asp:ImageButton ID="btnSeasonalColor" runat="server" disabled="disabled" />
                    <asp:ImageButton ID="btnSwapColorways" runat="server" Message="NONE" Visible="true" disabled="disabled" />
                    <asp:ImageButton ID="btnSort" runat="server" disabled="disabled" />
                    <asp:ImageButton ID="btnRemoveColorway" runat="server" disabled="disabled" />
                    <asp:ImageButton ID="btnSortMaterials" runat="server" disabled="disabled" />
                    <asp:ImageButton ID="btnConfigure" runat="server" disabled="disabled" />
                    <cc1:BWImageButton ID="btnChangeLog" runat="server" CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:BWImageButton>
                    <cc1:ConfirmedImageButton ID="btnClose" Message="NONE" runat="server" disabled="disabled" />
                </td>
            </tr>
        </table>
    </asp:Panel>
        
    <!-- Material Menu. Shown only by Javascript OnClick demand, from RadGrid below -->
     <div id="divMaterialMenu" class="MaterialMenu">
        <asp:Button ID="btnDuplicateMaterial" runat="server" Width="140" CssClass="MaterialMenu"/> <br />
        <asp:Button ID="btnReplaceMaterial" runat="server" Width="140" CssClass="MaterialMenu" OnClientClick="showMaterialReplacePopup(); return false;"/> <br />
        <asp:Button ID="btnDeleteMaterial" runat="server" Width="140" CssClass="MaterialMenu" OnClientClick="confirmMaterialDelete(); return false;"/>
        <asp:Button ID="btnDeleteAllMaterials" runat="server" Visible="false" OnClientClick="return false;" /> <!-- Invisible button for 'Remove All' option in material delete dialog. Is processed on server. -->
        <input type="hidden" id="hdnCurrentMaterialMenu" name="hdnCurrentMaterialMenu" /> <!-- ID of current material -->
        <input type="hidden" id="hdnCurrentMaterialNo" name="hdnCurrentMaterialNo" />
        <input type="hidden" id="hdnCurrentMaterialName" name="hdnCurrentMaterialName" />
        <input type="hidden" id="hdnCurrentMaterialImageSrc" name="hdnCurrentMaterialImageSrc" />
     </div>
    <!-- End of Material Menu -->

    <!-- Material Quick Search panel -->
    <asp:Panel ID="pnlMaterialQuickSearch" runat="server">
        <table id="tblMaterialQuickSearchHeader" cellspacing="0" cellpadding="0" border="0" width="100%">
            <tr class="TableHeader" height="25">
                <td valign="middle" align="center" width="10px">
                    <img height="15" alt="" src="../System/Images/bbTbSCnr.gif" width="3" />
                </td>
                <td width="15">
                    <img id="imgCollapseQuickSearch" alt="Collapse" src="../System/Icons/icon_Down.gif" onclick="collapseArea(this, 'divMaterialQuickSearchData');" style="cursor:pointer;"/>
                    <img id="imgExpandQuickSearch" alt="Expand" src="../System/Icons/icon_Next.gif" onclick="expandArea(this, 'divMaterialQuickSearchData'); " style="cursor:pointer;"/>
                </td>
                <td>
                    <asp:Label ID="lblMaterialQuickSearch" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
        <div id="divMaterialQuickSearchData">
            <cc2:YSTabView ID="YSTabView2" runat="server"></cc2:YSTabView>
            <telerik:RadAjaxPanel runat="server" ID="RadAjaxPanelStyleMQE" ClientEvents-OnRequestStart="processQuickSearchAjaxRequest" 
                ClientEvents-OnResponseEnd="processQuickSearchAjaxResponse">
                <asp:Panel ID="pnlQuickSearch" visible="true" runat="server">
                    <table cellspacing="0" cellpadding="1" rules="all" border="0" id="dgMaterialtbl"
                        style="background-color: White; border-color: Gainsboro;
                        border-collapse: collapse;">
                        <tr class="font" valign="bottom">
                            <td valign="bottom" style="border-color: Gainsboro;">
                                <asp:label ID="lblMQECode" Text="Material Code" class="fontHead" runat="server" ></asp:label>
                                <telerik:RadComboBox ID="cboMQECode" runat="server" Width="200px" Height="150px"
                                    EmptyMessage="" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                    EnableVirtualScrolling="true" AllowCustomText="true" MarkFirstMatch="true" 
                                    OnClientKeyPressing="cboMQECode_HandleKeyPress"
                                    EnableEmbeddedSkins="false" Skin="YPLM"
                                    AutoPostBack="true">
                                </telerik:RadComboBox>                            
                            </td>
                            <td width="5"></td>                                              
                            <td><cc1:ConfirmedImageButton ID="btnMaterialQuickSearchAddSave" runat="server" Message="NONE" OnClientClick="SaveMQE();return false;" /></td>
                        </tr>
                    </table>
                    <asp:DataGrid ID="dgMaterialQuickSearchAdd" runat="server" AutoGenerateColumns="false" DataKeyField="StyleMaterialID">
                        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                        <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
                        <headerStyle Height="25px" CssClass="TableHeader"></headerStyle>
                        <Columns>
                            <asp:TemplateColumn>
                                <HeaderStyle CssClass="TableHeaderRed" />
                                <ItemStyle CssClass="TableHeaderRed" />
                                <HeaderTemplate>
                                    <asp:ImageButton ID="btnClearQuickSearchMaterials" runat="server" ImageUrl='../System/Icons/icon_delete.gif' CommandName="clear"/>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:ImageButton ID="btnDeleteQuickSearchMaterial" runat="server" ImageUrl='../System/Icons/icon_delete.gif' CommandName="remove" />
                                </ItemTemplate>
                            </asp:TemplateColumn>
                        </Columns>
                    </asp:DataGrid>
                </asp:Panel>

                <asp:Panel ID="pnlquickadd" runat="server">
                    <cc1:ConfirmedImageButton ID="btnQuickAdd" runat="server" Message="NONE" OnClientClick="SaveQuickAdd();return false;" /> 
                    <asp:DataGrid ID="dgQuickAdd" runat="server" AutoGenerateColumns="false" DataKeyField="StyleMaterialID">
                            <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                            <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
                            <headerStyle Height="25px" CssClass="TableHeader"></headerStyle>
                    </asp:DataGrid>           
                </asp:Panel>

            </telerik:RadAjaxPanel>
            <cc1:ConfirmedImageButton ID="btnMaterialQuickSearchAddSaveHidden" runat="server" Message="NONE" Width="0" Height="0" style="display: none;" />
            <cc1:ConfirmedImageButton ID="btnMaterialQuickAddHidden" runat="server" Message="NONE" Width="0" Height="0" style="display: none;" />
        </div>
    </asp:Panel>
    <!-- End of Material Quick Search panel -->

    <!-- Temporary Color Area -->
    <asp:Panel ID="pnlTemporaryColor" runat="server">
        <table id="tblColorwayTempAreaHeader" cellspacing="0" cellpadding="0" border="0" width="100%">
            <tr class="TableHeader" height="25">
                <td valign="middle" align="center" width="10px">
                    <img height="15" alt="" src="../System/Images/bbTbSCnr.gif" width="3">
                </td>
                <td width="15">
                    <img id="imgCollapseTempArea" alt="Collapse" src="../System/Icons/icon_Down.gif" onclick="collapseArea(this, 'tblColorwayTempArea');" style="cursor:pointer;"/>
                    <img id="imgExpandTempArea" alt="Expand" src="../System/Icons/icon_Next.gif" onclick="expandArea(this, 'tblColorwayTempArea');" style="display: none;cursor:pointer;"/>
                </td>
                <td>
                    <asp:Label ID="lblColorwayTempArea" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
        <table id="tblColorwayTempArea" width="100%" style="border-bottom: 3px solid gainsboro; background-color:#ffffff;" cellpadding="0" cellspacing="0">
            <tr>
                <td width="200px" id="tbcActiveColor" align="center" style="border-right: 1px solid gainsboro;">
                    <asp:CheckBox id="chbUseActive" runat="server" CssClass="fontHead" /> 
                    <div id="divActiveColorInfo" align="center" class="ColorInfo">
                        <asp:Image ID="imgActiveColor" runat="server" Width="100" BorderColor="Gainsboro" BorderWidth="1" BorderStyle="Solid" style="cursor:pointer;" /> <br />
                        <asp:Label ID="lblActiveColorCode" runat="server" Width="100" CssClass="font" /> <br />
                        <asp:Label ID="lblActiveColorName" runat="server" Width="100" CssClass="font" /> <br />
                        <asp:HiddenField id="hdnActiveColorPaletteID" runat="server" EnableViewState="false"/>
                    </div>
                    <asp:ImageButton ID="btnMakeColorway" runat="server" OnClientClick="return confirmMakeColorway();"/>
                    <asp:ImageButton ID="btnClearActive" runat="server" OnClientClick="return clearActiveColor();" />
                </td>
                <td id="tbcTempColor" valign="top">
                    <table id="tblTempColorSearch" style="border-bottom: 1px solid gainsboro; height: 45px;">
                        <tr valign="middle">
                            <td width="100px" style="padding-left: 10px;">
                                <asp:Label ID="lblColorSearch" runat="server" Width="100" CssClass="fontHead"></asp:Label>
                            </td>
                            <td width="200px">
                                <telerik:RadComboBox ID="drlColorSearch" runat="server" Width="200" EnableLoadOnDemand="true" EnableEmbeddedSkins="false" Skin="YPLM" 
                                        ShowMoreResultsBox="true" EnableVirtualScrolling="true" AutoPostBack="true"></telerik:RadComboBox>
                            </td>
                            <td align="left">
                                <cc1:BWImageButton ID="btnAddPalette" runat="server" />
                            </td>
                            <td width="100%" align="left">
                                <asp:ImageButton ID="btnClearTempArea" runat="server" OnClientClick="return confirmClearTempColors();" />
                            </td>
                        </tr>
                    </table>
                    <div id="divTempColors" style="overflow: auto; height: 200px; width: 95%; padding-left: 10px;">
                        <telerik:RadListView ID="rlvTempColorsList" runat="server" DataKeyNames="ColorPaletteID,ColorFolderID" AllowPaging="false">
                            <ItemTemplate>
                                <table class="ColorInfo">
                                    <tr>
                                        <td>
                                            <asp:Image ID="imgColor" runat="server" Width="50" style="cursor:pointer;" onclick="makeActive(this);"/>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblColorCode" runat="server" Width="100" CssClass="font" /><br />
                                            <asp:Label ID="lblColorName" runat="server" Width="100" CssClass="font" />
                                            <asp:HiddenField ID="hdnColorPaletteID" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </telerik:RadListView>
                    </div>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <!-- End of Temporary Color Area -->

    <!-- Placeholder for RAD Grid. Filled from server-side -->

    <asp:PlaceHolder ID="PlaceHolderColorMgmt" runat="server"></asp:PlaceHolder>

    <!-- End of RAD Grid area -->

    <asp:Panel runat="server" ID="pnlPerm" Visible="false">
        <table style="height:50;" cellspacing="0" cellpadding="0" width="100%"  bgColor="#990000" border="1" borderColor="red">
            <tr>
                <td>
                    <table style="height:25;" cellspacing="0" cellpadding="0" width="100%" border="0">
                        <tr>
                            <td width="25"><div align="center"><asp:image id="imgWorkStatus" ImageUrl="../System/Icons/icon_lock.gif" runat="server"></asp:image></div></td>
                            <td>
                                  <asp:Label ID="lblPerm" runat="server" 
                                Text="You might not have permission to access this tab using your credentials." 
                                CssClass="fontHead" ForeColor="White"></asp:Label>                         
                        
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </asp:Panel>

    <telerik:RadScriptBlock runat="server">
        <script type="text/javascript">

            // If all the 'Select Auto Color' checkboxes are disabled, 'Select All Auto Color' should be disabled too
            var frm = document.form1;
            var chbSelectAll = document.getElementById("cbSelectAll")
            var disableSelectAll = true;

            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf("chbAutoColor") != -1 && !e.disabled) {
                    disableSelectAll = false;
                    break;
                }
            }
            if (chbSelectAll != undefined) {
                chbSelectAll.disabled = disableSelectAll;
            }

            // fix width for non ie browsers
            Sys.Application.add_load(function () {
                if ($.support.cssFloat) { $("#RadGridColorMgmt col").each(function () { $(this).width($(this).width() + 10) }) }
            });
        </script>
    </telerik:RadScriptBlock>
    </form>

    <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-1.6.2.min.js"></script>
    <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-ui-1.8.21.custom.min.js"></script>
    <script type="text/javascript">

        var strEmptyGuid = '<%= Guid.Empty.ToString() %>'
        var strEmptyColor = '<%= GetSystemText("No color").Replace("\'", "\\\'") %>'
        var strEmptyImageLink = '<%= GetColorStreamPath("20", Guid.Empty.ToString(), Guid.Empty.ToString()) %>'
        var strEmptyActiveImageLink = '<%= GetColorStreamPath(imgActiveColor.Width.Value.ToString(), Guid.Empty.ToString(), Guid.Empty.ToString()) %>'

        /****
        **** MATERIAL QUICK SEARCH
        ***/

        /* Sending non-AJAX postback to rebind non-AJAX controls */
        function SaveMQE() {
            document.getElementById('btnMaterialQuickSearchAddSaveHidden').click();
        }
        function SaveQuickAdd() {
            document.getElementById('btnMaterialQuickAddHidden').click();
        }

        function cboMQECode_HandleKeyPress(sender, eventArgs) {
            var keyCode = eventArgs.get_domEvent().keyCode;
            if (keyCode == 13) {
                var item = sender.findItemByText(sender.get_text());
                if (item) item.select();
            }
            if (keyCode == 27) {
                sender.clearSelection();
            }
        }

        function processQuickSearchAjaxRequest(sender, eventArgs) {
            show_wait_text();
            busyBox.Show();
        }

        function processQuickSearchAjaxResponse(sender, eventArgs) {
            busyBox.Hide();
            hide_wait_text();
        }

        /****
        **** COLLAPSIBLE HEADERS AND CHECKBOXES
        ***/

        function CheckAllAutoColor(checkAllBox) {
            var frm = document.form1;
            var actVar = checkAllBox.checked;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];

                if (e.type == 'checkbox' && e.name.indexOf("chbAutoColor") != -1 && !e.disabled) {
                    e.checked = actVar;
                }
            }
        }

        function checkAllColorways(sender) {
            $(sender).closest("table").find("input[id*='chbColorway']").each(function() {$(this)[0].checked = sender.checked;});
        }

        function collapseArea(sender, areaID) {
            var area = $("#" + areaID);
            $(area).hide();
            $(sender).closest("td").find("img[id*='imgExpand']").show();
            $(sender).hide();
        }

        function expandArea(sender, areaID) {
            var area = $("#" + areaID);
            $(area).show();
            $(sender).closest("td").find("img[id*='imgCollapse']").show();
            $(sender).hide();
        }

        /****
        **** TEMPORARY COLOR AREA
        ***/

        /** Rebinding Colors data list from client-side with AJAX **/
        function refreshTempColorsList() {
            var tempList = $find("<%=rlvTempColorsList.ClientId%>");
            tempList.rebind();
        }

        /** Fills the active color info with blank spaces and empty guids **/
        function clearActiveColor() {
            setActiveColor(strEmptyActiveImageLink, "","", strEmptyGuid);
            return false;
        }

        /** Gets the Active Color info. Returns object with useActive, imageSrc, colorCode, colorName and colorPaletteID fields. **/
        function getActiveColor() {
            
            var strCurrentImageLink = $("#imgActiveColor").attr('src');
            var strCurrentColorCode = $("#lblActiveColorCode").text();
            var strCurrentColorName = $("#lblActiveColorName").text();
            var strCurrentColorPaletteID = $("#hdnActiveColorPaletteID").val();
            var bUseActive;
            if ($("#chbUseActive").length > 0){
                bUseActive = $("#chbUseActive")[0].checked;
            }
            else{
                bUseActive = false;
            }

            var activeColorInfo = {
                useActive: bUseActive,
                imageSrc: strCurrentImageLink,
                colorCode: strCurrentColorCode,
                colorName: strCurrentColorName,
                colorPaletteID: strCurrentColorPaletteID
            };

            return activeColorInfo;

        }

        /** Fills Active Color with given info **/
        function setActiveColor(strImageLink, strColorCode, strColorName, strColorPaletteID) {
            $("#imgActiveColor").attr('src', strImageLink);
            $("#lblActiveColorCode").text(strColorCode);
            $("#lblActiveColorName").text(strColorName);
            $("#hdnActiveColorPaletteID").val(strColorPaletteID);
        }

        
        /** Makes the clicked color active **/
        function makeActive(sender) {
            var $currentColor = $(sender).closest(".ColorInfo");
            // Getting the selected color values
            var strImageLink = sender.src;
            var strColorName = $currentColor.find("span[id*='lblColorName']").text();
            var strColorCode = $currentColor.find("span[id*='lblColorCode']").text();
            var strColorPaletteID = $currentColor.find("input[id*='hdnColorPaletteID']").val();
            // Setting the selected color as active
            setActiveColor(strImageLink, strColorCode, strColorName, strColorPaletteID);
        }

        /** Confirmation windows **/
        function confirmClearTempColors() {
            var $confirmDialog = $("<div></div>");
            $confirmDialog.html(' <p> <%= GetSystemText("You are about to clear all the selected colors to be used with Active Color mode.") %> </p>' +
                                ' <p> <%= GetSystemText("Are you sure you want to continue?") %> </p>');
            $confirmDialog.dialog({
                autoOpen: false,
                modal: true,
                resizable: false,
                title: '<%= GetSystemText("Clear Selected Colors") %>',
                buttons: {
                    '<%= GetSystemText("Yes") %>': function () {
                        $(this).dialog("close");
                        <%= ClientScript.GetPostBackEventReference(New PostBackOptions(btnClearTempArea) With {.PerformValidation = False}) %>;       
                        return true;
                    },
                    '<%= GetSystemText("No") %>': function () {
                        $(this).dialog("close");
                        return false;
                    }
                }
            });

            $confirmDialog.dialog('open');
            return false;
        }

        function confirmMakeColorway() {
            
            var activeColorInfo = getActiveColor();

            var strCurrentColorPaletteID = activeColorInfo.colorPaletteID;
            var strImgLink = activeColorInfo.imageSrc;
            var strColorCode = activeColorInfo.colorCode;
            var strColorName = activeColorInfo.colorName;

            if (strCurrentColorPaletteID == "" || strCurrentColorPaletteID == null || strCurrentColorPaletteID == strEmptyGuid) {
                return false;
            }

            var $confirmDialog = $("<div></div>");
            $confirmDialog.html('<p> <%= GetSystemText("You are about to create the following colorway for this BOM:") %> </p>' +
                                '<table> ' +
                                '   <tr> ' +
                                '       <td> ' +
                                '           <img src="' + strImgLink + '" width="50px"> ' +
                                '       </td> ' +
                                '       <td> ' +
                                '           <span>' + strColorCode + '</span> <br /> ' +
                                '           <span>' + strColorName + '</span>  ' +
                                '       </td>  ' +
                                '   </tr>  ' +
                                '</table> ' +
                                '<p> <%= GetSystemText("Any changes made will be saved before proceeding.") %> </p> ' +
                                '<p> <%= GetSystemText("Are you sure you want to continue?") %> </p>');
            $confirmDialog.dialog({
                autoOpen: false,
                modal: true,
                resizable: false,
                title: '<%= GetSystemText("Create New Colorway") %>',
                buttons: {
                    '<%= GetSystemText("Yes") %>': function () {
                        $(this).dialog("close");
                        <%= ClientScript.GetPostBackEventReference(New PostBackOptions(btnMakeColorway) With {.PerformValidation = False}) %>;       
                        return true;
                    },
                    '<%= GetSystemText("No") %>': function () {
                        $(this).dialog("close");
                        return false;
                    }
                }
            });

            $confirmDialog.dialog('open');
            return false;
        }

        /****
        **** COLORWAY GRID COLOR PITCHING
        ***/

        /** 
         ** Gets the active color info and pitches it horizontally across all colorways of the material.
         ** WARNING! We can put either ColorPaletteID or MaterialColorID in the hidden field to be saved. But if we're putting ColorPaletteID into hidden field, we HAVE TO add "!" 
         ** at the beginning of the ID. 
         */
        function pitchActiveHorizontally(sender) {
            
            var activeColorInfo = getActiveColor();
            var strCurrentImageLink = activeColorInfo.imageSrc;
            var strCurrentColorCode = activeColorInfo.colorCode;
            var strCurrentColorName = activeColorInfo.colorName;
            var strCurrentColorPaletteID = activeColorInfo.colorPaletteID;

            if (strCurrentColorPaletteID == "" || strCurrentColorPaletteID == null || strCurrentColorPaletteID == strEmptyGuid) { // Clearing the colorways, if current color is blank
                pitchColorHorizontally(sender.id, strEmptyImageLink, strEmptyColor, strEmptyGuid);
            } else {
                pitchColorHorizontally(sender.id, strCurrentImageLink, strCurrentColorName + " - " + strCurrentColorCode, "!" + strCurrentColorPaletteID);
            }

            return false;
        }

        /** Gets the active color info and pitches it vertically across all materials of the colorway.
         ** WARNING! We can put either ColorPaletteID or MaterialColorID in the hidden field to be saved. But if we're putting ColorPaletteID into hidden field, we HAVE TO add "!" 
         ** at the beginning of the ID. 
         */
        function pitchActiveVertically(sender) {

            var activeColorInfo = getActiveColor();
            var strCurrentImageLink = activeColorInfo.imageSrc;
            var strCurrentColorCode = activeColorInfo.colorCode;
            var strCurrentColorName = activeColorInfo.colorName;
            var strCurrentColorPaletteID = activeColorInfo.colorPaletteID;

            if (strCurrentColorPaletteID == "" || strCurrentColorPaletteID == null || strCurrentColorPaletteID == strEmptyGuid) {  // Clearing the colorways, if current color is blank
                pitchColorVertically(sender.id, strEmptyImageLink, strEmptyColor, strEmptyGuid);
            } else {
                pitchColorVertically(sender.id, strCurrentImageLink, strCurrentColorName + " - " + strCurrentColorCode, "!" + strCurrentColorPaletteID);
            }

            
            return false;
        }

        /** 
         * Pitches given color horizontally across all materials of the colorway.
         */
        function pitchColorVertically(senderId, strImageLink, strColorLabel, strValueId) {
            
            var columnNumber = senderId.match(/(\d+)$/)[0]; // Finding the number of the column in the ID -- it's just after the name of button, at the end of ID
            
            // Finding all the textboxes with color names, hidden fields with color IDs and buttons with color image in current column.
            // Populating all the rows, except for silver colored, 'cause it's the Misc Material, not the color info.
            var radGrid = $("#RadGridColorMgmt");
            radGrid.find("tr:not(.rgRowYPLMSilver) input[id$='txtColor" + columnNumber + "']").val(strColorLabel).css("color","red");
            radGrid.find("tr:not(.rgRowYPLMSilver) input[id$='hdnColor" + columnNumber + "']").val(strValueId);
            radGrid.find("tr:not(.rgRowYPLMSilver) input[id$='imbColorChip" + columnNumber + "']").attr('src', strImageLink);
        }

        
        /** 
         * Pitches given color horizontally across all colorways of the material.
         */
        function pitchColorHorizontally(senderId, strImageLink, strColorLabel, strValueID) {
            var parentRow = $("#" + senderId).closest("tr.rgAltRowYPLME, tr.rgRowYPLME");
            parentRow.find("input[id*='txtColor']").val(strColorLabel).css("color","red");
            parentRow.find("input[id*='hdnColor']").val(strValueID);
            parentRow.find("input[id*='imbColorChip']").attr('src', strImageLink);
        }

        /** Processing the click on Material Color image button. If the Active Color is checked, we're just setting selected color as current Material Color. Other way,
         ** we're showing old pop-up with available material colors list.
         ** WARNING! We can put either ColorPaletteID or MaterialColorID in the hidden field to be saved. But if we're putting ColorPaletteID into hidden field, we HAVE TO add "!" 
         ** at the beginning of the ID.
         **/
         function setMaterialColor(sender, strMaterialID, strColorID) {

            var activeColorInfo = getActiveColor();

            if (activeColorInfo.useActive) {

                var strCurrentImageLink = activeColorInfo.imageSrc;
                var strCurrentColorCode = activeColorInfo.colorCode;
                var strCurrentColorName = activeColorInfo.colorName;
                var strCurrentColorPaletteID = activeColorInfo.colorPaletteID;

                if (strCurrentColorPaletteID == "" || strCurrentColorPaletteID == null || strCurrentColorPaletteID == strEmptyGuid) {  // Clearing the colorway, if current color is blank
                    sender.src = strEmptyImageLink;
                    document.getElementById(sender.id.replace("imbColorChip", "txtColor")).value = strEmptyColor;
                    document.getElementById(sender.id.replace("imbColorChip", "txtColor")).style.color = "red";
                    document.getElementById(sender.id.replace("imbColorChip", "hdnColor")).value = strEmptyGuid;
                } else {
                    sender.src = strCurrentImageLink;
                    document.getElementById(sender.id.replace("imbColorChip", "txtColor")).value = strCurrentColorName + " - " + strCurrentColorCode;
                    document.getElementById(sender.id.replace("imbColorChip", "txtColor")).style.color = "red";
                    document.getElementById(sender.id.replace("imbColorChip", "hdnColor")).value = "!" + strCurrentColorPaletteID;
                }

            } else {
                window.radopen("Style_DimensionalBOM_BOMColorway_Select.aspx?BTNID=" + sender.id + "&MTID=" + strMaterialID + "&CPID=" + strColorID, "SelectMaterialColor");
            }

            return false;
         }

        /****
        **** GRID MATERIAL MENU HANDLING
        ***/

        /**
         * Showing Material Menu for given material, and positioning it near the sender button
        **/
        function showMaterialMenu(sender, strStyleMaterialID) {
            var divMenu = $("#divMaterialMenu");
            var currentGridRow = $(sender).closest("span").closest("tr");

            var hdnCurrentMaterial = $("#hdnCurrentMaterialMenu");
            var hdnCurrentMaterialNo = $("#hdnCurrentMaterialNo");
            var hdnCurrentMaterialName = $("#hdnCurrentMaterialName");
            var hdnCurrentMaterialImageSrc = $("#hdnCurrentMaterialImageSrc");

            var btnSenderButton = $(sender);
            // If it's the same button, that menu already was opened, we're just toggling menu visibility
            if (hdnCurrentMaterial.val() == strStyleMaterialID) {
                divMenu.toggle();
                return;
            }
            // Else we're saving selected material data
            var strCurrentMaterialNo = currentGridRow.find("span[id$='lblMaterialNo']").text();
            var strCurrentMaterialName = currentGridRow.find("span[id$='lblMaterialName']").text();
            var strCurrentMaterialImageLink = currentGridRow.find("input[id$='hdnMaterialImageLink']").val();
            hdnCurrentMaterial.val(strStyleMaterialID);
            hdnCurrentMaterialNo.val(strCurrentMaterialNo);
            hdnCurrentMaterialName.val(strCurrentMaterialName)
            hdnCurrentMaterialImageSrc.val(strCurrentMaterialImageLink);
            
            // And showing menu in the new place
            var posX = btnSenderButton.offset().left + 25;
            var posY = btnSenderButton.offset().top;
            divMenu.css("left", posX);
            divMenu.css("top", posY);
            divMenu.show();
        }

        function hideMaterialMenu() {
            $("#divMaterialMenu").hide();
        }

        function showMaterialReplacePopup() {
            var hdnCurrentMaterial = $("#hdnCurrentMaterialMenu");

            var strStyleMaterialID = hdnCurrentMaterial.val();
            var strStyleBOMDimensionID = '<%= _StyleBOMDimensionId %>';
            
            var strLink = 'Style_DimensionalBOM_BOMColorway_ReplaceMaterial_List.aspx?SBDID=' + strStyleBOMDimensionID + '&SMID=' + strStyleMaterialID;
            var wnd = window.open(strLink, 'ReplaceMaterial', 'height=800,width=1100,left=10,top=10,resizable=yes,scrollbars=yes,status=yes,titlebar=yes,location=yes,menubar=yes');
            wnd.focus();
        }

        
        function confirmMaterialDelete() {

            var strImgLink = $("#hdnCurrentMaterialImageSrc").val();
            var strMaterialNo = $("#hdnCurrentMaterialNo").val();
            var strMaterialName = $("#hdnCurrentMaterialName").val();

            var $confirmDialog = $("<div></div>");
            $confirmDialog.html('<p> <%= GetSystemText("You are about to remove the following material for this BOM:") %> </p>' +
                                '<table> ' +
                                '   <tr> ' +
                                '       <td> ' +
                                '           <img src="' + strImgLink + '" width="50px"> ' +
                                '       </td> ' +
                                '       <td> ' +
                                '           <span>' + strMaterialNo + '</span> <br /> ' +
                                '           <span>' + strMaterialName + '</span>  ' +
                                '       </td>  ' +
                                '   </tr>  ' +
                                '</table> ' +
                                '<p> <%= GetSystemText("Any changes made will be saved before proceeding.") %> </p> ' +
                                '<p> <%= GetSystemText("Are you sure you want to continue?") %> </p>');
            $confirmDialog.dialog({
                autoOpen: false,
                modal: true,
                resizable: false,
                width: 400,
                title: '<%= GetSystemText("Remove Material") %>',
                buttons: {
                    '<%= GetSystemText("Remove") %>': function () {
                        $(this).dialog("close");
                        <%= ClientScript.GetPostBackEventReference(New PostBackOptions(btnDeleteMaterial) With {.PerformValidation = False}) %>;       
                        return true;
                    },
                    '<%= GetSystemText("Remove all") %>': function () {
                        $(this).dialog("close");
                        <%= ClientScript.GetPostBackEventReference(New PostBackOptions(btnDeleteAllMaterials) With {.PerformValidation = False}) %>;       
                        return true;
                    },
                    '<%= GetSystemText("No") %>': function () {
                        $(this).dialog("close");
                        return false;
                    }
                }
            });

            $confirmDialog.dialog('open');
            return false;
        }
        
        /**
        ** Hiding Material Menu when the RadGrid is scrolled
        **/
        function onRadGridScroll(sender, eventArgs) {
            hideMaterialMenu();
        }

        /** Opening popup with Material Color list for current material. Processing the click on MaterialColor button. **/
        function showMaterialColors(strMaterialID, strStyleBOMDimensionID) {
            window.radopen("Style_DimensionalBOM_BOMColorway_Add.aspx?SBDID=" + strStyleBOMDimensionID + "&MTID=" + strMaterialID, "MaterialColorsMenu");
        }

        function showColorwaySort(strStyleBOMDimensionID, strDimLevel) {
            window.radopen("Style_DimensionalBOM_BOMColorway_Sort.aspx?SBDID=" + strStyleBOMDimensionID + "&SDL=" + strDimLevel, "SortColorways");
        }

        function showColorwaySwap(strStyleBOMDimensionID, strDimLevel) {
            window.radopen('Style_DimensionalBOM_BOMColorway_Swap.aspx?SID=<%= Request("SID") %>&SN=<%= Request("SN") %>&WFIID=<%= Request("WFIID") %>&SBDID=' + strStyleBOMDimensionID + "&SDL=" + strDimLevel, "SwapColorway");
        }

        function showColorwayRemove(strStyleBOMDimensionID, strDimLevel) {
            window.radopen('Style_DimensionalBOM_BOMColorway_Remove.aspx?SID=<%= Request("SID") %>&SN=<%= Request("SN") %>&WFIID=<%= Request("WFIID") %>&SBDID=' + strStyleBOMDimensionID + '&SDL=' + strDimLevel, 'RemoveColorways');
        }

        function showMaterialSort(strStyleBOMDimensionID) {
            window.radopen("Style_DimensionalBOM_BOMColorway_Material_Sort.aspx?SBDID=" + strStyleBOMDimensionID, "SortMaterials");
        }

        function showConfigureBOM(strStyleBOMDimensionID) {
            window.radopen("Style_DimensionalBOM_Configure.aspx?SBDID=" + strStyleBOMDimensionID, "ConfigBOM");
        }

         /** Resizing Colorway Grid to take all the free height on the screen **/
        function resizeGrid() {

            var colorwayGrid = $("#RadGridColorMgmt");
            var windowHeight = $(window).height();
            var formHeight = $("#form1").height();
            var minHeight = 100;

            // Calculating, how much free space we have on the window for grid area
            var diff = windowHeight - (formHeight - colorwayGrid.height());

            if (diff > minHeight) {
                colorwayGrid.height(diff);
            } else {
                colorwayGrid.height(minHeight);
            }
        }

        /** Handling AJAX Postbacks. Showing and hiding busy box. **/
        function onAjaxRequestStart(sender, eventArgs) {
            var eventControlID = eventArgs.get_eventTarget();
            if (eventControlID == '<%= drlColorSearch.UniqueID %>' || eventControlID == '<%= rlvTempColorsList.UniqueID %>' || eventControlID == '<%= btnClearTempArea.UniqueID %>') {
                hideMaterialMenu();
                show_wait_text();
                busyBox.Show();
            }
        }

        function onAjaxResponseEnd(sender, eventArgs) {
            var eventControlID = eventArgs.get_eventTarget();
            if (eventControlID == '<%= rlvTempColorsList.UniqueID %>') {
                busyBox.Hide();
                hide_wait_text();
            }
            // Clearing the EVENTTARGET and EVENTARGUMENT from ajax postback, so we can verify if the next postback was caused by button or by the same control
            form1.__EVENTTARGET.value = ''
            form1.__EVENTARGUMENT.value = ''
            
        }

        /* Initialize loaded page */
        resizeGrid();

        
        // Enable controls buttons after the page has been loaded completely
        $(document).ready( function () {
            jQuery.fn.extend({
                disable: function(state) {
                    return this.each(function() {
                        if (this) {
                            this.disabled = state;
                        }
                    });
                }
            });
            $("#pnlColorMgmt input").disable(false);
        });

    </script>
</body>
</html>
