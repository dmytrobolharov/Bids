<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Color_PaletteSeasonYear.aspx.vb" Inherits="plmOnApp.Color_PaletteSeasonYear" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
	<HEAD runat="server">
		<title runat="server" id="PageTitle">Palette</title>
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
            th.rgHeaderYPLM, th.rgHeader {
                padding: 0 0px !important;
            }
        </style>
	</HEAD>
	<body>
	    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server" defaultbutton="imgBtnSearch">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server" EnablePageMethods="true">
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

			<input type="hidden" runat="server" id="hiddenCurrentPage"  value="0"/>
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<td valign="top">
					<cc1:bwimagebutton id="btnColorAdd" runat="server" ></cc1:bwimagebutton>
					<cc1:bwimagebutton id="btnColorRemove" runat="server"></cc1:bwimagebutton>
                    <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>
                    </td>
					<td width="75">&nbsp;</td>
					<td align="right"></td>
				</TR>
			</TABLE>
			<table height="10" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td><asp:label id="lblColorHeader" runat="server" ForeColor="#999999" 
                            Font-Size="X-Large" Font-Names="Tahoma,Verdana">Color Palette</asp:label></td>
				</tr>
			</table>
            <table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr bgcolor="White">
					
					<td width="900"  ><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
					<td>&nbsp;</td>
				</tr>
			</table>
            <table cellSpacing="0" cellPadding="0" width="100%" border="0" class="TableHeader">
				<tr>
					<td align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>&nbsp;<asp:Label ID="lblColorSearch" runat="server" Text=""></asp:Label></td>
				</tr>
			</table>
			<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhSearchControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td width="100%" valign="top">
						<table id="Table3" height="45">
							<TR>
								<TD>
									<asp:imagebutton id="imgBtnSearch" runat="server" CausesValidation="false"></asp:imagebutton></TD>
							</TR>
						</table>
					</td>
				</tr>
			</table>            


		<script language="javascript">
		var frm = document.Form1 ;
		function CheckAll( checkAllBox )
		{
		var actVar = checkAllBox.checked ;
		for(i=0;i< frm.length;i++)
		{
			e=frm.elements[i];
			if ( e.type=='checkbox' && e.name.indexOf("chkDelete") != -1 )
			e.checked= actVar ;
		}
		}
		</script>
	        <table id="Table2" border="0" cellpadding="0" cellspacing="0" 
                class="TableHeader" height="20" width="100%">
                <tr class="fontHead">
                    <td align="center" height="25" width="10">
                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
                    <td height="25">
                        <div align="left">
                            &nbsp;
                            <asp:Label ID="lblCurrentIndex" Runat="server" Text="0" Visible="False"></asp:Label>
                            <asp:Label ID="lblPageSize" Runat="server" Text="25" Visible="False"></asp:Label>
                        </div>
                    </td>
                    <td height="25" width="20">
                        <div align="center"><asp:imagebutton id="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:imagebutton></div>
                    </td>
                    <td height="25" width="20">
                        <div align="center"><asp:imagebutton id="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:imagebutton></div>
                    </td>
                    <td height="25" width="125">
                        <div align="center">
                            <asp:Label ID="lblCounts" Runat="server" CssClass="plaintable"></asp:Label>
                        </div>
                    </td>
                    <td height="25" width="20">
                        <div align="center"><asp:imagebutton id="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:imagebutton></div>
                    </td>
                    <td height="25" width="20">
                        <div align="center"><asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:imagebutton></div>
                    </td>
                    <td height="25">
                        <div align="left">
                            <b>
                            <asp:Label ID="lblRecordCount" Runat="server" Visible="true"></asp:Label>&nbsp;
                            <%--<asp:Label ID="lblRecordsFound" Runat="server" Visible="true" Text="Records Found"></asp:Label>--%>
                            </b>
                        </div>
                    </td>
                    <td width="300" align="right">
                        <asp:RadioButtonList ID="rbViewType" RepeatDirection="Horizontal" runat="server" AutoPostBack="true">
                            <asp:ListItem Text="Thumb View" Value="T" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="List View" Value="L"></asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                    <td height="25">
                        <p align="right">
                            <asp:DropDownList ID="ddlSortField" runat="server">
                            </asp:DropDownList>
                            <asp:DropDownList ID="ddlSortBy" runat="server">
                            </asp:DropDownList>
                            <asp:ImageButton ID="btnSort" runat="server" CausesValidation="false"
                                ImageUrl="../System/Icons/icon_sort.gif" />
                        </p>
                    </td>
                </tr>
            </table>
            <table border="0" bordercolor="gainsboro" cellpadding="0" cellspacing="1">
                <tr>
                    <td valign="top">
                        <asp:DataList ID="Datalist1" runat="server" DataKeyField="ColorPaletteId" 
                            EnableViewState="false" RepeatColumns="1" RepeatDirection="Horizontal" 
                            RepeatLayout="Table">
                            <ItemStyle BackColor="White" BorderColor="Gainsboro" BorderStyle="Solid" 
                                BorderWidth="0px" HorizontalAlign="Left" VerticalAlign="Top" />
                            <ItemTemplate>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Left" />
                        </asp:DataList>
                        <asp:PlaceHolder runat="server" ID="plhColorsGrid"></asp:PlaceHolder>
                    </td>
                </tr>
            </table>
	
        <script type="text/javascript" language="javascript">
            function ColumnHidden(sender, eventArgs) {
                var tableColumns = $find("RadGridColors").get_masterTableView().get_columns();
                var hiddenColumns = new Array();
                for (var i = 0; i < tableColumns.length; i++) {
                    if (tableColumns[i].get_visible() == false) {
                        hiddenColumns.push(tableColumns[i].get_uniqueName());
                    }
                }
                var strHiddenColumns = hiddenColumns.join();
                PageMethods.SaveHiddenColumns('RadGridColors', '<%= aspxPageName %>', strHiddenColumns, '<%= UserProperties.TeamID %>', '<%= UserProperties.Username %>');
            }

            function ColumnShown(sender, eventArgs) {
                var tableColumns = $find("RadGridColors").get_masterTableView().get_columns();
                var hiddenColumns = new Array();
                for (var i = 0; i < tableColumns.length; i++) {
                    if (tableColumns[i].get_visible() == false) {
                        hiddenColumns.push(tableColumns[i].get_uniqueName());
                    }
                }
                var strHiddenColumns = hiddenColumns.join();
                PageMethods.SaveHiddenColumns('RadGridColors', '<%= aspxPageName %>', strHiddenColumns, '<%= UserProperties.TeamID %>', '<%= UserProperties.Username %>');
            }
        </script>

		</form>
	</body>
</HTML>
