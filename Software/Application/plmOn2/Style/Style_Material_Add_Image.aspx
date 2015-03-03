<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Material_Header" Src="../Material/Material_Header.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Material_Add_Image.aspx.vb" Inherits="plmOnApp.Style.Material.Style_Material_Add_Image" %>
<%@ Register TagPrefix="uc1" TagName="Image_Comment" Src="../Image/Image_Comment.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
	<head>
		<title>Material Image</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	</head>
	<body MS_POSITIONING="GridLayout">
     <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" encType="multipart/form-data" runat="server">
			<!--

			-->
			<table height="25" cellSpacing="0" cellpadding="1" width="100%" border="0">
				<tr class="TableHeader" bgColor="whitesmoke">
					<td style="WIDTH: 11px" valign="middle" align="center" width="11"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td class="fonthead"><cc1:confirmedimagebutton id="imgBtnFolderImage" runat="server"  
							Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="imgBtnEditImage" runat="server"  ></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnSaveForm" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnCreateNewImage" runat="server" 
							Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="imgBtnImageSelect" runat="server" 
							Message="NONE" CausesValidation="False"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnUpdate" runat="server" 
							Visible="False"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnCancelUpdate" runat="server"  
							Visible="False"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="imgBtnCopyImage" runat="server"  
							DESIGNTIMEDRAGDROP="18"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="imgBtnDeleteImage" runat="server" 
							Message="Do you want to remove this image?"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"
							CausesValidation="False"></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<table height="75" cellSpacing="0" cellpadding="0" width="100%" background="../System/Images/MiddleFill.jpg"
				border="0">
				<TBODY>
					<tr>
						<td>
							<table cellSpacing="0" cellpadding="0" width="800" border="0">
								<TBODY>
									<tr>
										<td>&nbsp;</td>
										<td>
											<DIV align="right"><IMG src="../System/Icons/icon_32_2.gif"></DIV>
										</td>
										<td class="fontHead" style="FONT-SIZE: 12pt">&nbsp;<asp:Label ID="lblHeader" runat="server" ></asp:Label></td>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
										<td>
											<DIV align="right"></DIV>
										</td>
										<td>
											<table cellSpacing="0" cellpadding="0" width="100%" border="0">
												<TBODY>
													<tr>
														<td>&nbsp;</td>
														<td width="50"></td>
														<td><cc1:confirmedimagebutton id="btnNext" runat="server"  Message="NONE"
																CausesValidation="False"></cc1:confirmedimagebutton></td>
													</tr>
												</TBODY>
											</table>
										</td>
										<td>&nbsp;</td>
									</tr>
								</TBODY>
							</table>
						</td>
					</tr>
				</TBODY>
			</table>
			<table cellSpacing="0" cellpadding="1" width="100%" border="0">
				<tr>
					<td width="800" bgColor="#ffffff"><uc1:material_header id="Material_Header1" runat="server"></uc1:material_header></td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="1" width="100%" border="0">
				<tr>
					<td id="tblImage" valign="top" width="20%" runat="server"><table height="25" cellSpacing="0" cellpadding="0" width="100%" bgColor="whitesmoke" border="0">
							<tr class="TableHeader">
								<td style="WIDTH: 11px" valign="middle" align="center" width="11"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td>&nbsp;<asp:Label ID="lblImageH" runat="server" ></asp:Label></td>
							</tr>
						</table>
						<asp:panel id="pnlFileLocked" runat="server" Visible="False">
							<table cellSpacing="0" cellpadding="1" width="100%" bgColor="#ea0000" border="0">
								<tr>
									<td width="10">&nbsp;</td>
									<td width="20"><IMG height="16" src="../System/Icons/icon_lock.gif" width="16"></td>
									<td>&nbsp;
										<asp:Label id="lblFileLocked" runat="server" ForeColor="White"></asp:Label></td>
								</tr>
							</table>
						</asp:panel><asp:panel id="pnlVersionUpdate" runat="server" Visible="False">
							<table borderColor="limegreen" cellSpacing="0" cellpadding="0" width="100%" bgColor="white"
								border="1">
								<tr>
									<td class="fonthead" align="center"><BR>
                                        <asp:Label ID="lblReplaceInfo" runat="server"></asp:Label>&nbsp;#
										<asp:Label id="lbVersionCurrent" runat="server"></asp:Label><BR>
                                        <asp:Label ID="lblVerSionInfo" runat="server"></asp:Label>&nbsp;#
										<asp:Label id="lbVersionSelected" runat="server" ForeColor="Red"></asp:Label>&nbsp;?<BR>
										<BR>
										<cc1:confirmedimagebutton id="btnReplaceYes" runat="server"  Message="NONE"
											CausesValidation="False"></cc1:confirmedimagebutton>
										<asp:ImageButton id="btnReplaceNo" runat="server"  CausesValidation="False"></asp:ImageButton><BR>
										<BR>
										<P></P>
									</td>
								</tr>
							</table>
						</asp:panel><asp:panel id="pnlCurrentImage" runat="server" HorizontalAlign="Center">
							<asp:label id="lblMessageFileNotFound" runat="server" ForeColor="#C00000"></asp:label>
							<asp:image id="imgDesign" runat="server" BorderColor="Transparent"></asp:image>
						</asp:panel></td>
					<td valign="top"><asp:panel id="pnlProperty" runat="server">
							<table height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
								<tr class="TableHeader" bgColor="whitesmoke">
									<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
									<td class="fonthead"><asp:Label ID="lblImgproperty" runat="server" ></asp:Label></td>
								</tr>
							</table>
						</asp:panel><asp:panel id="pnlUpload" runat="server" Visible="false">
							<table height="75" cellSpacing="0" cellpadding="1" width="100%" border="0">
								<tr bgColor="#ffffff">
									<td style="WIDTH: 15px" width="16">&nbsp;</td>
									<td class="fontHead" width="125">&nbsp;<asp:Label ID="lblImageFileH" runat="server" ></asp:Label></td></td>
									<td>&nbsp; <INPUT id="File1" type="file" name="file1" runat="server">&nbsp;<INPUT id="Submit1" type="submit" value="Upload" name="Upload" runat="server"></td>
								</tr>
							</table>
						</asp:panel><asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder><br>
						<table height="25" cellSpacing="0" cellpadding="1" width="100%" border="0">
							<tr class="TableHeader" bgColor="whitesmoke">
								<td width="10">&nbsp;</td>
								<td class="fonthead"><asp:Label ID="lblImageHistory" runat="server" ></asp:Label></td></td>
							</tr>
						</table>
						<table cellSpacing="0" cellpadding="1" width="100%" border="0">
							<tr>
								<td valign="top"><asp:datalist id="DataList1" runat="server" OnItemCommand="DataList1_ItemCommand" CellPadding="0"
										CellSpacing="0" EnableViewState="true" RepeatColumns="3" RepeatDirection="Horizontal" ShowFooter="False"
										ShowHeader="False">
										<ItemTemplate>
											<table cellSpacing="0" cellpadding="1" width="125" border='<%# SelectHTMLImageCurrentVersion(DataBinder.Eval(Container.DataItem,"Version")) %>' bordercolor=CornflowerBlue>
												<tr bgColor="#ffffff">
													<td valign="middle" align="center">
														<cc1:ConfirmedImageButton id=imgBtnImage runat="server" CausesValidation="False" ImageUrl='<%# string.Concat("../Image/Image_Thumbnail.aspx?S=100&amp;Path=" &amp; Yunique.Core.Library.ConfigHandler.GetAppSettings(Yunique.Core.Library.ConfigHandler.AppSettings("STORAGE"))("IMAGETHUMBPATH")&amp; "\{" &amp; DataBinder.Eval(Container.DataItem,"ImageID").tostring &amp; "}\Version\000\{" &amp; DataBinder.Eval(Container.DataItem,"ImageHistoryID").tostring &amp; "}.jpg") %>' Message='<%# string.Concat(" Do you want to view version " &amp; DataBinder.Eval(Container.DataItem,"Version").tostring &amp; "?") %>' CommandName="Edit">
														</cc1:ConfirmedImageButton></td>
												</tr>
												<tr bgColor="#ffffff">
													<td class="font" valign="middle" align="center">Version:
														<asp:Label id="lblVersion" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"Version")%>'/>
													</td>
												</tr>
												<tr bgColor="#ffffff">
													<td class="font" valign="middle" align="center">Last Modified:<%#  GetLocalTime ( DataBinder.Eval(Container.DataItem,"MDate"))%></td>
												</tr>
											</table>
										</ItemTemplate>
									</asp:datalist></td>
							</tr>
						</table>
						<asp:placeholder id="pnlComment" runat="server"></asp:placeholder></td>
				</tr>
			</table>
			<p>&nbsp;</p>
		</form>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</html>
