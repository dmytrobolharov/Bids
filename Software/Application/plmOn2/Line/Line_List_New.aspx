<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Line_List_New.aspx.vb" Inherits="plmOnApp.Line_List_New" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<head runat="server">
		<title></title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>	
	</head>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
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
    <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1" />
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD><cc1:confirmedimagebutton id="btnSaveMaterial" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" OnClientClick="window.close(); return false;"
							CausesValidation="False"></cc1:confirmedimagebutton></TD>
				</TR>
			</TABLE>
			<table height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table height="90%" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top" bgColor="#ffffff">
						<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
							height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
							<tr>
								<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">New Line List Folder...</asp:label></td>
							</tr>
						</table>
						<br>
						<asp:panel id="pnlMaterial" runat="server">
							<TABLE height="100" cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TR vAlign="top">
									<TD width="10">&nbsp;</TD>
									<TD>
										<BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px">
											<P>
												<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></P>
										</BLOCKQUOTE>
									</TD>
								</TR>
							</TABLE>
						</asp:panel>
						<table height="100" cellSpacing="0" cellPadding="0" width="100%" background="../System/Images/MiddleFill.jpg"
							border="0">
							<tr vAlign="top">
								<td width="33%"></td>
								<td width="33%"></td>
								<td width="33%"></td>
							</tr>
						</table>
					</td>
					<td width="10%" bgColor="#f5f5f5">&nbsp;</td>
				</tr>
			</table>
            
            <asp:HiddenField ID="hdnSelectedStyleTypes" runat="server" />
            <asp:HiddenField ID="hdnSelectedStyleCategories" runat="server" />
            <asp:HiddenField ID="hdnSelectedCalendars" runat="server" />

            <asp:HiddenField ID="hdnXmlFiles" runat="server" />
            <telerik:RadScriptBlock runat="server">
                <script language="javascript" type="text/javascript">

                    function GetSelectedStyleTypes() {
                        var comboItems = $find('<%= dclStyleType.ClientID %>').get_items();
                        var hdnSelectedStyleTypes = $("#hdnSelectedStyleTypes");

                        var oldSelectedStyleTypes = $(hdnSelectedStyleTypes).val(); 
                        var strSelectedStyleTypes = ""

                        for (var i = 0; i < comboItems.get_count(); i++) {
                            if (comboItems.getItem(i).get_checked()) {

                                if (strSelectedStyleTypes != "") {
                                    strSelectedStyleTypes += ",";
                                }
                                strSelectedStyleTypes += comboItems.getItem(i).get_value();
                            }
                        }
                        $(hdnSelectedStyleTypes).val(strSelectedStyleTypes);
                        return (strSelectedStyleTypes != oldSelectedStyleTypes)
                    }

                    function OnStyleTypesLoad(sender, eventArgs) {
                        GetSelectedStyleTypes();    
                    }

                    function OnStyleTypesSelectionChanged(sender, eventArgs) {
                        var doRefresh = GetSelectedStyleTypes();
                        if (doRefresh) {
                            <%= ClientScript.GetPostBackEventReference(New PostBackOptions(dclStyleType) With {.PerformValidation = False}) %>;
                        }
                    }

                    
                    function GetSelectedStyleCategories(sender, eventArgs) {
                        var comboItems = $find('<%= dclStyleCategory.ClientID %>').get_items();
                        var hdnSelectedStyleCategories = $("#hdnSelectedStyleCategories");

                        var strSelectedStyleCategories = ""

                        for (var i = 0; i < comboItems.get_count(); i++) {
                            if (comboItems.getItem(i).get_checked()) {

                                if (strSelectedStyleCategories != "") {
                                    strSelectedStyleCategories += ",";
                                }
                                strSelectedStyleCategories += comboItems.getItem(i).get_value();
                            }
                        }
                        $(hdnSelectedStyleCategories).val(strSelectedStyleCategories);
                    }

                    function GetSelectedCalendars(sender, eventArgs) {
                        var comboItems = $find('<%= dclCalendar.ClientID %>').get_items();
                        var hdnSelectedCalendars = $("#hdnSelectedCalendars");

                        var strSelectedCalendars = ""

                        for (var i = 0; i < comboItems.get_count(); i++) {
                            if (comboItems.getItem(i).get_checked()) {

                                if (strSelectedCalendars != "") {
                                    strSelectedCalendars += ",";
                                }
                                strSelectedCalendars += comboItems.getItem(i).get_value();
                            }
                        }
                        $(hdnSelectedCalendars).val(strSelectedCalendars);
                    }

                </script>
            </telerik:RadScriptBlock>
		</form>
	</body>
</HTML>
