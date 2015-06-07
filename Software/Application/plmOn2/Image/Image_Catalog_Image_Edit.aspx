<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Image_Catalog_Image_Edit.aspx.vb" Inherits="plmOnApp.Image_Catalog_Image_Edit" EnableEventValidation="false" %>
<%@ Register TagPrefix="uc1" TagName="Image_Catalog_Image_Comment" Src="Image_Catalog_Image_Comment.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Image_Catalog_Comment" Src="Image_Catalog_Comment.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Image_User" Src="Image_User.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="ycl" Namespace="Yunique.Core.Library" Assembly="Yunique.Core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title>Image</title>
		
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	
        <script language="javascript" type="text/javascript">
// <!CDATA[

            function btnImageUpload_onclick() {

            }

// ]]>
        </script>
</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" encType="multipart/form-data" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnNew" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="imgBtnCopyImage" runat="server" ToolTip="Copy Image From..."
							Message="Are you sure you want to copy this image?"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnCancelUpdate" runat="server"  Message="NONE"
							Visible="False"></cc1:confirmedimagebutton>
						<cc1:bwimagebutton id="btn_createstyle" runat="server" 
							Visible="False"></cc1:bwimagebutton>
						<cc1:bwimagebutton id="btn_creatematerial" runat="server" 
							Visible="False"></cc1:bwimagebutton>
						<cc1:BWImageButton id="btnNewIssue" runat="server" Message="NONE" 
							CausesValidation="False"></cc1:BWImageButton>
						<cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"
							CausesValidation="False"></cc1:confirmedimagebutton></td>
					<td width="75">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</TABLE>
			<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblImageHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
							ForeColor="#E0E0E0">Image Catalog...</asp:label></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="1" width="100%" border="0">
				<tr>
					<td vAlign="top" bgColor="#ffffff" align="center">
						<table height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="whitesmoke" border="0">
							<tr class="TableHeader">
								<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td><cc1:confirmedimagebutton id="imgBtnFolderImage" runat="server" 
										Message="NONE" ToolTip="Edit Image ..."></cc1:confirmedimagebutton>
									<cc1:confirmedimagebutton id="imgBtnEditImage" runat="server" 
										Message="NONE" ToolTip="Edit Image File..."></cc1:confirmedimagebutton>
									<cc1:confirmedimagebutton id="imgBtnDeleteImage" runat="server" 
										Message="Are you sure you want to remove this image?" ToolTip="Remove Image From catalog..." CausesValidation="False"></cc1:confirmedimagebutton>
                                    <cc1:confirmedimagebutton id="btnUpdate" runat="server" Message="NONE"	Visible="False"></cc1:confirmedimagebutton>
                                    <asp:ImageButton ID="btnUpload" runat="server" Visible="false"/>
								</td>
								<td>&nbsp;</td>
							</tr>
						</table>
                        <asp:Panel ID="pnlFileUpdateUpload" runat="server" Visible="false">
                            <div>  
                                <CuteWebUI:UploadAttachments runat="server" ID="UploadAttachmentsUpdate" ManualStartUpload="False" AutoUseSystemTempFolder="False"
                                    InsertButtonID="btnUpload" MultipleFilesUpload="false" MaxFilesLimit="1" ShowCheckBoxes="false" ShowFileIcons="false">
                                </CuteWebUI:UploadAttachments>
                                <br />
                            </div>
                        </asp:Panel>
						<table class="MenuGroup" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td align="center"><asp:panel id="pnlFileLocked" runat="server" Visible="False">
										<TABLE cellSpacing="0" cellPadding="1" width="100%" bgColor="#ea0000" border="0">
											<TR>
												<TD width="10">&nbsp;</TD>
												<TD width="20"><IMG height="16" src="../System/Icons/icon_lock.gif" width="16"></TD>
												<TD>&nbsp;
													<asp:Label id="lblFileLocked" runat="server" ForeColor="White"></asp:Label></TD>
											</TR>
										</TABLE>
									</asp:panel><asp:panel id="pnlVersionUpdate" runat="server" Visible="False">
										<TABLE borderColor="limegreen" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ccff99"
											border="1">
											<TR>
												<TD class="fonthead" align="center"><BR>
													<asp:label id="lblQryReplace_1" runat="server">Do you want to replace version #</asp:label>
													<asp:label id="lbVersionCurrent" runat="server"></asp:label><BR>
													<asp:label id="lblQryReplace_2" runat="server">with this version #</asp:label>
													<asp:label id="lbVersionSelected" runat="server" ForeColor="Red"></asp:label>&nbsp;?<BR>
													<BR>
													<cc1:confirmedimagebutton id="btnReplaceYes" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
													<asp:imagebutton id="btnReplaceNo" runat="server" ></asp:imagebutton><BR>
													<BR>
													<P></P>
												</TD>
											</TR>
										</TABLE>
									</asp:panel></td>
							</tr>
						</table>
						<asp:panel id="pnlCurrentImage" runat="server" HorizontalAlign="Center">
							<asp:label id="lblMessageFileNotFound" runat="server" ForeColor="#C00000"></asp:label>
							<BR>
							<asp:image id="imgDesign" runat="server" BorderColor="Transparent"></asp:image>
						</asp:panel>
						<br>
						<asp:label id="lbCopyFrom" runat="server" ForeColor="#C00000"></asp:label></td>
					<td vAlign="top"><asp:panel id="pnlProperty" runat="server">
							<TABLE height="27" cellSpacing="0" cellPadding="0" width="100%">
								<TR class="TableHeader" bgColor="whitesmoke" border="0">
									<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
									<TD class="fonthead">
										<asp:Label id="lblImageProperty" runat="server">Image Property...</asp:Label></TD>
								</TR>
							</TABLE>
						</asp:panel><asp:panel id="pnlUpload" runat="server" Visible="false">
							<TABLE height="75" cellSpacing="0" cellPadding="1" width="100%" border="0">
								<TR bgColor="#ffffff">
									<TD style="WIDTH: 15px" width="16">&nbsp;</TD>
									<TD class="fontHead" width="125">&nbsp;
									<asp:label ID="lblimgFile" runat="server">Image File</asp:label>
									</TD>
									<TD>&nbsp; <INPUT id="File1" type="file" name="file1" runat="server">&nbsp;<INPUT id="btnImageUpload" type="submit" value="Upload" name="Upload" runat="server" onclick="return btnImageUpload_onclick()">
									</TD>
								</TR>
							</TABLE>
						</asp:panel><asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="false"  ></asp:placeholder>
						
						<BR>
				        <uc1:Image_Catalog_Comment id="Image_Catalog_Comment" runat="server" />

						
						<!-- -->
						<table height="25" cellSpacing="0" cellPadding="1" width="100%" border="0">
							<tr class="TableHeader" bgColor="whitesmoke">
								<td width="10">&nbsp;</td>
								<td class="fonthead"><asp:label id="lblImageHistory" runat="server">Image History...</asp:label></td>
							</tr>
						</table>
						<table cellSpacing="0" cellPadding="1" width="100%" border="0">
							<tr>
								<td vAlign="top" bgColor="#ffffff"><asp:datalist id="DataList1" runat="server" OnItemCommand="DataList1_ItemCommand" CellPadding="0"
										CellSpacing="0" EnableViewState="true" RepeatColumns="3" RepeatDirection="Horizontal" ShowFooter="False" ShowHeader="False">
										<ItemTemplate>
											<TABLE cellSpacing="0" cellPadding="1" width="125" border='<%# SelectHTMLImageCurrentVersion(DataBinder.Eval(Container.DataItem,"Version")) %>' bordercolor=CornflowerBlue>
												<TR bgColor="#ffffff">
													<TD vAlign="middle" align="center">
														<cc1:ConfirmedImageButton id=imgBtnImage runat="server" CommandName="Edit">
														</cc1:ConfirmedImageButton></TD>
												</TR>
												<TR bgColor="#ffffff">
													<TD class="font" vAlign="middle" align="center">
													    <asp:Label ID="lblVersionLabel" runat="server" Text='<%#GetSystemText("Version")%>' > </asp:Label>:
														<asp:Label id="lblVersion" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"Version")%>'/>
													</TD>
												</TR>
												<TR bgColor="#ffffff">
													<TD class="font" vAlign="middle" align="center">
													<asp:Label ID="lblLastModifiedLabel" runat="server" Text='<%#GetSystemText("Last Modified")%>'></asp:Label>:
													<%# Convert.ToDateTime(SystemHandler.GetLocalTime(DataBinder.Eval(Container.DataItem, "ImageDateLastModified"))).ToString(Me.GetFormatInfo.DateTimeShortFormat)%></TD>
												</TR>
											</TABLE>
										</ItemTemplate>
									</asp:datalist></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<asp:textbox id="txtURL" runat="server" Visible="False"></asp:textbox>
			<p>&nbsp;</p>
		</form>
        <script  language="javascript" type="text/javascript">
                    function btnClose_Click() {
                        <%= strExitScript %>;
                        return false;
                    }
        </script>
	</body>
</HTML>
