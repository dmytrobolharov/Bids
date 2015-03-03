<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_PredefinedTechPack_Add.aspx.vb" Inherits="plmOnApp.Control_PredefinedTechPack_Add" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Add Workflow Type</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TBODY>
					<TR vAlign="middle">
						<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
						<TD vAlign="middle" align="left" width="400">
						    <cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton>
					    </TD>
						<TD></TD>
					</TR>
				</TBODY>
			</TABLE>
			<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR>
					<TD colSpan="4">
						<TABLE width="100%" align="center">
							<TR>
								<TD align="center" width="40%"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead">
                                    <asp:Label ID="lblAvailable" runat="server" ></asp:Label></B></FONT></TD>
								<TD width="10%"></TD>
								<TD align="center" width="40%"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead">
                                    <asp:Label ID="lblSelected" runat="server" ></asp:Label>
										</B></FONT>
								</TD>
								<TD width="10%"></TD>
							</TR>
							<TR>
								<TD align="center" width="40%"><asp:listbox id="lstSelect" runat="server" BorderStyle="Outset" SelectionMode="Multiple" Height="445px"
										Width="350px" CssClass="fonthead"></asp:listbox></TD>
								<TD align="center" width="10%" class="fonthead">(+/-)<br>
									<br>
									<asp:imagebutton id="btnaddall" runat="server" ></asp:imagebutton><BR>
									<asp:imagebutton id="btnadditem" runat="server" ></asp:imagebutton><BR>
									<asp:imagebutton id="btnremoveitem" runat="server" ></asp:imagebutton><BR>
									<asp:imagebutton id="btnremoveall" runat="server" ></asp:imagebutton><BR>
								</TD>
								<TD align="center" width="40%">
									<asp:ListBox id="lstSelected" Width="350px" Height="445px" SelectionMode="Multiple" Runat="server"
										CssClass="fonthead"></asp:ListBox></TD>
								<TD align="center" width="10%" class="fonthead">
                                    <asp:Label ID="lblSort" runat="server"></asp:Label><br>
									<br>
									<asp:imagebutton id="btnColmoveup" Runat="server"  /><BR>
									<asp:imagebutton id="btnColmovedwn" Runat="server"  />
								</TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
			</TABLE>
		</form>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</HTML>
