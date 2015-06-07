<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Main.aspx.vb" Inherits="srmOnApp.Style_Main" %>
<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Main</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<meta http-equiv="content-type" content="text/html; charset=utf-8">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<table height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblStyleHeaderNew" runat="server" Font-Names="Tahoma,Verdana" Font-Size="XX-Large"
							ForeColor="#E0E0E0">Style</asp:label></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td width="900"><uc1:Style_Header id="Style_Header1" runat="server"></uc1:Style_Header></td>
					<td></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="900" bgColor="#ffffff" border="0">
				<TBODY>
					<tr>
						<td vAlign="top">
							<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
								<tr>
									<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
									<td class="fontHead">&nbsp;<asp:label id="lblTechPacks" runat="server">Tech Pack(s)</asp:label></td>
								</tr>
							</table>
							<asp:DataGrid id="dgTechPack" runat="server" ShowHeader="true" AutoGenerateColumns="False" Width="350px"
								OnItemDataBound="dlTechPack_ItemDataBound" BorderWidth="1px" BorderStyle="Solid" BorderColor="Silver"
								DataKeyField="TechPackId">
								<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
								<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
								<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
								<Columns>
									<asp:TemplateColumn>
										<ItemStyle Width="25px"></ItemStyle>
										<ItemTemplate>
											<div align="center">
												<asp:Image id="imgPdf" runat="server" ImageUrl="../System/Icons/icon_pdf.gif"></asp:Image>
											</div>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn>
						                <HeaderTemplate>
							                <asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("Tech Pack Name")%></asp:Label>
						                </HeaderTemplate>
										<ItemTemplate>
											<asp:Label id="lblTechPackName" runat="server" />
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn>
						                <HeaderTemplate>
							                <asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("Tech Pack Date")%></asp:Label>
						                </HeaderTemplate>
										<ItemTemplate>
											<asp:Label id="lblTechPackDate" runat="server" />
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn>
						                <HeaderTemplate>
							                <asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("Downloaded")%></asp:Label>
						                </HeaderTemplate>
										<ItemTemplate>
											<asp:Label id="lblTechpackDownload" runat="server" />
										</ItemTemplate>
									</asp:TemplateColumn>
								</Columns>
							</asp:DataGrid></td>
						<TD vAlign="top">
							<table cellSpacing="0" cellPadding="0" width="900" bgColor="#ffffff" border="0">
								<TBODY>
									<tr>
										<td vAlign="top">
											<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
												<tr>
													<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
													<td class="fontHead">&nbsp;<asp:label id="lblQuotes" runat="server">Quote(s)</asp:label></td>
												</tr>
											</table>
											<asp:DataGrid id="dgQuote" runat="server" DataKeyField="StyleQuoteItemId" BorderColor="Silver"
												BorderStyle="Solid" BorderWidth="1px" OnItemDataBound="dgQuote_ItemDataBound" Width="350px"
												AutoGenerateColumns="False" ShowHeader="true">
												<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
												<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
												<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
												<Columns>
													<asp:TemplateColumn>
														<ItemStyle Width="25px"></ItemStyle>
														<ItemTemplate>
															<div align="center">
																<asp:Image id="imgQuote" runat="server" ImageUrl="../System/Icons/icon_pdf.gif"></asp:Image>
															</div>
														</ItemTemplate>
													</asp:TemplateColumn>
													<asp:TemplateColumn>
						                                <HeaderTemplate>
							                                <asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("Quote Status")%></asp:Label>
						                                </HeaderTemplate>
														<ItemTemplate>
															<asp:Label id="lblQuoteStatus" runat="server" />
														</ItemTemplate>
													</asp:TemplateColumn>
                                                    <asp:TemplateColumn>
                                                        <HeaderTemplate>
                                                            <asp:Label runat="server" CssClass="fontHead" ID="label1"><%# GetSystemText("Quote No")%></asp:Label>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblQuoteNo" runat="server" />
                                                        </ItemTemplate>
                                                    </asp:TemplateColumn>
                                                    <asp:TemplateColumn>
                                                        <HeaderTemplate>
                                                            <asp:Label runat="server" CssClass="fontHead" ID="label1"><%# GetSystemText("Agent Name")%></asp:Label>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblQuoteAgentName" runat="server" />
                                                        </ItemTemplate>
                                                    </asp:TemplateColumn>
													<asp:TemplateColumn>
						                                <HeaderTemplate>
							                                <asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("Vendor Name")%></asp:Label>
						                                </HeaderTemplate>
														<ItemTemplate>
															<asp:Label id="lblQuoteVendorName" runat="server" />
														</ItemTemplate>
													</asp:TemplateColumn>
                                                    <asp:TemplateColumn>
                                                        <HeaderTemplate>
                                                            <asp:Label runat="server" CssClass="fontHead" ID="label1"><%# GetSystemText("Factory Name")%></asp:Label>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblQuoteFactoryName" runat="server" />
                                                        </ItemTemplate>
                                                    </asp:TemplateColumn>
													<asp:TemplateColumn>
						                                <HeaderTemplate>
							                                <asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("Quote Due Date")%></asp:Label>
						                                </HeaderTemplate>
														<ItemTemplate>
															<asp:Label id="lblQuoteDueDate" runat="server" />
														</ItemTemplate>
													</asp:TemplateColumn>
												</Columns>
											</asp:DataGrid></td>
                                            <TD vAlign="top">
							<table cellSpacing="0" cellPadding="0" width="900" bgColor="#ffffff" border="0">
								<TBODY>
									<tr>
										<td vAlign="top">
											<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
												<tr>
													<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
													<td class="fontHead">&nbsp;<asp:label id="lblCommitments" runat="server">Commitment(s)</asp:label></td>
												</tr>
											</table>
											<asp:DataGrid id="dgCommitment" runat="server" DataKeyField="SourcingCommitmentItemId" BorderColor="Silver"
												BorderStyle="Solid" BorderWidth="1px" OnItemDataBound="dgCommitment_ItemDataBound" Width="350px"
												AutoGenerateColumns="False" ShowHeader="true">
												<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
												<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
												<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
												<Columns>
													<asp:TemplateColumn>
														<ItemStyle Width="25px"></ItemStyle>
														<ItemTemplate>
															<div align="center">
																<asp:Image id="imgQuote" runat="server" ImageUrl="../System/Icons/icon_pdf.gif"></asp:Image>
															</div>
														</ItemTemplate>
													</asp:TemplateColumn>
													<asp:TemplateColumn>
						                                <HeaderTemplate>
							                                <asp:Label runat="server" CssClass="fontHead" ID="label1"><%# GetSystemText("Commitment Status")%></asp:Label>
						                                </HeaderTemplate>
														<ItemTemplate>
															<asp:Label id="lblQuoteStatus" runat="server" />
														</ItemTemplate>
													</asp:TemplateColumn>
                                                    <asp:TemplateColumn>
                                                        <HeaderTemplate>
                                                            <asp:Label runat="server" CssClass="fontHead" ID="label1"><%# GetSystemText("Commitment No")%></asp:Label>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblQuoteNo" runat="server" />
                                                        </ItemTemplate>
                                                    </asp:TemplateColumn>
                                                    <asp:TemplateColumn>
                                                        <HeaderTemplate>
                                                            <asp:Label runat="server" CssClass="fontHead" ID="label1"><%# GetSystemText("Agent Name")%></asp:Label>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblQuoteAgentName" runat="server" />
                                                        </ItemTemplate>
                                                    </asp:TemplateColumn>
													<asp:TemplateColumn>
						                                <HeaderTemplate>
							                                <asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("Vendor Name")%></asp:Label>
						                                </HeaderTemplate>
														<ItemTemplate>
															<asp:Label id="lblQuoteVendorName" runat="server" />
														</ItemTemplate>
													</asp:TemplateColumn>
                                                    <asp:TemplateColumn>
                                                        <HeaderTemplate>
                                                            <asp:Label runat="server" CssClass="fontHead" ID="label1"><%# GetSystemText("Factory Name")%></asp:Label>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblQuoteFactoryName" runat="server" />
                                                        </ItemTemplate>
                                                    </asp:TemplateColumn>
													<asp:TemplateColumn>
						                                <HeaderTemplate>
							                                <asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("Commitment Due Date")%></asp:Label>
						                                </HeaderTemplate>
														<ItemTemplate>
															<asp:Label id="lblQuoteDueDate" runat="server" />
														</ItemTemplate>
													</asp:TemplateColumn>
												</Columns>
											</asp:DataGrid></td>
										<TD vAlign="top">
											<table cellSpacing="0" cellPadding="0" width="900" bgColor="#ffffff" border="0">
												<tr>
													<td vAlign="top">
														<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
															<tr>
																<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
																<td class="fontHead">&nbsp;<asp:label id="lblAttachments" runat="server">Attachment(s)</asp:label></td>
															</tr>
														</table>
														<asp:DataGrid id="dgStyleDocument" runat="server" DataKeyField="StyleDocumentId" BorderColor="Silver"
															BorderStyle="Solid" BorderWidth="1px" OnItemDataBound="dgStyleDocument_ItemDataBound" Width="300px"
															AutoGenerateColumns="False" ShowHeader="true">
															<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
															<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
															<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
															<Columns>
																<asp:TemplateColumn>
																	<ItemStyle Width="25px"></ItemStyle>
																	<ItemTemplate>
																		<div align="center">
																			<asp:Image id="imgDoc" runat="server" ImageUrl="../System/Icons/icon_pdf.gif"></asp:Image>
																		</div>
																	</ItemTemplate>
																</asp:TemplateColumn>
																<asp:TemplateColumn>
						                                            <HeaderTemplate>
							                                            <asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("File Name")%></asp:Label>
						                                            </HeaderTemplate>
																	<ItemTemplate>
																		<asp:Label id="lblStyleDocumentName" runat="server" />
																	</ItemTemplate>
																</asp:TemplateColumn>
																<asp:TemplateColumn>
						                                            <HeaderTemplate>
							                                            <asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("File Date")%></asp:Label>
						                                            </HeaderTemplate>
																	<ItemTemplate>
																		<asp:Label id="lblStyleDocumentDate" runat="server" />
																	</ItemTemplate>
																</asp:TemplateColumn>
															</Columns>
														</asp:DataGrid></td>
												</tr>
											</table>
										</TD>
									</tr>
								</TBODY>
							</table>
						</TD>
					</tr>
				</TBODY>
			</table>
		</form>
	</body>
</HTML>
