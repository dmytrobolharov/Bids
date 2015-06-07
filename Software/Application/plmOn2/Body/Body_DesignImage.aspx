<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Body_DesignImage.aspx.vb" Inherits="plmOnApp.Body_DesignImage" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="ycl" Namespace="Yunique.Core.Library" Assembly="Yunique.Core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title id="titleImage" runat="server">Image</title>
    	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
		<script language="javascript" src="../System/Jscript/System.js"></script>
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>	
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
		
</head>
<body>
    <form id="form1" runat="server">

        <cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview>
        <table class="TableFloatHeader" height="25" cellSpacing="0" cellPadding="1" width="100%" border="0">
				<tr class="TableHeader" bgColor="whitesmoke">
					<td style="WIDTH: 11px" vAlign="middle" align="center" width="11"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td class="fonthead">
					<cc1:confirmedimagebutton id="imgBtnFolderImage" runat="server" ToolTip="Edit Image ..." Message="NONE"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="imgBtnEditImage" runat="server" ToolTip="Edit Image File..." 	Message="NONE"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnSaveForm" runat="server" Message="NONE" CausesValidation="False"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnCreateNewImage" runat="server" Message="NONE"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="imgBtnImageSelect" runat="server" Message="NONE" CausesValidation="False"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnUpdate" runat="server" Message="NONE" Visible="False"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnCancelUpdate" runat="server" Message="NONE" CausesValidation="False" Visible="False"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="imgBtnCopyImage" runat="server" ToolTip="Copy Image From..." DESIGNTIMEDRAGDROP="18"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="imgBtnDeleteImage" runat="server" ToolTip="Remove Image From Style..." Message="Do you want to remove this image?" CausesValidation="False"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" CausesValidation="False" Visible="false" ></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<TABLE id="Table1" cellSpacing="1" cellPadding="1" width="100%" bgColor="#ffffff" border="0">
				<TR>
					<TD width="900"><asp:placeholder id="plhHeaderControl" runat="server"></asp:placeholder></TD>
					<TD></TD>
				</TR>
			</TABLE>
			<br/>
			<br/>
			<table cellSpacing="0" cellPadding="1" width="100%" border="0">
				<tr>
					<td id="tblImage" vAlign="top" width="20%" runat="server" >
						<table cellSpacing="0" cellPadding="0" width="100%" >
							<tr><td colspan="3"><table height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="whitesmoke" border="0">
								<tr class="TableHeader">
									<td style="WIDTH: 11px" vAlign="middle" align="center" width="11"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
									<td>&nbsp;<asp:Label runat="server" ID="lblImage">Image...</asp:Label></td>
								</tr>
								</table>
							</td>
							</tr>
							<tr bgColor="#ffffff" >
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td><asp:panel id="pnlFileLocked" runat="server" Visible="False">
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
												<TD class="fonthead" align="center"><br/>
													<asp:Label id="lblVersionCurrentText" Text="Do you want to replace version #" runat="server" />
													<asp:Label id="lbVersionCurrent" runat="server"></asp:Label><br/>
													<asp:Label id="lblVersionSelectedText" Text="with this version #" runat="server" />
													<asp:Label id="lbVersionSelected" runat="server" ForeColor="Red"></asp:Label>&nbsp;?<br/>
													<br/>
													<cc1:confirmedimagebutton id="btnReplaceYes" runat="server" Message="NONE"></cc1:confirmedimagebutton>
													<asp:ImageButton id="btnReplaceNo" runat="server"></asp:ImageButton><br/>
													<br/>
													<P></P>
												</TD>
											</TR>
										</TABLE>
									</asp:panel><asp:panel id="pnlCurrentImage" runat="server" HorizontalAlign="Center">
										<asp:label id="lblMessageFileNotFound" runat="server" ForeColor="#C00000"></asp:label>
										<asp:image id="imgDesign" runat="server" BorderColor="Transparent"></asp:image>
										<BR>
										<DIV align="center">
											<asp:label id="lbCopyFrom" runat="server" ForeColor="#C00000"></asp:label></DIV>
									</asp:panel>								
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
							</tr> 
							
						</table>
					</td>
					<td vAlign="top" bgColor="#ffffff"><asp:panel id="pnlProperty" runat="server">
							<TABLE height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TR class="TableHeader" bgColor="whitesmoke">
									<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
									<TD class="fonthead"><asp:Label runat="server" ID="lblImageProperty"></asp:Label></TD>
								</TR>
							</TABLE>
						</asp:panel><asp:panel id="pnlUpload" runat="server" Visible="false">
							<TABLE height="75" cellSpacing="0" cellPadding="1" width="100%" border="0">
								<TR bgColor="#ffffff">
									<TD style="WIDTH: 15px" width="16">&nbsp;</TD>
									<TD class="fontHead" width="125">&nbsp;<asp:Label runat="server" ID="lblImageFile">Image File</asp:Label></TD>
									<TD>&nbsp; <input id="File1" type="file" name="file1" runat="server" />&nbsp;<input id="btnImageUpload" type="submit" value="Upload" name="Upload" runat="server" /></TD>
								</TR>
							</TABLE>
						</asp:panel>&nbsp;&nbsp;&nbsp;<br/>
						<asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder>
						<table height="25" cellSpacing="0" cellPadding="1" width="100%" border="0">
							<tr class="TableHeader" bgColor="whitesmoke">
								<td width="10">&nbsp;</td>
								<td class="fonthead"><asp:Label runat="server" ID="lblImageHistory">Image History...</asp:Label></td>
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
														<cc1:ConfirmedImageButton id=imgBtnImage runat="server" ImageUrl='<%# string.Concat("../Image/Image_Thumbnail.aspx?S=100&amp;Path=" &amp; Yunique.Core.Library.ConfigHandler.GetAppSettings(Yunique.Core.Library.ConfigHandler.AppSettings("STORAGE"))("IMAGETHUMBPATH")&amp; "\{" &amp; DataBinder.Eval(Container.DataItem,"ImageID").tostring &amp; "}\Version\000\{" &amp; DataBinder.Eval(Container.DataItem,"ImageHistoryID").tostring &amp; "}.jpg") %>' Message=' <%# string.format(GetSystemText("Do you want to view version {0}?") , DataBinder.Eval(Container.DataItem,"Version").tostring) %>' CommandName="Edit">
														</cc1:ConfirmedImageButton></TD>
												</TR>
												<TR bgColor="#ffffff">
													<TD class="font" vAlign="middle" align="center"><%# GetSystemText("Version") %>:
														<asp:Label id="lblVersion" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"Version")%>'/>
													</TD>
												</TR>
												<TR bgColor="#ffffff">
													<TD class="font" vAlign="middle" align="center"><%# GetSystemText("Last Modified") %>:<%#Convert.ToDateTime(SystemHandler.GetLocalTime(DataBinder.Eval(Container.DataItem,"MDate"))).ToString(Me.GetFormatInfo.DateTimeShortFormat)%></TD>
												</TR>
											</TABLE>
										</ItemTemplate>
									</asp:datalist></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<p>&nbsp;</p>

    </form>
</body>
</html>
