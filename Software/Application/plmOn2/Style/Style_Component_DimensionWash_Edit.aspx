<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow_Edit" Src="Style_Workflow_Edit.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Component_DimensionWash_Edit.aspx.vb" Inherits="plmOnApp.Style.Material.Style_Component_DimensionWash_Edit" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Style</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="400"><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnSummary" runat="server"  Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnSamplesize" runat="server" Message="Are you sure you want to change sample size?"
							 Visible="False" ToolTip="Change Sample Size..."></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton></td>
					<td class="FontHead" align="right" width="75"><asp:Label id="lblSelectSet" CssClass="FontHead" runat="server" />&nbsp;Select Set:</td>
					<td width="40"><asp:dropdownlist id="dpStyleSet" runat="server" AutoPostBack="true" DataValueField="ID" DataTextField="Value"
							CssClass="font"></asp:dropdownlist></td>
					<td><asp:imagebutton id="imgBtnGo" runat="server" ImageUrl="../System/Icons/icon_go.gif"></asp:imagebutton></td>
				</tr>
			</table>
			<uc1:style_workflow_edit id="Style_Workflow_Edit1" runat="server"></uc1:style_workflow_edit>
			<asp:panel id="pnlChange" runat="server">
			    <uc1:Style_Change_Alert id="Style_Change_Alert1" runat="server"></uc1:Style_Change_Alert>	
			</asp:panel>
			<uc2:style_header id=Style_Header1 runat="server" StyleID='<%Request("SID")%>'>
			</uc2:style_header>
			<table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
				</tr>
			</table>
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="top" width="300"><asp:datagrid id="DataGrid1" runat="server" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
							PageSize="100" AutoGenerateColumns="False" OnItemDataBound="ItemDataBoundEventHandler">
							<AlternatingItemStyle Height="20px" CssClass="font" BackColor="White"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							<HeaderStyle CssClass="fontHead" BackColor="WhiteSmoke"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn>
									<HeaderStyle CssClass="fontHead" VerticalAlign="Bottom"></HeaderStyle>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="100%" height="20" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr class="TableHeader">
												<td>
													<asp:Label id="lblHeaderMaterialNo" Text='<%#GetsystemText("Material No") %>' runat="server" />
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblMaterialNo" runat="server" Width="75"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle CssClass="fontHead" VerticalAlign="Bottom"></HeaderStyle>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="100%" height="20" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr class="TableHeader">
												<td>
													<asp:Label id="lblHeaderMaterialName" runat="server" width="150" Text='<%#GetsystemText("Material Name") %>' />
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblMaterialName" runat="server"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle CssClass="fontHead" VerticalAlign="Bottom"></HeaderStyle>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="100%" height="20" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr class="TableHeader">
												<td>
													<asp:Label id="lblHeaderSize" Text='<%#GetsystemText("Size") %>' runat="server" />
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblSize" runat="server" Width="75" />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle CssClass="fontHead" VerticalAlign="Bottom"></HeaderStyle>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="100%" height="20" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr class="TableHeader">
												<td>
													<asp:Label id="lblHeaderQty" Text='<%#GetsystemText("Qty") %>' runat="server" />
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblQty" runat="server" Width="75" />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="1px" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize0"><div align="center">
														<asp:Label id="lblSize0" runat="server" /></div>
												</td>
											</tr>
											<tr runat="server" id="trSize0">
												<td class="TableHeaderRed" width="75"><div align="center">BW</div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center">AW</div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeA0" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeB0" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="1" width="150" bordercolor="Gainsboro">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize1"><div align="center">
														<asp:Label id="lblSize1" runat="server" /></div>
												</td>
											</tr>
											<tr runat="server" id="trSize1">
												<td class="TableHeaderRed" width="70"><div align="center">BW</div>
												</td>
												<td class="TableHeaderGreen" width="70"><div align="center">AW</div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeA1" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeB1" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table borderColor="gainsboro" cellspacing="0" cellpadding="0" width="150" border="1">
											<tr>
												<td class="TableHeader" id="tdSize2" colSpan="2" runat="server">
													<DIV align="center">
														<asp:Label id="lblSize2" runat="server"></asp:Label></DIV>
												</td>
											</tr>
											<tr id="trSize2" runat="server">
												<td class="TableHeaderRed" width="75">
													<DIV align="center">BW</DIV>
												</td>
												<td class="TableHeaderGreen" width="75">
													<DIV align="center">AW</DIV>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeA2" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeB2" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="1" width="150" bordercolor="Gainsboro">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize3"><div align="center">
														<asp:Label id="lblSize3" runat="server" /></div>
												</td>
											</tr>
											<tr runat="server" id="trSize3">
												<td class="TableHeaderRed" width="75"><div align="center">BW</div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center">AW</div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeA3" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeB3" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="1" width="150" bordercolor="Gainsboro">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize4"><div align="center">
														<asp:Label id="lblSize4" runat="server" /></div>
												</td>
											</tr>
											<tr runat="server" id="trSize4">
												<td class="TableHeaderRed" width="75"><div align="center">BW</div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center">AW</div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeA4" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeB4" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="1" width="150" bordercolor="Gainsboro">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize5"><div align="center">
														<asp:Label id="lblSize5" runat="server" /></div>
												</td>
											</tr>
											<tr runat="server" id="trSize5">
												<td class="TableHeaderRed" width="75"><div align="center">BW</div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center">AW</div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeA5" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeB5" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="1" width="150" bordercolor="Gainsboro">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize6"><div align="center">
														<asp:Label id="lblSize6" runat="server" /></div>
												</td>
											</tr>
											<tr runat="server" id="trSize6">
												<td class="TableHeaderRed" width="75"><div align="center">BW</div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center">AW</div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeA6" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeB6" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="1" width="150" bordercolor="Gainsboro">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize7"><div align="center">
														<asp:Label id="lblSize7" runat="server" /></div>
												</td>
											</tr>
											<tr runat="server" id="trSize7">
												<td class="TableHeaderRed" width="75"><div align="center">BW</div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center">AW</div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeA7" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeB7" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="1" width="150" bordercolor="Gainsboro">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize8"><div align="center">
														<asp:Label id="lblSize8" runat="server" /></div>
												</td>
											</tr>
											<tr runat="server" id="trSize8">
												<td class="TableHeaderRed" width="75"><div align="center">BW</div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center">AW</div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeA8" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeB8" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="1" width="150" bordercolor="Gainsboro">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize9"><div align="center">
														<asp:Label id="lblSize9" runat="server" /></div>
												</td>
											</tr>
											<tr runat="server" id="trSize9">
												<td class="TableHeaderRed" width="75"><div align="center">BW</div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center">AW</div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeA9" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeB9" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="1" width="150" bordercolor="Gainsboro">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize10"><div align="center">
														<asp:Label id="lblSize10" runat="server" /></div>
												</td>
											</tr>
											<tr runat="server" id="trSize10">
												<td class="TableHeaderRed" width="75"><div align="center">BW</div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center">AW</div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeA10" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeB10" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="1" width="150" bordercolor="Gainsboro">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize11"><div align="center">
														<asp:Label id="lblSize11" runat="server" /></div>
												</td>
											</tr>
											<tr runat="server" id="trSize11">
												<td class="TableHeaderRed" width="75"><div align="center">BW</div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center">AW</div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeA11" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeB11" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="1" width="150" bordercolor="Gainsboro">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize12"><div align="center">
														<asp:Label id="lblSize12" runat="server" /></div>
												</td>
											</tr>
											<tr runat="server" id="trSize12">
												<td class="TableHeaderRed" width="75"><div align="center">BW</div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center">AW</div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeA12" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeB12" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="1" width="150" bordercolor="Gainsboro">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize13"><div align="center">
														<asp:Label id="lblSize13" runat="server" /></div>
												</td>
											</tr>
											<tr runat="server" id="trSize13">
												<td class="TableHeaderRed" width="75"><div align="center">BW</div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center">AW</div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeA13" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeB13" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="1" width="150" bordercolor="Gainsboro">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize14"><div align="center">
														<asp:Label id="lblSize14" runat="server" /></div>
												</td>
											</tr>
											<tr runat="server" id="trSize14">
												<td class="TableHeaderRed" width="75"><div align="center">BW</div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center">AW</div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeA14" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeB14" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="1" width="150" bordercolor="Gainsboro">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize15"><div align="center">
														<asp:Label id="lblSize15" runat="server" /></div>
												</td>
											</tr>
											<tr runat="server" id="trSize15">
												<td class="TableHeaderRed" width="75"><div align="center">BW</div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center">AW</div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeA15" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeB15" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="1" width="150" bordercolor="Gainsboro">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize16"><div align="center">
														<asp:Label id="lblSize16" runat="server" /></div>
												</td>
											</tr>
											<tr runat="server" id="trSize16">
												<td class="TableHeaderRed" width="75"><div align="center">BW</div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center">AW</div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeA16" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeB16" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="1" width="150" bordercolor="Gainsboro">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize17"><div align="center">
														<asp:Label id="lblSize17" runat="server" /></div>
												</td>
											</tr>
											<tr runat="server" id="trSize17">
												<td class="TableHeaderRed" width="75"><div align="center">BW</div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center">AW</div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeA17" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeB17" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="1" width="150" bordercolor="Gainsboro">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize18"><div align="center">
														<asp:Label id="lblSize18" runat="server" /></div>
												</td>
											</tr>
											<tr runat="server" id="trSize18">
												<td class="TableHeaderRed" width="75"><div align="center">BW</div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center">AW</div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeA18" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeB18" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="1" width="150" bordercolor="Gainsboro">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize19"><div align="center">
														<asp:Label id="lblSize19" runat="server" /></div>
												</td>
											</tr>
											<tr runat="server" id="trSize19">
												<td class="TableHeaderRed" width="75"><div align="center">BW</div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center">AW</div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeA19" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:TextBox Width="70" id="lblSizeB19" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
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
		<table id="Table5" height="24" cellspacing="0" cellpadding="0" width="100%" border="0"
			runat="server">
			<tr valign="middle">
				<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_left.gif"></td>
				<td class="TableBar" valign="middle" align="center" width="20"><IMG src="../System/icons/icon_changeobject.gif"></td>
				<td class="TableBar"><asp:label id="lblCreatedBy" runat="server" CssClass="fontHead" ForeColor="Gray"></asp:label>&nbsp;/
					<asp:label id="lblModifiedBy" runat="server" CssClass="fontHead"></asp:label></td>
				<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_right.gif"></td>
			</tr>
		</table>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</html>
