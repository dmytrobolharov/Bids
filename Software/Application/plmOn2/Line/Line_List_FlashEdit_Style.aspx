<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Line_List_FlashEdit_Style.aspx.vb" Inherits="plmOnApp.Line_List_FlashEdit_Style" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="GridEdit" Src="Line_List_FlashEdit_Style_GridEdit.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>Flash Edit</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
            <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
            <scripts>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js"></asp:ScriptReference>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js"></asp:ScriptReference>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js"></asp:ScriptReference>
            </scripts>
            <cdnsettings telerikcdn="Disabled" />
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
                    <telerik:RadWindow ID="QuickFill" runat="server" Title="Quick Fill" Height="600px" Width="800px" ReloadOnShow="true"
                        ShowContentDuringLoad="false" NavigateUrl="Line_List_FlashEdit_Style_QuickFill_New.aspx" Behaviors="Close"
                        IconUrl="../System/Icons/icon_table.gif" KeepInScreenBounds="true" Modal="true" VisibleOnPageLoad="false" />
                </Windows>
            </telerik:RadWindowManager>

			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server" align="left">
				<tr valign="middle" align="left">
					<td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
                    <td align="left" runat="server" id="tdNewStyleControls" width="250px">
                        <table width="250px">
                            <tr valign="middle">
                                <td valign="top">
                                    <asp:Label ID="lblStylesAmount" runat="server" CssClass="fontHead"> </asp:Label>
                                </td>
                                <td valign="top">
                                     <asp:DropDownList id="drlStylesAmount" runat="server" CssClass="fontHead">
                                        <asp:ListItem Value="1">1</asp:ListItem>
                                        <asp:ListItem Value="2">2</asp:ListItem>
                                        <asp:ListItem Value="3">3</asp:ListItem>
                                        <asp:ListItem Value="4">4</asp:ListItem>
                                        <asp:ListItem Value="5">5</asp:ListItem>
                                        <asp:ListItem Value="10">10</asp:ListItem>
                                        <asp:ListItem Value="15">15</asp:ListItem>
                                        <asp:ListItem Value="20">20</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td>
                                     <cc1:confirmedimagebutton id="btnCreateStyles" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                                </td>
                            </tr>
                         </table>
                    </td>
                    <td align="left" width="200px">
					    <asp:imagebutton id="btnInvSearch" runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px" />
					    <cc1:confirmedimagebutton id="btnBatchUpdate" runat="server" Message="NONE" Visible="False"></cc1:confirmedimagebutton>						
					    <cc1:confirmedimagebutton id="btnClose" runat="server" visible="true" Message="NONE" CausesValidation="false" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton>
                    </td>
					<td>
			            <table width="200" border="0" cellspacing="0" cellpadding="0" >
				            <tr>
				                <td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
					            <td><asp:CheckBox valign="top" align="center" ID="chbBatchUpdate" autopostback="true" runat="server" Text="BatchUpdate" CssClass="fontHead" /></td>
				            </tr>
			            </table>	
					</td>
                    <td>
                        &nbsp;
                    </td>
				</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
				<tr>
					<td>&nbsp;<asp:Label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:Label></td>
				</tr>
			</table>			
			<table class="TableHeaderYellow" height="25" width="100%" border="0" cellspacing="0" cellpadding="0" >
				<tr valign="middle">
				    <td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
					<td><asp:Label id="LabelEdit" runat="server" Font-Names="Tahoma,Verdana"  ></asp:Label></td>
				</tr>
			</table>
			<table id="BatchTable" runat="server" cellspacing="0" cellpadding="0" width="100%" bgcolor="" border="0">
				<tr>
					<td><asp:placeholder id="plhEditControlsHolder" runat="server" 
                            EnableViewState="False" ></asp:placeholder></td>
                    <td width="100%" valign="top">
                        <asp:CheckBox runat="server" ID="chbSaveQuickFill" CssClass="fontHead" />
                    </td>				
				</tr>
			</table>
            <table class="TableHeaderBlue" height="25" width="100%" border="0" cellspacing="0" cellpadding="0" >
				<tr valign="middle">
				    <td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
					<td><asp:Label id="LabelSearch" runat="server" Font-Names="Tahoma,Verdana" ></asp:Label></td>
				</tr>
			</table>
			<table cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder><br /></td>
					<td width="100%" valign="top">
						<table>
							<tr>
								<td>
									<asp:imagebutton id="imgBtnSearch" runat="server" CausesValidation="false"></asp:imagebutton></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<asp:PlaceHolder id="phStyle" runat="server" EnableViewState="False"></asp:PlaceHolder>
            <uc1:GridEdit runat="server" ID="ctrGridEdit" />				
			<input id="hiddenBatchUpdate" type="hidden" value="0" name="hiddenBatchUpdate" runat="server" />&nbsp;&nbsp;	
    </form>

    <script type="text/javascript">
        function ValidateRequiredCategory(sender, args) {
            var drlStyleType = $("#ctrlFE_drlStyleType");
            // Style Category field is required only if there's value in Style Type field
            if (drlStyleType.val().length > 0 && args.Value.length < 1) {
                args.IsValid = false;
            } else {
                args.IsValid = true;
            }
        }
        function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>

</body>
</html>
