<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_LanguageButton_List.aspx.vb" Inherits="plmOnApp.Control_LanguageButton_List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
	<HEAD>
		<title>Control</title>
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>

		<script type="text/javascript" language="JavaScript">
			<!--
		    function SchemaSaved() {
		        document.Form1.hdnMethod.value = 'SchemaSaved';
		        Form1.submit();
		    }
			//-->
		</script>

    </HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server" onkeypress="if(event.keyCode==13) { document.getElementById('btnSave').click(); return false}">		
            <asp:HiddenField ID="hdnMethod" runat="server" Value="" />
        
		<div id="TheWholeForm" runat="server">
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
                    <telerik:RadWindow ID="SelectLanguagesDialog" runat="server" Title="Dev Select Languages" Height="700px"
                        Width="700px" ReloadOnShow="true" ShowContentDuringLoad="false" 
                        NavigateUrl="Control_Language_SelectLanguages.aspx"
                        Top="10px" Left="10px" 
                        Behaviors="Close, Move, Resize, Maximize"
                        IconUrl="../System/Icons/icon_table.gif"
                        KeepInScreenBounds="true" Modal="true" OnClientClose="OnRadClosed" OnClientPageLoad="OnRadShown" />
                    <telerik:RadWindow ID="GenerateButtonDialog" runat="server" Title="Dev Generate Buttons" Height="700px"
                        Width="700px" ReloadOnShow="true" ShowContentDuringLoad="false" 
                        NavigateUrl="Control_LanguageButton_GenerateButton.aspx"
                        Top="10px" Left="10px" 
                        Behaviors="Close, Move, Resize, Maximize"
                        IconUrl="../System/Icons/icon_table.gif"
                        KeepInScreenBounds="true" Modal="true" OnClientClose="OnRadClosed" OnClientPageLoad="OnRadShown" />
                </Windows>
            </telerik:RadWindowManager>

            <script type="text/javascript">
                //<![CDATA[

                var radWnd;

                function ShowSelectLanguagesForm() {
                    OpenWindod("Control_Language_SelectLanguages.aspx", "SelectLanguagesDialog");
                }

                function ShowGenerateButtonsForm() {
                    OpenWindod("Control_LanguageButton_GenerateButton.aspx", "GenerateButtonDialog");
                }

                function OpenWindod(url, title) {
                    var oTop = document.body.scrollTop;
                    document.body.scroll = "no";
                    document.body.style.overflow = "hidden";
                    document.body.scrollTop = oTop;

                    radWnd = window.radopen(url, title);
                }

                function OnRadShown() {

                    var radWndTop = 0;
                    var radWndLeft = 0;
                    var radWndWidth = 700;
                    var radWndHeight = 700;

                    var docWidth = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
                    var docHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;

                    if (radWndWidth >= docWidth) {
                        radWndWidth = docWidth;
                    } else {
                        radWndLeft = (docWidth / 2) - (radWndWidth / 2);
                    }

                    if (radWndHeight >= docHeight) {
                        radWndHeight = docHeight;
                    } else {
                        radWndTop = (docHeight / 2) - (radWndHeight / 2);
                    }

                    radWnd.setSize(radWndWidth, radWndHeight);
                    //radWnd.moveTo(radWndLeft, radWndTop);
                }

                function OnRadClosed() {
                    document.body.style.overflow = "scroll";
                    document.body.scroll = "yes";
                }
                //]]>
            </script>

            <asp:PlaceHolder ID="plhLanguage" runat="server"></asp:PlaceHolder>
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD>
						<asp:imagebutton id="btnInvSearch" runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px" />
						<cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnSelectLanguages" runat="server" Message="NONE" OnClientClick="ShowSelectLanguagesForm(); return false;"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnBatchUpdate" runat="server" Message="NONE" OnClientClick="ShowGenerateButtonsForm(); return false;"></cc1:confirmedimagebutton>
					</TD>
					<td>&nbsp;</td>
				</TR>
			</TABLE>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
				</tr>
			</table>
            <TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR vAlign="top">
					<TD>
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
								<TD noWrap><asp:label id="RecordCount" runat="server" CssClass="fontHead"></asp:label></TD>
								<TD class="fontHead" align="right" width="110"><asp:Label ID="lblRecordsPerPage" runat="server" ></asp:Label></TD>
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
								<TD width="10"><asp:button id="Button1" onclick="RePage" runat="server" CssClass="fontHead" ></asp:button></TD>
							</TR>
						</TABLE>
						<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
							<tr>
								<td><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>
								<td vAlign="top" width="100%">
									<table height="45">
										<tr>
											<td align="center"><asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						<table border="0" cellpadding="0" cellspacing="0" width="800" style="border: thin solid #C0C0C0; background-color: #FFFFFF;">
						    <tr>
						        <td width="20" height="20" class="fontHead" align="center" valign="middle" bgcolor="White"><asp:HyperLink ID="lnkA" runat="server">A</asp:HyperLink></td>
						        <td width="20" height="20" class="fontHead" align="center" valign="middle" bgcolor="White"><asp:HyperLink ID="lnkB" runat="server">B</asp:HyperLink></td>
						        <td width="20" height="20" class="fontHead" align="center" valign="middle" bgcolor="White"><asp:HyperLink ID="lnkC" runat="server">C</asp:HyperLink></td>
						        <td width="20" height="20" class="fontHead" align="center" valign="middle" bgcolor="White"><asp:HyperLink ID="lnkD" runat="server">D</asp:HyperLink></td>
						        <td width="20" height="20" class="fontHead" align="center" valign="middle" bgcolor="White"><asp:HyperLink ID="lnkE" runat="server">E</asp:HyperLink></td>
						        <td width="20" height="20" class="fontHead" align="center" valign="middle" bgcolor="White"><asp:HyperLink ID="lnkF" runat="server">F</asp:HyperLink></td>
						        <td width="20" height="20" class="fontHead" align="center" valign="middle" bgcolor="White"><asp:HyperLink ID="lnkG" runat="server">G</asp:HyperLink></td>
						        <td width="20" height="20" class="fontHead" align="center" valign="middle" bgcolor="White"><asp:HyperLink ID="lnkH" runat="server">H</asp:HyperLink></td>
						        <td width="20" height="20" class="fontHead" align="center" valign="middle" bgcolor="White"><asp:HyperLink ID="lnkI" runat="server">I</asp:HyperLink></td>
						        <td width="20" height="20" class="fontHead" align="center" valign="middle" bgcolor="White"><asp:HyperLink ID="lnkJ" runat="server">J</asp:HyperLink></td>
						        <td width="20" height="20" class="fontHead" align="center" valign="middle" bgcolor="White"><asp:HyperLink ID="lnkK" runat="server">K</asp:HyperLink></td>
						        <td width="20" height="20" class="fontHead" align="center" valign="middle" bgcolor="White"><asp:HyperLink ID="lnkL" runat="server">L</asp:HyperLink></td>
						        <td width="20" height="20" class="fontHead" align="center" valign="middle" bgcolor="White"><asp:HyperLink ID="lnkM" runat="server">M</asp:HyperLink></td>
						        <td width="20" height="20" class="fontHead" align="center" valign="middle" bgcolor="White"><asp:HyperLink ID="lnkN" runat="server">N</asp:HyperLink></td>
						        <td width="20" height="20" class="fontHead" align="center" valign="middle" bgcolor="White"><asp:HyperLink ID="lnkO" runat="server">O</asp:HyperLink></td>
						        <td width="20" height="20" class="fontHead" align="center" valign="middle" bgcolor="White"><asp:HyperLink ID="lnkP" runat="server">P</asp:HyperLink></td>
						        <td width="20" height="20" class="fontHead" align="center" valign="middle" bgcolor="White"><asp:HyperLink ID="lnkQ" runat="server">Q</asp:HyperLink></td>
						        <td width="20" height="20" class="fontHead" align="center" valign="middle" bgcolor="White"><asp:HyperLink ID="lnkR" runat="server">R</asp:HyperLink></td>
						        <td width="20" height="20" class="fontHead" align="center" valign="middle" bgcolor="White"><asp:HyperLink ID="lnkS" runat="server">S</asp:HyperLink></td>
						        <td width="20" height="20" class="fontHead" align="center" valign="middle" bgcolor="White"><asp:HyperLink ID="lnkT" runat="server">T</asp:HyperLink></td>
						        <td width="20" height="20" class="fontHead" align="center" valign="middle" bgcolor="White"><asp:HyperLink ID="lnkU" runat="server">U</asp:HyperLink></td>
						        <td width="20" height="20" class="fontHead" align="center" valign="middle" bgcolor="White"><asp:HyperLink ID="lnkV" runat="server">V</asp:HyperLink></td>
						        <td width="20" height="20" class="fontHead" align="center" valign="middle" bgcolor="White"><asp:HyperLink ID="lnkW" runat="server">W</asp:HyperLink></td>
						        <td width="20" height="20" class="fontHead" align="center" valign="middle" bgcolor="White"><asp:HyperLink ID="lnkX" runat="server">X</asp:HyperLink></td>
						        <td width="20" height="20" class="fontHead" align="center" valign="middle" bgcolor="White"><asp:HyperLink ID="lnkY" runat="server">Y</asp:HyperLink></td>
						        <td width="20" height="20" class="fontHead" align="center" valign="middle" bgcolor="White"><asp:HyperLink ID="lnkZ" runat="server">Z</asp:HyperLink></td>
						        <td width="30" height="20" class="fontHead" align="center" valign="middle" bgcolor="White"><asp:HyperLink ID="lnk09" runat="server">All</asp:HyperLink></td>
						        <td></td>
						        <td></td>
						    </tr> 
						</table>
						<asp:datagrid id="DataGrid1" runat="server" AllowSorting="True">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
							<Columns>
								<asp:TemplateColumn ItemStyle-BorderWidth="0">
									<HeaderStyle Width="25px" CssClass="TableHeaderYellow"></HeaderStyle>
									<ItemStyle Width="25px"></ItemStyle>
									<ItemTemplate>
                                        <asp:Image ID="imgIcon" runat="server" />
                                        <asp:HiddenField ID="hd_ButtonName" runat="server" />
                                        <asp:HiddenField ID="hd_ButtonIcon" runat="server" />
                                        <asp:HiddenField ID="hd_ButtonUnicode" runat="server" />
                                        <asp:HiddenField ID="hd_Buttontype" runat="server" />
									</ItemTemplate>
								</asp:TemplateColumn>
                            </Columns>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
						</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label></TD>
				</TR>
			</TABLE>
		</div>
		</form>
	</body>
</HTML>
