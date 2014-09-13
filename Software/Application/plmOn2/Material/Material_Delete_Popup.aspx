<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_Delete_Popup.aspx.vb" Inherits="plmOnApp.Material_Delete_Popup"%>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<TITLE id="htmlHeader" runat=server ></TITLE>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table cellspacing="0" cellpadding="0" width="100%" border="0" bgcolor="#ffffff">
				<tr>
					<td width="10"></td>
					<td width="50" height="50"><IMG src="../System/Icons/icon_critical32.gif"></td>
					<td>
						<asp:Label id="lblHeader" runat="server" CssClass="fontHead">You are about to delete this material</asp:Label></td>
				</tr>
			</table>
            <div id="deleteBox" style="padding-left: 55px;">
                <table cellspacing="0" cellpadding="0" width="350" border="0">
                    <tr>
                        <td width="100"><asp:Label ID="lblReasonCode" runat="server" CssClass="fontHead"></asp:Label></td>
                        <td><asp:DropDownList ID="drlReasonCode" runat="server" Width="200"></asp:DropDownList></td>
                        <td><asp:RequiredFieldValidator ID="valReasonCode" runat="server" ControlToValidate="drlReasonCode" Text="<IMG height='17' src='../System/Icons/icon_warning.gif' border='0'>"></asp:RequiredFieldValidator></td>
                    </tr>
                    <tr>
                        <td width="100"><asp:Label ID="lblReasonComment" runat="server" CssClass="fontHead"></asp:Label></td>
                        <td><asp:TextBox ID="txtReasonComment" runat="server" TextMode="multiline" Rows="3" Width="200"></asp:TextBox></td>
                        <td><asp:RequiredFieldValidator ID="valReasonComment" runat="server" ControlToValidate="txtReasonComment" Text="<IMG height='17' src='../System/Icons/icon_warning.gif' border='0'>"></asp:RequiredFieldValidator></td>
                    </tr>
                </table>
                <div id="buttonPanel" style="padding-left: 55px;">
			        <cc1:confirmedimagebutton id="btnDelete" runat="server"  Message="NONE" CausesValidation="true"></cc1:confirmedimagebutton>
			        <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" CausesValidation="false"></cc1:confirmedimagebutton>
                </div>
            </div>
		</form>
	</body>
</html>
