<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_Override_VWX_Main.aspx.vb" Inherits="YuniFace.Control_Override_VWX_Main" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Administrator Panel</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link href="../System/CSS/Style.css" rel="stylesheet" type="text/css">
		<link href="../System/CSS/Tree.css" rel="stylesheet" type="text/css">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server" defaultbutton="btnSave" >
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

	        <input type="hidden" runat="server" id="hiddenCurrentPage"  value="0"/>
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<td valign="top">
    					<cc1:confirmedimagebutton id="btnSave" runat="server" ImageUrl="" Message="NONE" EnableViewState="False"></cc1:confirmedimagebutton>
	    				<cc1:confirmedimagebutton id="btnDel" runat="server" ImageUrl="" Message="NONE" EnableViewState="False"></cc1:confirmedimagebutton>
					    <cc1:confirmedimagebutton id="btnClose" runat="server" ImageUrl="" Message="NONE" CausesValidation="False"></cc1:confirmedimagebutton>
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
					<td><asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
				</tr>
			</table>
			<table  cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td width="100%" valign="top">	
					    <asp:TextBox ID="txtOrigHdr" runat="server" Height="100" TextMode="MultiLine" 
                                        Width="100%" Enabled="false" Wrap="False"></asp:TextBox>
                    </td>  
                </tr>
                <tr>                 
                    <td>
                        <cc2:YSTabView ID="YSTabView1" runat="server"></cc2:YSTabView>
                    </td>                                        
                </tr>
                <tr>
                    <td width="100%" valign="top">	
                        <asp:TextBox ID="txtOrigSPX" runat="server" Height="600" TextMode="MultiLine" 
                                        Width="100%" Wrap="False"></asp:TextBox>
					</td>
				</tr>
			</table>            
			
		</form>
		</body>
</HTML>
