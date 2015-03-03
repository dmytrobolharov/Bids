<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_Image_Item_Search.aspx.vb" Inherits="plmOnApp.Material_Image_Item_Search"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Image Folder</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server" autocomplete="on">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="imgBtnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton></td>
				</tr>
			</TABLE>
			<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table id="Table4" style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblImageHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
							ForeColor="#E0E0E0">Image Folder...</asp:label></td>
				</tr>
			</table>
			<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td vAlign="top" width="100%">
						<TABLE id="Table3" height="45">
							<TR>
								<TD><asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></TD>
							</TR>
						</TABLE>
					</td>
				</tr>
			</table>
			<TABLE id="Table1" cellSpacing="1" cellPadding="0" width="100%" border="0">
				<TR>
					<TD vAlign="top">
						<TABLE class="TableHeader" id="Table2" height="25" cellSpacing="0" cellPadding="0" width="100%"
							border="0">
							<TR class="fontHead">
								<TD align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<TD>
									<DIV align="left">&nbsp;
										<asp:label id="lblCurrentIndex" Runat="server" Visible="False" Text="0"></asp:label><asp:label id="lblPageSize" Runat="server" Visible="False" Text="24"></asp:label></DIV>
								</TD>
								<TD width="20">
								   <DIV align="center"><asp:imagebutton id="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif" OnClick="ShowFirstPage"></asp:imagebutton></DIV>
								</TD>
								<TD width="20">
									<DIV align="center"><asp:imagebutton id="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif" OnClick="ShowPreviousPage"></asp:imagebutton></DIV>
								</TD>
								<TD width="150">
									<DIV align="center"><asp:label id="lblCounts" Runat="server" CssClass="plaintable"></asp:label></DIV>
								</TD>
								<TD width="20">
									<DIV align="center"><asp:imagebutton id="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif" OnClick="ShowNextPage"></asp:imagebutton></DIV>
								</TD>
								<TD width="20">
									<DIV align="center"><asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif" OnClick="ShowLastPage"></asp:imagebutton></DIV>									
								</TD>
								<TD>
									<DIV align="left"><B><asp:label id="lblRecordCount" Runat="server" Visible="true"></asp:label>&nbsp;<asp:Label ID="lblRecordsFound" runat="server" Text="Records Found"></asp:Label></B></DIV>
									</TD>
								<td>&nbsp;</td>
							</TR>
						</TABLE>
						<asp:datalist id="DataList1" runat="server" Width="100%" DataKeyField="ImageID" RepeatColumns="6"
							OnItemCommand="DataList1_ItemCommand" RepeatDirection="Horizontal" OnItemDataBound="DataList1_ItemDataBound">
							<ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
								VerticalAlign="Top" BackColor="White"></ItemStyle>
							<ItemTemplate>
								<TABLE borderColor="silver" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
									border="0">
									<TR>
										<TD>
											<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
												<TR class="fontHead">
													<TD>&nbsp;													
														<asp:CheckBox id="cbSelectStyle" runat="server" Text='<%#GetSystemText("Select Image")%>...' CssClass="fonthead" ToolTip='<%#GetSystemText("click here to select image")%>...'
															OnCheckedChanged="SelectedIndexChanged" AutoPostBack="True" Checked="false"></asp:CheckBox></TD>
												</TR>
											</TABLE>
											<TABLE class="fontHead" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0"
												runat="server" id="tbImgData" visible="false">
												<TR class="fontHead">
													<TD>
														<asp:Label runat="server" ID="lblColorCode"></asp:Label>
													</TD>
													<TD>
														<asp:TextBox runat="server" ID="txtColorCode" MaxLength="50"></asp:TextBox>
													</TD>
												</TR>
												<tr>
													<TD>
														<asp:Label runat="server" ID="lblColorName"></asp:Label>
													</TD>
													<TD>
														<asp:TextBox runat="server" ID="txtColorName" MaxLength="50"></asp:TextBox>
													</TD>
												</tr>
											</TABLE>
										</TD>
									</TR>
									<TR>
										<TD vAlign="top" width="200" bgColor="#ffffff" height="150">
											<cc1:BWImageButton id="btnImgNewWindow" runat="server" CommandName="Window"></cc1:BWImageButton></TD>
									</TR>
									<TR>
										<TD>
											<TABLE>
												<TR>
													<TD class="font">
														<asp:Label id="lblImageCode" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ImageNo") %>'>
														</asp:Label></TD>
												</TR>
												<TR>
													<TD class="font">
														<asp:Label id=lbImgDescription runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ImageDescription") %>'>
														</asp:Label></TD>
												</TR>
											</TABLE>
											<INPUT id=txtImageFileName type=hidden value='<%# DataBinder.Eval(Container.DataItem, "ImageLocation") %>' runat="server" NAME="txtImageFileName">
											<INPUT id=txtImageVersion type=hidden value='<%# DataBinder.Eval(Container.DataItem, "Version") %>' runat="server" NAME="txtImageVersion">
											<INPUT id=txtImageID type=hidden value='<%# DataBinder.Eval(Container.DataItem, "ImageID") %>' runat="server" NAME="txtImageID"></TD>
									</TR>
								</TABLE>
							</ItemTemplate>
							<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
						</asp:datalist></TD>
				</TR>
			</TABLE>
		</form>
        <script language="javascript">
            function btnClose_Click() {
                <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</HTML>
