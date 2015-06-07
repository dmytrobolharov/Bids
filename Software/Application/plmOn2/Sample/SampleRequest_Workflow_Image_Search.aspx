<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Image_Search.aspx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Image_Search" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Image Folder</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" autocomplete="on" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>
					    <asp:ImageButton id="imgBtnClose" runat="server" OnClientClick="window.close(); return false;" />
                    </td>
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
					<td>&nbsp;<asp:label id="lblImageHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Image Folder...</asp:label></td>
				</tr>
			</table>
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
						<table class="TableHeader" id="Table2" height="25" cellSpacing="0" cellpadding="0" width="100%"
							border="0">
							<tr class="fontHead">
								<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td>
									<DIV align="left">&nbsp;
										<asp:label id="lblCurrentIndex" Text="0" Visible="False" Runat="server"></asp:label>
                                        <asp:label id="lblPageSize" Text="20" Visible="False" Runat="server"></asp:label></DIV>
								</td>
								<td width="20">
									<DIV align="center"><asp:imagebutton id="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:imagebutton></DIV>
								</td>
								<td width="20">
									<DIV align="center"><asp:imagebutton id="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:imagebutton></DIV>
								</td>
								<td width="150">
									<DIV align="center"><asp:label id="lblCounts" Runat="server" CssClass="plaintable"></asp:label></DIV>
								</td>
								<td width="20">
									<DIV align="center"><asp:imagebutton id="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:imagebutton></DIV>
								</td>
								<td width="20">
									<DIV align="center"><asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:imagebutton></DIV>
								</td>
								<td>
									<DIV align="left"><B><asp:label id="lblRecordCount" Visible="true" Runat="server"></asp:label>&nbsp;<asp:label id="lblRecordsFound" Runat="server" CssClass="fontHead">Records Found</asp:label></B></DIV>
									</td>
								<td>&nbsp;</td>
							</tr>
						</table>
						<asp:datalist id="DataList1" runat="server" RepeatDirection="Horizontal"
							RepeatColumns="5" DataKeyField="ImageID" Width="100%">
							<ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
								VerticalAlign="Top" BackColor="White"></ItemStyle>
							<ItemTemplate>
								<table borderColor="silver" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff"
									border="0">
									<tr>
										<td>
											<table class="TableHeader" height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
												<tr class="fontHead">
													<td>&nbsp;
														<asp:ImageButton ID="btnSelectImage" runat="server" 
                                                            CommandName="select" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ImageID") %>'  />
                                                    </td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td valign="top" width="200" bgColor="#ffffff" height="150">
											<cc1:BWImageButton id="btnImgNewWindow" runat="server" CommandName="Window"></cc1:BWImageButton></td>
									</tr>
									<tr>
										<td>
											<table>
												<tr>
													<td class="font">
														<asp:Label id="lblImageCode" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ImageNo") %>'>
														</asp:Label></td>
												</tr>
												<tr>
													<td class="font">
														<asp:Label id="lbImgDescription" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ImageDescription") %>'>
														</asp:Label></td>
												</tr>
											</table>
											<INPUT id="txtImageFileName" type="hidden" value='<%# DataBinder.Eval(Container.DataItem, "ImageLocation") %>' runat="server">
											<INPUT id="txtImageVersion" type="hidden" value='<%# DataBinder.Eval(Container.DataItem, "Version") %>' runat="server">
											<INPUT id="txtImageID" type="hidden" value='<%# DataBinder.Eval(Container.DataItem, "ImageID") %>' runat="server"></td>
									</tr>
								</table>
							</ItemTemplate>
							<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
						</asp:datalist></td>
				</tr>
			</table>
		</form>
	</body>
</html>
