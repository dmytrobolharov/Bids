<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Vendor_Folder_AddContact.aspx.vb" Inherits="srmOnApp.Vendor_Folder_AddContact" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>New Contact</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR>
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD width="500">
					<cc2:confirmedimagebutton id="btnAdd" runat="server" Message="NONE" ></cc2:confirmedimagebutton>
					<cc2:confirmedimagebutton id="btnClose" runat="server" Message="NONE" CausesValidation="false" OnClientClick="return btnClose_Click()"></cc2:confirmedimagebutton>
					</TD>
					<TD>&nbsp;</TD>
				</TR>
			</TABLE>
			<TABLE height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="gray" border="0">
				<TR>
					<TD width="10">&nbsp;</TD>
					<TD class="fontHead"><FONT color="white">&nbsp;<asp:Label ID="lblNewContact" runat="server"></asp:Label> </FONT></TD>
				</TR>
			</TABLE>
            <table cellspacing="0" cellpadding="0" width="100%" border="0">
                <tr>
                    <td valign="top" bgcolor="#ffffff">
                        <table cellspacing="2" cellpadding="0" width="100%" border="0">
                            <tr>
                                <td>
                                    <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>			
<%--			<TABLE cellSpacing="1" cellPadding="1" bgColor="#ffffff" border="0">
				<TR>
					<TD width="10">&nbsp;</TD>
					<TD class="fontHead" width="125"><asp:Label ID="lblFirstName" runat="server"></asp:Label></TD>
					<TD><asp:textbox id="txtFirstname" runat="server" Width="150px" TabIndex="0"></asp:textbox></TD>
					<TD width="10">&nbsp;</TD>
					<TD class="fontHead" width="125"><asp:Label ID="lblPhone" runat="server"></asp:Label></TD>
					<TD><asp:textbox id="txtPhoneNumber" runat="server" TabIndex="3"></asp:textbox></TD>
				</TR>
				<TR>
					<TD width="10">&nbsp;</TD>
					<TD class="fontHead" width="125"><asp:Label ID="lblLastName" runat="server"></asp:Label></TD>
					<TD><asp:textbox id="txtLastName" runat="server" Width="150px" TabIndex="1"></asp:textbox></TD>
					<TD width="10">&nbsp;</TD>
					<TD class="fontHead" width="125"><asp:Label ID="lblMobile" runat="server"></asp:Label></TD>
					<TD><asp:textbox id="txtMobileNumber" runat="server" TabIndex="4"></asp:textbox></TD>
				</TR>
				<TR>
					<TD width="10">&nbsp;</TD>
					<TD class="fontHead" width="125"><asp:Label ID="lblTitle" runat="server"></asp:Label></TD>
					<TD><asp:textbox id="txtTitle" runat="server" Width="150px" TabIndex="2"></asp:textbox></TD>
					<TD width="10">&nbsp;</TD>
					<TD class="fontHead" width="125"><asp:Label ID="lblEmail" runat="server"></asp:Label></TD>
					<TD><asp:textbox id="txtEmail" runat="server" TabIndex="5"></asp:textbox></TD>
				</TR>
			</TABLE>--%>
		</form>
	</body>
	<script type="text/javascript">
		function btnClose_Click() {
			<%= strExitScript %>
			return false;
		}
	</script>
</HTML>
