<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest.aspx.vb" Inherits="plmOnApp.SampleRequest" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle"></title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<asp:datagrid id="dgStyleSet" runat="server" AutoGenerateColumns="false" ShowHeader="False" BorderWidth="0"
				CellSpacing="0" CellPadding="0" Width="100%">
				<Columns>
					<asp:TemplateColumn>
						<ItemTemplate>
							<TABLE class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TR vAlign="middle">
									<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
									<TD>
										<asp:Label id="lblSetName" runat="server"></asp:Label></TD>
									<TD>&nbsp;
									</TD>
									<TD>&nbsp;</TD>
								</TR>
							</TABLE>
							<asp:DataGrid id="dgWorkflow" runat="server" AutoGenerateColumns="false" ShowHeader="False" Width="100%"
								CellPadding="0" CellSpacing="0" BorderWidth="0">
								<Columns>
									<asp:TemplateColumn>
										<ItemTemplate>
											<TABLE class="TableHeaderOver" cellSpacing="0" cellPadding="0" width="100%" border="0">
												<TR>
													<TD width="25" height="25">&nbsp;</TD>
													<TD>
														<asp:Label id="lblWorkflowName" runat="server"></asp:Label></TD>
													<TD>&nbsp;</TD>
												</TR>
											</TABLE>
											<asp:DataGrid id="dgMaterial" runat="server" AutoGenerateColumns="false" ShowHeader="False" Width="100%"
								CellPadding="0" CellSpacing="0" BorderWidth="0">
												<Columns>
													<asp:TemplateColumn>
														<ItemTemplate>
															<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
																<TR>
																	<TD width="25" height="25">&nbsp;</TD>
																</TR>
															</TABLE>
														</ItemTemplate>
														<ItemTemplate><asp:Label id="lblMaterialName" runat="server"></asp:Label></ItemTemplate>
													</asp:TemplateColumn>
												</Columns>
											</asp:DataGrid>
										</ItemTemplate>
									</asp:TemplateColumn>
								</Columns>
							</asp:DataGrid>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
			</asp:datagrid></form>
	</body>
</HTML>
