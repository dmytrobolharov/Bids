<%@ Control Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Submit_Spec.ascx.vb" Inherits="srmOnApp.SampleRequest_Workflow_Submit_Spec" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<cc1:ystabview id="YSTabView1" runat="server"></cc1:ystabview>
<%--<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
	<TR vAlign="middle">
		<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
		<TD><asp:label id="lblFitSummary" runat="server">Fit Summary</asp:label></TD>
		<TD></TD>
	</TR>
</TABLE>--%>
<%--<asp:label id="lblFitComment" runat="server"></asp:label>--%>
<asp:PlaceHolder ID="phComment" runat="server" ></asp:PlaceHolder>
<asp:datagrid id="dgSampleWorkflow" runat="server" Width="300" AutoGenerateColumns="false" PageSize="100"
	BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0">
	<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
	<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
	<HeaderStyle Height="20px"></HeaderStyle>
</asp:datagrid>
