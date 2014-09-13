<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_New.aspx.vb" Inherits="plmOnApp.Material_New" enableViewState="False"%>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
    <head runat="server">
        <title>New Material</title>
        <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
        <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
        <meta content="JavaScript" name="vs_defaultClientScript" />
        <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
        <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
            .colors td {
            	padding: 2px;
            }
            
            .pos { position:relative;}
            
            .DeleteMarker, .DeleteMarker:link, .DeleteMarker:active {
            	display: none; 
            	color: Red; 
            	font-weight: bold;
            	font-size: 12px;
            }
                      
            .pos:hover .DeleteMarker {display:inline-block;}
            
            #dgTradePartner TD.pos .DeleteMarker,
            #dgSize TD.pos .DeleteMarker {            	
            	position: absolute;
            	right: 2px;
            	top: 50%;
            	height: 100%;
            	margin-top: -6px;
            } 
            
            #dgTradePartner .pos:hover TD.pos,
            #dgSize .pos:hover TD.pos {
            	padding-right: 15px;
            }
        </style>        
        <script type="text/javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
    </head>
	<body MS_POSITIONING="GridLayout">
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
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
        <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1">
            <ClientEvents OnRequestStart="" OnResponseEnd="onAjaxResponseEnd" />
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="drlColorSearch">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="drlColorSearch" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="drlSeasonYearSearch">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="drlSeasonYearSearch" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="drlSizeSearch">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="drlSizeSearch" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="drlTradePartnerSearch">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="drlTradePartnerSearch" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnSizeAdd">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="drlSizeSearch" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
            
            <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
                <tr valign="middle">
                    <td valign="middle" align="center" width="10">
                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                    </td>
                    <td>
                        <cc1:ConfirmedImageButton ID="btnNext" runat="server" Message="NONE" Visible="false"></cc1:ConfirmedImageButton>
                        <cc1:ConfirmedImageButton ID="btnSaveMaterial" runat="server" Message="NONE" Visible="true"></cc1:ConfirmedImageButton>
                        <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" CausesValidation="false"></cc1:ConfirmedImageButton>
                    </td>
                </tr>
            </table>
			<table height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table height="90%" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td valign="top" bgColor="#ffffff">
						<table cellspacing="0" cellpadding="0" width="100%" border="0">
							<tr>
								<td>
									<div align="right"><asp:label id="lblMaterialNew" runat="server" ForeColor="#E0E0E0" Font-Size="XX-Large" Font-Names="Tahoma,Verdana">New Material...</asp:label></div>
								</td>
							</tr>
						</table>
                        
                        <table  cellspacing="0" cellpadding="0" border="0">
                            <tr valign="top">
                                <td width="10">
                                    &nbsp;
                                </td>
                                <td class="fontHead" width="127">
                                    <%= GetSystemText("No. of Materials")%>
                                </td>
                                <td class="fontHead">
                                    <asp:DropDownList runat="server" ID="NoMaterials" Width="150">
                                        <asp:ListItem Value="1" Text="1" Selected="True"></asp:ListItem>
                                        <asp:ListItem Value="2" Text="2"></asp:ListItem>
                                        <asp:ListItem Value="3" Text="3"></asp:ListItem>
                                        <asp:ListItem Value="4" Text="4"></asp:ListItem>
                                        <asp:ListItem Value="5" Text="5"></asp:ListItem>
                                        <asp:ListItem Value="10" Text="10"></asp:ListItem>
                                        <asp:ListItem Value="15" Text="15"></asp:ListItem>
                                        <asp:ListItem Value="20" Text="20"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>                             
                        </table><br/>                                               

						<asp:panel id="pnlMaterial" runat="server">
                            <table height="100" cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr valign="top">
                                    <td width="10">
                                        &nbsp;
                                    </td>
                                    <td>
                                        <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
                                    </td>
                                </tr>
                            </table>
						</asp:panel>

                        <%-- Season/Year --%>
                        <%--<table class="TableHeader" id="Table1" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
                            <tr valign="middle">
                                <td valign="middle" align="left" width="120">
                                    <%= GetSystemText("Season Year")%>
                                </td>
                                <td width="200px">
                                <telerik:RadComboBox ID="drlSeasonYearSearch" runat="server" Width="200" EnableLoadOnDemand="true" 
                                        ShowMoreResultsBox="true" EnableVirtualScrolling="true" AutoPostBack="true"></telerik:RadComboBox>
                                </td>
                                <td>
                                    <cc1:BWImageButton runat="server" ID="btnSeasonYearAdd" />
                                </td>
                            </tr>                            
                        </table>
                        <asp:UpdatePanel runat="server" ID="upSeasonYear">
                            <ContentTemplate>
                                <asp:DataGrid runat="server" ID="dgSeasonYear" DataKeyField="SeasonYearID" ShowHeader="false" ItemStyle-CssClass="pos"></asp:DataGrid>
                            </ContentTemplate>
                        </asp:UpdatePanel>   --%>                    
                        
                        <%-- Color --%>
                        <table class="TableHeader" id="Table2" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
                            <tr valign="middle">
                                <td valign="middle" align="left" width="120">
                                    <%= GetSystemText("Color")%>
                                </td>
                                <td width="200px">
                                <telerik:RadComboBox ID="drlColorSearch" runat="server" Width="200" EnableLoadOnDemand="true" 
                                        ShowMoreResultsBox="true" EnableVirtualScrolling="true" AutoPostBack="true" CausesValidation="false"></telerik:RadComboBox>
                                </td>

                                <td>
                                    <cc1:BWImageButton runat="server" ID="btnColorAdd" />
                                </td>
                            </tr>                            
                        </table>
                        <asp:UpdatePanel runat="server" ID="upColors">
                            <ContentTemplate>
                                <asp:DataList ID="dlColors" runat="server" EnableViewState="False" RepeatColumns="8" BorderColor="Gray"
                                    BorderWidth="0px" CellPadding="2" GridLines="Both" DataKeyField="ColorPaletteID">
                                    <ItemStyle BackColor="White" BorderColor="Gainsboro" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left"
                                        VerticalAlign="Top" CssClass="pos"/>
                                    <ItemTemplate>
                                        <table cellspacing="0" cellpadding="0" class="colors">
                                            <tr>
                                                <td>
                                                    <asp:Image runat="server" ID="imgColor" ImageUrl='<%# String.Format(GetColorStreamPath("40", Eval("ColorFolderID").ToString, Eval("ColorPaletteID").ToString)) %>' />
                                                </td>
                                                <td class="font">
                                                    <%# Eval("ColorCode")%><br /><%# Eval("ColorName")%>
                                                </td>
                                            </tr>                                
                                        </table>
                                        <div style="position:absolute; top:0; right:1px; font-weight:bold;" class="DeleteMarker"><asp:LinkButton style="text-decoration: none; cursor:pointer;" runat="server" CommandName="delete" OnClientClick="once_disable_wait_text=true" >X</asp:LinkButton></div>
                                    </ItemTemplate>
                                </asp:DataList>
                            </ContentTemplate>
                        </asp:UpdatePanel>

                        <%-- Size/Treatment --%>
                        <table class="TableHeader" id="Table4" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
                            <tr valign="middle">
                                <td valign="middle" align="left" width="120">
                                    <%= GetSystemText("Size/Treatment")%>
                                </td>
                                <td width="200px">
                                    <telerik:RadComboBox ID="drlSizeSearch" runat="server" Width="200" EnableLoadOnDemand="true" ShowMoreResultsBox="true"
                                        EnableVirtualScrolling="true" AutoPostBack="true" Filter="Contains" HighlightTemplatedItems="true">
                                    </telerik:RadComboBox>
                                </td>
                                <td runat="server" id="tdAddSize" width="30px">
                                    <asp:DropDownList ID="dpNewRow" runat="server" CssClass="fontHead">
                                        <asp:ListItem Value="1" Selected="True">1</asp:ListItem>
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
                                    <asp:ImageButton runat="server" ID="btnSizeAdd" OnClientClick="return checkSize()" />
                                </td>
                            </tr>
                        </table>
                        <asp:UpdatePanel runat="server" ID="upSize">
                            <ContentTemplate>
                                <asp:DataGrid runat="server" ID="dgSize" DataKeyField="MaterialSizeID" ShowHeader="true" ItemStyle-CssClass="pos"
                                    BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0" Width="250" AutoGenerateColumns="False">
                                    <AlternatingItemStyle Height="20px" BackColor="AliceBlue" CssClass="font pos"></AlternatingItemStyle>
                                    <ItemStyle Height="20px" CssClass="font pos" BackColor="White"></ItemStyle>
                                    <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>                                    
                                </asp:DataGrid>
                            </ContentTemplate>
                        </asp:UpdatePanel>

                        <%-- Trade Partner --%>
                        <table class="TableHeader" id="Table3" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
                            <tr valign="middle">
                                <td valign="middle" align="left" width="120">
                                    <%= GetSystemText("Trade Partner")%>
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="drlTradePartnerSearch" runat="server" DropDownAutoWidth="Enabled" EnableLoadOnDemand="true" ShowMoreResultsBox="true"
                                        EnableVirtualScrolling="true" AutoPostBack="true" Filter="Contains">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>                                             
                        </table>
                        <asp:UpdatePanel runat="server" ID="upTradePartner">
                            <ContentTemplate>
                                <asp:DataGrid runat="server" ID="dgTradePartner" DataKeyField="TradePartnerRelationshipLevelID" ShowHeader="true"
                                    ItemStyle-CssClass="pos" HeaderStyle-CssClass="TableHeader" HeaderStyle-Height="20px">
                                </asp:DataGrid>
                            </ContentTemplate>
                        </asp:UpdatePanel>

                        <table height="100" cellspacing="0" cellpadding="0" width="100%" background="../System/Images/MiddleFill.jpg"
                            border="0">
                            <tr valign="top">
                                <td width="33%">
                                </td>
                                <td width="33%">
                                </td>
                                <td width="33%">
                                </td>
                            </tr>
                        </table>
					</td>					
				</tr>
			</table>
		</form>
        <script type="text/javascript">
            function UpdateColors() {
                __doPostBack('<%= upColors.ID %>', '');
            }

            function UpdateSize() {
                __doPostBack('<%= upSize.ID %>', '');
            }

            function onAjaxResponseEnd(sender, eventArgs) {
                UpdateColors();
               // UpdateSeasonYears();
            }

            function checkSize() {
                var materialType = '<%= _MaterialType %>';
                if (materialType == "" || materialType == "0") {
                    alert('<%= GetSystemText("Please select a material type") %>');
                } else if ($("#tdAddSize").length) {
                    return true;
                } else {
                    var w = window.open('Material_Treatment_Select.aspx?MTID=<%= _MaterialID %>&MT=<%= _MaterialType %>', 'MaterialNewTreatmentAdd', 'menubar=0,toolbar=0,status=1,scrollbars=1,location=0,resizable=1,top=200,left=200,height=600,width=400');
                    w.focus();
                }

                return false;
            }
        </script>
	</body>
</HTML>
