<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Color_Where.aspx.vb" Inherits="plmOnApp.Color_Where" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="uc1" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Material Where</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
	</HEAD>
	<body>
	    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
        <uc1:Color_Wait ID="Color_Wait" runat="server" />

			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD width="80"><cc1:confirmedimagebutton id="btnBatchUpdate" runat="server" Visible="False" Message="NONE"></cc1:confirmedimagebutton></TD>
					<td width="80"></td>
					<td width="75">&nbsp;</td>
					<td>&nbsp;</td>
				</TR>
			</TABLE>
			<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblMaterialHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
							ForeColor="#E0E0E0">Color Where Used</asp:label></td>
				</tr>
			</table>
			<asp:datalist id="Datalist1" EnableViewState="True" RepeatColumns="1" runat="server" 
				DataKeyField="ColorPaletteID" >
				<ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
					VerticalAlign="Top" BackColor="White" Width ="100%"></ItemStyle>
					
				<ItemTemplate>
					<table cellpadding="0" cellspacing="0" border="0" width="100%">
						<tr>
							<td height="16" width="20" valign="top">
								<asp:ImageButton id=imgColor runat="server" CommandName="Detail">
								</asp:ImageButton>&nbsp;&nbsp;</td>
							<td>
								<asp:Label Runat="server" ID="lblDescription" CssClass="font">
									<%#  string.Concat( "( " & DataBinder.Eval(Container.DataItem,"ColorCode").toString & " ) "   &    DataBinder.Eval(Container.DataItem,"ColorName").toString ) %>
								</asp:Label>&nbsp;&nbsp;&nbsp;<asp:Panel ID="pnlDetail" Runat="server" Visible="False">
								<br>
								<asp:DataGrid ID="dgDetail" Runat="server" CssClass="font" Width="100%" AutoGenerateColumns="False"
									ShowHeader="true" DataKeyField="MaterialID" OnItemDataBound="dgDetail_OnItemDataBound">
									<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
									<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
									<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
									<Columns>
										<asp:TemplateColumn>
											<HeaderTemplate><span class="fontHead"><%#GetSystemText("Material")%></span></HeaderTemplate>
											<ItemTemplate>
												<asp:Label ID="lblMaterial" Runat="server" CssClass="font"></asp:Label>
											</ItemTemplate>
										</asp:TemplateColumn>
									</Columns>
								</asp:DataGrid>
								<br>
								<asp:DataGrid ID="dgStyleDetail" Runat="server" CssClass="font" Width="100%" AutoGenerateColumns="False"
									ShowHeader="true" DataKeyField="StyleColorwaySeasonYearID" OnItemDataBound="dgStyleDetail_OnItemDataBound">
									<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
									<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
									<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
									<Columns>
									<asp:TemplateColumn>
											<HeaderTemplate><span class="fontHead"></span></HeaderTemplate>
											<ItemTemplate>
												<asp:ImageButton  ID="imgStyle" Runat="server"></asp:ImageButton >
											</ItemTemplate>
										</asp:TemplateColumn>
										<asp:TemplateColumn>
											<HeaderTemplate><span class="fontHead"><%#GetSystemText("StyleNo")%></span></HeaderTemplate>
											<ItemTemplate>
												<asp:Label ID="lblStyleNo" Runat="server" CssClass="font"></asp:Label>
											</ItemTemplate>
										</asp:TemplateColumn>
										<asp:TemplateColumn>
											<HeaderTemplate><span class="fontHead"><%#GetSystemText("Description")%></span></HeaderTemplate>
											<ItemTemplate>
												<asp:Label ID="lblStyleDescription" Runat="server" CssClass="font"></asp:Label>
											</ItemTemplate>
										</asp:TemplateColumn>
										<asp:TemplateColumn>
											<HeaderTemplate><span class="fontHead"><%#GetSystemText("Season")%></span></HeaderTemplate>
											<ItemTemplate>
												<asp:Label ID="lblSeasonYear" Runat="server" CssClass="font"></asp:Label>
											</ItemTemplate>
										</asp:TemplateColumn>
									</Columns>
								</asp:DataGrid><br>
                                    <asp:DataGrid ID="dgPlanningDetail" runat="server" CssClass="font" Width="100%" AutoGenerateColumns="False"
                                        ShowHeader="true" DataKeyField="PlanningID" OnItemDataBound="dgPlanningDetail_OnItemDataBound">
                                        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                                        <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
                                        <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>                                        
                                        <Columns>
                                            <asp:TemplateColumn>
                                                <HeaderTemplate>
                                                    <span class="fontHead">
                                                        <%#GetSystemText("Planning Name")%></span></HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPlanningName" runat="server" CssClass="font"><%# Eval("PlanningName")%></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>                                            
                                            <asp:TemplateColumn>
                                                <HeaderTemplate>
                                                    <span class="fontHead">
                                                        <%#GetSystemText("Season Year")%></span></HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSeasonYear" runat="server" CssClass="font"><%# Eval("SeasonYear")%></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                        </Columns>
                                    </asp:DataGrid>
							</asp:Panel>
								
							</td>
							<td width="20">&nbsp;</td>
						</tr>
					</table>
				</ItemTemplate>
				
						

			</asp:datalist></form>
	</body>
</HTML>
