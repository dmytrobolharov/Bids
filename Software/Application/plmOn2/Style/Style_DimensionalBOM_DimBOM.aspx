<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_DimensionalBOM_DimBOM.aspx.vb" Inherits="plmOnApp.Style.DimensionalBOM.Style_DimensionalBOM_DimBOM" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid_Y.css" type="text/css" rel="stylesheet" />
     <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="form1" runat="server">
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
    <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1"></telerik:RadAjaxManager>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
        <Windows>            
            <telerik:RadWindow ID="SortColorways" runat="server" Title="Sort Colorways" Height="600px" Width="800px"
                ReloadOnShow="true" ShowContentDuringLoad="false" NavigateUrl="Style_DimensionalBOM_BOMColorway_Sort.aspx"
                Behaviors="Close" IconUrl="../System/Icons/icon_table.gif" KeepInScreenBounds="true" Modal="true" />
            <telerik:RadWindow ID="RemoveColorways" runat="server" Title="Remove Colorways" Height="600px" Width="800px"
                ReloadOnShow="true" ShowContentDuringLoad="false" NavigateUrl="Style_DimensionalBOM_BOMColorway_Remove.aspx"
                Behaviors="Close" IconUrl="../System/Icons/icon_table.gif" KeepInScreenBounds="true" Modal="true" />
            <telerik:RadWindow ID="ConfigBOM" runat="server" Title="Configure BOM" Height="250px" Width="600px"
                ReloadOnShow="true" ShowContentDuringLoad="false" NavigateUrl="Style_DimensionalBOM_Configure.aspx"
                Behaviors="Close" IconUrl="../System/Icons/icon_table.gif" KeepInScreenBounds="true" Modal="true" />
        </Windows>
    </telerik:RadWindowManager>

    <input id="hidBOMDimensionId" type="hidden" name="hidBOMDimensionId" width="20" runat="server" />
    <asp:Panel ID="pnlDimType" runat="server">
        <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <td valign="middle" align="center" width="10px"><img height="15" alt="" src="../System/Images/bbTbSCnr.gif" width="3"></td>
                <td>                    
                    <cc1:ConfirmedImageButton ID="btnSave" Message="NONE" runat="server"></cc1:ConfirmedImageButton>&nbsp;       
                    <asp:ImageButton ID="btnConfigure" runat="server" />
                    <cc1:BWImageButton ID="btnChangeLog" runat="server" CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:BWImageButton>&nbsp;
                    <cc1:ConfirmedImageButton ID="btnClose" Message="NONE" runat="server"></cc1:ConfirmedImageButton>&nbsp;&nbsp;                    
                </td>
            </tr>
        </table>
        <table cellspacing="1" width="50%">            
            <tr>
                <td nowrap="nowrap">
                    <asp:Label runat="server" ID="lblDim1" class="fontHead">Dimension1:</asp:Label>&nbsp;
                    <asp:DropDownList ID="ddlDim1" runat="server">
                    </asp:DropDownList>
                    &nbsp;&nbsp;
                    <asp:ImageButton ID="imgBtnDim1" Visible="false" runat="server"></asp:ImageButton>
                </td>
                <td>&nbsp;&nbsp;</td>
                <td nowrap="nowrap">
                    <asp:Label runat="server" ID="lblDim2" class="fontHead">Dimension2:</asp:Label>&nbsp;
                    <asp:DropDownList ID="ddlDim2" runat="server">
                    </asp:DropDownList>
                    &nbsp;&nbsp;
                    <asp:ImageButton ID="imgBtnDim2" Visible="false" runat="server"></asp:ImageButton>
                </td>
                <td>&nbsp;&nbsp;</td>
                <td nowrap="nowrap">
                    <asp:Label runat="server" ID="lblDim3" class="fontHead">Dimension3:</asp:Label>&nbsp;
                    <asp:DropDownList ID="ddlDim3" runat="server">
                    </asp:DropDownList>
                    &nbsp;&nbsp;
                    <asp:ImageButton ID="imgBtnDim3" Visible="false" runat="server"></asp:ImageButton>
                </td>
            </tr>
        </table>
        <br />      
        <table cellspacing="1" cellpadding="1" width="100%">
            <tr class="TableHeader">
                <td>
                    <asp:Label runat="server" ID="lblDim1Name" class="fontHead"></asp:Label>&nbsp;
                    <asp:ImageButton ID="btnImageDim1" Visible="false" runat="server"></asp:ImageButton>
                    <asp:ImageButton ID="btnDim1Sort" Visible="false" runat="server"></asp:ImageButton>
                    <asp:ImageButton ID="btnDim1Remove" Visible="false" runat="server"></asp:ImageButton>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:DataGrid ID="DataGridDim1" runat="server" Datakeys="DimID" BorderColor="Silver"
                        BorderStyle="Solid" BorderWidth="1px" PageSize="100" AutoGenerateColumns="false"
                        AllowPaging="true" PagerStyle-Visible="false">
                        <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
                        <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
                        <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                    </asp:DataGrid>
                </td>
            </tr>
        </table>
        <br />
        <table cellspacing="1" cellpadding="1" width="100%">
            <tr class="TableHeader">
                <td>
                    <asp:Label runat="server" ID="lblDim2Name" class="fontHead"></asp:Label>&nbsp;
                    <asp:ImageButton ID="btnImageDim2" Visible="false" runat="server"></asp:ImageButton>
                    <asp:ImageButton ID="btnDim2Sort" Visible="false" runat="server"></asp:ImageButton>
                    <asp:ImageButton ID="btnDim2Remove" Visible="false" runat="server"></asp:ImageButton>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:DataGrid ID="DataGridDim2" runat="server" Datakeys="DimID" BorderColor="Silver"
                        BorderStyle="Solid" BorderWidth="1px" PageSize="100" AutoGenerateColumns="false"
                        AllowPaging="true" PagerStyle-Visible="false">
                        <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
                        <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
                        <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                    </asp:DataGrid>
                </td>
            </tr>
        </table>
        <br />
        <table cellspacing="1" cellpadding="1" width="100%">
            <tr class="TableHeader">
                <td>
                    <asp:Label runat="server" ID="lblDim3Name" class="fontHead"></asp:Label>&nbsp;
                    <asp:ImageButton ID="btnImageDim3" Visible="false" runat="server"></asp:ImageButton>
                    <asp:ImageButton ID="btnDim3Sort" Visible="false" runat="server"></asp:ImageButton>
                    <asp:ImageButton ID="btnDim3Remove" Visible="false" runat="server"></asp:ImageButton>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:DataGrid ID="DataGridDim3" runat="server" Datakeys="DimID" BorderColor="Silver"
                        BorderStyle="Solid" BorderWidth="1px" PageSize="100" AutoGenerateColumns="false"
                        AllowPaging="true" PagerStyle-Visible="false">
                        <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
                        <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
                        <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                    </asp:DataGrid>
                </td>
            </tr>
        </table>
    </asp:Panel>
    
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

    <script type="text/javascript">
        function showColorwaySort(strStyleBOMDimensionID, strDimLevel) {
            window.radopen("Style_DimensionalBOM_BOMColorway_Sort.aspx?SBDID=" + strStyleBOMDimensionID + "&SDL=" + strDimLevel, "SortColorways");
        }

        function showColorwayRemove(strStyleBOMDimensionID, strDimLevel) {
            window.radopen('Style_DimensionalBOM_BOMColorway_Remove.aspx?SID=<%= Request("SID") %>&SN=<%= Request("SN") %>&WFIID=<%= Request("WFIID") %>&SBDID=' + strStyleBOMDimensionID + '&SDL=' + strDimLevel, 'RemoveColorways');
        }
        function showConfigureBOM(strStyleBOMDimensionID) {
            window.radopen("Style_DimensionalBOM_Configure.aspx?SBDID=" + strStyleBOMDimensionID, "ConfigBOM");
        }
    </script>
    </form>
</body>
</html>
