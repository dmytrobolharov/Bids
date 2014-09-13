<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Password.aspx.vb" Inherits="plmOnApp.Password"%>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title id="PageTitle" runat="server">Password</title>
		<LINK href="./System/CSS/Style.css" type="text/css" rel="stylesheet">
		<script language="javascript"> 
		
		function noEnter() {
			if ( window.event && window.event.keyCode==13 )
				return false;
			else
				return true ;
			
		}	
		</script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<div align="center">
				<TABLE class="TableHeaderOver" id="Table1" height="24" cellSpacing="0" cellPadding="0"
					width="100%" border="0" runat="server">
					<TR vAlign="middle">
						<TD vAlign="middle" align="center" width="10"><IMG height="15" src="./System/Images/bbTbSCnr.gif" width="3"></TD>
						<TD><asp:Label ID="lblPassReq" runat="server" Text="Password Request"></asp:Label></TD>
					</TR>
				</TABLE>
			</div>
			<TABLE id="Table2" height="100" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
				border="0">
				<TR>
					<TD width="10"></TD>
					<TD>
						<P align="center"><asp:label id="lblMsg" Runat="server" CssClass="fontRed"></asp:label></P>
					</TD>
				</TR>
				<TR>
					<TD width="10"></TD>
					<TD>
						<table cellSpacing="0" cellPadding="0" width="100%" border="0">
							<TR>
								<TD class="fontHead" height="25">&nbsp;</TD>
								<TD class="fontHead" height="25"><asp:Label ID="Label1" runat="server" Text="Enter your email address"></asp:Label></TD>
								<TD class="font" height="25"></TD>
							</TR>
							<TR>
								<TD class="fontHead"></TD>
								<TD class="font"><asp:textbox id="txtEmail" runat="server" CssClass="font" Width="200px"></asp:textbox></TD>
								<TD class="font"><asp:regularexpressionvalidator id="rvEmail" runat="server" CssClass="fontHead" ErrorMessage="*" ControlToValidate="txtEmail"
										ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ToolTip="Email Required!"></asp:regularexpressionvalidator></TD>
							</TR>
							<TR>
								<TD height="10"></TD>
								<TD height="10"></TD>
								<TD height="10"></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD><cc1:confirmedButton id="btnSubmit" runat="server" Message="NONE"></cc1:confirmedButton>
									<cc1:ConfirmedButton id="btnCancel" runat="server" Message="NONE"></cc1:ConfirmedButton>
								</TD>
								<TD></TD>
							</TR>
						</table>
					</TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
