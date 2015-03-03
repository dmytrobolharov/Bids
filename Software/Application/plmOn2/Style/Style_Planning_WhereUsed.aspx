<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Planning_WhereUsed.aspx.vb" Inherits="plmOnApp.Style.Planning.Style_Planning_WhereUsed" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>
<%@ Register TagPrefix="telerik" Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
	<HEAD>
		<title>Line</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
    	<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <style type="text/css">
            .search-cell td {
            	vertical-align: top !important;
            }
        </style>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server" defaultbutton="imgBtnSearch">
		<wc1:Color_Wait ID="Color_Wait" runat="server" />
		<asp:Panel runat="server" ID="pnlPerm" Visible=false>
				<table style="height:50;" cellspacing="0" cellpadding="0" width="100%"  bgColor="#990000" border="1" borderColor="red">
					<tr>
						<td>
                            <table style="height:25;" cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td width="25"><div align="center"><asp:image id="imgWorkStatus" ImageUrl="../System/Icons/icon_lock.gif" runat="server"></asp:image></div></td>
                                    <td><asp:Label ID="lblPerm" runat="server" 
                                        Text="You might not have permission to access user groups using your credentials." 
                                        CssClass="fontHead" ForeColor="White"></asp:Label></td>
                                </tr>
                            </table>
                          </td>
                      </tr>
                  </table>			
			</asp:Panel>
			
			<asp:Panel runat="server" ID="pnlMain">	
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Line Folder</asp:label></td>
				</tr>
			</table>
			<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
				border="0">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></TD>
					<TD width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></TD>
					<TD noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
					<TD width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></TD>
					<TD width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></TD>
					<TD width="10">&nbsp;</TD>
					<TD noWrap height="25"><div align="left"><b>
                        <asp:label id="lblRecordCount" Visible="true" Runat="server"></asp:label>&nbsp;
                        <asp:label id="lblRecordFound" Runat="server" />
                        </b></div>
                    </TD>	
					<TD  width="110" align="right"><asp:label id="lblRecordPerPage" runat="server" CssClass="fontHead"></asp:label></TD>
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
					<TD width="10"><asp:button id="Button1" onclick="RePage" runat="server" CssClass="fontHead" text="GO"></asp:button></TD>
				</TR>
			</TABLE>
            <table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
                <tr colspan="2"><td>&nbsp;</td></tr>
                <tr>
                    <td class="search-cell"><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>
                    <td vAlign="top" width="100%">
                        <table height="45">
                            <tr><td><asp:imagebutton id="imgBtnSearch" runat="server"></asp:imagebutton></td></tr>
                        </table>
                    </td>
                </tr>
            </table>

			<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR vAlign="top">
					<TD>
						<asp:datagrid id="DataGrid1" runat="server" AllowSorting="True" DataKeyField="PlanningID">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
						</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label></TD>
				</TR>
			</TABLE>
			<asp:HiddenField ID="hdnXmlFiles" runat="server" />
			<input id="hiddenCurrentPage" type="hidden" value="0" name="hiddenCurrentPage" runat="server">&nbsp;&nbsp;</asp:Panel>

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

		</form>
	</body>
</HTML>
