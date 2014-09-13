<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SendError.aspx.vb" Inherits="plmOnApp.SendError" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title id="PageTitle" runat="server">Bug Tracking</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<link href="System/CSS/Style.css" rel="stylesheet" type="text/css">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="./System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
					<td class="FontHead" align="right" width="75"></td>
					<td width="40"></td>
					<td></td>
				</tr>
			</table>
            <div runat="server" id="divMessage">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff" height="50">
				<tr>
					<td width="10">&nbsp;</td>
					<td width="60">
						<div align="center"><img src="./System/Icons/icon_bug48.gif"  border="0"></div>
					</td>
					<td class="fontHead"><asp:Label ID="lblErr" runat="server" Text="We have created an error report that you can send to help us improve Yunique Solutions."></asp:Label></td>
				</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="White">
				<tr>
					<td width="10" height="25">&nbsp;</td>
					<td width="60" height="25">&nbsp;</td>
					<td class="fontHead" height="25">
					<asp:Label ID="lblYun" runat="server" Text="Please tell Yunique Solutions about this problem."></asp:Label>
					<br/>(<asp:Label ID="lblErrNo" runat="server" Text="Error No."></asp:Label>:
						<asp:Label id="lblErrorNo" runat="server"></asp:Label>)<br/><br /></td>
				</tr>
		    </table>
		    </div>			
			<table cellSpacing="2" cellPadding="0" width="100%" border="0" bgcolor="White">
				<tr>
				    <td vAlign="top" width="100">&nbsp;</td>
					<td><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
				</tr>
				<tr>
				    <td vAlign="top" width="100">&nbsp;</td>
					<td>
                        <asp:Label ID="lbl_SentMessage" runat="server"></asp:Label>
                    </td>
				</tr>
				<tr>
				    <td vAlign="top" width="100">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top"></td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
