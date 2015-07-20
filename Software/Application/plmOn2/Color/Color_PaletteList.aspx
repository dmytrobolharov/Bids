<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Color_PaletteList.aspx.vb" Inherits="plmOnApp.Color_PaletteList" %>
<%@ Register src="../System/Control/SystemPageActiveUser.ascx" tagname="SystemPageActiveUser" tagprefix="uc1" %>
<%@ Register Src="Color_WorkflowStatus.ascx" TagName="Color_WorkflowStatus" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
	<head runat="server">
		<title runat="server" id="PageTitle">Palette</title>
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
        <style type="text/css">
            th.rgHeaderYPLM, th.rgHeader {
                padding: 0 0px !important;
            }
        </style>
	</head>
	<body>
	    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
        
        <form id="Form1" method="post" runat="server">
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
					<TD valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<td valign="top">
					<cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" EnableViewState="False"></cc1:confirmedimagebutton>
					<cc1:bwimagebutton id="btnColorNew" runat="server"></cc1:bwimagebutton>
					<cc1:bwimagebutton id="btnColorSort" runat="server"></cc1:bwimagebutton>
					<cc1:confirmedimagebutton id="btnCopy" runat="server" Message="NONE" CausesValidation="False"></cc1:confirmedimagebutton>
					<cc1:BWImageButton id="btnPreview" runat="server"/>
					<cc1:bwimagebutton id="btnColorRemove" runat="server"></cc1:bwimagebutton>
					<cc1:confirmedimagebutton id="btnDeletePalette" runat="server" CausesValidation="False"></cc1:confirmedimagebutton>   
                    <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>
                    <cc1:confirmedimagebutton id="btnExcelExport" runat="server"  Message="NONE" OnClientClick="enable_close_link();"></cc1:confirmedimagebutton>
                    <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" CausesValidation="False" OnClientClick="return btnClose_Click();"></cc1:confirmedimagebutton>
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
			
			<%--<uc1:SystemPageActiveUser ID="SystemPageActiveUser1" runat="server"  />--%>
			
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td><asp:label id="lblColorHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
				</tr>
			</table>
            <uc1:Color_WorkflowStatus runat="server" ID="Color_WorkflowStatus1" ColorFolderWorkflowID="10000000-0000-0000-0000-000000000000" />
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

        function btnClose_Click() {
            <%= strExitScript %>
            return false;
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
                            <asp:Label ID="lblPageSize" Runat="server" Text="24" Visible="False"></asp:Label>
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
                            <asp:Label ID="lblCounts" Runat="server" CssClass="plaintable" Font-Bold="True"></asp:Label>
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
                            <%--<asp:Label ID="lblRecordsFound" Runat="server" Visible="true" text="Records Found"/>--%>
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
                        <p align="right" style="margin: 0;">
                            <span id="spanSortPanel" runat="server">
                                <asp:DropDownList ID="ddlSortField" runat="server"></asp:DropDownList>
                                <asp:DropDownList ID="ddlSortBy" runat="server"></asp:DropDownList>
                                <asp:ImageButton ID="btnSort" runat="server" CausesValidation="false" ImageUrl="../System/Icons/icon_sort.gif" />
                            </span>
                        </p>
                    </td>
                    <span id="spanRecordsPerPage" runat="server">
                    <TD class="fontHead" align="right"><asp:label id="lblRecordsPerPage" runat="server" CssClass="fontHead" Text="Records per Page:"></asp:label></TD>
								<TD width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
										<asp:ListItem Value="5">5</asp:ListItem>
										<asp:ListItem Value="10">10</asp:ListItem>
										<asp:ListItem Value="15">15</asp:ListItem>
										<asp:ListItem Value="20">20</asp:ListItem>
										<asp:ListItem Value="25">25</asp:ListItem>
										<asp:ListItem Value="30">30</asp:ListItem>
										<asp:ListItem Value="40">40</asp:ListItem>
										<asp:ListItem Value="50" Selected="True">50</asp:ListItem>
									</asp:dropdownlist></TD>
								<TD width="10"><asp:button id="btnRePage" onclick="RePage" runat="server" CssClass="fontHead" text="GO"></asp:button></TD>
						</span>	
                </tr>
            </table>
            <table border="0" bordercolor="gainsboro" cellpadding="0" cellspacing="1">
                <tr>
                    <td valign="top">
                        <asp:DataList ID="Datalist1" runat="server" DataKeyField="ColorPaletteId" 
                            EnableViewState="false" RepeatColumns="1" RepeatDirection="Horizontal" 
                            RepeatLayout="Table">
                            <ItemStyle BackColor="White" BorderColor="Gainsboro" BorderStyle="Solid" 
                                BorderWidth="0" HorizontalAlign="Left" VerticalAlign="Top" />
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
