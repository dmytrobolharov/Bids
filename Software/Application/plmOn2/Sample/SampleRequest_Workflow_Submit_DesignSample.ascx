<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="SampleRequest_Workflow_Submit_DesignSample.ascx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Submit_DesignSample" %>
<cc1:ystabview id="YSTabView1" runat="server"></cc1:ystabview>


<asp:PlaceHolder ID="phComment" runat="server" ></asp:PlaceHolder>


<asp:DataList ID="dlMeasSummary" runat="server" CssClass="font" Datakeyfield="SampleRequestAMLMeasHdrID" BorderWidth="1px"
				BorderStyle="Solid" BorderColor="Silver" BackColor="White" RepeatDirection="Horizontal"
				GridLines="Both" >
				<HeaderTemplate>
				</HeaderTemplate>
				<ItemStyle VerticalAlign="Top" HorizontalAlign="Left"></ItemStyle>
<ItemTemplate>
<asp:datagrid id="DataGrid2" runat="server" BorderColor="Silver" 
                            BorderStyle="Solid" BorderWidth="1px"
					            PageSize="100" AutoGenerateColumns="False" AllowPaging="true" PagerStyle-Visible="false" OnItemDataBound="DataGrid2_ItemDataBound">
					            <AlternatingItemStyle CssClass="AlternateItemTemplate"></AlternatingItemStyle>
					            <ItemStyle CssClass="ItemTemplate"></ItemStyle>
					            <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle></asp:datagrid>
</ItemTemplate>
</asp:DataList>