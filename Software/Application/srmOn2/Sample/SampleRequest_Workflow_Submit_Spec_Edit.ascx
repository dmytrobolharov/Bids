<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Submit_Spec_Edit.ascx.vb" Inherits="srmOnApp.SampleRequest_Workflow_Submit_Spec_Edit" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="uc1" TagName="SampleRequest_Workflow_Submit_Comment" Src="SampleRequest_Workflow_Submit_Comment.ascx" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<TABLE id="Table3" cellSpacing="1" cellPadding="1" width="100%" bgColor="#ffffff" border="0">
	<TR>
		<TD vAlign="top" width="1%"><cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview><asp:placeholder id="phlStatus" runat="server"></asp:placeholder>
			<TABLE id="Table2" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR class="TableHeader">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD width="20"><asp:imagebutton id="imbBtnExpand" runat="server" ImageUrl="../System/Icons/icon_Next.gif"></asp:imagebutton><asp:imagebutton id="imgBtnCollapse" runat="server" ImageUrl="../System/Icons/icon_Down.gif"></asp:imagebutton></TD>
					<TD class="fontHead"><asp:label id="lblHeaderSpec" runat="server"></asp:label>&nbsp;
						<asp:label id="txtSampleSize" runat="server"></asp:label></TD>
				</TR>
			</TABLE>
			<asp:panel id="Panel1" runat="server">
				<TABLE cellSpacing="1" cellPadding="1" border="0">
					<TR>
						<TD vAlign="top">
							<TABLE cellSpacing="0" cellPadding="0" border="0">
								<TR>
									<TD>&nbsp;</TD>
								</TR>
							</TABLE>
							<TABLE height="26" cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TR>
									<TD vAlign="bottom">
										<cc2:YSTabView id="YSTabView2" runat="server"></cc2:YSTabView></TD>
								</TR>
							</TABLE>
							<asp:datagrid id="DataGrid1" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
								PageSize="100" AutoGenerateColumns="False" Width="550px">
								<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
								<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
								<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
								<Columns>
									<asp:TemplateColumn>
										<HeaderTemplate>
											&nbsp;
										</HeaderTemplate>
										<ItemTemplate>
											&nbsp;
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn>
										<HeaderTemplate>
											<div align="center">
												<asp:Label id="lblHeaderPOM" runat="server"><%#GetSystemText("POM")%></asp:Label>
											</div>
										</HeaderTemplate>
										<ItemTemplate>
											<div align="center">
												<asp:Label id="txtPOM" runat="server"></asp:Label>
											</div>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn>
										<HeaderTemplate>
											<asp:Label id="lblHeaderPointMeasur" runat="server"><%#GetSystemText("Point of Measurment")%></asp:Label>
										</HeaderTemplate>
										<ItemTemplate>
											<asp:Label id="txtPointMeasur" runat="server"></asp:Label>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn>
										<HeaderStyle CssClass="TableHeaderRed"></HeaderStyle>
										<HeaderTemplate>
											<DIV align="center" style='width:35px;'>
												<asp:Label id="lblHeaderTol" runat="server"><%#GetSystemText("TOL")%></asp:Label></DIV>
										</HeaderTemplate>
										<ItemTemplate>
											<asp:Label id="txtTOL" runat="server" ForeColor="#C00000"></asp:Label>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn>
										<HeaderStyle Width="50px" CssClass="TableHeaderBlue"></HeaderStyle>
										<HeaderTemplate>
											<DIV align="center" style='width:35px;'>
												<asp:Label id="lblAsked" runat="server" Width="50"><%#GetSystemText("Asked")%></asp:Label></DIV>
										</HeaderTemplate>
										<ItemTemplate>
											<asp:Label id="txtAsk" runat="server" ForeColor="RoyalBlue"></asp:Label>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn>
										<HeaderStyle Width="50px" CssClass="TableHeaderYellow"></HeaderStyle>
										<HeaderTemplate>
											<DIV align="center">
												<asp:Label id="lblHeaderVendor" runat="server" Width="50"><%#GetSystemText("Vendor")%></asp:Label></DIV>
										</HeaderTemplate>
										<ItemTemplate>
											<DIV align="center">
												<asp:TextBox id="txtVendor" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
													columns="5" maxlength="10" CssClass="fontHead"></asp:TextBox></DIV>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn>
										<HeaderStyle Width="50px" CssClass="TableHeaderRed"></HeaderStyle>
										<HeaderTemplate>
											<DIV align="center" style='width:35px;'>
												<asp:Label id="lblVar" runat="server" Width="50"><%#GetSystemText("Var")%></asp:Label></DIV>
										</HeaderTemplate>
										<ItemTemplate>
											<DIV style="FONT-WEIGHT: bold; COLOR: red">
												<asp:LABEL id="txtVar" runat="Server"></asp:LABEL></DIV>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn>
										<HeaderStyle CssClass="TableHeader"></HeaderStyle>
										<HeaderTemplate>
											<DIV align="center" Class="fontHead" style='width:35px;'><%#GetSystemText("Spec")%></DIV>
										</HeaderTemplate>
										<ItemTemplate>
											<asp:Label id="txtSpec" runat="server"></asp:Label>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn>
										<HeaderStyle CssClass="TableHeader"></HeaderStyle>
										<HeaderTemplate>
											<DIV align="center" Class="fontHead" style='width:35px;'><%#GetSystemText("Rev")%></DIV>
										</HeaderTemplate>
										<ItemTemplate>
											<asp:Label id="txtRev" runat="server"></asp:Label>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn>
										<HeaderStyle CssClass="TableHeaderGreen"></HeaderStyle>
										<HeaderTemplate>
											<DIV align="center" Class="fontHead" style='width:35px;'><%#GetSystemText("Final")%></DIV>
										</HeaderTemplate>
										<ItemTemplate>
											<asp:Label id="txtFinal" runat="server" ForeColor="Green"></asp:Label>
										</ItemTemplate>
									</asp:TemplateColumn>
								</Columns>
							</asp:datagrid>
							<asp:image id="imgDesign" runat="server" BorderColor="Transparent"></asp:image>
							<TABLE id="TB_FitComment" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server">
								<TR>
									<TD><BR>
									</TD>
								</TR>
							</TABLE>
							<TABLE id="TB_FitImage" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server">
								<TR>
									<TD>
                                        <table height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
                                            <tr class="TableHeader">
                                                <td valign="middle" align="center" width="10">
                                                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                                                </td>
                                                <td class="fontHead">
                                                    <cc1:ConfirmedImageButton ID="btnAttachMultipleFile" runat="server" Message="NONE" CausesValidation="False">
                                                    </cc1:ConfirmedImageButton>
                                                    <cc1:ConfirmedImageButton ID="btnDeleteImage" runat="server"></cc1:ConfirmedImageButton>
                                                </td>
                                            </tr>
                                        </table>
                                        <asp:DataGrid ID="dgFitImage" runat="server" AutoGenerateColumns="False" PageSize="100" BorderWidth="1px"
                                            BorderStyle="Solid" BorderColor="Silver" Width="100%" DataKeyField="SampleRequestSubmitImageID">
                                            <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                                            <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
                                            <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                                            <Columns>
                                                <asp:TemplateColumn>
                                                    <HeaderTemplate>
                                                        <asp:Image ID="Image1" runat="server" ImageUrl="../System/Icons/icon_delete.gif"></asp:Image>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="cbSpecImageDelete" runat="server" ForeColor="Red" ToolTip='<%#GetSystemText("click here to delete item")%>'>
                                                        </asp:CheckBox>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                            </Columns>
                                        </asp:DataGrid></TD>
								</TR>
							</TABLE>
							<TABLE id="TB_FitMeasure" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server">
								<TR>
									<TD>
									    <asp:datalist id="dlHowToMeasure" runat="server" BorderColor="WhiteSmoke" BorderStyle="Solid"
											BorderWidth="1px" BackColor="White">
											<HeaderTemplate>
												<table cellspacing="0" cellpadding="0" width="100%" border="0">
													<tr class="TableHeader">
														<td class="fonthead" width="75"><%#GetSystemText("Code")%></td>
														<td class="fonthead" width="200"><%#GetSystemText("Point of Measure")%></td>
														<td class="fonthead" width="200"><%#GetSystemText("How To Measure")%></td>
														<td class="fonthead" width="200"><%#GetSystemText("How To Image")%></td>
													</tr>
												</table>
											</HeaderTemplate>
											<AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
											<FooterTemplate>
											</FooterTemplate>
											<ItemStyle BackColor="White"></ItemStyle>
											<ItemTemplate>
												<TABLE width="100%">
													<TR>
														<TD class="font" width="75"><%#Container.DataItem("POM")%></TD>
														<TD class="font" width="200"><%#Container.DataItem("PointMeasur")%></TD>
														<TD class="font" width="200"><%#Container.DataItem("HowTomeasurText")%></TD>
														<TD class="font" width="200">
															<cc1:BWImageButton id="imgHowTo" runat="server"></cc1:BWImageButton></TD>
													</TR>
												</TABLE>
											</ItemTemplate>
										</asp:datalist>
									</TD>
								</TR>
							</TABLE>
							<table id="TB_FitPhotos" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
                                <tr>
                                    <td>
                                        <table id="TB_UpDelPhoto" height="25" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
                                            <tr class="TableHeader">
                                                <td valign="middle" align="center" width="10">
                                                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                                                </td>
                                                <td class="fontHead">
                                                    <cc1:confirmedimagebutton id="btnSaveSort" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
                                                    <cc1:ConfirmedImageButton ID="btnUploadFile" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                                                    <cc1:ConfirmedImageButton ID="btnDeleteFitPhotos" runat="server"></cc1:ConfirmedImageButton>
                                                </td>
                                            </tr>
                                        </table>
                                        <table id="TB_UpldPhoto" runat="server">
                                            <tr>
                                                <td class="fontHead" width="100">
                                                    <asp:Label ID="lblUpload" runat="server"></asp:Label>:
                                                </td>
                                                <td>
                                                    <input class="font" id="txtImagePath" type="file" name="txtImagePath" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                                        <asp:DataGrid ID="dgFitPhotos" runat="server" AutoGenerateColumns="False" PageSize="100"
                                            BorderWidth="1px" BorderStyle="Solid" BorderColor="Silver" Width="100%" DataKeyField="FitPhotoId">
                                            <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                                            <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
                                            <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                                            <Columns>
                                                <asp:TemplateColumn>
                                                    <HeaderTemplate>
                                                        <asp:Image ID="Image2" runat="server" ImageUrl="../System/Icons/icon_delete.gif">
                                                        </asp:Image>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="cbFitPhotosDelete" runat="server" ForeColor="Red" ToolTip='<%#GetSystemText("click here to delete item")%>'>
                                                        </asp:CheckBox>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                            </Columns>
                                        </asp:DataGrid>
                                    </td>
                                </tr>
                            </table>
						</TD>
					</TR>
				</TABLE>
			</asp:panel></TD>
		<TD vAlign="top"><cc2:ystabview id="Ystabview3" runat="server"></cc2:ystabview><asp:panel id="pnlComment" runat="server">
				<uc1:SampleRequest_Workflow_Submit_Comment id="SampleRequest_Workflow_Submit_Comment2" runat="server"></uc1:SampleRequest_Workflow_Submit_Comment>
			</asp:panel><asp:panel id="pnlFitComment" runat="server">
				<TABLE id="Table1" cellSpacing="0" cellPadding="0" width="400" border="0" runat="server">
					<TR>
						<TD bgColor="#ffffff"><BR>
							<asp:Label id="txt_FitComment" runat="server" CssClass="font"></asp:Label><BR>
							<BR>
						</TD>
					</TR>
				</TABLE>
			</asp:panel></TD>
		<TD vAlign="top" width="98%" bgColor="#ffffff"></TD>
	</TR>
</TABLE>
