<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Material_Add_Thumb.aspx.vb" Inherits="plmOnApp.Style.Material.Style_Material_Add_Thumb" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Image_Folder</title>	
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server" autocomplete="on">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>
						<cc1:confirmedimagebutton id="imgBtnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<table height="15" cellSpacing="0" cellpadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table id="Table4" style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblImageHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
							ForeColor="#E0E0E0"></asp:label></td>
				</tr>
			</table>
			<table height="15" cellSpacing="0" cellpadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
					<td width="100%"><asp:imagebutton id="imgBtnSearch" runat="server"  /></td>
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
									<DIV align="center"><A id="First" href="pagingdatalist.aspx#BookMark" runat="server" OnServerClick="ShowFirstPage"><IMG height="16" alt="First Record" src="../System/Icons/icon_first.gif" width="16" border="0"></A></DIV>
								</td>
								<td width="20">
									<DIV align="center"><A id="Previous" href="pagingdatalist.aspx#BookMark" runat="server" OnServerClick="ShowPreviousPage"><IMG height="16" alt="Previous Record" src="../System/Icons/icon_Previous.gif" width="16"
												border="0"></A></DIV>
								</td>
								<td width="150">
									<DIV align="center"><asp:label id="lblCounts" Runat="server" CssClass="plaintable"></asp:label></DIV>
								</td>
								<td width="20">
									<DIV align="center"><A id="Next" href="pagingdatalist.aspx#BookMark" runat="server" OnServerClick="ShowNextPage"><IMG height="16" alt="Next Record" src="../System/Icons/icon_next.gif" width="16" border="0"></A></DIV>
								</td>
								<td width="20">
									<DIV align="center"><A id="Last" href="pagingdatalist.aspx#BookMark" runat="server" OnServerClick="ShowLastPage"><IMG height="16" alt="Last Record" src="../System/Icons/icon_last.gif" width="16" border="0"></A></DIV>
								</td>
								<td>
									<DIV align="left"><B><asp:label id="lblRecordCount" Runat="server" Visible="true"></asp:label>&nbsp; 
											</B></DIV>
									</B></td>
							</tr>
						</table>
						<asp:datalist id="DataList1" runat="server" Width="100%" DataKeyField="StyleID" RepeatColumns="6"
							OnItemCommand="DataList1_ItemCommand" RepeatDirection="Horizontal" EnableViewState="True"
							OnItemDataBound="DataList1_ItemDataBound">
							<ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
								VerticalAlign="Top" BackColor="White"></ItemStyle>
							<ItemTemplate>
								<table borderColor="silver" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff"
									border="0">
									<tr>
										<td>
											<asp:CheckBox id="cbSelectStyle" runat="server" Text='<%#GetSystemText("Click here to select style")%>...' CssClass="font"></asp:CheckBox></td>
									</tr>
									<tr>
										<td valign="top" width="200" bgColor="#ffffff" height="150"><IMG alt="" id="ImgMaterialAdd" runat="server" ></td>
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
											</table>
										</td>
									</tr>
								</table>
								<INPUT id=txtImageID type=hidden value='<%# DataBinder.Eval(Container.DataItem, "DesignSketchID") %>' name=txtImageID runat="server">
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
