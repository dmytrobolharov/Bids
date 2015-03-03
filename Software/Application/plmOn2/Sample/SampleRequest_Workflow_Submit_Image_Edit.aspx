<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Submit_Image_Edit.aspx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Submit_Image_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Image</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
		<script language="javascript">
			function calendar(sTxtBoxName)
			{
			windowDatePicker = window.open("../System/Control/month_popup.aspx?txtbox=" + sTxtBoxName,"dp","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=200,height=180,left=375,top=200");
			windowDatePicker.focus();
			}
		</script>
	</HEAD>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" encType="multipart/form-data" runat="server">
			<!--

			-->
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnNew" runat="server" Message="NONE"	Visible="False"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnUpdate" runat="server" Message="NONE" Visible="False"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnCancelUpdate" runat="server" Message="NONE" Visible="False"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" CausesValidation="False" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
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
							ForeColor="#E0E0E0"></asp:label></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="1" width="100%" border="0">
				<tr>
					<td vAlign="top" bgColor="#ffffff">
						<table height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="whitesmoke" border="0">
							<tr class="TableHeader">
								<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td><cc1:confirmedimagebutton id="imgBtnFolderImage" runat="server" Message="NONE" Visible="False"></cc1:confirmedimagebutton>
								<cc1:confirmedimagebutton id="imgBtnEditImage" runat="server" Message="NONE"  Visible="False"></cc1:confirmedimagebutton></td>
								<td>&nbsp;</td>
							</tr>
						</table>
						<table class="MenuGroup" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td align="center"><asp:label id="lblMessageFileNotFound" runat="server" ForeColor="#C00000"></asp:label><BR>
									<cc1:bwimagebutton id="imgDesign" runat="server" BorderColor="Transparent"></cc1:bwimagebutton></td>
							</tr>
						</table>
						<br>
						<div align="center">&nbsp;</div>
					</td>
					<td vAlign="top"><asp:panel id="pnlProperty" runat="server">
							<TABLE height="27" cellSpacing="0" cellPadding="0" width="100%">
								<TR class="TableHeader" bgColor="whitesmoke" border="0">
									<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
									<TD class="fonthead">
										<asp:Label id="lblImageProperty" runat="server"></asp:Label></TD>
								</TR>
							</TABLE>
						</asp:panel><asp:panel id="pnlUpload" runat="server" Visible="true">
							<TABLE height="75" cellSpacing="0" cellPadding="1" width="100%" border="0">
								<TR bgColor="#ffffff">
									<TD style="WIDTH: 15px" width="16">&nbsp;</TD>
									<TD class="fontHead" width="125">&nbsp;<asp:Label ID="lblImageFile" runat="server"><%#GetSystemText("Image File")%></asp:Label></TD>
									<TD>&nbsp;<INPUT id="File1" type="file" name="file1" runat="server">&nbsp;<INPUT id="btnImageUpload" type="submit" value="Upload" name="Upload" runat="server">
									</TD>
								</TR>
								<TR bgColor="#ffffff">
									<TD style="WIDTH: 15px" width="16">&nbsp;</TD>
									<TD class="fontHead" width="125">&nbsp;<asp:Label ID="lblDescription" runat="server"></asp:Label></TD>
									<TD>&nbsp;
										<asp:TextBox id="txtDescription" CssClass="font" Runat="server" MaxLength="200" ></asp:TextBox></TD>
								</TR>
							</TABLE>
						</asp:panel><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
				</tr>
			</table>
			<asp:textbox id="txtURL" runat="server" Visible="False"></asp:textbox></form>
            <script language="javascript">
	            function btnClose_Click() {
		            <%= strExitScript %>
                    return false;
                }
            </script>
	</body>
</HTML>
