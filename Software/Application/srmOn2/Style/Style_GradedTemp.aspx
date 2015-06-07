<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_GradedTemp.aspx.vb" Inherits="srmOnApp.Style_GradedTemp" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow" Src="Style_Workflow.ascx" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Style Development Spec</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<uc1:style_workflow id="Style_Workflow1" runat="server"></uc1:style_workflow><uc2:style_header id=Style_Header1 runat="server" StyleID='<%Request("SID")%>'></uc2:style_header>
			<table class="ToolbarShort" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
				</tr>
			</table>
			<br>
			<cc2:YSTabView id="YSTabView2" runat="server"></cc2:YSTabView>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr bgColor="#ffffff">
					<td vAlign="top" width="400"><asp:datagrid id="DataGrid1" runat="server" Width="100%" OnItemDataBound="ItemDataBoundEventHandler"
							AutoGenerateColumns="False" PageSize="100" BorderWidth="1px" BorderStyle="Solid" BorderColor="Silver">
							<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<div align="center">
											<asp:label id="lblHeaderPOM" runat="server"><%#GetSystemText("POM")%></asp:label>
										</div>
									</HeaderTemplate>
									<ItemTemplate>
										<DIV align="center">
											<asp:Label id="lblPOM" runat="server" Width="50"></asp:Label></DIV>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<DIV align="left">
											<asp:Label id="lblHeaderPointMeasur" runat="server" Width="200px"><%#GetSystemText("Point of Measurment")%></asp:Label>
										</DIV>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblPointMeasur" runat="server"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<div align="center">
											<asp:label id="lblHeaderTOL" runat="server"><%#GetSystemText("TOL")%></asp:label>
										</div>
									</HeaderTemplate>
									<ItemTemplate>
										<div align="center">
											<asp:Label id="lblTOL" runat="server" Width="50" /></div>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<div align="center">
											<asp:Label id="lblSampleSize" runat="server" /></div>
									</HeaderTemplate>
									<ItemTemplate>
										<div align="center">
											<asp:Label id="lblSpec" runat="server" Width="50" /></div>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<div align="center">
											<asp:Label id="lblSize0" runat="server" /></div>
									</HeaderTemplate>
									<ItemTemplate>
										<div align="center">
											<asp:Label id="lblSpec0" runat="server" Width="50" /></div>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<div align="center">
											<asp:Label id="lblSize1" runat="server" /></div>
									</HeaderTemplate>
									<ItemTemplate>
										<div align="center">
											<asp:Label id="lblSpec1" runat="server" Width="50" /></div>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<div align="center">
											<asp:Label id="lblSize2" runat="server" /></div>
									</HeaderTemplate>
									<ItemTemplate>
										<div align="center">
											<asp:Label id="lblSpec2" runat="server" Width="50" /></div>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<div align="center">
											<asp:Label id="lblSize3" runat="server" /></div>
									</HeaderTemplate>
									<ItemTemplate>
										<div align="center">
											<asp:Label id="lblSpec3" runat="server" Width="50" /></div>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<div align="center">
											<asp:Label id="lblSize4" runat="server" /></div>
									</HeaderTemplate>
									<ItemTemplate>
										<div align="center">
											<asp:Label id="lblSpec4" runat="server" Width="50" /></div>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<div align="center">
											<asp:Label id="lblSize5" runat="server" /></div>
									</HeaderTemplate>
									<ItemTemplate>
										<div align="center">
											<asp:Label id="lblSpec5" runat="server" Width="50" /></div>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<div align="center">
											<asp:Label id="lblSize6" runat="server" /></div>
									</HeaderTemplate>
									<ItemTemplate>
										<div align="center">
											<asp:Label id="lblSpec6" runat="server" Width="50" /></div>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<div align="center">
											<asp:Label id="lblSize7" runat="server" /></div>
									</HeaderTemplate>
									<ItemTemplate>
										<div align="center">
											<asp:Label id="lblSpec7" runat="server" Width="50" /></div>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<div align="center">
											<asp:Label id="lblSize8" runat="server" /></div>
									</HeaderTemplate>
									<ItemTemplate>
										<div align="center">
											<asp:Label id="lblSpec8" runat="server" Width="50" /></div>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<div align="center">
											<asp:Label id="lblSize9" runat="server" /></div>
									</HeaderTemplate>
									<ItemTemplate>
										<div align="center">
											<asp:Label id="lblSpec9" runat="server" Width="50" /></div>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<div align="center">
											<asp:Label id="lblSize10" runat="server" /></div>
									</HeaderTemplate>
									<ItemTemplate>
										<div align="center">
											<asp:Label id="lblSpec10" runat="server" Width="50" /></div>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<div align="center">
											<asp:Label id="lblSize11" runat="server" /></div>
									</HeaderTemplate>
									<ItemTemplate>
										<div align="center">
											<asp:Label id="lblSpec11" runat="server" Width="50" /></div>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid></td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
