<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow" Src="Style_Workflow.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Component1.aspx.vb" Inherits="plmOnApp.Style.Material.Style_Component1" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Style</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<uc1:style_workflow id="Style_Workflow1" runat="server"></uc1:style_workflow><uc2:style_header id=Style_Header1 runat="server" StyleID='<%Request("SID")%>'>
			</uc2:style_header>
			<table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
				</tr>
			</table>
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr bgColor="#ffffff">
					<td valign="top"><asp:datagrid id="dgComponent" runat="server" BorderColor="Silver" AutoGenerateColumns="false"
							ShowHeader="False" Width="100%">
							<Columns>
								<asp:TemplateColumn>
									<ItemTemplate>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr class="TableHeader">
												<td width="10" height="24" bgColor="white"></td>
												<td class="fontHead" bgColor="white"><%# DataBinder.Eval(Container.DataItem, "ComponentDescription") %></td>
											</tr>
										</table>
										<asp:datagrid id=DataGrid1 runat="server" PageSize="100" AutoGenerateColumns="False" ShowHeader="False" EnableViewState="False" Width="100%" CssClass="CodeBlock" OnItemDataBound="ItemDataBoundEventHandler" DataSource='<%#MaterialDataSource(DataBinder.Eval(Container.DataItem, "ComponentTypeID"))%>'>
											<Columns>
												<asp:TemplateColumn>
													<ItemTemplate>
														<table bgColor="Silver" cellspacing="1" cellpadding="1" width="100%" border="0">
															<tr id="TR1" runat="server">
																<td width="200" bgColor="#ffffff">
																	<table cellspacing="0" cellpadding="0" width="100%" border="0">
																		<tr>
																			<td class="fontHead" width="100"><%#GetSystemText("Material Code")%>:</td>
																			<td>&nbsp;
																				<asp:Label id="lblMaterialNo" runat="server"></asp:Label></td>
																		</tr>
																	</table>
																</td>
																<td width="300" bgColor="#ffffff">
																	<table cellspacing="0" cellpadding="0" width="100%" border="0">
																		<tr>
																			<td class="fontHead" width="75"><%#GetSystemText("Description")%>:</td>
																			<td>&nbsp;
																				<asp:Label id="lblMaterialName" runat="server"></asp:Label></td>
																		</tr>
																	</table>
																</td>
																<td bgColor="#ffffff">
																	<table cellspacing="0" cellpadding="0" width="100%" border="0">
																		<tr>
																			<td class="fontHead" width="100"><%#GetSystemText("Qty")%>:</td>
																			<td>&nbsp;
																				<asp:Label id="lblQty" runat="server"></asp:Label></td>
																		</tr>
																	</table>
																</td>
																<td rowspan="4" bgColor="#ffffff" width="100"><IMG id="imgMaterial" runat="server"></td>
															</tr>
															<tr id="TR2" runat="server">
																<td width="200" bgColor="#ffffff">
																	<table cellspacing="0" cellpadding="0" width="100%" border="0">
																		<tr>
																			<td class="fontHead" width="100"><%#GetSystemText("Const./# of Ends")%>:</td>
																			<td>&nbsp;
																				<asp:Label id="lblE" runat="server"></asp:Label></td>
																		</tr>
																	</table>
																</td>
																<td width="300" bgColor="#ffffff">
																	<table cellspacing="0" cellpadding="0" width="100%" border="0">
																		<tr>
																			<td class="fontHead" width="75"><%#GetSystemText("Content")%>:</td>
																			<td>&nbsp;
																				<asp:Label id="lblA" runat="server"></asp:Label></td>
																		</tr>
																	</table>
																</td>
																<td bgColor="#ffffff">
																	<table cellspacing="0" cellpadding="0" width="100%" border="0">
																		<tr>
																			<td class="fontHead" width="100"><%#GetSystemText("Weight")%>:</td>
																			<td>&nbsp;
																				<asp:Label id="lblZ" runat="server"></asp:Label></td>
																		</tr>
																	</table>
																</td>
															</tr>
															<tr id="TR3" runat="server">
																<td width="200" bgColor="#ffffff">
																	<table cellspacing="0" cellpadding="0" width="100%" border="0">
																		<tr>
																			<td class="fontHead" width="100"><%#GetSystemText("Yarn Size/Count")%>:</td>
																			<td>&nbsp;
																				<asp:Label id="lblC" runat="server"></asp:Label></td>
																		</tr>
																	</table>
																</td>
																<td width="300" bgColor="#ffffff">
																	<table cellspacing="0" cellpadding="0" width="100%" border="0">
																		<tr>
																			<td class="fontHead" width="75"><%#GetSystemText("Gauge")%>:</td>
																			<td>&nbsp;
																				<asp:Label id="lblB" runat="server"></asp:Label></td>
																		</tr>
																	</table>
																</td>
																<td bgColor="#ffffff">
																	<table cellspacing="0" cellpadding="0" width="100%" border="0">
																		<tr>
																			<td class="fontHead" width="100"><%#GetSystemText("Finish")%>:</td>
																			<td>&nbsp;
																				<asp:Label id="lblH" runat="server"></asp:Label></td>
																		</tr>
																	</table>
																</td>
															</tr>
															<tr bgColor="#ffffff">
																<td class="fontHead" width="100"><%#GetSystemText("Placement")%>:</td>
																<td colspan="2">&nbsp;
																	<asp:Label id="lblPlacement" runat="server"></asp:Label></td>
															</tr>
															<tr bgColor="#ffffff" id="TRA" runat="server">
																<td colspan="3">&nbsp;</td>
															</tr>
															<tr bgColor="#ffffff" id="TRB" runat="server">
																<td colspan="3">&nbsp;</td>
															</tr>
														</table>
													</ItemTemplate>
												</asp:TemplateColumn>
											</Columns>
										</asp:datagrid>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid></td>
					<td valign="top"></td>
				</tr>
			</table>
		</form>
	</body>
</html>
