<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Component1.aspx.vb" Inherits="srmOnApp.Style_Component1" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow" Src="Style_Workflow.ascx" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Style</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<uc1:style_workflow id="Style_Workflow1" runat="server"></uc1:style_workflow><uc2:style_header id=Style_Header1 runat="server" StyleID='<%Request("SID")%>'>
			</uc2:style_header>
			<table class="ToolbarShort" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr bgColor="#ffffff">
					<td vAlign="top"><asp:datagrid id="dgComponent" runat="server" BorderColor="Silver" AutoGenerateColumns="false"
							ShowHeader="False" Width="100%">
							<Columns>
								<asp:TemplateColumn>
									<ItemTemplate>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr class="TableHeader">
												<TD width="10" height="24" bgColor="white"></TD>
												<TD class="fontHead" bgColor="white"><%# DataBinder.Eval(Container.DataItem, "ComponentDescription") %></TD>
											</tr>
										</table>
										<asp:datagrid id=DataGrid1 runat="server" PageSize="100" AutoGenerateColumns="False" ShowHeader="False" EnableViewState="False" Width="100%" CssClass="CodeBlock" OnItemDataBound="ItemDataBoundEventHandler" DataSource='<%#MaterialDataSource(DataBinder.Eval(Container.DataItem, "ComponentTypeID"))%>'>
											<Columns>
												<asp:TemplateColumn>
													<ItemTemplate>
														<TABLE bgColor="Silver" cellSpacing="1" cellPadding="1" width="100%" border="0">
															<TR id="TR1" runat="server">
																<TD width="200" bgColor="#ffffff">
																	<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
																		<TR>
																			<TD class="fontHead" width="100"><asp:label id="lblAddress" runat="server"><%#GetSystemText("Material Code")%>:</asp:label></TD>
																			<TD>&nbsp;
																				<asp:Label id="lblMaterialNo" runat="server"></asp:Label></TD>
																		</TR>
																	</TABLE>
																</TD>
																<TD width="300" bgColor="#ffffff">
																	<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
																		<TR>
																			<TD class="fontHead" width="75"><asp:label id="Label1" runat="server"><%#GetSystemText("Description")%></asp:label></TD>
																			<TD>&nbsp;
																				<asp:Label id="lblMaterialName" runat="server"></asp:Label></TD>
																		</TR>
																	</TABLE>
																</TD>
																<TD bgColor="#ffffff">
																	<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
																		<TR>
																			<TD class="fontHead" width="100"><asp:label id="Label2" runat="server"><%#GetSystemText("Qty")%>:</asp:label></TD>
																			<TD>&nbsp;
																				<asp:Label id="lblQty" runat="server"></asp:Label></TD>
																		</TR>
																	</TABLE>
																</TD>
																<TD rowspan="4" bgColor="#ffffff" width="100"><IMG id="imgMaterial" runat="server"></TD>
															</TR>
															<TR id="TR2" runat="server">
																<TD width="200" bgColor="#ffffff">
																	<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
																		<TR>
																			<TD class="fontHead" width="100"><asp:label id="Label3" runat="server"><%#GetSystemText("Const.")%>/<%#GetSystemText("# of Ends")%>:</asp:label></TD>
																			<TD>&nbsp;
																				<asp:Label id="lblE" runat="server"></asp:Label></TD>
																		</TR>
																	</TABLE>
																</TD>
																<TD width="300" bgColor="#ffffff">
																	<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
																		<TR>
																			<TD class="fontHead" width="75"><asp:label id="Label4" runat="server"><%#GetSystemText("Content")%>:</asp:label></TD>
																			<TD>&nbsp;
																				<asp:Label id="lblA" runat="server"></asp:Label></TD>
																		</TR>
																	</TABLE>
																</TD>
																<TD bgColor="#ffffff">
																	<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
																		<TR>
																			<TD class="fontHead" width="100"><asp:label id="Label5" runat="server"><%#GetSystemText("Weight")%>:</asp:label></TD>
																			<TD>&nbsp;
																				<asp:Label id="lblZ" runat="server"></asp:Label></TD>
																		</TR>
																	</TABLE>
																</TD>
															</TR>
															<TR id="TR3" runat="server">
																<TD width="200" bgColor="#ffffff">
																	<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
																		<TR>
																			<TD class="fontHead" width="100"><asp:label id="Label6" runat="server"><%#GetSystemText("Yarn Size")%>/<%#GetSystemText("Count")%>:</asp:label></TD>
																			<TD>&nbsp;
																				<asp:Label id="lblC" runat="server"></asp:Label></TD>
																		</TR>
																	</TABLE>
																</TD>
																<TD width="300" bgColor="#ffffff">
																	<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
																		<TR>
																			<TD class="fontHead" width="75"><asp:label id="Label7" runat="server"><%#GetSystemText("Gauge")%>:</asp:label></TD>
																			<TD>&nbsp;
																				<asp:Label id="lblB" runat="server"></asp:Label></TD>
																		</TR>
																	</TABLE>
																</TD>
																<TD bgColor="#ffffff">
																	<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
																		<TR>
																			<TD class="fontHead" width="100"><asp:label id="Label8" runat="server"><%#GetSystemText("Finish")%>:</asp:label></TD>
																			<TD>&nbsp;
																				<asp:Label id="lblH" runat="server"></asp:Label></TD>
																		</TR>
																	</TABLE>
																</TD>
															</TR>
															<TR bgColor="#ffffff">
																<TD class="fontHead" width="100"><asp:label id="Label9" runat="server"><%#GetSystemText("Placement")%>:</asp:label></TD>
																<TD colspan="2">&nbsp;
																	<asp:Label id="lblPlacement" runat="server"></asp:Label></TD>
															</TR>
															<TR bgColor="#ffffff" id="TRA" runat="server">
																<TD colspan="3">&nbsp;</TD>
															</TR>
															<TR bgColor="#ffffff" id="TRB" runat="server">
																<TD colspan="3">&nbsp;</TD>
															</TR>
														</TABLE>
													</ItemTemplate>
												</asp:TemplateColumn>
											</Columns>
										</asp:datagrid>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid></td>
					<td vAlign="top"></td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
