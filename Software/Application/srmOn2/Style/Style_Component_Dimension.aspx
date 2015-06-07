<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_Component_Dimension.aspx.vb" Inherits="srmOnApp.Style_Component_Dimension" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow" Src="Style_Workflow.ascx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title runat="server" id="PageTitle">Style</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />    
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <uc1:style_workflow id="Style_Workflow1" runat="server"></uc1:style_workflow>
	    <uc2:style_header id="Style_Header1" runat="server" StyleID='<%Request("SID")%>'/>
	    <uc1:style_comment id="Style_Comment1" runat="server" />

			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr bgColor="#ffffff">
					<td vAlign="top" width="400"><asp:datagrid id="DataGrid1" runat="server" BorderColor="Silver" BorderStyle="Solid" 
					    BorderWidth="1px" PageSize="100" AutoGenerateColumns="False" >
							<AlternatingItemStyle Height="20px" CssClass="font" BackColor="White"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							<HeaderStyle CssClass="fontHead" BackColor="WhiteSmoke"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn>
									<HeaderStyle CssClass="fontHead" VerticalAlign="Bottom"></HeaderStyle>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="100%" height="20" >
											<tr class="TableHeader">
												<td>
													<asp:Label id="lblHeaderMaterialNo" runat="server"><%#GetSystemText("Material No")%></asp:Label>
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
										<table cellpadding="0" cellspacing="0" border="0px" width="100%" height="20" >
											<tr class="TableHeader">
												<td>
													<asp:Label id="lblHeaderMaterialName" runat="server"><%#GetSystemText("Material Name")%></asp:Label>
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
										<table cellpadding="0" cellspacing="0" border="0px" width="100%" height="20" >
											<tr class="TableHeader">
												<td>
													<asp:Label id="lblHeaderSize" runat="server"><%#GetSystemText("Size")%></asp:Label>
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
										<table cellpadding="0" cellspacing="0" border="0px" width="100%" height="20" >
											<tr class="TableHeader">
												<td>
													<asp:Label id="lblHeaderQty" runat="server"><%#GetSystemText("Qty")%></asp:Label>
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
										<table cellpadding="0" cellspacing="0" border="0px" width="75" >
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize0"><div align="center">
														<asp:Label id="lblSize0" runat="server" /></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75" >
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA0" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize1"><div align="center">
														<asp:Label id="lblSize1" runat="server" /></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75" >
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA1" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<TABLE cellSpacing="0" cellPadding="0" width="75" border="0">
											<TR>
												<TD class="TableHeader" id="tdSize2" colSpan="2" runat="server">
													<DIV align="center">
														<asp:Label id="lblSize2" runat="server"></asp:Label></DIV>
												</TD>
											</TR>
										</TABLE>
									</HeaderTemplate>
									<ItemTemplate>
										<TABLE cellSpacing="0" cellPadding="0" width="75" border="0">
											<TR>
												<TD class="font" width="75">
													<asp:Label id="lblSizeA2" runat="server"></asp:Label>&nbsp;
												</TD>
											</TR>
										</TABLE>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize3"><div align="center">
														<asp:Label id="lblSize3" runat="server" /></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75" >
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA3" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize4"><div align="center">
														<asp:Label id="lblSize4" runat="server" /></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75" >
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA4" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize5"><div align="center">
														<asp:Label id="lblSize5" runat="server" /></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75" >
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA5" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize6"><div align="center">
														<asp:Label id="lblSize6" runat="server" /></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75" >
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA6" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize7"><div align="center">
														<asp:Label id="lblSize7" runat="server" /></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75" >
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA7" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize8"><div align="center">
														<asp:Label id="lblSize8" runat="server" /></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75" >
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA8" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize9"><div align="center">
														<asp:Label id="lblSize9" runat="server" /></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75" >
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA9" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize10"><div align="center">
														<asp:Label id="lblSize10" runat="server" /></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75" >
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA10" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize11"><div align="center">
														<asp:Label id="lblSize11" runat="server" /></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75" >
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA11" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize12"><div align="center">
														<asp:Label id="lblSize12" runat="server" /></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75" >
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA12" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize13"><div align="center">
														<asp:Label id="lblSize13" runat="server" /></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75" >
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA13" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize14"><div align="center">
														<asp:Label id="lblSize14" runat="server" /></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75" >
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA14" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize15"><div align="center">
														<asp:Label id="lblSize15" runat="server" /></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75" >
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA15" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize16"><div align="center">
														<asp:Label id="lblSize16" runat="server" /></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75" >
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA16" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize17"><div align="center">
														<asp:Label id="lblSize17" runat="server" /></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75" >
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA17" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize18"><div align="center">
														<asp:Label id="lblSize18" runat="server" /></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75" >
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA18" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75">
											<tr>
												<td colspan="2" class="TableHeader" runat="server" id="tdSize19"><div align="center">
														<asp:Label id="lblSize19" runat="server" /></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="0px" width="75" >
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA19" runat="server" />&nbsp;
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
</body>
</html>
