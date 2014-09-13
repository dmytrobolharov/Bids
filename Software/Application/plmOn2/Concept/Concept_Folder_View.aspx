<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Concept_Folder_View.aspx.vb" Inherits="plmOnApp.Concept_Folder_View" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Concept_Folder_View</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<script language="javascript">
			function calendar(sTxtBoxName)
			{
			windowDatePicker = window.open("../System/Control/month_popup.aspx?txtbox=" + sTxtBoxName,"dp","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=200,height=180,left=375,top=200");
			windowDatePicker.focus();
			}
		</script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<td>
					    <cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
					    <cc1:confirmedimagebutton id="btnPDFView" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
				    </td>
				</TR>
			</TABLE>
			<table height="10" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblConceptHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Concept Folder...</asp:label></td>
				</tr>
			</table>
			<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder><br>
			<asp:datalist id="Datalist1" runat="server" Width="100%" GridLines="Both" RepeatDirection="Horizontal"
				RepeatColumns="4" BackColor="White" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
				Datakeyfield="StyleID" CssClass="font" onitemdatabound="Datalist1_ItemDataBound">
				<HeaderTemplate>
				</HeaderTemplate>
				<ItemStyle Height="250px" Width="225px" VerticalAlign="Top"></ItemStyle>
				<ItemTemplate>
					<TABLE width="100%">
						<TR>
							<TD vAlign="top">
								<table width="100%">
									<tr>
										<td align="center">
										</td>
									</tr>
								</table>
								<TABLE width="100%">
									<TR>
										<TD align="center">
											<cc1:confirmedimagebutton id=imgBtnEdit runat="server" Message='<%# string.Concat("Do You Want to Edit " &amp; DataBinder.Eval(Container.DataItem,"StyleNo").tostring &amp; " ?") %>'  CommandName="Link">
											</cc1:confirmedimagebutton></TD>
									</TR>
								</TABLE>
								<TABLE width="100%">
									<TR>
										<TD width="85"><FONT size="1"><B>Concept No:</B></FONT></TD>
										<TD><FONT size="1"><%#Container.DataItem("StyleNo")%></FONT></TD>
									</TR>
									<TR>
										<TD width="85"><FONT size="1"><B>Concept Name:</B></FONT></TD>
										<TD><FONT size="1"><%#Container.DataItem("Description")%></FONT></TD>
									</TR>
									<TR>
										<TD width="85"><FONT size="1"><B>Concept Status:</B></FONT></TD>
										<TD><FONT size="1"><%#Container.DataItem("StyleStatus")%></FONT></TD>
									</TR>
								</TABLE>
							</TD>
						</TR>
					</TABLE>
				</ItemTemplate>
				<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
			</asp:datalist></form>
	</body>
</HTML>
