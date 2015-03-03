<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_Costing.aspx.vb" Inherits="plmOnApp.Sourcing_Costing" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc2" TagName="Style_QuoteItem_Document" Src="../Style/Style_QuoteItem_Document.ascx" %>
<%@ Register TagPrefix="uc2" TagName="Style_QuoteItem_Comment" Src="../Style/Style_QuoteItem_Comment.ascx" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title runat="server" id="PageTitle">Sourcing</title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" /> 
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
    <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
    <script>
    function btnClose_Click() {
        <%= strExitScript %>
        return false;
    }
    </script>
</head>
<body>
    <form id="Form1" runat="server">
	<TABLE class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" border="0">
		<TR vAlign="middle" height="25">
			<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
			<TD>
                <cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                <cc1:confirmedimagebutton id="btnAddColor" Visible="true" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                <cc1:bwimagebutton id="btnAddCosting" runat="server" Message="NONE"></cc1:bwimagebutton>
                <cc1:confirmedimagebutton id="btnRemove" runat="server" Message="NONE"  Visible="false"></cc1:confirmedimagebutton>
                <cc1:bwimagebutton id="btnGoTo" Visible="false" runat="server" Message="NONE"></cc1:bwimagebutton>
                <cc1:bwimagebutton id="btnPreview" runat="server" Message="NONE"></cc1:bwimagebutton>
                <cc1:bwimagebutton id="btnChangeLog" runat="server"></cc1:bwimagebutton>
                <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" CausesValidation="false" OnClientClick="return btnClose_Click();"></cc1:confirmedimagebutton>
            </TD>
            <td class="FontHead" vAlign="middle" align="center" width="75"><asp:label ID="lblColorWay" runat="server" >Colorway</asp:label>&nbsp;</td>
            <td width="40"><asp:dropdownlist id="dpColoways" runat="server" AutoPostBack="true" DataValueField="ID" DataTextField="Value" CssClass="font"></asp:dropdownlist></td>					
            <td width="40">&nbsp;</td>
		</TR>
	</TABLE>
    <table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
		height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
		<TR>
			<TD>&nbsp;
				<asp:label id="lbHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="Silver">Quote</asp:label></TD>
		</TR>
	</table>
	<table id="Table1" cellSpacing="1" cellpadding="1" width="100%" bgColor="#ffffff" border="0">
		<tr>
			<td><asp:placeholder id="plhHeaderControl" runat="server"></asp:placeholder></td>
		</tr>
	</table>
    <asp:Panel ID="pnlSeasonYear"  runat="server" >
        <table class="TableHeaderYellow" cellspacing="0" cellpadding="0" width="100%" height="30"
            border="0">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                </td>
                <td width="20"><img src="../System/Icons/icon_season.gif" /></td>
                <td nowrap="nowrap">
                    <asp:Label runat="server" ID="lblSeasonYearLabel" class="fontHead" ></asp:Label>&nbsp;
                    <asp:Label ID="lblStyleSeasonYear" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
    </asp:Panel> 	    
	<TABLE cellSpacing="1" cellPadding="1" width="100%" bgColor="#ffffff" border="0">
		<TR>
			<td width="900">
				<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder><BR>
			</td>
		</TR>
	</TABLE>
    <!----------------------------- QUOTE  ---------------->				
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>										
			<td valign="top">          
    <asp:Panel ID="pnlCosting"  runat ="server"  >
	<table cellpadding="0" cellspacing="0" width="100%" bgColor="#ffffff" border="0" bordercolor="red">
		<tr>
			<td valign="top" width="50%"  bgColor="#ffffff"
				<table cellpadding="0" cellspacing="0" width="100%" bgColor="#ffffff" border="0" bordercolor="red">
				    <tr>
				        <td>
		                     <TABLE bgColor="#ffffff" border="0" cellPadding="1" cellSpacing="1" width="100%">
                                <tr>
                                    <td valign="top" width="300">
                                        <table border="3" bordercolor="#ffffff" cellpadding="2" cellspacing="2">
                                            <tr>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    <asp:CheckBox ID="cbApplyToAllColors" runat="server" CssClass="fontHead" 
                                                        ForeColor="Red" Text="Apply to all" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    <asp:CheckBox ID="cbShareAgent" runat="server" CssClass="fontHead" 
                                                        ForeColor="Red" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </TABLE>
			            </td>
                    </tr>
                </table> 
                <TABLE cellSpacing="1" cellPadding="1" width="100%" bgColor="#ffffff" border="0">
					<TR vAlign="top">
						<TD>
							<TABLE height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TR class="TableHeader">
									<TD vAlign="middle" align="center" width="10">
                                        <IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
									<TD class="fontHead"><asp:label id="lbQuote" runat="server">Quote Detail</asp:label>&nbsp;</TD>
								</TR>
							</TABLE>
							<asp:placeholder id="plhQuoteControlsHolder" runat="server"></asp:placeholder>
                            <asp:Panel ID="pnlContainer" runat="server">
								<table border="0" cellpadding="0" cellspacing="0" height="25" width="100%">
									<tr class="TableHeader">
										<td align="center" style="HEIGHT: 24px" valign="middle" width="10">
                                            <img 
                                    height="15" src="../System/Images/bbTbSCnr.gif" width="3"></img></td>
										<td class="fontHead" style="HEIGHT: 24px">
											<asp:Label ID="lbQuoteSpecial" runat="server">Container...</asp:Label>&#160;</td>
									</tr>
								</table>
								<table bgcolor="#ffff99" border="0" cellpadding="0" cellspacing="0" height="25" 
                                    width="100%">
									<tr>
										<td>
											<asp:PlaceHolder ID="plhContainer" runat="server"></asp:PlaceHolder></td>
									</tr>
								</table>
							</asp:Panel>
							<table border="0" cellpadding="0" cellspacing="0" class="TableHeader" 
                        height="25" width="100%">
								<tr valign="middle">
									<td align="center" valign="middle" width="10">
                                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></img></td>
									<td>&#160;<asp:Label ID="lblFreightCost" runat="server">Freight Cost</asp:Label></td>
								</tr>
							</table>
							<asp:DataGrid ID="dgFreightCost" runat="server" AutoGenerateColumns="False" BorderColor="Silver" BorderStyle="Solid" 
                                BorderWidth="1px" PageSize="100" Width="300px">
								<AlternatingItemStyle BackColor="AliceBlue" Height="20px">
                                </AlternatingItemStyle>
                                <ItemStyle BackColor="White" CssClass="font" Height="20px"></ItemStyle>
								<HeaderStyle CssClass="TableHeader" Height="20px"></HeaderStyle>
								<Columns>
									<asp:TemplateColumn>
										<HeaderTemplate>
											<div align="center"></div>
										</HeaderTemplate>
										<ItemTemplate>
											<div align="center">
												<asp:CheckBox ID="cbFreightCostSelected" runat="server" visible="False">
                                                </asp:CheckBox>
												<asp:RadioButton ID="rbFreightCostSelected" Runat="server">
                                                </asp:RadioButton>
											</div>
										</ItemTemplate>
									</asp:TemplateColumn>

									<asp:TemplateColumn>
										<HeaderTemplate>
											<div align="center">
												<asp:Label ID="lblHeaderFreightMethod" runat="server"><%#GetSystemText("Method")%></asp:Label></div>
										</HeaderTemplate>
										<ItemTemplate>
											<div align="center">
												<asp:Label ID="lblFreightMethod" runat="server" Width="50"></asp:Label></div>
										</ItemTemplate>
									</asp:TemplateColumn>

									<asp:TemplateColumn HeaderStyle-Width="75px">
										<HeaderTemplate>
											<div align="center">
												<asp:Label ID="lblHeaderMargin" runat="server"><%#GetSystemText("Margin")%></asp:Label></div>
										</HeaderTemplate>
                                    
										<ItemTemplate>
											<div align="center">
												<asp:Label ID="lblMargin" runat="server" /></div>
										</ItemTemplate>
                                    
									</asp:TemplateColumn>
									<asp:TemplateColumn>
										<HeaderTemplate>
											<div align="center">
												<asp:Label ID="lblHeaderTotalLandCost" runat="server"><%#GetSystemText("TLC")%></asp:Label></div>
										</HeaderTemplate>
                                    
										<ItemTemplate>
											<div align="center">
												<asp:Label ID="lblTotalLandCost" runat="server" Width="50" /></div>
										</ItemTemplate>
                                    
									</asp:TemplateColumn>
									<asp:TemplateColumn>
										<HeaderTemplate>
											<div align="center">
												<asp:Label ID="lblHeaderFreightCost" runat="server"><%#GetSystemText("Frt Cost")%></asp:Label></div>
										</HeaderTemplate>
                                    
										<ItemTemplate>
											<div align="center">
												<asp:Label ID="lblFreightCost" runat="server" Width="50" /></div>
										</ItemTemplate>
                                    
									</asp:TemplateColumn>
									<asp:TemplateColumn>
										<HeaderTemplate>
											<div align="center">
												<asp:Label ID="lblHeaderFreightRate" runat="server"><%#GetSystemText("Frt Rate")%></asp:Label></div>
										</HeaderTemplate>
                                    
										<ItemTemplate>
											<div align="center">
												<asp:Label ID="lblFreightRate" runat="server" Width="50" /></div>
										</ItemTemplate>
                                    
									</asp:TemplateColumn>
								</Columns>
                                
							</asp:DataGrid></TD>
					</TR>
				</TABLE>                  						
				<br/>																		      
			</td>				
			<td valign="top" width="50%"  bgColor="#ffffff">
		        <cc2:YSTabView id="YSTabView1" runat="server"></cc2:YSTabView>	
				<asp:Panel ID="pnlVendor" Runat="server">
					<TABLE height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
						<TR class="TableHeaderYellow">
							<TD vAlign="middle" align="center" width="10">
                                <IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
							<TD class="fontHead">&nbsp;
								<asp:label id="lblVendorQuote" runat="server" text="Vendor Quote" CssClass="fonthead"></asp:label></TD>
						</TR>
					</TABLE>
					<table bgcolor="#ffffff" width="100%" border="0" cellspacing="0" cellpadding="0">
					    <tr>
					        <td>
					            <asp:placeholder id="plhVendorQuote" runat="server"></asp:placeholder>
					        </td>
					    </tr>
					</table>							
				</asp:Panel>
				<asp:Panel ID="pnlComments" Runat="server">
					<uc2:Style_QuoteItem_Comment id="Style_QuoteItem_Comment1" runat="server"></uc2:Style_QuoteItem_Comment>
				</asp:Panel>
				<asp:Panel ID="pnlAttachments" Runat="server">
					<uc2:Style_QuoteItem_Document id="Style_QuoteItem_Document1" runat="server"></uc2:Style_QuoteItem_Document>
				</asp:Panel>	
				<br />			        
			</td>
			
			
		</tr>
	</table>
	</asp:Panel>
			</td>
		</tr>
	</table>	
    <!----------------------------- QUOTE  ---------------->
    </form>
</body>
</html>
