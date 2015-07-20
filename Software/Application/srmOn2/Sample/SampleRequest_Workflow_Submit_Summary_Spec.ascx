<%@ Control Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Submit_Summary_Spec.ascx.vb" Inherits="srmOnApp.SampleRequest_Workflow_Submit_Summary_Spec" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
	<TR vAlign="middle">
		<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
		<TD>
			<asp:Label id="lblSummary" runat="server"></asp:Label></TD>
		<TD></TD>
	</TR>
</TABLE>
<asp:Label runat="server" ID="lblTest" Visible="false"></asp:Label>
<asp:label id="lblFitComment" runat="server"></asp:label>
<asp:datagrid id="dgSampleWorkflow" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
	PageSize="100" AutoGenerateColumns="false" Width="300">
	<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
	<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
	<HeaderStyle Height="20px"></HeaderStyle>
	<Columns></Columns>
</asp:datagrid>
