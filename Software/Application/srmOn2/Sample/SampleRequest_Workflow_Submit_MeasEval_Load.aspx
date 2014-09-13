<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Submit_MeasEval_Load.aspx.vb" Inherits="srmOnApp.SampleRequest_Workflow_Submit_MeasEval_Load" %>
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
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>					
					<TD width="80"><cc1:confirmedimagebutton id="btnNext" runat="server" Message="NONE"></cc1:confirmedimagebutton></TD>
					<TD><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE"></cc1:confirmedimagebutton></TD>										
				</TR>
			</TABLE>
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td width="100%"></td>
				</tr>
			</table>
			<asp:datagrid id="DataGrid1" runat="server" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
				PageSize="100" AutoGenerateColumns="False" Width="100%">
				<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn >
					<HeaderTemplate >
                        <asp:Label ID="lblHeader1" runat="server"> <%#GetSystemText("Select")%> </asp:Label>
					</HeaderTemplate>
						<HeaderStyle HorizontalAlign="Center" Width="50px"></HeaderStyle>
						<ItemStyle HorizontalAlign="Center"></ItemStyle>
						<ItemTemplate>
							<asp:Label id="lblRadio" runat="server"></asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn >
					<HeaderTemplate >                         
                        <asp:Label ID="lblHeader2" runat="server"><%#GetSystemText("Select Spec From")%>...</asp:Label>
					</HeaderTemplate>
						<ItemTemplate>
							<asp:Label id="lblSpec" runat="server"></asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>						
				</Columns>
			</asp:datagrid>
		</form>
	</body>
</HTML>
