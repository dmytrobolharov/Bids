<%@ Control Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Wizard_StyleSchedule.ascx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Wizard_StyleSchedule" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="../Style/Style_Header.ascx" %>
<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
	height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
	<tr>
		<td width="50" height="50">&nbsp;</td>
		<td class="fonthead">
			<P><FONT color="lightgrey">&nbsp;</FONT><FONT color="darkgray" size="3"><asp:Label ID="lblSelectStyleSchedule"
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
<table cellSpacing="0" cellPadding="0" width="100%" border="0">
	<tr>
		<td>
			<TABLE id="Table1" cellSpacing="1" cellPadding="1" width="100%" border="0">
				<TR>
					<TD width="10" height="25"></TD>
					<TD class="TableHeader" height="25">
						<DIV align="center">
                            <asp:Label ID="lblStyleSet" runat="server"></asp:Label></DIV>
					</TD>
					<TD class="TableHeader" height="25">
						<DIV align="center">
                            <asp:Label ID="lblSchedule" runat="server" ></asp:Label></DIV>
					</TD>
					<TD height="25"></TD>
				</TR>
				<TR>
					<TD width="10"></TD>
					<TD vAlign="top" width="250"><asp:listbox id="lstStyleSet" AutoPostBack="True" CssClass="fonthead" Width="250px" Height="250px"
							Runat="server"></asp:listbox></TD>
					<TD vAlign="top" width="400">
						<TABLE cellSpacing="1" cellPadding="1" width="448" border="0">
							<TR>
								<TD></TD>
								<TD><asp:label id="lblStartDate" runat="server" CssClass="fontHead"></asp:label></TD>
								<TD><asp:label id="lblEndDate" runat="server" CssClass="fontHead"></asp:label></TD>
								<TD><asp:label id="lblTemplate" runat="server" CssClass="fontHead"></asp:label></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD><asp:textbox id="txtStartDate" runat="server" Width="75px"></asp:textbox><A id="aStartDate" runat="server"><IMG height="17" src="../System/Icons/icon_calendar.gif" width="18" border="0"></A></TD>
								<TD><asp:textbox id="txtEndDate" runat="server" Width="75px"></asp:textbox><A id="aEndDate" runat="server"><IMG height="17" src="../System/Icons/icon_calendar.gif" width="18" border="0"></A></TD>
								<TD><asp:dropdownlist id="dplTemplate" runat="server" AutoPostBack="True"></asp:dropdownlist></TD>
							</TR>
						</TABLE>
						<TABLE cellSpacing="1" cellPadding="1" width="500" border="0">
							<TR>
								<TD class="fontHead" width="75">
                                    <asp:Label ID="lblScheduleBy" runat="server"></asp:Label>
								</TD>
								<TD><asp:radiobuttonlist id="rbSubmitType" runat="server" CssClass="fontHead" RepeatDirection="Horizontal">
							
									</asp:radiobuttonlist></TD>
							</TR>
						</TABLE>
						<asp:datagrid id="DataGrid1" runat="server" Width="600px" BorderStyle="Solid" AutoGenerateColumns="False"
							PageSize="100" BorderWidth="1px" BorderColor="#E0E0E0">
							<AlternatingItemStyle CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle CssClass="ItemTemplate"></ItemStyle>
							<Columns>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
                                        <asp:Label ID="lblProcess" runat="server"><%#GetSystemText("Process")%></asp:Label>
                                                                                      
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblWorkflow" runat="server">
											<INPUT id="Hidden1" type="hidden" runat="server" NAME="txtWorkflow"></asp:Label><INPUT id="txtWorkflow" type="hidden" runat="server" NAME="txtWorkflow">
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="50px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label ID="lblSubmitDays" runat="server"><%#GetSystemText("Submit Days")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtSubmitDays" runat="server" Width="50px" MaxLength="5"></asp:TextBox>
										<asp:RequiredFieldValidator id="rvSubmitDays" runat="server" CssClass="fontHead" ErrorMessage="*" ControlToValidate="txtSubmitDays"
											ToolTip="Enter Submit Days..." Display="Dynamic">*</asp:RequiredFieldValidator>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="75px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label ID="lblResubmitDays" runat="server"><%#GetSystemText("Resubmit Days")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtResubmitDays" runat="server" Width="50px" MaxLength="5"></asp:TextBox>
										<asp:RequiredFieldValidator id="rvResubmitDays" runat="server" CssClass="fontHead" ErrorMessage="*" ControlToValidate="txtResubmitDays"
											ToolTip='<%#GetSystemText("Enter Resubmit Days") %>...' Display="Dynamic">*</asp:RequiredFieldValidator>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="75px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label ID="lblAssignedTo" runat="server"><%#GetSystemText("Assigned To")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:DropDownList id="dlAssignedTo" runat="server"></asp:DropDownList>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="125px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label ID="lblDueDate" runat="server"><%#GetSystemText("Due Date")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtDueDate" runat="server" Width="75px" MaxLength="10" Enabled="false" ></asp:TextBox>
									</ItemTemplate>
								</asp:TemplateColumn>
								
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="125px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate><asp:Label ID="lblFinalDateH" runat="server"><%#GetSystemText("Final Date")%></asp:Label></HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtFinalDate" runat="server" Width="75px" MaxLength="10" Enabled="true" ReadOnly="true"></asp:TextBox><asp:Label ID="lblLink" runat="server" 
										></asp:Label><input type="hidden" runat="server" id="hdnFinalDate" />
									</ItemTemplate>
								</asp:TemplateColumn>	
								
							</Columns>
						</asp:datagrid></TD>
					<TD></TD>
				</TR>
			</TABLE>
		</td>
	</tr>
</table>
<TABLE style="BORDER-TOP: gray thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: gainsboro"
	height="35" cellSpacing="0" cellPadding="0" width="100%" bgColor="gainsboro" border="0">
	<TR>
		<TD align="center" width="50">&nbsp;</TD>
		<TD align="center" width="500"><asp:imagebutton id="btnBack" runat="server"></asp:imagebutton><asp:imagebutton id="btnSave" runat="server"></asp:imagebutton><asp:imagebutton id="btnNext" runat="server" ></asp:imagebutton></TD>
		<TD align="center">&nbsp;</TD>
	</TR>
</TABLE>
