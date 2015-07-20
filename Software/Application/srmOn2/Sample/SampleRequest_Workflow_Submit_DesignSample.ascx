<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="SampleRequest_Workflow_Submit_DesignSample.ascx.vb" Inherits="srmOnApp.SampleRequest_Workflow_Submit_DesignSample" %>
<cc1:ystabview id="YSTabView1" runat="server"></cc1:ystabview>


<asp:PlaceHolder ID="phComment" runat="server" ></asp:PlaceHolder>

<asp:datagrid id="dgSampleWorkflowPivot" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="0px"
	PageSize="100" AutoGenerateColumns="false" Width="300">
	<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
	<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
	<HeaderStyle Height="20px"></HeaderStyle>
	<Columns></Columns>
</asp:datagrid>
