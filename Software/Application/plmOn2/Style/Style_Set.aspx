<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Set.aspx.vb" Inherits="plmOnApp.Style_Set" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Style Set</title>
		
		
		<link
		
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</head>
	<body onload="self.focus()">
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSaveSet" runat="server" Message="NONE"
							></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE"
							></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<table height="15" cellSpacing="0" cellpadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="100%" border="0" bgColor="#ffffff">
				<tr>
					<td>
						<DIV align="left"><asp:label id="lblStyleHeaderNew" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
								ForeColor="#E0E0E0">Edit Style Set...</asp:label></DIV>
					</td>
				</tr>
			</table>
			<br>
			<table cellSpacing="1" cellpadding="1" width="100%" border="0">
				<tr>
					<td width="50">&nbsp;</td>
					<td width="75">
                    <asp:label id="Set1" runat="server" CssClass="fontHead"></asp:label>
                    </td>
					<td>&nbsp;
						<asp:textbox id="txtSet1" runat="server" CssClass="fontHead"></asp:textbox>
                        <asp:HiddenField ID="hdnSet1" runat="server" />
                        </td>
				</tr>
				<tr>
					<td width="50">&nbsp;</td>
					<td width="75"><asp:label id="Set2" runat="server" CssClass="fontHead"></asp:label></td>
					<td>&nbsp;
						<asp:textbox id="txtSet2" runat="server" CssClass="fontHead"></asp:textbox>
                        <asp:HiddenField ID="hdnSet2" runat="server" />
                        </td>
				</tr>
				<tr>
					<td width="50">&nbsp;</td>
					<td width="75"><asp:label id="Set3" runat="server" CssClass="fontHead"></asp:label></td>
					<td>&nbsp;
						<asp:textbox id="txtSet3" runat="server" CssClass="fontHead"></asp:textbox>
                        <asp:HiddenField ID="hdnSet3" runat="server" />
                        </td>
				</tr>
				<tr>
					<td width="50">&nbsp;</td>
					<td width="75"><asp:label id="Set4" runat="server" CssClass="fontHead"></asp:label></td>
					<td>&nbsp;
						<asp:textbox id="txtSet4" runat="server" CssClass="fontHead"></asp:textbox>
                        <asp:HiddenField ID="hdnSet4" runat="server" />
                        </td>
				</tr>
			</table>
		</form>
	</body>
</html>
