<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_User_Edit_Password.aspx.vb" Inherits="plmOnApp.Control_User_Edit_Password" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Options</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<BR>
			<cc3:ystabview id="YSTabView1" runat="server"></cc3:ystabview><asp:panel id="pnlUserOption" runat="server">
				<TABLE class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0">
					<TR>
						<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
						<TD width="100%">
							<cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"
								CausesValidation="False"></cc1:confirmedimagebutton>
						<TD>
						<TD>&nbsp;</TD>
					</TR>
				</TABLE>
				<asp:label id="lblMsg" CssClass="fontRed" Runat="server"></asp:label>
				<TABLE cellSpacing="0" cellPadding="0" width="270" border="0">
					<TR>
						<TD width="120">&nbsp;</TD>
						<TD>&nbsp;</TD>
					</TR>
					<TR>
						<TD class="fontHead" width="120"><asp:Label ID="lblUserName" runat="server"></asp:Label></TD>
						<TD>
							<asp:textbox id="txtUserName" runat="server" CssClass="font" MaxLength="25" Width="150px"></asp:textbox></TD>
					</TR>
					<TR>
						<TD class="fontHead" style="HEIGHT: 20px" width="120"><asp:Label ID="lblPassword" runat="server"></asp:Label></TD>
						<TD style="HEIGHT: 20px">
							<asp:textbox id="txtPassword1" onfocus="this.select();" runat="server" CssClass="font" MaxLength="15"
								Width="150px" TextMode="Password"></asp:textbox></TD>
					</TR>
					<TR>
						<TD class="fontHead" width="120"><asp:Label ID="lblConfirmpassword" runat="server"></asp:Label></TD>
						<TD>
							<asp:textbox id="txtPassword2" onfocus="this.select();" runat="server" CssClass="font" MaxLength="15"
								Width="150px" TextMode="Password"></asp:textbox></TD>
					</TR>
					<TR>
						<TD class="fontHead" id="AutoGenerate" colSpan="2" runat="server"><asp:Label ID="lblAutogenerate" runat="server"></asp:Label>
							<INPUT id="chkAutoPwd" onclick="Check(this);" type="checkbox" Runat="server"></TD>
					</TR>
				</TABLE>
			</asp:panel><asp:panel id="pnlMailOption" runat="server">
				<TABLE class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0">
					<TR>
						<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
						<TD width="100%">
							<cc1:confirmedimagebutton id="btnSaveMail" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnCloseMail" runat="server" Message="NONE"
								CausesValidation="False"></cc1:confirmedimagebutton>
						<TD>
						<TD>&nbsp;</TD>
					</TR>
				</TABLE>
				<TABLE cellSpacing="2" cellPadding="0" width="100%" border="0">
					<TR>
						<TD>
							<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></TD>
					</TR>
				</TABLE>
			</asp:panel></form>
		<script language="javascript">
			
			try {
				document.Form1("txtPassword1").value = "#GENERAL_PASSWORD#"   ;
				document.Form1("txtPassword2").value = "#GENERAL_PASSWORD#"   ;
			}catch(err) {
				// alert (err.message) ; 
			}
			
			function Check( obj) {
					document.Form1("txtPassword1").disabled= obj.checked ; 
					document.Form1("txtPassword2").disabled = obj.checked  ; 
			}
			
			
		</script>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</HTML>
