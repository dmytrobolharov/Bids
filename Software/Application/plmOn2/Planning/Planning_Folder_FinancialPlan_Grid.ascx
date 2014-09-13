<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Planning_Folder_FinancialPlan_Grid.ascx.vb" Inherits="plmOnApp.Planning_Folder_FinancialPlan_Grid" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>


<table cellSpacing="0" cellPadding="0" border="0" width="100%">
<tr class="TableHeader35">
    <td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
    <td align="left"><asp:Panel ID="pnlLinePlanBreadCrumb" runat="server"></asp:Panel></td>
    <td>&nbsp;</td>
</tr>
</table>

<asp:datagrid id="DataGrid1" runat="server" PageSize="1000" OnItemDataBound="DataGrid1_ItemDataBound"
		DataKeyField="PlanningBusinessID" CellPadding="0" CellSpacing="2" BorderWidth="0" CssClass="fontHead" BackColor="#DFDFDF"
        AutoGenerateColumns="false">
		<ItemStyle BorderStyle="Solid" BorderWidth="1" BorderColor="Black" BackColor="White" Height="20"></ItemStyle>
		<HeaderStyle CssClass="fontHead"></HeaderStyle>
		<Columns>

            <asp:TemplateColumn>
                <HeaderStyle Width="250" HorizontalAlign="Center" />
                <HeaderTemplate>
                    &nbsp;
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:HiddenField ID="hdnDataType" runat="server" />
                    <asp:HiddenField ID="hdnDataFormat" runat="server" />
                    <asp:Label ID="lblFinText" runat="server" />
                </ItemTemplate>
            </asp:TemplateColumn>

			<asp:TemplateColumn>
                <HeaderStyle CssClass="TableHeaderYellow" Height="30" Width="75" HorizontalAlign="Center" />
				<HeaderTemplate>
                    <%#GetSystemText("Last Year")%>
				</HeaderTemplate>
				<ItemTemplate>
                    <asp:Label ID="lblLY" runat="server"></asp:Label>
                </ItemTemplate>
			</asp:TemplateColumn>

            <asp:TemplateColumn>
                <HeaderStyle CssClass="TableHeaderGreen" Height="30"  Width="75" HorizontalAlign="Center" />
                <HeaderTemplate>
                    <%# GetSystemText("Planned")%>
				</HeaderTemplate>
				<ItemTemplate>
                    <asp:Label ID="lblPlan" runat="server"></asp:Label>
                </ItemTemplate>
			</asp:TemplateColumn>

            <asp:TemplateColumn>
                <HeaderStyle CssClass="TableHeaderRed" Height="30"  Width="75" HorizontalAlign="Center" />
				<HeaderTemplate>
                    <%# GetSystemText("Developed")%>
				</HeaderTemplate>
				<ItemTemplate>
                    <asp:Label ID="lblDIP" runat="server"></asp:Label>
                </ItemTemplate>
			</asp:TemplateColumn>

            <asp:TemplateColumn>
                <HeaderStyle CssClass="TableHeaderBlue" Height="30"  Width="75" HorizontalAlign="Center" />
				<HeaderTemplate>
                    <%#GetSystemText("Actual")%>
				</HeaderTemplate>
				<ItemTemplate>
                    <asp:Label ID="lblActual" runat="server"></asp:Label>
                </ItemTemplate>
			</asp:TemplateColumn>
		</Columns>

</asp:datagrid>
