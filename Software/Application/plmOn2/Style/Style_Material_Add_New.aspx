<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Material_Add_New.aspx.vb" Inherits="plmOnApp.Style.Material.Style_Material_Add_New" enableViewState="False"%>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
	<head>
		<title>Style_Main</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
         <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>

	</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table height="100" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td>
						<table height="75" cellSpacing="0" cellpadding="0" width="100%" background="../System/Images/MiddleFill.jpg"
							border="0">
							<tr>
								<td>
									<table cellSpacing="0" cellpadding="0" width="800" border="0">
										<tr>
											<td>&nbsp;</td>
											<td>
												<div align="right"><IMG src="../System/Icons/icon_32_1.gif"></div>
											</td>
											<td class="fontHead" style="FONT-SIZE: 12pt">&nbsp;<asp:Label ID="lblCreatingH" runat="server"></asp:Label></td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>
												<div align="right"></div>
											</td>
											<td>
												<table cellSpacing="0" cellpadding="0" width="100%" border="0">
													<tr>
														<td>&nbsp;</td>
														<td width="50"><cc1:confirmedimagebutton id="btnCancel" runat="server"  Visible="False"></cc1:confirmedimagebutton></td>
                                                        <td>
                                                        <cc1:confirmedimagebutton id="btnNext" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
                                                        <cc1:confirmedimagebutton id="btnSaveMaterial" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                                                        </td>
													</tr>
												</table>
											</td>
											<td>&nbsp;</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<table > <tr>
			<td bgcolor="#ffffff" valign="top"><asp:panel id="pnlMaterial" runat="server">
					<table height="100" cellSpacing="0" cellpadding="0" width="100%" border="0">
						<tr valign="top">
							<td width="10">&nbsp;</td>
							<td>
								<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
						</tr>
					</table>
				</asp:panel><br>
			</td>
			<td bgcolor="#f5f5f5" width="10%">&nbsp;</td>
			</tr></table></form>
	</body>
</html>
