<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="../Style/Style_Header.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Wizard_StyleSelected.ascx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Wizard_StyleSelected" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
<table id="Table6" style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
	height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
	<tr>
		<td width="50" height="50">&nbsp;</td>
		<td>
			<P><FONT color="lightgrey">&nbsp;</FONT><FONT color="darkgray" size="5"><asp:Label ID="lblHeader"
                    runat="server" ></asp:Label>
					</FONT></P>
		</td>
	</tr>
</table>
<table id="Table7" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
	<tr>
		<td width="800"><uc1:style_header id="Style_Header1" runat="server"></uc1:style_header></td>
		<td></td>
	</tr>
</table>
<table id="Table8" cellSpacing="0" cellPadding="0" width="100%" border="0">
	<tr>
		<td vAlign="top" width="300">
			<TABLE class="TableHeader" id="Table2" height="25" cellSpacing="0" cellPadding="0" width="100%"
				border="0" runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD><cc1:bwimagebutton id="btnGoToStyle" runat="server"></cc1:bwimagebutton></TD>
				</TR>
			</TABLE>
			<cc1:bwimagebutton id="imgDesign" runat="server"></cc1:bwimagebutton></td>
		<td vAlign="top">
			<TABLE class="TableHeader" id="Table1" height="27" cellSpacing="0" cellPadding="0" width="100%"
				border="0" runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD>
                        <asp:Label ID="lblTechPackH" runat="server" ></asp:Label>
						<asp:textbox id="txtTechPackID" runat="server" Visible="False"></asp:textbox></TD>
				</TR>
			</TABLE>
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<TD vAlign="middle" align="center" width="10"></TD>
					<td height="25"><asp:label id="lblTechPack" runat="server"></asp:label></td>
				</tr>
			</table>
			<TABLE class="TableHeader" id="Table5" height="25" cellSpacing="0" cellPadding="0" width="100%"
				border="0" runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD> 
                        <asp:Label ID="lblSelectStyleH" runat="server" ></asp:Label><%= Me.strColorway %>...</TD>
				</TR>
			</TABLE>
			<table id="Table10" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<!--
								<asp:TemplateColumn>
									<ItemTemplate>
										&nbsp;
										<asp:Label id="lblRadio" runat="server"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								-->
					<td vAlign="top"><asp:datagrid id="dgStyleColor" runat="server" ForeColor="Transparent" ShowHeader="False" AutoGenerateColumns="False"
							PageSize="100" GridLines="Horizontal" BorderColor="White" BackColor="White" BorderStyle="None" BorderWidth="1px"
							CellPadding="0">
							<HeaderStyle CssClass="TableHeader"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn>
									<ItemTemplate>
										<asp:CheckBox id="cbStyleColorway" runat="server"></asp:CheckBox>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<%=strColorway%>
									</HeaderTemplate>
									<ItemTemplate>
										&nbsp;
										<asp:Label id="lblMainColor" runat="server" CssClass="fonthead"></asp:Label>
										<INPUT type="hidden" ID="txtStyleColorwayId" Runat="server">
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
							<PagerStyle HorizontalAlign="Right" ForeColor="Black" BackColor="White"></PagerStyle>
						</asp:datagrid></td>
				</tr>
			</table>
			<BR>
			<TABLE class="TableHeader" id="Table3" height="25" cellSpacing="0" cellPadding="0" width="100%"
				border="0" runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD>
                        <asp:Label ID="lblSelectStyleSet" runat="server" ></asp:Label>......</TD>
				</TR>
			</TABLE> <!--
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td width="25" height="35">&nbsp;</td>
					<td class="fontHead">Please select Style Set...
					</td>
				</tr>
			</table>-->
			<table id="Table11" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td vAlign="top"><asp:datagrid id="dgStyleSet" runat="server" ForeColor="Transparent" ShowHeader="False" AutoGenerateColumns="False"
							PageSize="100" GridLines="Horizontal" BorderColor="White" BackColor="White" BorderStyle="None" BorderWidth="1px"
							CellPadding="0">
							<HeaderStyle CssClass="TableHeader"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn>
									<ItemTemplate>
										<asp:CheckBox id="cbStyleSet" runat="server" Checked="TRUE"></asp:CheckBox>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										Style Set
									</HeaderTemplate>
									<ItemTemplate>
										&nbsp;
										<asp:Label id="lblStyleSet" runat="server" CssClass="fonthead"></asp:Label>
										<INPUT type="hidden" ID="txtStyleSet" Runat="server">
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<TABLE id="Table4" style="BORDER-TOP: gray thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: gainsboro"
	height="35" cellSpacing="0" cellPadding="0" width="100%" bgColor="gainsboro" border="0">
	<TR>
		<TD align="center" width="50">&nbsp;</TD>
		<TD align="center" width="500"><asp:imagebutton id="btnBack" runat="server" ></asp:imagebutton><asp:imagebutton id="btnSave" runat="server"></asp:imagebutton><asp:imagebutton id="btnNext" runat="server" ></asp:imagebutton></TD>
		<TD align="center">&nbsp;</TD>
	</TR>
</TABLE>
