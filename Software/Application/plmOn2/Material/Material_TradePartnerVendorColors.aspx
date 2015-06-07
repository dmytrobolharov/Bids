<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Material_TradePartnerVendorColors.aspx.vb" Inherits="plmOnApp.Material_TradePartnerVendorColors" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc2" TagName="Material_Header" Src="Material_Header.ascx" %>
<%@ Register TagPrefix="uc2" TagName="TradePartner_Header" Src="MaterialRequest_Partner_Header.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head runat="server">
    <%--<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />--%>
	<title>Material Colors</title>
    <link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />		
    <link href="../System/CSS/Grid.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/Tree.css" rel="stylesheet" type="text/css" />    
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
 <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="Form1" runat="server" defaultbutton="imgBtnSearch">
			<table class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" 
                height="25" border="0">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><asp:ImageButton 
					    id="btnSave" runat="server"  /><cc1:BWImageButton 
					    ID="btnColorAdd" runat="server"  /><cc1:BWImageButton 
					    id="btnRemove" runat="server"  /><cc1:confirmedimagebutton 
					    id="btnDelete" runat="server"  CausesValidation="false"/><asp:ImageButton 
					    id="btnAddSeason" runat="server"  /><cc1:bwimagebutton 
					    id="btnVendorReplace" runat="server"  Visible="true" /><cc1:bwimagebutton 
					    id="btnAddFGVendor" runat="server"  Visible="true" /><cc1:bwimagebutton
                        id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>
					</td>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" 
                            Font-Size="X-Large" ForeColor="Gray"><%#GetSystemText("Material Request")%></asp:label></td>
				</tr>
			</table>
			<table height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr class="TableHeader">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="20"><asp:imagebutton id="imbBtnExpand" runat="server" ImageUrl="../System/Icons/icon_Next.gif"></asp:imagebutton><asp:imagebutton id="imgBtnCollapse" runat="server" ImageUrl="../System/Icons/icon_Down.gif"></asp:imagebutton></td>
					<td class="fontHead">&nbsp;
						<asp:label id="lblMaterialDetail" runat="server"></asp:label></td>
				</tr>
			</table>
			<asp:panel id="Panel1" runat="server" CssClass="font" BorderWidth="0" BackColor="#ffffff" Width="100%">
				<table height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
					<tr>
						<td width="900">
							<uc2:Material_Header id="Material_Header1" runat="server"></uc2:Material_Header></td>
						<td>&nbsp;</td>
					</tr>
				</table>
			</asp:panel>
            <uc2:TradePartner_Header ID="TradePartner_Header1" runat="server"></uc2:TradePartner_Header>
            <table class="TableHeaderYellow" cellspacing="0" cellpadding="0" width="100%" height="30"
                border="0">
                <tr valign="middle">
                    <td valign="middle" align="center" width="10">
                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                    </td>
                    <td width="20"><img src="../System/Icons/icon_season.gif" /></td>
                    <td width="125" align="right" nowrap="nowrap">
                        <asp:Label runat="server" ID="lblStyleSeasonYear" class="fontHead" >Select Season / Year:</asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList  ID="ddlSeasonYearID" runat="server" AutoPostBack="true" ></asp:DropDownList>
                    </td>
                </tr>
            </table>
            <br />
			<asp:panel id="pnlAlert" runat="server" Visible="False">
				<TABLE borderColor="gold" height="75" cellSpacing="0" cellPadding="0" width="900" bgColor="#ffff99"
					border="1">
					<TR>
						<TD>
							<TABLE id="TB_MainMaterial" cellSpacing="0" cellPadding="0" width="600" border="0">
								<TR>
									<TD width="10" height="50">&nbsp;</TD>
									<TD width="50" height="50" rowSpan="2"><IMG src="../System/Icons/icon_warning_32.gif"></TD>
									<TD class="fontHead">
										<asp:Label id="lblAlert" runat="server" Font-Bold="True" CssClass="fontRed"></asp:Label></TD>
									<TD class="fontHead" height="50"></TD>
								</TR>
							</TABLE>
						</TD>
					</TR>
				</TABLE>
				<br />
			</asp:panel>			
			<br />
            <table  cellspacing="0" cellpadding="0" width="100%" height="30" border="0">
                <tr valign="middle">
                    <td width="20"></td>
                    <td ><asp:CheckBox id="cbApplyToAllColors" runat="server" CssClass="fontHead" ForeColor="Red" Text="Apply to all" /></td>
                </tr>
            </table>			
            <br />
            <cc2:YSTabView ID="YSTabView1" runat="server" />
			<asp:Panel ID="pnlColors" runat="server">
	        <table cellspacing="0" bgcolor="White" border="0" cellpadding="0" width="100%">
                <tr >
                    <td valign="top" bgcolor="White"  > 
                        <table cellSpacing="1" cellPadding="0" width="100%" border="0">
                            <tr>
                                <td class="fontHead"><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
                            </tr>
                        </table>
                   
                        <table height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
                            <tr class="TableHeader">
                                <td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
                                <td class="fontHead">&nbsp;<asp:label id="lblSubmitGrid" runat="server"></asp:label></td>
                            </tr>
                        </table>
                        <table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
				            <tr>
					            <td><asp:placeholder id="plhSearchControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					            <td width="100%" valign="top">
						            <table height="45">
							            <tr>
								            <td>
									            <asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton>
                                            </td>
							            </tr>
						            </table>
					            </td>
				            </tr>
			            </table>  
                        <table  class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff"
				            border="0">
				            <tr valign="middle">
					            <td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					            <td class="fontHead" width="10">&nbsp;</td>
					            <td width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></td>
					            <td width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></td>
					            <td nowrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></td>
					            <td width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></td>
					            <td width="20"><asp:imagebutton id="btnImgLast" runat="server"></asp:imagebutton></td>
					            <td width="10">&nbsp;</td>
					            <td width="125"><asp:label id="RecordCount" runat="server" CssClass="fontHead"></asp:label></td>				
					            <td class = "fontHead"  align="right" width="110"><asp:Label ID="lblRecordsperPage" runat="server" Visible="true" Text="Records per Page:"></asp:Label></td>
					            <td width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
							            <asp:ListItem Value="5">5</asp:ListItem>
							            <asp:ListItem Value="10">10</asp:ListItem>
							            <asp:ListItem Value="15">15</asp:ListItem>
							            <asp:ListItem Value="20">20</asp:ListItem>
							            <asp:ListItem Value="25">25</asp:ListItem>
							            <asp:ListItem Value="30">30</asp:ListItem>
							            <asp:ListItem Value="40">40</asp:ListItem>
							            <asp:ListItem Value="50" Selected="true">50</asp:ListItem>
							            <asp:ListItem Value="75">75</asp:ListItem>
							            <asp:ListItem Value="100">100</asp:ListItem>
						            </asp:dropdownlist></td>
					            <td width="10"><asp:button id="Button1" runat="server" CssClass="fontHead" Text="GO"></asp:button></td>
					            <td>&nbsp;</td>
				            </tr>
			            </table>
                             <asp:datagrid id="dgMaterial" runat="server"
                                DataKeyField="MaterialTradePartnerColorID" AllowSorting="true" AutoGenerateColumns="False" BackColor="White" >
                                <PagerStyle Visible="false"/>
                                <AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
                                <ItemStyle Height="20px" CssClass="font"></ItemStyle>
                                <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                            </asp:datagrid>	
                                          			

                        <asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
                    </td>
                </tr>
            </table>
             </asp:Panel> 
            <asp:Panel ID="pnlWorkflow" runat="server">                      
                <asp:datagrid id="dgMaterialRequest" runat="server" AllowSorting="true"
                    DataKeyField="MaterialTradePartnerColorID" AutoGenerateColumns="false" BackColor="White">
                    <PagerStyle />
                    <AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
                    <ItemStyle Height="20px" CssClass="font"></ItemStyle>
                    <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                    <Columns > 
                        <asp:TemplateColumn >
                            <HeaderStyle CssClass="TableHeader" /> 
                            <ItemTemplate>
                                <cc1:BWImageButton runat="server" ID="imgRedirect" ImageUrl="../System/icons/icon_search.gif" />
                             </ItemTemplate>
                             
                        </asp:TemplateColumn>
                    </Columns>
                </asp:datagrid>
            </asp:Panel>  
            <input type="hidden"  id="hdnContent"  runat ="server" />              					
            <asp:HiddenField ID="hdn_XmlFiles" runat="server" />
            
            					
    </form>

    <script type="text/javascript">
        for (var i = 0, len = Page_Validators.length; i < len; i++) {
            Page_Validators[i].display = "Dynamic";
            Page_Validators[i].style.visibility = "visible";
        }

        Page_ClientValidate();
    </script>
</body>
</html>
