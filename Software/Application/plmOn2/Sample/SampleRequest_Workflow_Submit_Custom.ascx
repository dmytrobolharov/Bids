<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="SampleRequest_Workflow_Submit_Custom.ascx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Submit_Custom" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>

<cc1:YSTabView id="YSTabView1" runat="server"></cc1:YSTabView>
<asp:PlaceHolder ID="phComment" runat="server" ></asp:PlaceHolder>

<asp:datagrid id="dgSampleWorkflowPivot" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="0px"
	PageSize="100" AutoGenerateColumns="false" Width="300">
	<AlternatingItemStyle CssClass="AlternateItemTemplate"></AlternatingItemStyle>
	<ItemStyle CssClass="ItemTemplate"></ItemStyle>
	<HeaderStyle Height="20px"></HeaderStyle>
	<Columns></Columns>
</asp:datagrid>

