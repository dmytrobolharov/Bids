<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_SampleSize.aspx.vb" Inherits="plmOnApp.Style_SampleSize" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Sample Size</title>
		<META http-equiv="Content-Type" content="text/html; charset=windows-1252">	
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</head>
	<body onblur="this.focus();" onload="self.focus()">
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton></td>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td valign="middle">&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Sample Size</asp:label>
						<asp:label id="lblSampleRequired" runat="server" ForeColor="Red" CssClass="FontHead"></asp:label></td>
				</tr>
			</table>
			<table id="TABLE1" borderColor="#cccccc" cellSpacing="0" cellpadding="0" width="300" bgColor="#ffffff"
				border="1" runat="server">
				<tr class="TableHeader">
					<td style="WIDTH: 96px" height="20">
						<P align="center"><asp:label id="lblSize" Runat="server" CssClass="fontHead">Size</asp:label></P>
					</td>
					<td height="20">&nbsp;<asp:label id="lblSample" Runat="server" CssClass="fontHead">Sample</asp:label></td>
				</tr>
				<tr id="TR1" runat="server">
					<td style="WIDTH: 96px">&nbsp;
						<asp:textbox id="TextBox1" runat="server" Width="64px" MaxLength="5"></asp:textbox><asp:requiredfieldvalidator id="rvSize1" runat="server" CssClass="Fonthead" Display="Dynamic" ToolTip="Required Size"
							ControlToValidate="TextBox1" ErrorMessage="*"></asp:requiredfieldvalidator></td>
					<td>&nbsp;
						<asp:radiobutton id="RadioButton1" runat="server" GroupName="Sample"></asp:radiobutton></td>
				</tr>
				<tr id="TR2" runat="server">
					<td style="WIDTH: 96px">&nbsp;
						<asp:textbox id="TextBox2" runat="server" Width="64px" MaxLength="5"></asp:textbox></td>
					<td>&nbsp;
						<asp:radiobutton id="RadioButton2" runat="server" GroupName="Sample"></asp:radiobutton></td>
				</tr>
				<tr id="TR3" runat="server">
					<td style="WIDTH: 96px">&nbsp;
						<asp:textbox id="TextBox3" runat="server" Width="64px" MaxLength="5"></asp:textbox></td>
					<td>&nbsp;
						<asp:radiobutton id="RadioButton3" runat="server" GroupName="Sample"></asp:radiobutton></td>
				</tr>
				<tr id="TR4" runat="server">
					<td style="WIDTH: 96px">&nbsp;
						<asp:textbox id="TextBox4" runat="server" Width="64px" MaxLength="5"></asp:textbox></td>
					<td>&nbsp;
						<asp:radiobutton id="RadioButton4" runat="server" GroupName="Sample"></asp:radiobutton></td>
				</tr>
				<tr id="TR5" runat="server">
					<td style="WIDTH: 96px">&nbsp;
						<asp:textbox id="TextBox5" runat="server" Width="64px" MaxLength="5"></asp:textbox></td>
					<td>&nbsp;
						<asp:radiobutton id="RadioButton5" runat="server" GroupName="Sample"></asp:radiobutton></td>
				</tr>
				<tr id="TR6" runat="server">
					<td style="WIDTH: 96px">&nbsp;
						<asp:textbox id="TextBox6" runat="server" Width="64px" MaxLength="5"></asp:textbox></td>
					<td>&nbsp;
						<asp:radiobutton id="RadioButton6" runat="server" GroupName="Sample"></asp:radiobutton></td>
				</tr>
				<tr id="TR7" runat="server">
					<td style="WIDTH: 96px">&nbsp;
						<asp:textbox id="TextBox7" runat="server" Width="64px" MaxLength="5"></asp:textbox></td>
					<td>&nbsp;
						<asp:radiobutton id="RadioButton7" runat="server" GroupName="Sample"></asp:radiobutton></td>
				</tr>
				<tr id="TR8" runat="server">
					<td style="WIDTH: 96px">&nbsp;
						<asp:textbox id="TextBox8" runat="server" Width="64px" MaxLength="5"></asp:textbox></td>
					<td>&nbsp;
						<asp:radiobutton id="RadioButton8" runat="server" GroupName="Sample"></asp:radiobutton></td>
				</tr>
				<tr id="TR9" runat="server">
					<td style="WIDTH: 96px">&nbsp;
						<asp:textbox id="TextBox9" runat="server" Width="64px" MaxLength="5"></asp:textbox></td>
					<td>&nbsp;
						<asp:radiobutton id="RadioButton9" runat="server" GroupName="Sample"></asp:radiobutton></td>
				</tr>
				<tr id="TR10" runat="server">
					<td style="WIDTH: 96px">&nbsp;
						<asp:textbox id="TextBox10" runat="server" Width="64px" MaxLength="5"></asp:textbox></td>
					<td>&nbsp;
						<asp:radiobutton id="RadioButton10" runat="server" GroupName="Sample"></asp:radiobutton></td>
				</tr>
				<tr id="TR11" runat="server">
					<td style="WIDTH: 96px">&nbsp;
						<asp:textbox id="TextBox11" runat="server" Width="64px" MaxLength="5"></asp:textbox></td>
					<td>&nbsp;
						<asp:radiobutton id="RadioButton11" runat="server" GroupName="Sample"></asp:radiobutton></td>
				</tr>
				<tr id="TR12" runat="server">
					<td style="WIDTH: 96px">&nbsp;
						<asp:textbox id="TextBox12" runat="server" Width="64px" MaxLength="5"></asp:textbox></td>
					<td>&nbsp;
						<asp:radiobutton id="RadioButton12" runat="server" GroupName="Sample"></asp:radiobutton></td>
				</tr>
				<tr id="Tr13" runat="server">
					<td style="WIDTH: 96px">&nbsp;
						<asp:textbox id="Textbox13" runat="server" Width="64px" MaxLength="5"></asp:textbox></td>
					<td>&nbsp;
						<asp:radiobutton id="Radiobutton13" runat="server" GroupName="Sample"></asp:radiobutton></td>
				</tr>
				<tr id="Tr14" runat="server">
					<td style="WIDTH: 96px">&nbsp;
						<asp:textbox id="Textbox14" runat="server" Width="64px" MaxLength="5"></asp:textbox></td>
					<td>&nbsp;
						<asp:radiobutton id="Radiobutton14" runat="server" GroupName="Sample"></asp:radiobutton></td>
				</tr>
				<tr id="Tr15" runat="server">
					<td style="WIDTH: 96px">&nbsp;
						<asp:textbox id="Textbox15" runat="server" Width="64px" MaxLength="5"></asp:textbox></td>
					<td>&nbsp;
						<asp:radiobutton id="Radiobutton15" runat="server" GroupName="Sample"></asp:radiobutton></td>
				</tr>
				<tr id="Tr16" runat="server">
					<td style="WIDTH: 96px">&nbsp;
						<asp:textbox id="Textbox16" runat="server" Width="64px" MaxLength="5"></asp:textbox></td>
					<td>&nbsp;
						<asp:radiobutton id="Radiobutton16" runat="server" GroupName="Sample"></asp:radiobutton></td>
				</tr>
				<tr id="Tr17" runat="server">
					<td style="WIDTH: 96px">&nbsp;
						<asp:textbox id="Textbox17" runat="server" Width="64px" MaxLength="5"></asp:textbox></td>
					<td>&nbsp;
						<asp:radiobutton id="Radiobutton17" runat="server" GroupName="Sample"></asp:radiobutton></td>
				</tr>
				<tr id="Tr18" runat="server">
					<td style="WIDTH: 96px">&nbsp;
						<asp:textbox id="Textbox18" runat="server" Width="64px" MaxLength="5"></asp:textbox></td>
					<td>&nbsp;
						<asp:radiobutton id="Radiobutton18" runat="server" GroupName="Sample"></asp:radiobutton></td>
				</tr>
				<tr id="Tr19" runat="server">
					<td style="WIDTH: 96px">&nbsp;
						<asp:textbox id="Textbox19" runat="server" Width="64px" MaxLength="5"></asp:textbox></td>
					<td>&nbsp;
						<asp:radiobutton id="Radiobutton19" runat="server" GroupName="Sample"></asp:radiobutton></td>
				</tr>
				<tr id="Tr20" runat="server">
					<td style="WIDTH: 96px">&nbsp;
						<asp:textbox id="Textbox20" runat="server" MaxLength="5" Width="64px"></asp:textbox></td>
					<td>&nbsp;
						<asp:radiobutton id="Radiobutton20" runat="server" GroupName="Sample"></asp:radiobutton></td>
				</tr>
			</table>
			<br>
		</form>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</html>
