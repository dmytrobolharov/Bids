<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Search.aspx.vb" Inherits="srmOnApp.Style_Search" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Style Search</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server" autocomplete="on">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
				<tr>
					<td>&nbsp;<asp:Label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Style</asp:Label></td>
				</tr>
			</table>
			<cc3:YSTabView id="YSTabView1" runat="server"></cc3:YSTabView>
			<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td vAlign="top"><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
					<td width="100%" vAlign="top"><table height="45">
							<tr>
								<td><asp:imagebutton id="imgBtnSearch" runat="server" /></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<TABLE id="Table1" cellSpacing="1" cellPadding="0" width="100%" border="0">
				<TR>
					<TD vAlign="top">
						<TABLE class="ToolbarShort" id="Table2" height="20" cellSpacing="0" cellPadding="0" width="100%"
							border="0">
							<TR class="fontHead">
								<TD align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<TD>
									<DIV align="left">&nbsp;
										<asp:label id="lblCurrentIndex" Runat="server" Visible="False" Text="0"></asp:label><asp:label id="lblPageSize" Runat="server" Visible="False" Text="24"></asp:label></DIV>
								</TD>
								<TD width="20">
									<DIV align="center"><asp:imagebutton id="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:imagebutton></DIV>
								</TD>
								<TD width="20">
									<DIV align="center"><asp:imagebutton id="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:imagebutton></DIV>
								</TD>
								<TD width="100">
									<DIV align="center"><asp:label id="lblCounts" Runat="server" CssClass="plaintable"></asp:label></DIV>
								</TD>
								<TD width="20">
									<DIV align="center"><asp:imagebutton id="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:imagebutton></DIV>
								</TD>
								<TD width="20">
									<DIV align="center"><asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:imagebutton></DIV>
								</TD>
								<TD>
									<DIV align="left"><asp:label id="lblRecordCount" Runat="server" Visible="true"></asp:label></DIV>
									</B></TD>
							</TR>
						</TABLE>
						<asp:datalist id="DataList1" runat="server" Width="100%" DataKeyField="StyleID" RepeatColumns="6"
							RepeatDirection="Horizontal" EnableViewState="True" OnItemDataBound="DataList1_ItemDataBound">
							<ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
								VerticalAlign="Top" BackColor="White"></ItemStyle>
							<ItemTemplate>
								<TABLE borderColor="silver" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
									border="0">
									<TR>
										<TD>
											<cc1:ConfirmedImageButton id="imgBtnEditImage" runat="server" ImageUrl="../System/icons/icon_edit_file.gif"
												Message="NONE" ToolTip='<%#GetSystemText("Edit Style")%>...' CommandName="Edit"></cc1:ConfirmedImageButton>&nbsp;
											<cc1:BWImageButton id="btnImgNewWindow" runat="server" ImageUrl="../System/icons/icon_popup.gif" ToolTip='<%#GetSystemText("New Window")%>...'
												CommandName="Window"></cc1:BWImageButton>&nbsp;</TD>
									</TR>
									<TR>
										<TD vAlign="top" width="200" bgColor="#ffffff" height="150"><asp:Image alt="" runat="server" id="image1"></asp:Image></TD>
									</TR>
									<TR>
										<TD>
											<TABLE>
												<TR>
													<TD class="font">
														<asp:Label id=Label1 runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "StyleNo") %>'>
														</asp:Label></TD>
												</TR>
												<TR>
													<TD class="font">
														<asp:Label id=lbImgDescription runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Description") %>'>
														</asp:Label></TD>
												</TR>
											</TABLE>
										</TD>
									</TR>
								</TABLE>
								<INPUT id=txtImageID type=hidden value='<%# DataBinder.Eval(Container.DataItem, "DesignSketchID") %>' name=txtImageID runat="server">
								<INPUT id=txtStyleNo type=hidden value='<%# DataBinder.Eval(Container.DataItem, "StyleNo") %>' name=txtStyleNo runat="server">
							</ItemTemplate>
							<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
						</asp:datalist></TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
