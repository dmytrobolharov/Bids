<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Submit_Spec_SampleSize.aspx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Submit_Spec_SampleSize" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle"></title>
		<META http-equiv="Content-Type" content="text/html; charset=windows-1252">
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body onblur="this.focus();" onload="self.focus()">
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                    <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton></td>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td vAlign="middle">&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:label>
						<asp:label id="lblSampleRequired" runat="server" ForeColor="Red" CssClass="FontHead"></asp:label></td>
				</tr>
			</table>
			<TABLE id="TABLE1" borderColor="#cccccc" cellSpacing="0" cellPadding="0" width="300" bgColor="#ffffff"
				border="1" runat="server">
				<TR class="TableHeader">
					<TD style="WIDTH: 96px" height="20">
						<P align="center">
                            <asp:Label ID="lblSizeH" runat="server" ></asp:Label></P>
					</TD>
					<TD height="20">&nbsp;<asp:Label ID="lblSampleH" runat="server" ></asp:Label></TD>
				</TR>
				<TR id="TR1" runat="server">
					<TD style="WIDTH: 96px">&nbsp;
						<asp:textbox id="TextBox1" runat="server" Width="64px" MaxLength="5"></asp:textbox><asp:requiredfieldvalidator id="rvSize1" runat="server" CssClass="Fonthead" Display="Dynamic" 
							ControlToValidate="TextBox1" ErrorMessage="*"></asp:requiredfieldvalidator></TD>
					<TD>&nbsp;
						<asp:radiobutton id="RadioButton1" runat="server" GroupName="Sample"></asp:radiobutton></TD>
				</TR>
				<TR id="TR2" runat="server">
					<TD style="WIDTH: 96px">&nbsp;
						<asp:textbox id="TextBox2" runat="server" Width="64px" MaxLength="5"></asp:textbox></TD>
					<TD>&nbsp;
						<asp:radiobutton id="RadioButton2" runat="server" GroupName="Sample"></asp:radiobutton></TD>
				</TR>
				<TR id="TR3" runat="server">
					<TD style="WIDTH: 96px">&nbsp;
						<asp:textbox id="TextBox3" runat="server" Width="64px" MaxLength="5"></asp:textbox></TD>
					<TD>&nbsp;
						<asp:radiobutton id="RadioButton3" runat="server" GroupName="Sample"></asp:radiobutton></TD>
				</TR>
				<TR id="TR4" runat="server">
					<TD style="WIDTH: 96px">&nbsp;
						<asp:textbox id="TextBox4" runat="server" Width="64px" MaxLength="5"></asp:textbox></TD>
					<TD>&nbsp;
						<asp:radiobutton id="RadioButton4" runat="server" GroupName="Sample"></asp:radiobutton></TD>
				</TR>
				<TR id="TR5" runat="server">
					<TD style="WIDTH: 96px">&nbsp;
						<asp:textbox id="TextBox5" runat="server" Width="64px" MaxLength="5"></asp:textbox></TD>
					<TD>&nbsp;
						<asp:radiobutton id="RadioButton5" runat="server" GroupName="Sample"></asp:radiobutton></TD>
				</TR>
				<TR id="TR6" runat="server">
					<TD style="WIDTH: 96px">&nbsp;
						<asp:textbox id="TextBox6" runat="server" Width="64px" MaxLength="5"></asp:textbox></TD>
					<TD>&nbsp;
						<asp:radiobutton id="RadioButton6" runat="server" GroupName="Sample"></asp:radiobutton></TD>
				</TR>
				<TR id="TR7" runat="server">
					<TD style="WIDTH: 96px">&nbsp;
						<asp:textbox id="TextBox7" runat="server" Width="64px" MaxLength="5"></asp:textbox></TD>
					<TD>&nbsp;
						<asp:radiobutton id="RadioButton7" runat="server" GroupName="Sample"></asp:radiobutton></TD>
				</TR>
				<TR id="TR8" runat="server">
					<TD style="WIDTH: 96px">&nbsp;
						<asp:textbox id="TextBox8" runat="server" Width="64px" MaxLength="5"></asp:textbox></TD>
					<TD>&nbsp;
						<asp:radiobutton id="RadioButton8" runat="server" GroupName="Sample"></asp:radiobutton></TD>
				</TR>
				<TR id="TR9" runat="server">
					<TD style="WIDTH: 96px">&nbsp;
						<asp:textbox id="TextBox9" runat="server" Width="64px" MaxLength="5"></asp:textbox></TD>
					<TD>&nbsp;
						<asp:radiobutton id="RadioButton9" runat="server" GroupName="Sample"></asp:radiobutton></TD>
				</TR>
				<TR id="TR10" runat="server">
					<TD style="WIDTH: 96px">&nbsp;
						<asp:textbox id="TextBox10" runat="server" Width="64px" MaxLength="5"></asp:textbox></TD>
					<TD>&nbsp;
						<asp:radiobutton id="RadioButton10" runat="server" GroupName="Sample"></asp:radiobutton></TD>
				</TR>
				<TR id="TR11" runat="server">
					<TD style="WIDTH: 96px">&nbsp;
						<asp:textbox id="TextBox11" runat="server" Width="64px" MaxLength="5"></asp:textbox></TD>
					<TD>&nbsp;
						<asp:radiobutton id="RadioButton11" runat="server" GroupName="Sample"></asp:radiobutton></TD>
				</TR>
				<TR id="TR12" runat="server">
					<TD style="WIDTH: 96px">&nbsp;
						<asp:textbox id="TextBox12" runat="server" Width="64px" MaxLength="5"></asp:textbox></TD>
					<TD>&nbsp;
						<asp:radiobutton id="RadioButton12" runat="server" GroupName="Sample"></asp:radiobutton></TD>
				</TR>
				<TR id="Tr13" runat="server">
					<TD style="WIDTH: 96px">&nbsp;
						<asp:textbox id="Textbox13" runat="server" Width="64px" MaxLength="5"></asp:textbox></TD>
					<TD>&nbsp;
						<asp:radiobutton id="Radiobutton13" runat="server" GroupName="Sample"></asp:radiobutton></TD>
				</TR>
				<TR id="Tr14" runat="server">
					<TD style="WIDTH: 96px">&nbsp;
						<asp:textbox id="Textbox14" runat="server" Width="64px" MaxLength="5"></asp:textbox></TD>
					<TD>&nbsp;
						<asp:radiobutton id="Radiobutton14" runat="server" GroupName="Sample"></asp:radiobutton></TD>
				</TR>
				<TR id="Tr15" runat="server">
					<TD style="WIDTH: 96px">&nbsp;
						<asp:textbox id="Textbox15" runat="server" Width="64px" MaxLength="5"></asp:textbox></TD>
					<TD>&nbsp;
						<asp:radiobutton id="Radiobutton15" runat="server" GroupName="Sample"></asp:radiobutton></TD>
				</TR>
				<TR id="Tr16" runat="server">
					<TD style="WIDTH: 96px">&nbsp;
						<asp:textbox id="Textbox16" runat="server" Width="64px" MaxLength="5"></asp:textbox></TD>
					<TD>&nbsp;
						<asp:radiobutton id="Radiobutton16" runat="server" GroupName="Sample"></asp:radiobutton></TD>
				</TR>
				<TR id="Tr17" runat="server">
					<TD style="WIDTH: 96px">&nbsp;
						<asp:textbox id="Textbox17" runat="server" Width="64px" MaxLength="5"></asp:textbox></TD>
					<TD>&nbsp;
						<asp:radiobutton id="Radiobutton17" runat="server" GroupName="Sample"></asp:radiobutton></TD>
				</TR>
				<TR id="Tr18" runat="server">
					<TD style="WIDTH: 96px">&nbsp;
						<asp:textbox id="Textbox18" runat="server" Width="64px" MaxLength="5"></asp:textbox></TD>
					<TD>&nbsp;
						<asp:radiobutton id="Radiobutton18" runat="server" GroupName="Sample"></asp:radiobutton></TD>
				</TR>
				<TR id="Tr19" runat="server">
					<TD style="WIDTH: 96px">&nbsp;
						<asp:textbox id="Textbox19" runat="server" Width="64px" MaxLength="5"></asp:textbox></TD>
					<TD>&nbsp;
						<asp:radiobutton id="Radiobutton19" runat="server" GroupName="Sample"></asp:radiobutton></TD>
				</TR>
				<TR id="Tr20" runat="server">
					<TD style="WIDTH: 96px">&nbsp;
						<asp:textbox id="Textbox20" runat="server" MaxLength="5" Width="64px"></asp:textbox></TD>
					<TD>&nbsp;
						<asp:radiobutton id="Radiobutton20" runat="server" GroupName="Sample"></asp:radiobutton></TD>
				</TR>
			</TABLE>
			<br>
		</form>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</HTML>
