<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Search.aspx.vb" Inherits="plmOnApp.Style_Search" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Style Search</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server" autocomplete="on">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><asp:imagebutton id="btnInvSearch" runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px"
							Height="0px"></asp:imagebutton>
						<cc1:confirmedimagebutton id="btnNew" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="imgBtnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
				<tr>
					<td>&nbsp;<asp:Label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Style</asp:Label></td>
				</tr>
			</table>
			<cc3:YSTabView id="YSTabView1" runat="server"></cc3:YSTabView>
			<table height="15" cellSpacing="0" cellpadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td width="100%" valign="top">
						<table id="Table3" height="45">
							<tr>
								<td>
									<asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<table id="Table1" cellSpacing="1" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="top">
						<table class="ToolbarShort" id="Table2" height="20" cellSpacing="0" cellpadding="0" width="100%"
							border="0">
							<tr class="fontHead">
								<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td>
									<DIV align="left">&nbsp;
										<asp:label id="lblCurrentIndex" Runat="server" Visible="False" Text="0"></asp:label><asp:label id="lblPageSize" Runat="server" Visible="False" Text="24"></asp:label></DIV>
								</td>
								<td width="20">
									<DIV align="center"><asp:imagebutton id="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:imagebutton></DIV>
								</td>
								<td width="20">
									<DIV align="center"><asp:imagebutton id="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:imagebutton></DIV>
								</td>
								<td width="125">
									<DIV align="center"><asp:label id="lblCounts" Runat="server" CssClass="plaintable"></asp:label></DIV>
								</td>
								<td width="20">
									<DIV align="center"><asp:imagebutton id="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:imagebutton></DIV>
								</td>
								<td width="20">
									<DIV align="center"><asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:imagebutton></DIV>
								</td>
								<td>
									<DIV align="left"><B><asp:label id="lblRecordCount" Runat="server" Visible="true"></asp:label>&nbsp;<asp:label id="lblRecordsFound" Runat="server" CssClass="fontHead">Records Found</asp:label></B></DIV>
									</B></td>
							</tr>
						</table>
						<asp:datalist id="DataList1" runat="server" Width="100%" DataKeyField="StyleID" RepeatColumns="6"
							RepeatDirection="Horizontal" EnableViewState="True" OnItemDataBound="DataList1_ItemDataBound">
							<ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
								VerticalAlign="Top" BackColor="White"></ItemStyle>
							<ItemTemplate>
								<table borderColor="silver" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff"
									border="0">
									<tr>
										<td>
											<cc1:BWImageButton id="btnImgNewWindow" runat="server"  ToolTip="New Window..."
												CommandName="Window"></cc1:BWImageButton>&nbsp;</td>
									</tr>
									<tr>
										<td valign="top" width="200" bgColor="#ffffff" height="150"><IMG alt="" id="ImgStyleSearch" runat="server" ></td>
									</tr>
									<tr>
										<td>
											<table>
												<tr>
													<td class="font">
														<asp:Label id=Label1 runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "StyleNo") %>'>
														</asp:Label></td>
												</tr>
												<tr>
													<td class="font">
														<asp:Label id=lbImgDescription runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Description") %>'>
														</asp:Label></td>
												</tr>
												<tr>
													<td class="font">
														<asp:Label id=Label2 runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "SizeClass") %>'>
														</asp:Label></td>
												</tr>
												<tr>
													<td class="font">
														<asp:Label id=Label3 runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "SizeRange") %>'>
														</asp:Label></td>
												</tr>
												<tr>
													<td class="font">
														<asp:Label id="Label4" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, strFieldSeason) %>'>
														</asp:Label></td>
												</tr>
												<tr>
													<td class="font">
														<asp:Label id="Label5" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, strFieldYear ) %>'>
														</asp:Label></td>
												</tr>
												<tr>
													<td class="font">
														<asp:Label id="Label7" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "MaterialName") %>'>
														</asp:Label></td>
												</tr>
											</table>
										</td>
									</tr>
								</table>
								<INPUT id=txtImageID type=hidden value='<%# DataBinder.Eval(Container.DataItem, "DesignSketchID") %>' name=txtImageID runat="server">
								<INPUT id=txtStyleNo type=hidden value='<%# DataBinder.Eval(Container.DataItem, "StyleNo") %>' name=txtStyleNo runat="server">
							</ItemTemplate>
							<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
						</asp:datalist></td>
				</tr>
			</table>
		</form>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</html>
