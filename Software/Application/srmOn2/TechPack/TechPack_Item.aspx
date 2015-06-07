<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TechPack_Item.aspx.vb" Inherits="srmOnApp.TechPack_Item" %>
<%@ Import Namespace="Yunique.Core.Library" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="../Style/Style_Header.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Tech Pack</title>
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
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td height="20"><cc1:confirmedimagebutton id="btnPreview" runat="server"  Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<uc1:style_header id="Style_Header1" runat="server"></uc1:style_header>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top" width="300">
						<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<TR vAlign="middle">
								<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<td><asp:label id="lblTechPack" runat="server">Tech Pack...</asp:label></td>
							</TR>
						</TABLE>
						<table cellSpacing="1" cellPadding="0" width="100%" bgColor="#e4e4e4" border="0">
							<tr bgColor="#ffffff">
								<td width="15" height="20">&nbsp;</td>
								<td class="fontHead" width="100" height="20">
								    <asp:label id="lblTechPackNo" runat="server">Tech Pack No.:</asp:label>
								</td>
								<td class="font" height="20">&nbsp;
									<asp:label id="txtTechPackNo" runat="server"></asp:label></td>
							</tr>
							<tr bgColor="#ffffff">
								<td height="20">&nbsp;</td>
								<td class="fontHead" height="20">
								    <asp:label id="lblTechPackName" runat="server">Tech Pack Name:</asp:label>
								</td>
								<td class="font" height="20">&nbsp;
									<asp:label id="txtTechPackName" runat="server"></asp:label></td>
							</tr>
							<tr bgColor="#ffffff">
								<td width="15" height="20">&nbsp;</td>
								<td class="fontHead" width="100" height="20">
                                    <asp:label id="lblSeasonYear" runat="server">Season/Year:</asp:label>
								</td>
								<td class="font" height="20">&nbsp;
									<asp:label id="txtSeasonYear" runat="server"></asp:label></td>
							</tr>
							<tr bgColor="#ffffff">
								<td width="15" height="20">&nbsp;</td>
								<td class="fontHead" width="100" height="20">
								    <asp:label id="lblCreatedBy" runat="server">Created By:</asp:label>
								</td>
								<td class="font" height="20">&nbsp;
									<asp:label id="txtCUser" runat="server"></asp:label></td>
							</tr>
							<tr bgColor="#ffffff">
								<td width="15" height="20">&nbsp;</td>
								<td class="fontHead" width="100" height="20">
								    <asp:label id="lblCreatedDate" runat="server">Created Date:</asp:label>
								</td>
								<td class="font" height="20">&nbsp;
									<asp:label id="txtCDate" runat="server"></asp:label></td>
							</tr>
							<tr bgColor="#ffffff">
								<td height="20">&nbsp;</td>
								<td class="fontHead" height="20">&nbsp;</td>
								<td class="font" height="20">&nbsp;</td>
							</tr>
						</table>
					</td>
					<td vAlign="top">
						<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<TR vAlign="middle">
								<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<td><asp:label id="lblComments" runat="server">Comments...</asp:label></td>
							</TR>
						</TABLE>
						<table cellSpacing="1" cellPadding="0" width="740" bgColor="#e4e4e4" border="0" style="WIDTH: 740px; HEIGHT: 128px">
							<tr bgColor="#ffffff">
								<td width="15" height="60">&nbsp;</td>
								<td class="font" height="60" vAlign="top">&nbsp;
									<asp:Label id="txtNotes" runat="server"></asp:Label></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
            <table cellspacing="0" cellpadding="0">
                <tr class="TableHeader">
                    <td>
                        <table class="TableHeader" cellpadding="0" cellspacing="0">
                            <tr>
                                <td valign="middle" width="10">
                                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                                </td>
                                <td>
                                    <asp:Label ID="lblChangeLogHeader" runat="server" Text="Change Log"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:DataGrid ID="dgChange" runat="server" Width="600px" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                            AutoGenerateColumns="False" ShowHeader="true">
                            <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplateYellow"></AlternatingItemStyle>
                            <ItemStyle Height="20px" CssClass="ItemTemplateYellow"></ItemStyle>
                            <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                            <Columns>
                                <asp:TemplateColumn>
                                    <HeaderTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%#GetSystemText("Action") %>'></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblActionType" runat="server" CssClass="font" Text='<%# Eval("ActionType") %>' />
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <HeaderTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%#GetSystemText("Workflow") %>'></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblWorkflow" runat="server" CssClass="font" Text='<%# Eval("Workflow") %>' />
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <HeaderTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%#GetSystemText("Field Name") %>'></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblFieldName" runat="server" CssClass="font" Text='<%# Eval("ChangeFieldAlias") %>' />
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <HeaderTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%#GetSystemText("Before") %>'></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblChangeUser" runat="server" CssClass="font" Text='<%# Eval("ChangeBeforeText") %>' />
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <HeaderTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%#GetSystemText("After") %>'></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblChangeUser" runat="server" CssClass="font" Text='<%# Eval("ChangeAfterText") %>' />
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <HeaderTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%#GetSystemText("User") %>'></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblChangeUser" runat="server" CssClass="font" Text='<%# Eval("ChangeUserName") %>' />
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <HeaderTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%#GetSystemText("Date") %>'></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblChangeDate" runat="server" CssClass="font" Text='<%# Convert.ToDateTime(SystemHandler.GetLocalTime(Eval("ChangeDate"))).ToString(Me.GetFormatInfo.DateTimeLongFormat) %>' />
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                            </Columns>
                        </asp:DataGrid>
                    </td>
                </tr>
            </table>
		</form>
	</body>
</HTML>
