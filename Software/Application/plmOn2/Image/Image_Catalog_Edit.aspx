<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Image_Catalog_Edit.aspx.vb" Inherits="plmOnApp.Image_Catalog_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Catalog</title>
		
		
		
		
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>

	</HEAD>
	<body bgColor="#ffffff">
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<td>
					<cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnAddStyle" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
					<cc1:bwimagebutton id="imgImageSort" runat="server" ></cc1:bwimagebutton>
					<cc1:bwimagebutton id="btnPrint" runat="server" Message="NONE" ></cc1:bwimagebutton>
                    <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>
					<cc1:confirmedimagebutton id="btnBurn" runat="server" Message="Are you sure you want to burn this folder?" ></cc1:confirmedimagebutton>
					<cc1:bwimagebutton id="btnDelete" runat="server" ></cc1:bwimagebutton>
					<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" CausesValidation="False" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton>
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
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Image Catalog...</asp:label></td>
				</tr>
			</table>
			<TABLE id="Table1" cellSpacing="1" cellPadding="1" width="100%" border="0">
				<TR>
					<TD width="800" bgColor="#ffffff"><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></TD>
				</TR>
			</TABLE>
			<TABLE class="TableHeader" id="Table3" height="25" cellSpacing="0" cellPadding="0" width="100%"
				border="0" runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD><asp:Label  id="lblImageSelected" runat="server">Image Selected...</asp:Label></TD>
				</TR>
			</TABLE>
			<asp:datalist id="Datalist1" runat="server" Width="100%" GridLines="Both" RepeatDirection="Horizontal"
				RepeatColumns="4" BackColor="White" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
				Datakeyfield="ImageCatalogItemID" CssClass="font">
				<HeaderTemplate>
				</HeaderTemplate>
				<ItemStyle Height='200' VerticalAlign="Top"></ItemStyle>
				<ItemTemplate>
					<TABLE width='<%# string.Concat(ImageWidth) %>'>
						<TR>
							<TD vAlign="top">
								<TABLE width="100%">
									<TR>
										<TD align="center"><%# ImageVersionChecker(Container.DataItem("ImageID").tostring, Container.DataItem("ImageVersion").tostring) %></TD>
									</TR>
								</TABLE>
								<TABLE width="100%">
									<TR>
										<TD>
											<cc1:confirmedimagebutton id=imgBtnEdit runat="server" Message="NONE" CommandName="Link">
											</cc1:confirmedimagebutton></TD>
									</TR>
								</TABLE>
							</TD>
						</TR>
					</TABLE>
					<TABLE>
						<TR>
							<TD class="font">
								<asp:Label id=lbImgDescription runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ImageDescription") %>' CssClass="fonthead">
								</asp:Label></TD>
						</TR>
					</TABLE>
					<asp:Textbox id=txtImageID runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"ImageID")%>' Visible="False">
					</asp:Textbox>
					<asp:Textbox id=txtImageVersion runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"ImageVersion")%>' Visible="False">
					</asp:Textbox>
				</ItemTemplate>
				<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
			</asp:datalist></form>
	</body>
    <script  language="javascript" type="text/javascript">
                    function btnClose_Click() {
                        <%= strExitScript %>
                        return false;
                    }
    </script>
</HTML>
