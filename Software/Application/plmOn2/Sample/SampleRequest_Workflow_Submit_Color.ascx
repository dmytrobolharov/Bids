<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Submit_Color.ascx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Submit_Color" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<cc1:YSTabView id="YSTabView1" runat="server"></cc1:YSTabView>
<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
	<TR vAlign="middle">
		<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
		<TD>
			<asp:Label id="lblHeaderComment" runat="server"></asp:Label></TD>
		<TD></TD>
	</TR>
</TABLE>
<asp:label id="lblFitComment" runat="server"></asp:label>
<asp:datagrid id="dgSampleWorkflow" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
	PageSize="100" AutoGenerateColumns="false" Width="300">
	<AlternatingItemStyle CssClass="AlternateItemTemplate"></AlternatingItemStyle>
	<ItemStyle CssClass="ItemTemplate"></ItemStyle>
	<HeaderStyle Height="20px"></HeaderStyle>
	<Columns></Columns>
</asp:datagrid>
