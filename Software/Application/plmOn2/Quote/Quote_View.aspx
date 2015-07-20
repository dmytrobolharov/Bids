<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Quote_View.aspx.vb" Inherits="plmOnApp.Quote_View" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" />
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">View</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server" defaultbutton="btnSearch">
			<TABLE class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TBODY>
					<TR vAlign="middle">
						<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
						<TD vAlign="middle" align="left" width="400"><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE"></cc1:confirmedimagebutton></TD>
						<TD></TD>
					</TR>
				</TBODY>
			</TABLE>
			<TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<TBODY>
					<TR>
						<TD height="50">&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Filter Quote Folders</asp:label>
						</TD>
					</TR>
				</TBODY>
			</TABLE>
			<TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<TBODY>
					<TR>
						<TD height="50"><cc2:YSTabView id="YSTabView1" runat="server"></cc2:YSTabView>
						</TD>
					</TR>
				</TBODY>
			</TABLE>
			<asp:Panel id="pnlAgent" runat="server" BackColor="White">
				<TABLE cellSpacing="0" cellPadding="0" width="100%" align="center" bgColor="#ffffff" border="0">
					<TR>
						<TD>
							<TABLE id="Table2" height="35" cellSpacing="1" cellPadding="1" width="100%" border="0">
								<TR>
									<TD class="fonthead" width="75">
										<P align="center"><asp:label id="lblSearch" runat="server" CssClass="fontHead">Search:</asp:label></P>
									</TD>
									<TD width="150">
										<asp:TextBox id="txtSearch" runat="server" Width="200px"></asp:TextBox></TD>
									<TD width="30">
										<asp:imagebutton id="btnSearch" runat="server"></asp:imagebutton></TD>
									<TD></TD>
								</TR>
							</TABLE>
						</TD>
					</TR>
				</TABLE>
				<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
					<TR>
						<TD>
							<TABLE cellSpacing="0" cellPadding="0" width="600" bgColor="#ffffff" border="0">
								<TR>
									<TD align="center" width="200"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead">
												<asp:label id="lblTradePartnerAvailable" runat="server"></asp:label></B></FONT></TD>
									<TD width="50"></TD>
									<TD align="center" width="200"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead">
												<asp:label id="lblTradePartnerSelected" runat="server"></asp:label></B></FONT></TD>
									<TD>&nbsp;</TD>
								</TR>
								<TR>
									<TD align="center" width="200">
										<asp:listbox id="lstSelect" runat="server" Width="350px" CssClass="fonthead" BorderStyle="Outset"
											SelectionMode="Multiple" Height="450px"></asp:listbox></TD>
									<TD align="center" width="50">
										<asp:imagebutton id="btnaddall" runat="server"></asp:imagebutton><BR>
										<asp:imagebutton id="btnadditem" runat="server"></asp:imagebutton><BR>
										<asp:imagebutton id="btnremoveitem" runat="server"></asp:imagebutton><BR>
										<asp:imagebutton id="btnremoveall" runat="server"></asp:imagebutton><BR>
									</TD>
									<TD align="center" width="200">
										<asp:listbox id="lstSelected" Width="350px" CssClass="fonthead" SelectionMode="Multiple" Height="450px"
											Runat="server"></asp:listbox></TD>
									<TD>&nbsp;</TD>
								</TR>
							</TABLE>
						</TD>
					</TR>
				</TABLE>
			</asp:Panel>
		</form>
	</body>
</HTML>
