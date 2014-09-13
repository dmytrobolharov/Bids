<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TechPack_Item.aspx.vb" Inherits="plmOnApp.TechPack_Item" trace="false"%>
<%@ Import Namespace="Yunique.Core.Library" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="../Style/Style_Header.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
	<HEAD>
		<title>Tech Pack</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
	</HEAD>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td height="20"><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE"></cc1:confirmedimagebutton><cc1:bwimagebutton id="btnAgentAdd" runat="server" ></cc1:bwimagebutton><cc1:confirmedimagebutton id="btnPreview" runat="server" Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnTechDelete" runat="server" Message="Are you sure you want to delete tech pack?"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnNewIssue" runat="server" Message="NONE" 
							CausesValidation="False"></cc1:confirmedimagebutton></td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<uc1:style_header id="Style_Header1" runat="server"></uc1:style_header>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top" width="300">
						<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<TR vAlign="middle">
								<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<td><asp:Label ID="lblTechPackHeader" runat="server"></asp:Label></td>
							</TR>
						</TABLE>
						<table cellSpacing="1" cellPadding="0" width="100%" bgColor="#e4e4e4" border="0">
							<tr bgColor="#ffffff">
								<td width="15" height="20">&nbsp;</td>
								<td class="fontHead" width="100" height="20">
                                    <asp:Label ID="lblTP_No" runat="server"></asp:Label>:
								</td>
								<td class="font" height="20">&nbsp;
									<asp:label id="txtTechPackNo" runat="server"></asp:label></td>
							</tr>
							<tr bgColor="#ffffff">
								<td height="20">&nbsp;</td>
								<td class="fontHead" height="20">
                                    <asp:Label ID="lblTP_Name" runat="server"></asp:Label>:
								</td>
								<td class="font" height="20">&nbsp;
									<asp:label id="txtTechPackName" runat="server"></asp:label></td>
							</tr>
							<tr bgColor="#ffffff">
								<td height="20">&nbsp;</td>
								<td class="fontHead" height="20">
                                    <asp:Label ID="lblTP_Language" runat="server"></asp:Label>:
								</td>
								<td class="font" height="20">&nbsp;
									<asp:label id="txtTechPackLanguage" runat="server"></asp:label></td>
							</tr>
							<tr bgColor="#ffffff">
								<td width="15" height="20">&nbsp;</td>
								<td class="fontHead" width="100" height="20">
                                    <asp:Label ID="lblTP_SeasonYear" runat="server"></asp:Label>:
								</td>
								<td class="font" height="20">&nbsp;
									<asp:label id="txtSeasonYear" runat="server"></asp:label></td>
							</tr>
							<tr bgColor="#ffffff">
								<td width="15" height="20">&nbsp;</td>
								<td class="fontHead" width="100" height="20">
                                    <asp:Label ID="lblTP_CUser" runat="server"></asp:Label>:
								</td>
								<td class="font" height="20">&nbsp;
									<asp:label id="txtCUser" runat="server"></asp:label></td>
							</tr>
							<tr bgColor="#ffffff">
								<td width="15" height="20">&nbsp;</td>
								<td class="fontHead" width="100" height="20">
                                    <asp:Label ID="lblTP_CDate" runat="server"></asp:Label>:</td>
								<td class="font" height="20">&nbsp;
									<asp:label id="txtCDate" runat="server"></asp:label></td>
							</tr>
						</table>
					</td>
					<td vAlign="top">
						<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<TR vAlign="middle">
								<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<td><asp:Label ID="lblComments" runat="server"></asp:Label></td>
							</TR>
						</TABLE>
						<table cellSpacing="1" cellPadding="0" width="100%" bgColor="#e4e4e4" border="0">
							<tr bgColor="#ffffff">
								<td width="15" height="60">&nbsp;</td>
								<td class="font" height="60">&nbsp;
									<asp:textbox id="txtNotes" runat="server" Width="460px" Height="125px" CssClass="font" TextMode="MultiLine"></asp:textbox></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<BR>
			<table cellSpacing="1" cellPadding="0" width="100%" bgColor="#e4e4e4" border="0">
				<tr bgColor="#ffffff">
					<TD vAlign="top" width="450">
						<TABLE class="TableHeaderYellow" id="Table1" height="25" cellSpacing="0" cellPadding="0"
							width="100%" border="0">
							<TR vAlign="middle">
								<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<TD><asp:Label ID="lblAgent" runat="server"></asp:Label></TD>
							</TR>
						</TABLE>
						<asp:datagrid id="dgAgent" runat="server" Width="450px" BorderColor="Silver" BorderStyle="Solid"
							BorderWidth="1px" OnItemDataBound="dgAgent_ItemDataBound" AutoGenerateColumns="False" ShowHeader="False">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplateYellow"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="ItemTemplateYellow"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn ItemStyle-Width="25">
									<ItemTemplate>
										<div align="center">
											<asp:Image id="imgTradeSelect" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:Image>
										</div>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<ItemTemplate>
										<asp:Label id="lblTradePartnerName" runat="server" CssClass="font" />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn ItemStyle-Width="120px">
									<ItemTemplate>
										<asp:Label id="lblAgentName" runat="server" CssClass="font" />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn ItemStyle-Width="120px">
									<ItemTemplate>
										<asp:Label id="lblVendorName" runat="server" CssClass="font" />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn ItemStyle-Width="120px">
									<ItemTemplate>
										<asp:Label id="lblFactoryName" runat="server" CssClass="font" />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<ItemTemplate>
										<asp:Label id="lblTradePartnerCountry" runat="server" CssClass="font" />
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid></TD>
					<TD vAlign="top"><cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview><asp:datagrid id="dgActivity" runat="server" Width="600px" BorderColor="Silver" BorderStyle="Solid"
							BorderWidth="1px" AutoGenerateColumns="False" ShowHeader="true" DataKeyField="ActivityTempId">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplateYellow"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="ItemTemplateYellow"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn>
								<HeaderTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%#GetSystemText("Log No") %>'></asp:Label>
								    </HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblActivityNo" runat="server" CssClass="font" />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn >
								    <HeaderTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%#GetSystemText("Date") %>'></asp:Label>
								    </HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblActivityDate" runat="server" CssClass="font" />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn >
								<HeaderTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%#GetSystemText("User") %>'></asp:Label>
								    </HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblActivityUser" runat="server" CssClass="font" />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn >
								    <HeaderTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%#GetSystemText("Description") %>'></asp:Label>
								    </HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblActivityDescription" runat="server" CssClass="font" />
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid>
						<asp:datagrid id="dgChange" runat="server" Width="600px" BorderColor="Silver" BorderStyle="Solid"
							BorderWidth="1px" AutoGenerateColumns="False" ShowHeader="true">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplateYellow"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="ItemTemplateYellow"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn >
								<HeaderTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%#GetSystemText("Action") %>'></asp:Label>
								    </HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblActionType" runat="server" CssClass="font" Text='<%# Eval("ActionType") %>' />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn >
								<HeaderTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%#GetSystemText("Workflow") %>'></asp:Label>
								    </HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblWorkflow" runat="server" CssClass="font" Text='<%# Eval("Workflow") %>' />
									</ItemTemplate>
								</asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <HeaderTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%#GetSystemText("Field Name") %>'></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblFieldName" runat="server" CssClass="font" Text='<%# Eval("ChangeFieldAlias") %>' />
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <HeaderTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%#GetSystemText("Before") %>'></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblChangeUser" runat="server" CssClass="font" Text='<%# Eval("ChangeBeforeText") %>' />
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <HeaderTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%#GetSystemText("After") %>'></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblChangeUser" runat="server" CssClass="font" Text='<%# Eval("ChangeAfterText") %>' />
                                    </ItemTemplate>
                                </asp:TemplateColumn>
								<asp:TemplateColumn>
								<HeaderTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%#GetSystemText("User") %>'></asp:Label>
								    </HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblChangeUser" runat="server" CssClass="font" Text='<%# Eval("ChangeUserName") %>' />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn >
								    <HeaderTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%#GetSystemText("Date") %>'></asp:Label>
								    </HeaderTemplate>
									<ItemTemplate>
										<asp:Label ID="lblChangeDate" runat="server" CssClass="font" Text='<%# Convert.ToDateTime(SystemHandler.GetLocalTime(Eval("ChangeDate"))).ToString(Me.GetFormatInfo.DateTimeLongFormat) %>' />
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid>
					</TD>
				</tr>
			</table>
		</form>
	</body>
</HTML>
