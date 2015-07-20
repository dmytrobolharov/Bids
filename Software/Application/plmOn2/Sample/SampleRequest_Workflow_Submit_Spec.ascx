<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Submit_Spec.ascx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Submit_Spec" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<cc1:ystabview id="YSTabView1" runat="server"></cc1:ystabview>


<asp:PlaceHolder ID="phComment" runat="server" ></asp:PlaceHolder>

<asp:datagrid id="dgSampleWorkflowPivot" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="0px"
	PageSize="100" AutoGenerateColumns="false" Width="300">
	<AlternatingItemStyle CssClass="AlternateItemTemplate"></AlternatingItemStyle>
	<ItemStyle CssClass="ItemTemplate"></ItemStyle>
	<HeaderStyle Height="20px"></HeaderStyle>
	<Columns></Columns>
</asp:datagrid>
