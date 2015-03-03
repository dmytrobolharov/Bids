<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_Image.aspx.vb" Inherits="plmOnApp.Material_Image" %>
<%@ Register TagPrefix="uc1" TagName="Material_Header" Src="Material_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Material_WorkflowStatus" Src="Material_WorkflowStatus.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="ycl" Namespace="Yunique.Core.Library" Assembly="Yunique.Core" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
	<HEAD>
		<title>Material Image</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
         <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	</HEAD>
	<body>
     <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" encType="multipart/form-data" runat="server">
			<!--

			-->
               <wc1:Color_Wait ID="Color_Wait" runat="server" />
			<table height="25" cellSpacing="0" cellPadding="1" width="100%" border="0">
				<tr class="TableHeader" bgColor="whitesmoke">
					<td style="WIDTH: 11px" vAlign="middle" align="center" width="11"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td class="fonthead"><cc1:confirmedimagebutton id="imgBtnFolderImage" runat="server" 
							Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="imgBtnEditImage" runat="server" 
							Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnSaveForm" runat="server"  Message="NONE"
							CausesValidation="False"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnCreateNewImage" runat="server" 
							Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="imgBtnImageSelect" runat="server" 
							Message="NONE" CausesValidation="False"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnUpdate" runat="server"  Message="NONE"
							Visible="False"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnCancelUpdate" runat="server"  Message="NONE"
							Visible="False"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="imgBtnCopyImage" runat="server"  DESIGNTIMEDRAGDROP="18"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="imgBtnDeleteImage" runat="server" 
							CausesValidation="False"></cc1:confirmedimagebutton>
                            <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>
                            <cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"
							CausesValidation="False"></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblImageHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Material Image</asp:label></td>
				</tr>
			</table>
            <uc1:Material_WorkflowStatus ID="Material_WorkflowStatus1" runat="server" MaterialTemplatePageID="30000000-0000-0000-0000-000000000000" MaterialWorkflowPageID='<%# Request.QueryString("MWPID") %>' />
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td width="900"><uc1:material_header id="Material_Header1" runat="server" IsCollapsible="true" IsCollapsed="false"></uc1:material_header></td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="1" width="100%" border="0">
				<tr>
					<td id="tblImage" vAlign="top" width="20%" runat="server"><table height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="whitesmoke" border="0">
							<tr class="TableHeader">
								<td style="WIDTH: 11px" vAlign="middle" align="center" width="11"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td>&nbsp;<asp:Label ID="lblImage" runat="server" Text="Image..."></asp:Label></td>
							</tr>
						</table>
						<asp:panel id="pnlFileLocked" runat="server" Visible="False">
							<TABLE cellSpacing="0" cellPadding="1" width="100%" bgColor="#ea0000" border="0">
								<TR>
									<TD width="10">&nbsp;</TD>
									<TD width="20"><IMG height="16" src="../System/Icons/icon_lock.gif" width="16"></TD>
									<TD>&nbsp;
										<asp:Label id="lblFileLocked" runat="server" ForeColor="White"></asp:Label></TD>
								</TR>
							</TABLE>
						</asp:panel><asp:panel id="pnlVersionUpdate" runat="server" Visible="False">
							<TABLE borderColor="limegreen" cellSpacing="0" cellPadding="0" width="100%" bgColor="white"
								border="1">
								<TR>
									<TD class="fonthead" align="center"><BR>
										<asp:Label ID="lblQuest1" runat="server" Text="Do you want to replace version #"></asp:Label>
										<asp:Label id="lbVersionCurrent" runat="server"></asp:Label><BR>
										<asp:Label ID="lblQuest2" runat="server" Text="with this version #"></asp:Label>
										<asp:Label id="lbVersionSelected" runat="server" ForeColor="Red"></asp:Label>&nbsp;?<BR>
										<BR>
										<cc1:confirmedimagebutton id="btnReplaceYes" runat="server" ></cc1:confirmedimagebutton>
										<asp:ImageButton id="btnReplaceNo" runat="server" ></asp:ImageButton><BR>
										<BR>
										<P></P>
									</TD>
								</TR>
							</TABLE>
						</asp:panel><asp:panel id="pnlCurrentImage" runat="server" HorizontalAlign="Center">
							<asp:label id="lblMessageFileNotFound" runat="server" ForeColor="#C00000"></asp:label>
							<asp:image id="imgDesign" runat="server" BorderColor="Transparent"></asp:image>
							<TABLE cellSpacing="1" cellPadding="0" width="100%" border="0">
								<TR>
									<TD width="15">&nbsp;</TD>
									<TD class="fontHead" width="125">&nbsp;<asp:Label ID="lblCreatedBy" runat="server" Text="Created By:"></asp:Label></TD>
									<TD class="font">&nbsp;
										<asp:label id="lbCUser" runat="server"></asp:label></TD>
								</TR>
								<TR>
									<TD width="15">&nbsp;</TD>
									<TD class="fontHead" width="125">&nbsp;<asp:Label ID="lblCreatedDate" runat="server" Text="Created Date:"></asp:Label></TD>
									<TD class="font">&nbsp;
										<asp:label id="lbCDate" runat="server"></asp:label></TD>
								</TR>
								<TR>
									<TD width="15">&nbsp;</TD>
									<TD class="fontHead" width="125">&nbsp;<asp:Label ID="lblModifiedBy" runat="server" Text="Modified By:"></asp:Label></TD>
									<TD class="font">&nbsp;
										<asp:label id="lbMUser" runat="server"></asp:label></TD>
								</TR>
								<TR>
									<TD width="15">&nbsp;</TD>
									<TD class="fontHead" width="125">&nbsp;<asp:Label ID="lblModifiedDate" runat="server" Text="Modified Date:"></asp:Label></TD>
									<TD class="font">&nbsp;
										<asp:label id="lbMDate" runat="server"></asp:label></TD>
								</TR>
							</TABLE>
						</asp:panel></td>
					<td vAlign="top"><asp:panel id="pnlProperty" runat="server">
							<TABLE height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TR class="TableHeader" bgColor="whitesmoke">
									<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
									<TD class="fonthead"><asp:Label ID="lblImageProperty" runat="server" Text="Image Property..."></asp:Label></TD>
								</TR>
							</TABLE>
						</asp:panel><asp:panel id="pnlUpload" runat="server" Visible="false">
							<TABLE height="75" cellSpacing="0" cellPadding="1" width="100%" border="0">
								<TR bgColor="#ffffff">
									<TD style="WIDTH: 15px" width="16">&nbsp;</TD>
									<TD class="fontHead" width="125">&nbsp;<asp:Label ID="lblImageFile" runat="server" Text="Image File"></asp:Label></TD>
									<TD>&nbsp; <INPUT id="File1" type="file" name="file1" runat="server">&nbsp;
										<asp:Button id="btnUpload" runat="server" Text="Upload"></asp:Button></TD>
								</TR>
							</TABLE>
						</asp:panel><asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder><br>
						<table height="25" cellSpacing="0" cellPadding="1" width="100%" border="0">
							<tr class="TableHeader" bgColor="whitesmoke">
								<td width="10">&nbsp;</td>
								<td class="fonthead"><asp:Label ID="lblImageHistory" runat="server" Text="Image History..."></asp:Label></td>
							</tr>
						</table>
						<table cellSpacing="0" cellPadding="1" width="100%" border="0">
							<tr>
								<td vAlign="top"><asp:datalist id="DataList1" runat="server" ShowHeader="False" ShowFooter="False" RepeatDirection="Horizontal"
										RepeatColumns="3" EnableViewState="true" CellSpacing="0" CellPadding="0" OnItemCommand="DataList1_ItemCommand">
										<ItemTemplate>
											<TABLE cellSpacing="0" cellPadding="1" width="125" border='<%# SelectHTMLImageCurrentVersion(DataBinder.Eval(Container.DataItem,"Version")) %>' bordercolor=CornflowerBlue>
												<TR bgColor="#ffffff">
													<TD vAlign="middle" align="center">
														<cc1:ConfirmedImageButton id="imgBtnImage" runat="server"  Message=' <%# string.format(GetSystemText("Do you want to view version {0}?"), DataBinder.Eval(Container.DataItem,"Version").tostring) %>' CommandName="Edit">
														</cc1:ConfirmedImageButton></TD>
												</TR>
												<TR bgColor="#ffffff">
													<TD class="font" vAlign="middle" align="center"><%=GetSystemText("Version")%>:
														<asp:Label id="lblVersion" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"Version")%>'/>
													</TD>
												</TR>
												<TR bgColor="#ffffff">
													<TD class="font" vAlign="middle" align="center"><%=GetSystemText("Last Modified")%>:<%# Convert.ToDateTime(SystemHandler.GetLocalTime(DataBinder.Eval(Container.DataItem,"MDate"))).ToString(Me.GetFormatInfo.DateTimeShortFormat)%></TD>
												</TR>
											</TABLE>
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
</HTML>
