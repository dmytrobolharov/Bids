<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_DimensionalBOM_Options.aspx.vb" Inherits="plmOnApp.Style.DimensionalBOM.Style_DimensionalBOM_Options" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid_Y.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
<div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="form1" runat="server" defaultbutton="imgBtnSearch">
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
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
        <Windows>
            <telerik:RadWindow ID="ConfigBOM" runat="server" Title="Configure BOM" Height="250px" 
                Width="600px" ReloadOnShow="true" ShowContentDuringLoad="false" 
                NavigateUrl="Style_DimensionalBOM_Configure.aspx"
                Behaviors="Close" 
                IconUrl="../System/Icons/icon_table.gif" 
                KeepInScreenBounds="true" Modal="true" />
        </Windows>
    </telerik:RadWindowManager>

    <input id="hidBOMDimensionId" type="hidden" name="hidBOMDimensionId" width="20" runat="server" />
    <asp:Panel runat="server">
        <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <td valign="middle" align="center" width="10px"><img height="15" alt="" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
                <td>                    
                    <cc1:ConfirmedImageButton ID="btnSave" Message="NONE" runat="server"></cc1:ConfirmedImageButton>
                    <cc1:confirmedimagebutton id="btnBatchUpdate" runat="server" Message="NONE" Visible="True" CausesValidation="false"></cc1:confirmedimagebutton>
                    <asp:ImageButton ID="btnConfigure" runat="server" OnClientClick="showConfigureBOM(); return false;" />
                    <cc1:BWImageButton ID="btnChangeLog" runat="server" CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:BWImageButton>
                    <cc1:ConfirmedImageButton ID="btnClose" Message="NONE" runat="server" OnClientClick="return btnClose_Click()"></cc1:ConfirmedImageButton>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <table id="tbHeader" runat="server" style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45"
        cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                &nbsp;<asp:Label ID="lblBigHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:Label>
            </td>
        </tr>
    </table>
    <table cellSpacing="0" cellPadding="0" width="100%" border="0">
		<tr vAlign="top">
			<td>
			    <table class="TableHeaderYellow" height="25" width="100%" border="0" cellspacing="0" cellpadding="0" >
				    <tr valign="middle">
				        <td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
					    <td><asp:Label id="LabelEdit" runat="server" Font-Names="Tahoma,Verdana"  ></asp:Label></td>
				    </tr>
			    </table>
			    <table id="BatchTable" runat="server" cellspacing="0" cellpadding="0" width="100%" bgcolor="#EEEB9F" border="0">
				    <tr>
					    <td>
                            <asp:placeholder id="plhEditControlsHolder" runat="server"
                                EnableViewState="False" ></asp:placeholder>
                        </td>
                        <td>&nbsp;</td>
				    </tr>
			    </table>
                <table class="TableHeaderBlue" height="25" width="100%" border="0" cellspacing="0" cellpadding="0" >
				    <tr valign="middle">
				        <td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
					    <td><asp:Label id="LabelSearch" runat="server" Font-Names="Tahoma,Verdana" ></asp:Label></td>
				    </tr>
			    </table>
				<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
					<tr>
						<td><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>
						<td vAlign="top" width="100%">
							<table height="45">
								<tr>
									<td><asp:imagebutton id="imgBtnSearch" runat="server"></asp:imagebutton></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
					border="0">
					<tr vAlign="middle">
						<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
						<td width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></td>
						<td width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></td>
						<td noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></td>
						<td width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></td>
						<td width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></td>
						<td width="10">&nbsp;</td>
						<td noWrap><asp:label id="RecordCount" runat="server" CssClass="fontHead"></asp:label></td>
						<td class="fontHead" align="right" width="110"><asp:Label ID="lblRecordsPerPage" runat="server" ></asp:Label></td>
						<td width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
								<asp:ListItem Value="5">5</asp:ListItem>
								<asp:ListItem Value="10">10</asp:ListItem>
								<asp:ListItem Value="15">15</asp:ListItem>
								<asp:ListItem Value="20">20</asp:ListItem>
								<asp:ListItem Value="25">25</asp:ListItem>
								<asp:ListItem Value="30">30</asp:ListItem>
								<asp:ListItem Value="40">40</asp:ListItem>
								<asp:ListItem Value="50" Selected="True">50</asp:ListItem>
							</asp:dropdownlist></td>
						<td width="10"><asp:button id="btnGo" runat="server" CssClass="fontHead" ></asp:button></td>
					</tr>
				</table>
                <asp:DataGrid id="DataGrid1" runat="server" AllowSorting="false" DataKeyField="StyleBOMDimensionItemID" >
	                <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
	                <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
	                <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
	                <PagerStyle Visible="False"></PagerStyle>
                    <Columns>
                        <asp:TemplateColumn ItemStyle-BorderWidth="1" ItemStyle-BorderColor="Gainsboro">
                            <HeaderStyle CssClass="TableHeader" Width="20"></HeaderStyle>
				            <ItemStyle>
                            </ItemStyle>
                            <HeaderTemplate>
                                <input type="checkbox" id="checkAll" onclick="CheckAll(this);" runat="server" name="checkAll" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkSelect" runat="server"></asp:CheckBox>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                    </Columns>
                </asp:DataGrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
			</td>
		</tr>
	</table>
    </form>

    <script type="text/javascript">
        var frm = document.form1;
        function CheckAll(checkAllBox) {
            var actVar = checkAllBox.checked;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf("chkSelect") != -1)
                    e.checked = actVar;
            }
        }

        function showConfigureBOM() {
            window.radopen("Style_DimensionalBOM_Configure.aspx?SBDID=" + "<%= _StyleDimensionBOMId %>", "ConfigBOM");
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
