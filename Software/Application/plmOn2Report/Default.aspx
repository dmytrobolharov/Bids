<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Default.aspx.vb" Inherits="plmOn2Report._Default"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title runat="server" id="PageTitle"></title>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<BR>
			<BR>
			<TABLE id="Table1" height="1" cellSpacing="0" cellPadding="0" width="1" align="center"
				border="1">
				<TR>
					<TD borderColor="gray">
						<TABLE height="400" cellSpacing="0" cellPadding="0" width="600" align="center" border="0">
							<TR>
								<TD align="right" width="20" colSpan="3" height="100" bgcolor="#666666" 
                                    dir="rtl">
                                    <img src="Image/main_yunique.gif" style="width: 300px; height: 75px" /></TD>
							</TR>
							<TR>
								<TD align="center" width="10"></TD>
								<TD align="center" width="580">&nbsp;
									<asp:Label id="lblVersion" runat="server" ForeColor="#C00000" Font-Size="Smaller" Font-Names="Tahoma"
										Font-Bold="True"></asp:Label></TD>
								<TD align="center" width="10"></TD>
							</TR>
							<TR>
								<TD align="center" width="20" bgColor="gray" height="10"></TD>
								<TD align="center" bgColor="gray" height="10">&nbsp;</TD>
								<TD align="center" width="20" bgColor="gray" height="10"></TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
			</TABLE>
		</form>
	</body>
</html>
