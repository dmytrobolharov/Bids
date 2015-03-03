<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Vendor_FolderPage_ImageEdit.aspx.vb" Inherits="plmOnApp.Vendor_FolderPage_ImageEdit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
		<title runat="server" id="PageTitle">Image</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
</head>
	<body>
		<form id="Form1" method="post" enctype="multipart/form-data" runat="server">
			<!--

			-->
			<table class="tableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" CausesValidation="False" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton>
                     </td>
					<td>&nbsp;</td>
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
					<td>&nbsp;<asp:label id="lblImageHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
							ForeColor="#E0E0E0"></asp:label></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="1" width="100%" border="0">
				<tr>
					<td valign="top" bgColor="#ffffff">
						<table height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="whitesmoke" border="0">
							<tr class="tableHeader">
								<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td></td>
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
					<td valign="top"><asp:panel id="pnlProperty" runat="server">
							<table height="27" cellSpacing="0" cellPadding="0" width="100%">
								<TR class="tableHeader" bgColor="whitesmoke" border="0">
									<TD valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
									<TD class="fonthead">
										<asp:Label id="lblImageProperty" runat="server"></asp:Label></TD>
								</TR>
							</table>
						</asp:panel><asp:panel id="pnlUpload" runat="server" Visible="true">
							<table height="75" cellSpacing="0" cellPadding="1" width="100%" border="0">
								<TR bgColor="#ffffff">
									<TD style="WIDTH: 15px" width="16">&nbsp;</TD>
									<TD class="fontHead" width="125">&nbsp;<asp:Label ID="lblImageFile" runat="server"><%#GetSystemText("Image File")%></asp:Label></TD>
									<TD>&nbsp;<INPUT id="File1" type="file" name="file1" runat="server">&nbsp;
									</TD>
								</TR>
								<TR bgColor="#ffffff">
									<TD style="WIDTH: 15px" width="16">&nbsp;</TD>
									<TD class="fontHead" width="125">&nbsp;<asp:Label ID="lblDescription" runat="server"></asp:Label></TD>
									<TD>&nbsp;
										<asp:TextBox id="txtDescription" CssClass="font" Runat="server" MaxLength="200" ></asp:TextBox></TD>
								</TR>
							</table>
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

</html>
