<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Submit_Log.aspx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Submit_Log" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="ycl" Namespace="Yunique.Core.Library" Assembly="Yunique.Core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle"></title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body onload="self.focus()">
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>
                        <asp:Label ID="lblSubmitLog" runat="server" ><%#GetSystemText("Submit Log...")%></asp:Label>
					</td>
				</tr>
			</table>
			<asp:datalist id="dlSampleLog" runat="server" RepeatDirection="Vertical" Width="100%">
				<ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
					VerticalAlign="Top" Width="100%"></ItemStyle>
				<ItemTemplate>
					<table cellSpacing="0" cellPadding="0" border="0" height="25" width="100%" class=TableHeaderOver>
						<tr>
							<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
							<td width="20">
								<asp:imagebutton CommandName="Expand" id="imbBtnExpand" ImageUrl="../System/Icons/icon_Next.gif"
									runat="server"></asp:imagebutton>
								<asp:imagebutton CommandName="Collapse" id="imgBtnCollapse" ImageUrl="../System/Icons/icon_Down.gif"
									runat="server"></asp:imagebutton></td>
							<td class="fontHead">&nbsp;
								<asp:Label id="lblSubmit" runat="server"><%#GetSystemText("Submit")%></asp:Label></td>
						</tr>
					</table>
					<asp:Panel Runat="server" ID="pnlList" Visible="False">
						<asp:datagrid id="dgSampleLog" runat="server" AutoGenerateColumns="False" PageSize="100" BorderWidth="1px"
							BorderStyle="Solid" BorderColor="#E0E0E0" ShowHeader="False" Width="100%" OnItemDataBound="dgSampleLog_OnItemDataBound">
							<AlternatingItemStyle Height="20px" Font-Size="11px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle Height="20px" Font-Size="11px" CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Width="100%"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn >
									<ItemTemplate >
										<asp:Image Runat=server ID="imgUserType"></asp:Image>
									 </ItemTemplate>
								</asp:TemplateColumn>
								
								<asp:TemplateColumn>
									<ItemStyle Width="50px"></ItemStyle>
									<ItemTemplate>
										<%#Container.DataItem("SampleRequestLogId")%>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<ItemTemplate>
										<%#Container.DataItem("LogDescription")%>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<ItemTemplate>
										<%#Container.DataItem("CUser")%>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<ItemTemplate>
										<%# SystemHandler.GetLocalTime ( Container.DataItem("CDate") ) %>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid>
					</asp:Panel>
				</ItemTemplate>
			</asp:datalist>
		</form>
	</body>
</HTML>
