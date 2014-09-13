<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="SampleRequest_Workflow_Wizard_StyleSourcingAgentVendor.ascx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Wizard_StyleSourcingAgentVendor" %>
<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="../Style/Style_Header.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />

<table id="Table1" style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
	height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
	<tr>
		<td width="50" height="50">&nbsp;</td>
		<td class="fontHead">&nbsp;
			<asp:label id="lblVendorHeader" runat="server" CssClass="fontHead"></asp:label></td>
	</tr>
</table>
<TABLE cellSpacing="1" cellPadding="1" width="100%" border="0">
	<TR>
		<TD width="800" bgColor="#ffffff"><uc1:style_header id="Style_Header1" runat="server"></uc1:style_header></TD>
	</TR>
</TABLE>
<TABLE id="Table4" style="BORDER-TOP: gray thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: gainsboro"
	height="35" cellSpacing="0" cellPadding="0" width="100%" bgColor="gainsboro" border="0">
	<TR>
		<TD align="left" width="400"><asp:imagebutton id="btnBack" runat="server"></asp:imagebutton><asp:imagebutton id="btnSave" runat="server"></asp:imagebutton><asp:imagebutton id="btnNext" runat="server" Visible="false"></asp:imagebutton><asp:imagebutton id="btnClose" runat="server"></asp:imagebutton></TD>
		<TD align="left"><asp:checkbox id="CbVendorShare" runat="server" CssClass="fontHead" Enabled="false" 
													ForeColor="Black" Checked="True" AutoPostBack="True"></asp:checkbox>&nbsp;</TD>
	</TR>
</TABLE>
<TABLE cellSpacing="0" cellPadding="0" width="100%" align="center" bgColor="#ffffff" border="0">
	<tr>
		<TD>
			<TABLE id="Table2" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR vAlign="top">
					<TD>
						<TABLE class="TableHeader" id="Table3" height="25" cellSpacing="0" cellPadding="0" width="100%"
							bgColor="#ffffff" border="0">
							<TR vAlign="middle">
								<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<TD width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></TD>
								<TD width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></TD>
								<TD noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
								<TD width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></TD>
								<TD width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></TD>
								<TD width="10">&nbsp;</TD>
								<TD noWrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></TD>
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
						<TABLE id="Table5" height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white"
							border="0">
							<TR>
								<TD>
									<TABLE id="Table7" cellSpacing="1" cellPadding="1" width="100%" border="0">
										<TR>
											<TD><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></TD>
										</TR>
										<TR>
											<TD><asp:checkbox id="cbStyleQuote" runat="server" CssClass="fontHead" 
													ForeColor="Red" Checked="True" AutoPostBack="True"></asp:checkbox></TD>
										</TR>
									</TABLE>
								</TD>
								<TD vAlign="top" width="100%">
									<TABLE id="Table6" height="45">
										<TR>
											<TD><asp:imagebutton id="imgBtnSearch" runat="server"></asp:imagebutton></TD>
										</TR>
									</TABLE>
								</TD>
							</TR>
						</TABLE>
						<asp:datagrid id="DataGrid1" runat="server" PageSize="50" AllowSorting="True" DataKeyField="TradePartnerVendorId">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
                            <Columns>
                                <asp:TemplateColumn ItemStyle-BorderWidth="1" ItemStyle-BorderColor="Gainsboro">
                                    <HeaderStyle Width="25px"></HeaderStyle>
                                    <ItemStyle Width="25px"></ItemStyle>
                                    <HeaderTemplate>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox runat="server" ID="chbTradePartnerVendorID" />
                                        <asp:HiddenField runat="server" ID="hdnTradePartnerIDChain" Value='<%# DataBinder.Eval(Container.DataItem, "TradePartnerIDChain")%>' />
                                        <asp:HiddenField runat="server" ID="hdnTradePartnerRelationshipLevelID" Value='<%# DataBinder.Eval(Container.DataItem, "RelationshipLevelID")%>' />
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                            </Columns>
					   </asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label></TD>
				</TR>
			</TABLE>
		</TD>
	</tr>
</TABLE>
<table cellSpacing="0" cellPadding="0" width="100%" border="0">
	<tr>
		<td>&nbsp;
		</td>
	</tr>
</table>

