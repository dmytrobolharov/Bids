<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Component_Edit.aspx.vb" Inherits="plmOnApp.Style.Material.Style_Component_Edit" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Style</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</head>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<table class="ToolbarTop" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="80"><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
					<td width="80"><cc1:confirmedimagebutton id="btnMaterial" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
					<td width="80"><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"
							></cc1:confirmedimagebutton></td>
					<td class="FontHead" align="right" width="75"><asp:Label id="lblSelectSet" CssClass="FontHead" runat="server" />&nbsp;Select Set:</td>
					<td width="40"><asp:dropdownlist id="dpStyleSet" runat="server" AutoPostBack="true" DataValueField="ID" DataTextField="Value"
							CssClass="font"></asp:dropdownlist></td>
					<td><asp:imagebutton id="imgBtnGo" runat="server" ImageUrl="../System/Icons/icon_go.gif"></asp:imagebutton></td>
				</tr>
			</table>
			<asp:panel id="pnlChange" runat="server">
				<uc1:Style_Change_Alert id="Style_Change_Alert1" runat="server"></uc1:Style_Change_Alert>
			</asp:panel><uc2:style_header id=Style_Header1 runat="server" StyleID='<%Request("SID")%>'>
			</uc2:style_header>
			<table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
				</tr>
			</table>
			<table id="Table1" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr bgColor="#ffffff">
					<td valign="top"><asp:datagrid id="dgComponent" runat="server" AutoGenerateColumns="false" BorderColor="Silver"
							Width="100%" ShowHeader="False" EnableViewState="True" CellPadding="1" cellspacing="0">
							<Columns>
								<asp:TemplateColumn>
									<ItemTemplate>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr class="TableHeader">
												<td width="10" height="24" bgColor="white"></td>
												<td class="fontHead" bgColor="white"><%# DataBinder.Eval(Container.DataItem, "ComponentDescription") %></td>
											</tr>
										</table>
										<asp:datagrid id=DataGrid1 runat="server" PageSize="100" AutoGenerateColumns="False" ShowHeader="False" EnableViewState="True" Width="100%" CssClass="CodeBlock" OnItemCommand="DataGrid1_ItemCommand" OnItemDataBound="DataGrid1_ItemEventArgs" DataSource='<%#MaterialDataSource(DataBinder.Eval(Container.DataItem, "ComponentTypeID"))%>' CellPadding="0" cellspacing="0">
											<Columns>
												<asp:TemplateColumn>
													<ItemTemplate>
														<table cellspacing="0" cellpadding="0" width="100%" bgColor="silver" border="0">
															<tr id="Tr1" runat="server">
																<td width="200" bgColor="#ffffff">
																	<table cellspacing="0" cellpadding="0" width="100%" border="0">
																		<tr>
																			<td class="fontHead" width="100"><%#GetSystemText("Material Code") & ":"%></td>
																			<td>
																				<asp:Label id="txtMaterialNo" runat="server" MaxLength="25"></asp:Label></td>
																		</tr>
																	</table>
																</td>
																<td width="280" bgColor="#ffffff">
																	<table cellspacing="0" cellpadding="0" width="100%" border="0">
																		<tr>
																			<td class="fontHead" width="100"><%#GetSystemText("Description")%></td>
																			<td>
																				<asp:Label id="txtMaterialname" runat="server" /></td>
																		</tr>
																	</table>
																</td>
																<td bgColor="#ffffff">
																	<table cellspacing="0" cellpadding="0" width="100%" border="0">
																		<tr>
																			<td class="fontHead" width="75"><%#GetSystemText("Qty") & ":"%></td>
																			<td>
																				<asp:TextBox id="txtQty" runat="server" Width="100" MaxLength="25"></asp:TextBox></td>
																		</tr>
																	</table>
																</td>
																<td width="100" bgColor="#ffffff" rowSpan="4">
																	<table cellspacing="0" cellpadding="0" width="100%" border="0">
																		<tr>
																			<td>
																				<cc1:confirmedimagebutton id="btnEditMaterial" runat="server"  Message="NONE"
																					CommandName="Edit"></cc1:confirmedimagebutton></td>
																		</tr>
																		<tr>
																			<td>
																				<DIV align="center"><IMG id="ImgMaterial" runat="server"></DIV>
																			</td>
																		</tr>
																	</table>
																</td>
															</tr>
															<tr id="Tr2" runat="server">
																<td width="200" bgColor="#ffffff">
																	<table cellspacing="0" cellpadding="0" width="100%" border="0">
																		<tr>
																			<td class="fontHead" width="100"><%#GetSystemText("Const./# of Ends") & ":"%></td>
																			<td>
																				<asp:Label id="txtE" runat="server" /></td>
																		</tr>
																	</table>
																</td>
																<td width="280" bgColor="#ffffff">
																	<table cellspacing="0" cellpadding="0" width="100%" border="0">
																		<tr>
																			<td class="fontHead" width="100"><%#GetSystemText("Content") & ":"%></td>
																			<td>
																				<asp:Label id="txtA" runat="server" /></td>
																		</tr>
																	</table>
																</td>
																<td bgColor="#ffffff">
																	<table cellspacing="0" cellpadding="0" width="100%" border="0">
																		<tr>
																			<td class="fontHead" width="75"><%#GetSystemText("Weight") & ":"%></td>
																			<td>
																				<asp:DropDownList id="dpWeight" runat="server"></asp:DropDownList></td>
																		</tr>
																	</table>
																</td>
															</tr>
															<tr id="TrA" bgColor="#ffffff" runat="server">
																<td width="200" bgColor="#ffffff">&nbsp;
																</td>
																<td width="280" bgColor="#ffffff">
																	<table cellspacing="0" cellpadding="0" width="100%" border="0">
																		<tr>
																			<td class="fontHead" width="100"><%#GetSystemText("Content") & ":"%></td>
																			<td>
																				<asp:Label id="txtA1" runat="server" /></td>
																		</tr>
																	</table>
																</td>
																<td bgColor="#ffffff">
																	<table cellspacing="0" cellpadding="0" width="100%" border="0">
																		<tr>
																			<td class="fontHead" width="75"><%#GetSystemText("Size") & ":"%></td>
																			<td>
																				<asp:DropDownList id="dpSize" runat="server"></asp:DropDownList></td>
																		</tr>
																	</table>
																</td>
															</tr>
															<tr id="Tr3" runat="server">
																<td width="200" bgColor="#ffffff">
																	<table cellspacing="0" cellpadding="0" width="100%" border="0">
																		<tr>
																			<td class="fontHead" width="100"><%#GetSystemText("Yarn Size/Count") & ":"%></td>
																			<td>
																				<asp:Label id="txtC" runat="server" /></td>
																		</tr>
																	</table>
																</td>
																<td width="280" bgColor="#ffffff">
																	<table cellspacing="0" cellpadding="0" width="100%" border="0">
																		<tr>
																			<td class="fontHead" width="100">Gauge:</td>
																			<td>
																				<asp:label id="txtB" runat="server" /></td>
																		</tr>
																	</table>
																</td>
																<td bgColor="#ffffff">
																	<table cellspacing="0" cellpadding="0" width="100%" border="0">
																		<tr>
																			<td class="fontHead" width="75"><%#GetSystemText("Finish") & ":"%></td>
																			<td>
																				<asp:Label id="txtH" runat="server" /></td>
																		</tr>
																	</table>
																</td>
															</tr>
															<tr bgColor="#ffffff">
																<td class="fontHead" colSpan="3">
																	<table cellspacing="0" cellpadding="0" width="100%" border="0">
																		<tr>
																			<td class="fontHead" width="100"><%#GetSystemText("Placement") & ":"%></td>
																			<td>
																				<asp:TextBox id="txtPlacement" runat="server" Width="300" MaxLength="4000"></asp:TextBox></td>
																		</tr>
																	</table>
																</td>
															</tr>
															<tr id="TrB" bgColor="#ffffff" runat="server">
																<td colSpan="3">&nbsp;</td>
															</tr>
														</table>
														<INPUT id="txtMaterialID" type=hidden value='<%# DataBinder.Eval(Container.DataItem, "MaterialID") %>' name=txtMaterialID runat="server">
														<INPUT id=txtStyleMaterialID type=hidden value='<%# DataBinder.Eval(Container.DataItem, "StyleMaterialID") %>' name=txtStyleMaterialID runat="server">
														<INPUT id=txtMaterialType type=hidden value='<%# DataBinder.Eval(Container.DataItem, "MaterialType") %>' name=txtMaterialType runat="server">
													</ItemTemplate>
												</asp:TemplateColumn>
											</Columns>
										</asp:datagrid>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid></td>
				</tr>
			</table>
		</form>
		<script language="javascript">
		var frm = document.Form1 ;
		function CheckAll( checkAllBox )
		{
		var actVar = checkAllBox.checked ;
		for(i=0;i< frm.length;i++)
		{
			e=frm.elements[i];
			if ( e.type=='checkbox' && e.name.indexOf("chkDelete") != -1 )
			e.checked= actVar ;
		}
		}
		</script>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</html>
