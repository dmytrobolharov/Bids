<%@ Control Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Wizard_StyleSourcing.ascx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Wizard_StyleSourcing" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="../Style/Style_Header.ascx" %>
<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">

<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
	height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
	<tr>
		<td width="50" height="50">&nbsp;</td>
		<td class="fontHead">
			<P><FONT color="lightgrey">&nbsp;</FONT><FONT color="darkgray" size="3"><asp:Label ID="lblHeaderStyle"
                    runat="server" ></asp:Label>
					</FONT></P>
		</td>
	</tr>
</table>
<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
	<tr>
		<td width="800"><uc1:style_header id="Style_Header1" runat="server"></uc1:style_header></td>
		<td></td>
	</tr>
</table>
<BR>
<table cellSpacing="0" cellPadding="0" width="450" border="0">
	<tr>
		<td class="TableHeader" height="25" Width="450">
			<DIV align="center"><asp:Label ID="lblSourcing" runat="server" ></asp:Label>
            </DIV>
		</td>
	</tr>
	<tr>
		<td Width="600"><asp:datagrid id="dgSourcing" runat="server" Width="450px" BorderStyle="Solid" AutoGenerateColumns="False"
				PageSize="100" BorderWidth="1px" BorderColor="#E0E0E0" DataKeyField="StyleSourcingID"  CssClass="font">
				<AlternatingItemStyle CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				<ItemStyle CssClass="ItemTemplate"></ItemStyle>
				<Columns>
					<asp:TemplateColumn>
						<HeaderStyle Height="20px" Width="50px" HorizontalAlign="Center" CssClass="TableHeader"></HeaderStyle>
						<HeaderTemplate>
                            <asp:Label ID="lblSelectH" runat="server"><%#GetSystemText("Select")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<div align="center" > <asp:Label ID="lblCheckbox"  Runat ="server" ></asp:Label></div>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
						<HeaderTemplate>
                            <asp:Label ID="lblSourcingNameH" runat="server" ><%#GetSystemText("Sourcing Name")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:Label ID="lblSourcingName" Runat="server"></asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
						<HeaderTemplate>
                            <asp:Label ID="lblColorwayH" runat="server" ><%#GetSystemText("Colorway")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:Label ID="lblColorWay" Runat="server"></asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
			</asp:datagrid></td>
	</tr>
</table>
<TABLE style="BORDER-TOP: gray thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: gainsboro"
	height="35" cellSpacing="0" cellPadding="0" width="100%" bgColor="gainsboro" border="0">
	<TR>
		<TD align="center"><asp:imagebutton id="btnBack" runat="server" ></asp:imagebutton><asp:imagebutton id="btnSave" runat="server"></asp:imagebutton><asp:imagebutton id="btnNext" runat="server"></asp:imagebutton>
		</TD>
	</TR>
</TABLE>
