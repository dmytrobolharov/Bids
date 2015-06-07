<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Submit_Delete.aspx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Submit_Delete" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle"></title>
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
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnDelete" runat="server" Message="Are you sure you want to delete selected submit(s)?" ></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr bgColor="#ffffff">
					<td vAlign="top" width="600"><asp:datagrid id="DataGrid1" runat="server" Width="400px" AutoGenerateColumns="False" PageSize="100"
							BorderWidth="1px" BorderStyle="Solid" BorderColor="Silver">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<input type="checkbox" id="checkAll" onClick="CheckAll(this);" runat="server" name="checkAll">
									</HeaderTemplate>
									<ItemTemplate>
										<asp:CheckBox id="chkDelete" runat="server"></asp:CheckBox>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
                                        <asp:Label ID="lblProcess" runat="server" ><%#GetSystemText("Process")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblWorkflow" runat="server"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="150px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
                                        <asp:Label ID="lblStatus" runat="server" ><%#GetSystemText("Status")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblStatus" runat="server"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="150px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
                                        <asp:Label ID="lblSubmit" runat="server"><%#GetSystemText("Submit")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblSubmit" runat="server"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid></td>
					<td vAlign="top">&nbsp;</td>
				</tr>
			</table>
		</form>
		<SCRIPT language="javascript">
			var frm = document.Form1 ;
			function CheckAll( checkAllBox )
			{
			var actVar = checkAllBox.checked ;
			for(i=0;i< frm.length;i++)
			{
				e=frm.elements[i];
				if ( e.type=='checkbox' && e.name.indexOf("chkDelete") != -1 )
				e.checked= actVar ;
			}
			}
		</SCRIPT>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</HTML>
