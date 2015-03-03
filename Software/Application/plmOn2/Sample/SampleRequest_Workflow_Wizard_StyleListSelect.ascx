<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Wizard_StyleListSelect.ascx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Wizard_StyleListSelect" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>

<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
	runat="server">
	<tr valign="middle">
		<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		<td><asp:imagebutton id="btnInvSearch" runat="server" Height="0px" Width="0px" ImageUrl="../System/icons/1x1.gif"></asp:imagebutton><cc1:confirmedimagebutton id="imgBtnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
	</tr>
</table>
<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
	<tr>
		<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
	</tr>
</table>
<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
	<tr>
		<td><asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
		<td vAlign="top" width="100%">
			<table id="Table3" height="45">
				<tr>
					<td><asp:imagebutton id="imgBtnSearch" runat="server"></asp:imagebutton></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<table id="Table1" cellSpacing="1" cellPadding="0" width="100%" border="0">
	<TR>
		<TD vAlign="top">
			<table class="ToolbarShort" id="Table2" height="20" cellSpacing="0" cellPadding="0" width="100%"
				border="0">
				<TR class="fontHead">
					<TD align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></TD>
					<TD>
						<DIV align="left">&nbsp;
							<asp:label id="lblCurrentIndex" Visible="False" Runat="server" Text="0"></asp:label><asp:label id="lblPageSize" Visible="False" Runat="server" Text="24"></asp:label></DIV>
					</TD>
					<TD width="20">
						<DIV align="center"><asp:ImageButton id="btnFirst" Runat="server" ImageUrl="../System/Icons/icon_first.gif" Height="16"
								AlternateText="First Record"></asp:ImageButton></DIV>
					</TD>
					<TD width="20">
						<DIV align="center"><asp:ImageButton id="btnPrevious" Runat="server" ImageUrl="../System/Icons/icon_Previous.gif" Height="16"
								AlternateText="Previous Record"></asp:ImageButton></DIV>
					</TD>
					<TD width="125">
						<DIV align="center"><asp:label id="lblCounts" Runat="server" CssClass="plaintable"></asp:label></DIV>
					</TD>
					<TD width="20">
						<DIV align="center"><asp:ImageButton id="btnNext" Runat="server" ImageUrl="../System/Icons/icon_next.gif" Height="16"
								AlternateText="Next Record"></asp:ImageButton></DIV>
					</TD>
					<TD width="20">
						<DIV align="center"><asp:ImageButton Runat="server" ImageUrl="../System/Icons/icon_last.gif" Height="16" AlternateText="Last Record"
								id="btnLast"></asp:ImageButton></DIV>
					</TD>
					<TD>
						<DIV align="left"><B><asp:label id="lblRecordCount" Visible="true" Runat="server"></asp:label>&nbsp;<asp:Label
                                    ID="lblRecordsFoundText" runat="server"></asp:Label>
								</B></DIV>
						</TD>
				</TR>
			</table>
			<asp:datalist id="DataList1" runat="server" Width="100%" OnItemDataBound="DataList1_ItemDataBound"
				EnableViewState="True" RepeatDirection="Horizontal" OnItemCommand="DataList1_ItemCommand"
				RepeatColumns="6" DataKeyField="StyleID">
				<ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
					VerticalAlign="Top" BackColor="White"></ItemStyle>
				<ItemTemplate>
					<table borderColor="silver" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
						border="0">
						<TR>
							<TD>
								<cc1:ConfirmedImageButton id="imgBtnEditImage" runat="server" Message="NONE" CommandName="Edit" ToolTip="Select Style..."></cc1:ConfirmedImageButton>&nbsp;
							</TD>
						</TR>
						<!--
						<TR>
							<TD>
								<asp:Label id="txtTechPack" runat="server"></asp:Label></TD>
						</TR>
						-->
						<TR>
							<TD vAlign="top" width="200" bgColor="#ffffff" height="150"><IMG alt="" ID="ImgSampleStyleSelect" runat="server" /></TD>
						</TR>
						<TR>
							<TD>
								<table>
									<TR>
										<TD class="font">
											<asp:Label id=lbStyleNo Text='<%# DataBinder.Eval(Container.DataItem, "StyleNo") %>' runat="server">
											</asp:Label></TD>
									</TR>
									<TR>
										<TD class="font">
											<asp:Label id="lbSizeClass" Text='<%# DataBinder.Eval(Container.DataItem, "SizeClass") %>' runat="server">
											</asp:Label></TD>
									</TR>
									<TR>
										<TD class="font">
											<asp:Label id="lbSizeRange" Text='<%# DataBinder.Eval(Container.DataItem, "SizeRange") %>' runat="server">
											</asp:Label></TD>
									</TR>
									<TR>
										<TD class="font">
											<asp:Label id="lbImgDescription" Text='<%# DataBinder.Eval(Container.DataItem, "Description") %>' runat="server">
											</asp:Label></TD>
									</TR>
									<TR>
										<TD class="font">
											<asp:Label id="Label4" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, strFieldSeason) %>'>
											</asp:Label></TD>
									</TR>
									<TR>
										<TD class="font">
											<asp:Label id="Label5" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, strFieldYear ) %>'>
											</asp:Label></TD>
									</TR>
									<TR>
										<TD class="font">
											<asp:Label id="Label7" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "MaterialName") %>'>
											</asp:Label></TD>
									</TR>
								</table>
							</TD>
						</TR>
					</table>
					<INPUT id="txtImageID" type="hidden" value='<%# DataBinder.Eval(Container.DataItem, "DesignSketchID") %>' name="txtImageID" runat="server">
					<INPUT id="txtStyleNo" type="hidden" value='<%# DataBinder.Eval(Container.DataItem, "StyleNo") %>' name="txtStyleNo" runat="server">
				</ItemTemplate>
				<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
			</asp:datalist></TD>
	</TR>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</table>
