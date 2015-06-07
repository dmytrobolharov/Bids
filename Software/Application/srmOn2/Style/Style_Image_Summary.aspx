<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Image_Summary.aspx.vb" Inherits="srmOnApp.Style_Image_Summary" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Style</title>
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
			<table class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td vAlign="middle" align="left">&nbsp;
						<cc1:confirmedimagebutton id="btnBurn" runat="server"  Message="Are you sure you want to burn this folder?"></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<uc2:style_header id=Style_Header1 runat="server" StyleID='<%Request("SID")%>'>
			</uc2:style_header>
			<table cellSpacing="1" cellPadding="0" width="100%" bgColor="#cccccc" border="0">
				<tr bgColor="#ffffff">
					<td vAlign="top" width="100%">
						<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="TableHeader" vAlign="middle" align="left">&nbsp;<asp:label id="lblStyle" runat="server">Style</asp:label></td>
							</tr>
						</table>
						<table cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td width="201" valign="top">
									<table id="TBDesignSketch" height="200" cellSpacing="1" cellPadding="1" width="200" bgColor="#cccccc"
										border="0" runat="server">
										<tr>
											<td class="fontHead" bgColor="#ffffff" height="25"><asp:label id="lblDesignSketch" runat="server">Design Sketch</asp:label>
											</td>
										</tr>
										<tr>
											<td bgColor="#ffffff">&nbsp;
												<cc1:confirmedimagebutton id="imgDesignDetail" runat="server"></cc1:confirmedimagebutton></td>
										</tr>
									</table>
								</td>
								<td valign="top">
									<table id="TBLineListSketch" height="200" cellSpacing="1" cellPadding="1" width="200" bgColor="#cccccc"
										border="0" runat="server">
										<tr>
											<td class="fontHead" bgColor="#ffffff" height="25">
												<asp:label id="lblConceptSketch" runat="server">Concept Sketch</asp:label>
											</td>
										</tr>
										<tr>
											<td bgColor="#ffffff">&nbsp;
												<cc1:confirmedimagebutton id="imgLineListSketch" runat="server"></cc1:confirmedimagebutton></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="TableHeader" vAlign="middle" align="left">&nbsp;<asp:label id="lblDesignDetail" runat="server">Design Detail</asp:label>
								</td>
							</tr>
						</table>
						<asp:datalist id="dlDetail" runat="server" CellPadding="0" EnableViewState="False" RepeatDirection="Horizontal"
							RepeatColumns="4" Datakeyfield="StyleImageItemID">
							<ItemStyle Height="200px" Width="200px" VerticalAlign="Top"></ItemStyle>
							<ItemTemplate>
								<TABLE height="200" cellSpacing="1" cellPadding="1" width="200" bgColor="#cccccc" border="0">
									<TR>
										<TD class="fontHead" bgColor="#ffffff" height="25">&nbsp;
											<asp:Label id="Label2" runat="server"></asp:Label></TD>
									</TR>
									<TR>
										<TD bgColor="#ffffff">&nbsp;
											<cc1:confirmedimagebutton id="Confirmedimagebutton1" runat="server" Message='<%# string.Concat("Do You Want to Edit ?") %>'>
											</cc1:confirmedimagebutton></TD>
									</TR>
								</TABLE>
							</ItemTemplate>
						</asp:datalist>
						<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="TableHeader" vAlign="middle" align="left">&nbsp;<asp:label id="lblMaterial" runat="server">Material</asp:label></td>
							</tr>
						</table>
						<asp:datalist id="dlMaterial" runat="server" Datakeyfield="StyleMaterialID" RepeatColumns="4"
							RepeatDirection="Horizontal" EnableViewState="False" CellPadding="0">
							<ItemStyle Height="200px" Width="200px" VerticalAlign="Top"></ItemStyle>
							<ItemTemplate>
								<TABLE id="Table1" height="200" cellSpacing="1" cellPadding="1" width="200" bgColor="#cccccc"
									border="0">
									<TR>
										<TD class="fontHead" bgColor="#ffffff" height="25">&nbsp;
											<asp:Label id="Label1" runat="server"></asp:Label></TD>
									</TR>
									<TR>
										<TD bgColor="#ffffff">&nbsp;
											<cc1:confirmedimagebutton id=imgBtnEdit runat="server" Message='<%# string.Concat("Do You Want to Edit " &amp; DataBinder.Eval(Container.DataItem,"MaterialName").tostring &amp; " ?") %>' >
											</cc1:confirmedimagebutton></TD>
									</TR>
								</TABLE>
							</ItemTemplate>
						</asp:datalist>
						<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="TableHeader" vAlign="middle" align="left"><asp:label id="lblArtwork" runat="server">Artwork</asp:label></td>
							</tr>
						</table>
						<asp:datalist id="dlArtwork" runat="server" Datakeyfield="StyleMaterialID" RepeatColumns="4" RepeatDirection="Horizontal"
							EnableViewState="False" CellPadding="0">
							<ItemStyle Height="200px" Width="200px" VerticalAlign="Top"></ItemStyle>
							<ItemTemplate>
								<TABLE id="Table1" height="200" cellSpacing="1" cellPadding="1" width="200" bgColor="#cccccc"
									border="0">
									<TR>
										<TD class="fontHead" bgColor="#ffffff" height="25">&nbsp;
											<asp:Label id="Label1" runat="server"></asp:Label></TD>
									</TR>
									<TR>
										<TD bgColor="#ffffff">&nbsp;
											<cc1:confirmedimagebutton id=imgBtnEdit runat="server" Message='<%# string.Concat("Do You Want to Edit " &amp; DataBinder.Eval(Container.DataItem,"MaterialName").tostring &amp; " ?") %>' >
											</cc1:confirmedimagebutton></TD>
									</TR>
								</TABLE>
							</ItemTemplate>
						</asp:datalist>
						<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="TableHeader" vAlign="middle" align="left">&nbsp;<asp:label id="lblLicense" runat="server">License</asp:label></td>
							</tr>
						</table>
						<asp:datalist id="dlLicense" runat="server" Datakeyfield="StyleMaterialID" RepeatColumns="4" RepeatDirection="Horizontal"
							EnableViewState="False" CellPadding="0">
							<ItemStyle Height="200px" Width="200px" VerticalAlign="Top"></ItemStyle>
							<ItemTemplate>
								<TABLE id="Table1" height="200" cellSpacing="1" cellPadding="1" width="200" bgColor="#cccccc"
									border="0">
									<TR>
										<TD class="fontHead" bgColor="#ffffff" height="25">&nbsp;
											<asp:Label id="Label1" runat="server"></asp:Label></TD>
									</TR>
									<TR>
										<TD bgColor="#ffffff">&nbsp;
											<cc1:confirmedimagebutton id=imgBtnEdit runat="server" Message='<%# string.Concat("Do You Want to Edit " &amp; DataBinder.Eval(Container.DataItem,"MaterialName").tostring &amp; " ?") %>' >
											</cc1:confirmedimagebutton></TD>
									</TR>
								</TABLE>
							</ItemTemplate>
						</asp:datalist>
						<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="TableHeader" vAlign="middle" align="left"><asp:label id="lblDevelopmentSpec" runat="server">Development Spec</asp:label>
								</td>
							</tr>
						</table>
						<table cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td width="201" valign="top">
									<table height="200" cellSpacing="1" cellPadding="1" width="200" bgColor="#cccccc" border="0">
										<tr>
											<td class="fontHead" bgColor="#ffffff" height="25">&nbsp;
												<asp:Label id="lblDevelopmentSpec1" runat="server"></asp:Label></td>
										</tr>
										<tr>
											<td bgColor="#ffffff">&nbsp;
												<cc1:confirmedimagebutton id="imgDevelopmentSpec1" runat="server"></cc1:confirmedimagebutton></td>
										</tr>
									</table>
								</td>
								<td width="201" valign="top">
									<table height="200" cellSpacing="1" cellPadding="1" width="200" bgColor="#cccccc" border="0">
										<tr>
											<td class="fontHead" bgColor="#ffffff" height="25">
												<asp:Label id="lblDevelopmentSpec2" runat="server"></asp:Label></td>
										</tr>
										<tr>
											<td bgColor="#ffffff">&nbsp;
												<cc1:confirmedimagebutton id="imgDevelopmentSpec2" runat="server"></cc1:confirmedimagebutton></td>
										</tr>
									</table>
								</td>
								<td width="201" valign="top">
									<table height="200" cellSpacing="1" cellPadding="1" width="200" bgColor="#cccccc" border="0">
										<tr>
											<td class="fontHead" bgColor="#ffffff" height="25">
												<asp:Label id="lblDevelopmentSpec3" runat="server"></asp:Label></td>
										</tr>
										<tr>
											<td bgColor="#ffffff">&nbsp;
												<cc1:confirmedimagebutton id="imgDevelopmentSpec3" runat="server"></cc1:confirmedimagebutton></td>
										</tr>
									</table>
								</td>
								<td valign="top">
									<table height="200" cellSpacing="1" cellPadding="1" width="200" bgColor="#cccccc" border="0">
										<tr>
											<td class="fontHead" bgColor="#ffffff" height="25">
												<asp:Label id="lblDevelopmentSpec4" runat="server"></asp:Label></td>
										</tr>
										<tr>
											<td bgColor="#ffffff">&nbsp;
												<cc1:confirmedimagebutton id="imgDevelopmentSpec4" runat="server"></cc1:confirmedimagebutton></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
