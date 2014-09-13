<%@ Register TagPrefix="uc1" TagName="SampleRequest_Workflow_Submit_Comment" Src="SampleRequest_Workflow_Submit_Comment.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Submit_Color_Edit.ascx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Submit_Color_Edit" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>

<TABLE cellSpacing="1" cellPadding="1" width="100%" border="0">
	<TR>
		<TD valign="top" bgColor="#ffffff"><cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview><asp:placeholder id="phlStatus" runat="server"></asp:placeholder>
			<TABLE height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR class="TableHeader">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD width="20"><asp:imagebutton id="imbBtnExpand" runat="server" ImageUrl="../System/Icons/icon_Next.gif"></asp:imagebutton><asp:imagebutton id="imgBtnCollapse" runat="server" ImageUrl="../System/Icons/icon_Down.gif"></asp:imagebutton></TD>
					<TD class="fontHead"><asp:label id="lblHeaderSpec" runat="server"></asp:label></TD>
				</TR>
			</TABLE>
			<TABLE height="26" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR>
					<TD vAlign="bottom"><cc2:ystabview id="YSTabView2" runat="server"></cc2:ystabview></TD>
				</TR>
			</TABLE>
			<asp:panel id="Panel1" runat="server">
                <script language="javascript" type="text/javascript">
                    function checkSubmit() {
                        if (document.getElementById("<%=HFSubmitForm.ClientID %>").value == 1)
                            return false;
                        else {
                            document.getElementById("<%=HFSubmitForm.ClientID %>").value = 1;
                            return true;
                        }
                    }
                </script>
				<TABLE height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
					<TR class="TableHeader">
						<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
						<TD class="fontHead">
							<asp:HiddenField ID="HFSubmitForm" runat="server" Value="0" />
                     </TD>
					</TR>
				</TABLE>
				<TABLE cellSpacing="1" cellPadding="1" border="0">
					<TR>
						<TD vAlign="top" width="375" bgColor="#ffffff">
							<asp:datagrid id="DataGrid1" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
								PageSize="100" AutoGenerateColumns="False" OnItemDataBound="ItemDataBoundEventHandler" OnItemCommand="DisplayBoundColumnValues"
								Width="375px">
								<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
								<ItemStyle Height="20px" CssClass="font" VerticalAlign="Top" BackColor="White"></ItemStyle>
								<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
								<Columns>
									<asp:TemplateColumn>
										<HeaderStyle Width="25px"></HeaderStyle>
										<ItemTemplate>
											<asp:ImageButton id="btnViewMaterial" runat="server" CommandName="View"></asp:ImageButton>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn>
										<HeaderStyle Width="200px" CssClass="TableHeader"></HeaderStyle>
										<HeaderTemplate>
											<div align="left">
												<asp:Label id="lblHeaderMaterial" runat="server"><%#GetSystemText("Material")%></asp:Label>
											</div>
										</HeaderTemplate>
										<ItemTemplate>
											<div align="left">
												<asp:Label id="txtMaterial" runat="server"><%#GetSystemText("Material")%></asp:Label>
											</div>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn>
										<HeaderStyle CssClass="TableHeaderGreen"></HeaderStyle>
										<HeaderTemplate>
											<asp:Label id="lblHeaderEndDate" runat="server"><%#GetSystemText("Submit")%></asp:Label>
										</HeaderTemplate>
										<ItemTemplate>
											<asp:DropDownList id="drlStatus" runat="server"></asp:DropDownList>
										</ItemTemplate>
									</asp:TemplateColumn>
								</Columns>
							</asp:datagrid></TD>
						<TD vAlign="top" bgColor="#ffffff">
							<TABLE id="Table1" cellSpacing="1" cellPadding="1" width="100%" border="0">
								<TR>
									<TD vAlign="top">
										<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></TD>
									<TD vAlign="top"></TD>
								</TR>
								<TR>
									<TD vAlign="top">
										<cc1:BWImageButton id="imgDesign" runat="server"></cc1:BWImageButton></TD>
									<TD vAlign="top"></TD>
								</TR>
							</TABLE>
						</TD>
					</TR>
				</TABLE>
			</asp:panel>
			<asp:panel id="Panel2" runat="server">
				<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
					<TR class="TableHeader">
						<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
						<TD>
							<asp:imagebutton id="btnComment1" runat="server" ></asp:imagebutton>
							<asp:checkbox id="cbAutoComment" runat="server" CssClass="fontHead" ForeColor="DarkRed" 
								AutoPostBack="True"  Visible="False"></asp:checkbox></TD>
					</TR>
				</TABLE>
			</asp:panel><asp:panel id="Panel3" runat="server">
				<TABLE id="TB_FitImage" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server">
					<TR>
						<TD>
							<TABLE height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TR class="TableHeader">
									<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
									<TD class="fontHead">
										<%--<cc1:confirmedimagebutton id="btnNewImage" runat="server" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_add.gif" Message="NONE"></cc1:confirmedimagebutton>--%>
										  <cc1:ConfirmedImageButton ID="btnAttachMultipleFile" runat="server" Message="NONE" CausesValidation="False"></cc1:confirmedimagebutton>
										<cc1:confirmedimagebutton id="btnDeleteImage" runat="server"  Message="Are you sure you want to continue?"></cc1:confirmedimagebutton></TD>
								</TR>
							</TABLE>
							<asp:datagrid id="dgFitImage" runat="server" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
								PageSize="200" AutoGenerateColumns="False" Width="500px">
								<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
								<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
								<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
								<Columns>
									<asp:TemplateColumn>
										<HeaderStyle Width="20px"></HeaderStyle>
										<HeaderTemplate>
											<asp:Image id="Image1" runat="server" ImageUrl="../System/Icons/icon_delete.gif"></asp:Image>
										</HeaderTemplate>
										<ItemTemplate>
											<asp:CheckBox id="cbSpecImageDelete" runat="server" ForeColor="Red" ToolTip="click here to delete item"></asp:CheckBox>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn>
									<HeaderTemplate>
                                        <asp:Label ID="lblImageH" runat="server"><%#GetSystemText("Image")%></asp:Label>
                                        </HeaderTemplate>
										<ItemTemplate>
											<cc1:BWImageButton id="imgSpec" runat="server"></cc1:BWImageButton>
											<cc1:BWImageButton ID="btnMarkup" runat="server" Message="NONE" ToolTip="Markup..."></cc1:BWImageButton>
										</ItemTemplate>
									</asp:TemplateColumn>
									
									<asp:TemplateColumn >
									
									<HeaderTemplate>
                                        <asp:Label ID="lblDescriptionH" runat="server"><%#GetSystemText("Description")%></asp:Label>
                                        </HeaderTemplate>
										<ItemTemplate>
											<asp:Label id="lblImageDescription" runat="server" Text='<%# string.Concat( Convert.ToString(DataBinder.Eval(Container.DataItem,"ImageDescription" )))  %>'></asp:Label>
										</ItemTemplate>
									</asp:TemplateColumn>
									
									<asp:TemplateColumn >
																		
									<HeaderTemplate>
                                        <asp:Label ID="lblModifiedByH" runat="server"><%#GetSystemText("Modified By")%></asp:Label>
                                        </HeaderTemplate>
										<ItemTemplate>
											<asp:Label id="lblModifiedBy" runat="server"></asp:Label>
										</ItemTemplate>
									</asp:TemplateColumn>
								</Columns>
							</asp:datagrid></TD>
					</TR>
				</TABLE>
			</asp:panel><BR>
		</TD>
		<TD bgColor="#ffffff" width="400" vAlign="top"><cc2:ystabview id="Ystabview3" runat="server"></cc2:ystabview><asp:panel id="pnlComment" runat="server">
				<UC1:SAMPLEREQUEST_WORKFLOW_SUBMIT_COMMENT id="SampleRequest_Workflow_Submit_Comment1" runat="server"></UC1:SAMPLEREQUEST_WORKFLOW_SUBMIT_COMMENT>
			</asp:panel><asp:panel id="pnlFitComment" runat="server">
				<TABLE id="TB_FitComment" cellSpacing="0" cellPadding="0" width="400" border="0" runat="server">
					<TR class="TableHeader">
						<TD>&nbsp;
							<asp:ImageButton id="btnComment" runat="server"></asp:ImageButton></TD>
					</TR>
					<TR>
						<TD bgColor="#ffffff"><BR>
							<asp:label id="txt_Comment" runat="server" CssClass="font"></asp:label><BR>
							<BR>
						</TD>
					</TR>
				</TABLE>
			</asp:panel></TD>
		<TD bgColor="#ffffff" width="98%" vAlign="top"></TD>
	</TR>
</TABLE>
<TABLE height="24" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server">
	<TR vAlign="middle">
		<TD vAlign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_left.gif"></TD>
		<TD class="TableBar" vAlign="middle" align="center" width="20"><IMG src="../System/icons/icon_changeobject.gif"></TD>
		<TD class="TableBar"><asp:label id="lblCreatedBy" runat="server" ForeColor="Gray" CssClass="fontHead"></asp:label>&nbsp;/
			<asp:label id="lblModifiedBy" runat="server" CssClass="fontHead"></asp:label></TD>
		<TD vAlign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_right.gif"></TD>
	</TR>
</TABLE>
