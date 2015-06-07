<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_Component_DimensionWash.aspx.vb" Inherits="srmOnApp.Style_Component_DimensionWash" %>
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
					<td vAlign="top" width="400"><asp:datagrid id="DataGrid1" runat="server" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
							PageSize="100" AutoGenerateColumns="False" >
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
													<asp:label id="lblHeaderMaterialNo" runat="server"><%#GetSystemText("Material No")%></asp:label>
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
													<asp:label id="lblHeaderMaterialName" runat="server"><%#GetSystemText("Material Name")%></asp:label>
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
													<asp:label id="lblHeaderSize" runat="server"><%#GetSystemText("Size")%></asp:label>
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
													<asp:label id="lblHeaderQty" runat="server"><%#GetSystemText("Qty")%></asp:label>
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
												<td class="TableHeaderRed" width="75"><div align="center"><asp:label id="lblSize0BW" runat="server"><%#GetSystemText("BW")%></asp:label></div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center"><asp:label id="lblSize0AW" runat="server"><%#GetSystemText("AW")%></asp:label></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="1px" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA0" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:Label id="lblSizeB0" runat="server" />&nbsp;
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
												<td class="TableHeaderRed" width="75"><div align="center"><asp:label id="lblSize1BW" runat="server"><%#GetSystemText("BW")%></asp:label></div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center"><asp:label id="lblSize1AW" runat="server"><%#GetSystemText("AW")%></asp:label></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="1px" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA1" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:Label id="lblSizeB1" runat="server" />&nbsp;
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<TABLE borderColor="gainsboro" cellSpacing="0" cellPadding="0" width="150" border="1">
											<TR>
												<TD class="TableHeader" id="tdSize2" colSpan="2" runat="server">
													<DIV align="center">
														<asp:Label id="lblSize2" runat="server"></asp:Label></DIV>
												</TD>
											</TR>
											<TR id="trSize2" runat="server">
												<TD class="TableHeaderRed" width="75">
													<DIV align="center"><asp:label id="lblSize2BW" runat="server"><%#GetSystemText("BW")%></asp:label></DIV>
												</TD>
												<TD class="TableHeaderGreen" width="75">
													<DIV align="center"><asp:label id="lblSize2AW" runat="server"><%#GetSystemText("AW")%></asp:label></DIV>
												</TD>
											</TR>
										</TABLE>
									</HeaderTemplate>
									<ItemTemplate>
										<TABLE style="BORDER-RIGHT: silver 1px solid; BORDER-TOP: silver 1px solid; BORDER-LEFT: silver 1px solid; BORDER-BOTTOM: silver 1px solid; BORDER-COLLAPSE: collapse"
											cellSpacing="0" cellPadding="0" width="150" border="1">
											<TR>
												<TD class="font" width="75">
													<asp:Label id="lblSizeA2" runat="server"></asp:Label>&nbsp;
												</TD>
												<TD class="font" width="75">
													<asp:Label id="lblSizeB2" runat="server"></asp:Label>&nbsp;
												</TD>
											</TR>
										</TABLE>
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
												<td class="TableHeaderRed" width="75"><div align="center"><asp:label id="lblSize3BW" runat="server"><%#GetSystemText("BW")%></asp:label></div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center"><asp:label id="lblSize3AW" runat="server"><%#GetSystemText("AW")%></asp:label></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="1px" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA3" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:Label id="lblSizeB3" runat="server" />&nbsp;
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
												<td class="TableHeaderRed" width="75"><div align="center"><asp:label id="lblSize4BW" runat="server"><%#GetSystemText("BW")%></asp:label></div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center"><asp:label id="lblSize4AW" runat="server"><%#GetSystemText("AW")%></asp:label></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="1px" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA4" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:Label id="lblSizeB4" runat="server" />&nbsp;
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
												<td class="TableHeaderRed" width="75"><div align="center"><asp:label id="lblSize5BW" runat="server"><%#GetSystemText("BW")%></asp:label></div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center"><asp:label id="lblSize5AW" runat="server"><%#GetSystemText("AW")%></asp:label></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="1px" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA5" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:Label id="lblSizeB5" runat="server" />&nbsp;
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
												<td class="TableHeaderRed" width="75"><div align="center"><asp:label id="lblSize6BW" runat="server"><%#GetSystemText("BW")%></asp:label></div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center"><asp:label id="lblSize6AW" runat="server"><%#GetSystemText("AW")%></asp:label></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="1px" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA6" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:Label id="lblSizeB6" runat="server" />&nbsp;
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
												<td class="TableHeaderRed" width="75"><div align="center"><asp:label id="lblSize7BW" runat="server"><%#GetSystemText("BW")%></asp:label></div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center"><asp:label id="lblSize7AW" runat="server"><%#GetSystemText("AW")%></asp:label></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="1px" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA7" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:Label id="lblSizeB7" runat="server" />&nbsp;
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
												<td class="TableHeaderRed" width="75"><div align="center"><asp:label id="lblSize8BW" runat="server"><%#GetSystemText("BW")%></asp:label></div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center"><asp:label id="lblSize8AW" runat="server"><%#GetSystemText("AW")%></asp:label></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="1px" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA8" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:Label id="lblSizeB8" runat="server" />&nbsp;
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
												<td class="TableHeaderRed" width="75"><div align="center"><asp:label id="lblSize9BW" runat="server"><%#GetSystemText("BW")%></asp:label></div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center"><asp:label id="lblSize9AW" runat="server"><%#GetSystemText("AW")%></asp:label></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="1px" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA9" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:Label id="lblSizeB9" runat="server" />&nbsp;
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
												<td class="TableHeaderRed" width="75"><div align="center"><asp:label id="lblSize10BW" runat="server"><%#GetSystemText("BW")%></asp:label></div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center"><asp:label id="lblSize10AW" runat="server"><%#GetSystemText("AW")%></asp:label></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="1px" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA10" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:Label id="lblSizeB10" runat="server" />&nbsp;
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
												<td class="TableHeaderRed" width="75"><div align="center"><asp:label id="lblSize11BW" runat="server"><%#GetSystemText("BW")%></asp:label></div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center"><asp:label id="lblSize11AW" runat="server"><%#GetSystemText("AW")%></asp:label></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="1px" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA11" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:Label id="lblSizeB11" runat="server" />&nbsp;
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
												<td class="TableHeaderRed" width="75"><div align="center"><asp:label id="lblSize12BW" runat="server"><%#GetSystemText("BW")%></asp:label></div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center"><asp:label id="lblSize12AW" runat="server"><%#GetSystemText("AW")%></asp:label></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="1px" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA12" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:Label id="lblSizeB12" runat="server" />&nbsp;
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
												<td class="TableHeaderRed" width="75"><div align="center"><asp:label id="lblSize13BW" runat="server"><%#GetSystemText("BW")%></asp:label></div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center"><asp:label id="lblSize13AW" runat="server"><%#GetSystemText("AW")%></asp:label></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="1px" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA13" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:Label id="lblSizeB13" runat="server" />&nbsp;
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
												<td class="TableHeaderRed" width="75"><div align="center"><asp:label id="lblSize14BW" runat="server"><%#GetSystemText("BW")%></asp:label></div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center"><asp:label id="lblSize14AW" runat="server"><%#GetSystemText("AW")%></asp:label></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="1px" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA14" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:Label id="lblSizeB14" runat="server" />&nbsp;
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
												<td class="TableHeaderRed" width="75"><div align="center"><asp:label id="lblSize15BW" runat="server"><%#GetSystemText("BW")%></asp:label></div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center"><asp:label id="lblSize15AW" runat="server"><%#GetSystemText("AW")%></asp:label></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="1px" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA15" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:Label id="lblSizeB15" runat="server" />&nbsp;
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
												<td class="TableHeaderRed" width="75"><div align="center"><asp:label id="lblSize16BW" runat="server"><%#GetSystemText("BW")%></asp:label></div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center"><asp:label id="lblSize16AW" runat="server"><%#GetSystemText("AW")%></asp:label></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="1px" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA16" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:Label id="lblSizeB16" runat="server" />&nbsp;
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
												<td class="TableHeaderRed" width="75"><div align="center"><asp:label id="lblSize17BW" runat="server"><%#GetSystemText("BW")%></asp:label></div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center"><asp:label id="lblSize17AW" runat="server"><%#GetSystemText("AW")%></asp:label></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="1px" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA17" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:Label id="lblSizeB17" runat="server" />&nbsp;
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
												<td class="TableHeaderRed" width="75"><div align="center"><div align="center"><asp:label id="lblSize18BW" runat="server"><%#GetSystemText("BW")%></asp:label></div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center"><asp:label id="lblSize18AW" runat="server"><%#GetSystemText("AW")%></asp:label></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="1px" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA18" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:Label id="lblSizeB18" runat="server" />&nbsp;
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
												<td class="TableHeaderRed" width="75"><div align="center"><asp:label id="lblSize19BW" runat="server"><%#GetSystemText("BW")%></asp:label></div>
												</td>
												<td class="TableHeaderGreen" width="75"><div align="center"><asp:label id="lblSize19AW" runat="server"><%#GetSystemText("AW")%></asp:label></div>
												</td>
											</tr>
										</table>
									</HeaderTemplate>
									<ItemTemplate>
										<table cellpadding="0" cellspacing="0" border="1px" width="150" style="border-color:Silver;border-width:1px;border-style:Solid;border-collapse:collapse;">
											<tr>
												<td class="font" width="75">
													<asp:Label id="lblSizeA19" runat="server" />&nbsp;
												</td>
												<td class="font" width="75">
													<asp:Label id="lblSizeB19" runat="server" />&nbsp;
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
