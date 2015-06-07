<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Concept_Folder_Edit.aspx.vb" Inherits="plmOnApp.Concept_Folder_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc1" TagName="Concept_Folder_Header" Src="Concept_Folder_Header.ascx" %>
<%@ Register TagPrefix="ycl" Namespace="Yunique.Core.Library" Assembly="Yunique.Core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Concept</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
		<script language="javascript">
			function calendar(sTxtBoxName)
			{
			windowDatePicker = window.open("../System/Control/month_popup.aspx?txtbox=" + sTxtBoxName,"dp","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=200,height=180,left=375,top=200");
			windowDatePicker.focus();
			}
		</script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<br>
			<cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview><asp:panel id="Panel1" runat="server">
				<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
					runat="server">
					<TR>
						<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
						<TD width="300">
							<cc1:confirmedimagebutton id="btnSaveStyle" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnMoveTo" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
							<cc1:BWImageButton id="btnStyleGoTo" runat="server" ></cc1:BWImageButton></TD>
						<TD>&nbsp;</TD>
					</TR>
				</TABLE>
				<TABLE height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
					<TR>
						<TD>&nbsp;</TD>
						<TD>&nbsp;</TD>
					</TR>
				</TABLE>
				<TABLE height="90%" cellSpacing="0" cellPadding="0" width="100%" border="0">
					<TR>
						<TD vAlign="top" bgColor="#ffffff">
							<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TR>
									<TD></TD>
									<TD>
										<DIV align="right">
											<asp:label id="lblHeaderNew" runat="server" Font-Size="XX-Large" Font-Names="Tahoma,Verdana"
												ForeColor="#E0E0E0">Edit Concept Item...</asp:label></DIV>
									</TD>
								</TR>
							</TABLE>
							<asp:panel id="pnlStyle" runat="server">
								<TABLE height="100" cellSpacing="0" cellPadding="0" width="100%" border="0">
									<TR vAlign="top">
										<TD width="10">&nbsp;</TD>
										<TD>
											<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></TD>
									</TR>
								</TABLE>
							</asp:panel>
							<TABLE height="100" cellSpacing="0" cellPadding="0" width="100%" background="../System/Images/MiddleFill.jpg"
								border="0">
								<TR vAlign="top">
									<TD style="HEIGHT: 63px" width="33%"></TD>
									<TD style="HEIGHT: 63px" width="33%"></TD>
									<TD style="HEIGHT: 63px" width="33%"></TD>
								</TR>
							</TABLE>
						</TD>
						<TD width="10%" bgColor="#f5f5f5">&nbsp;</TD>
					</TR>
				</TABLE>
			</asp:panel><asp:panel id="Panel2" runat="server">
				<TABLE height="25" cellSpacing="0" cellPadding="1" width="100%" border="0">
					<TR class="TableHeader" bgColor="whitesmoke">
						<TD style="WIDTH: 11px" vAlign="middle" align="center" width="11"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
						<TD class="fonthead">
							<cc1:confirmedimagebutton id="imgBtnFolderImage" runat="server" 
								CausesValidation="False" ToolTip="Edit Image ..."></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="imgBtnEditImage" runat="server" 
								ToolTip="Edit Image File..."></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnSaveForm" runat="server"  Message="NONE"
								CausesValidation="False"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnCreateNewImage" runat="server" 
								Message="NONE"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="imgBtnImageSelect" runat="server" 
								Message="NONE" CausesValidation="False"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnUpdate" runat="server"  Message="Are you sure you want to update it?"
								Visible="False"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnCancelUpdate" runat="server"  Message="Are you sure you want to cancel update?"
								Visible="False"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="imgBtnCopyImage" runat="server"  ToolTip="Copy Image From..."></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="imgBtnDeleteImage" runat="server" 
								Message="Do you want to remove this image?" ToolTip="Remove Image ..."></cc1:confirmedimagebutton></TD>
					</TR>
				</TABLE>
				<uc1:Concept_Folder_Header id="Concept_Folder_Header1" runat="server"></uc1:Concept_Folder_Header>
				<TABLE style="WIDTH: 1000px; HEIGHT: 360px" cellSpacing="0" cellPadding="1" width="1000"
					border="0">
					<TR>
						<TD id="tblImage" vAlign="top" width="20%" runat="server">
							<TABLE height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="whitesmoke" border="0">
								<TR class="TableHeader">
									<TD style="WIDTH: 11px" vAlign="middle" align="center" width="11"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
									<TD>&nbsp;Image...</TD>
								</TR>
							</TABLE>
							<asp:panel id="pnlFileLocked" runat="server" Visible="False">
								<TABLE cellSpacing="0" cellPadding="1" width="100%" bgColor="#ea0000" border="0">
									<TR>
										<TD width="10">&nbsp;</TD>
										<TD width="20"><IMG height="16" src="../System/Icons/icon_lock.gif" width="16"></TD>
										<TD>&nbsp;
											<asp:Label id="lblFileLocked" runat="server" ForeColor="White"></asp:Label></TD>
									</TR>
								</TABLE>
							</asp:panel>
							<asp:panel id="pnlVersionUpdate" runat="server" Visible="False">
								<TABLE borderColor="limegreen" cellSpacing="0" cellPadding="0" width="100%" bgColor="white"
									border="1">
									<TR>
										<TD class="fonthead" align="center"><BR>
											Do you want to replace version&nbsp;#
											<asp:Label id="lbVersionCurrent" runat="server"></asp:Label><BR>
											with this version&nbsp;#
											<asp:Label id="lbVersionSelected" runat="server" ForeColor="Red"></asp:Label>&nbsp;?<BR>
											<BR>
											<cc1:confirmedimagebutton id="btnReplaceYes" runat="server"  Message="Are you sure you want to cancel update?"
												CausesValidation="False"></cc1:confirmedimagebutton>
											<asp:ImageButton id="btnReplaceNo" runat="server"  CausesValidation="False"></asp:ImageButton><BR>
											<BR>
											<P></P>
										</TD>
									</TR>
								</TABLE>
							</asp:panel>
							<asp:panel id="pnlCurrentImage" runat="server" HorizontalAlign="Center">
								<asp:label id="lblMessageFileNotFound" runat="server" ForeColor="#C00000"></asp:label>
								<asp:image id="imgDesign" runat="server" BorderColor="Transparent"></asp:image>
								<TABLE cellSpacing="1" cellPadding="0" width="100%" border="0">
									<TR>
										<TD width="15">&nbsp;</TD>
										<TD class="fontHead" width="125">&nbsp;Created By:</TD>
										<TD class="font">&nbsp;
											<asp:label id="lbCUser" runat="server"></asp:label></TD>
									</TR>
									<TR>
										<TD width="15">&nbsp;</TD>
										<TD class="fontHead" width="125">&nbsp;Created Date:</TD>
										<TD class="font">&nbsp;
											<asp:label id="lbCDate" runat="server"></asp:label></TD>
									</TR>
									<TR>
										<TD width="15">&nbsp;</TD>
										<TD class="fontHead" width="125">&nbsp;Modified By:</TD>
										<TD class="font">&nbsp;
											<asp:label id="lbMUser" runat="server"></asp:label></TD>
									</TR>
									<TR>
										<TD width="15">&nbsp;</TD>
										<TD class="fontHead" width="125">&nbsp;Modified Date:</TD>
										<TD class="font">&nbsp;
											<asp:label id="lbMDate" runat="server"></asp:label></TD>
									</TR>
								</TABLE>
							</asp:panel></TD>
						<TD vAlign="top">
							<asp:panel id="pnlProperty" runat="server">
								<TABLE height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
									<TR class="TableHeader" bgColor="whitesmoke">
										<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
										<TD class="fonthead">Image Property...</TD>
									</TR>
								</TABLE>
							</asp:panel>
							<asp:panel id="pnlUpload" runat="server" Visible="false">
								<TABLE height="75" cellSpacing="0" cellPadding="1" width="100%" border="0">
									<TR bgColor="#ffffff">
										<TD style="WIDTH: 15px" width="16">&nbsp;</TD>
										<TD class="fontHead" width="125">&nbsp;Image File</TD>
										<TD>&nbsp; <INPUT id="File1" type="file" name="file1" runat="server">&nbsp;<INPUT id="Submit1" type="submit" value="Upload" name="Upload" runat="server">
										</TD>
									</TR>
								</TABLE>
							</asp:panel>
							<asp:placeholder id="plhImageControlHolder" runat="server"></asp:placeholder><BR>
							<TABLE height="25" cellSpacing="0" cellPadding="1" width="100%" border="0">
								<TR class="TableHeader" bgColor="whitesmoke">
									<TD width="10">&nbsp;</TD>
									<TD class="fonthead">Image History...</TD>
								</TR>
							</TABLE>
							<TABLE cellSpacing="0" cellPadding="1" width="100%" border="0">
								<TR>
									<TD vAlign="top">
										<asp:datalist id="dlImageHistory" runat="server" OnItemCommand="DataList1_ItemCommand" RepeatColumns="3"
											RepeatDirection="Horizontal" EnableViewState="true" CellPadding="0" CellSpacing="0" ShowFooter="False"
											ShowHeader="False">
											<ItemTemplate>
												<TABLE cellSpacing="0" cellPadding="1" width="125" border='<%# SelectHTMLImageCurrentVersion(DataBinder.Eval(Container.DataItem,"Version")) %>' bordercolor=CornflowerBlue>
													<TR bgColor="#ffffff">
														<TD vAlign="middle" align="center">
															<cc1:ConfirmedImageButton id=imgBtnImage runat="server" ImageUrl='<%# string.Concat("../Image/Image_Thumbnail.aspx?S=100&amp;Path=" &amp; Yunique.Core.Library.ConfigHandler.GetAppSettings(Yunique.Core.Library.ConfigHandler.AppSettings("STORAGE"))("IMAGETHUMBPATH")&amp; "\{" &amp; DataBinder.Eval(Container.DataItem,"ImageID").tostring &amp; "}\Version\000\{" &amp; DataBinder.Eval(Container.DataItem,"ImageHistoryID").tostring &amp; "}.jpg") %>' Message='<%# string.Concat(" Do you want to view version " &amp; DataBinder.Eval(Container.DataItem,"Version").tostring &amp; "?") %>' CommandName="Edit">
															</cc1:ConfirmedImageButton></TD>
													</TR>
													<TR bgColor="#ffffff">
														<TD class="font" vAlign="middle" align="center">Version:
															<asp:Label id="lblVersion" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"Version")%>'/>
														</TD>
													</TR>
													<TR bgColor="#ffffff">
														<TD class="font" vAlign="middle" align="center">Last Modified:<%#SystemHandler.GetLocalTime(DataBinder.Eval(Container.DataItem, "ImageDateLastModified"))%></TD>
													</TR>
												</TABLE>
											</ItemTemplate>
										</asp:datalist></TD>
								</TR>
							</TABLE>
						</TD>
					</TR>
				</TABLE>
				<P>&nbsp;</P>
			</asp:panel></form>
	</body>
</HTML>
