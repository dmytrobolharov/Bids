<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Style_SubComponent.ascx.vb" Inherits="plmOn2Report.Style_SubComponent" %>

<asp:datagrid id="DataGrid1" runat="server" Width="100%" GridLines="Horizontal" BackColor="White" EnableViewState="False" 
     CellPadding="0" CellSpacing="0"    >

	<AlternatingItemStyle Font-Size="6pt" Font-Names="Tahoma" BorderStyle="Solid" BorderColor="Black"></AlternatingItemStyle>
    <ItemStyle Font-Size="6pt" Font-Names="Tahoma" ></ItemStyle>
    <HeaderStyle Font-Size="6pt" Font-Names="Tahoma" Font-Bold="True" ForeColor="Black"  BackColor="WhiteSmoke" 
        ></HeaderStyle>
    
    <Columns>
        <asp:TemplateColumn >
            <HeaderStyle Width="60"  BorderColor="black" BorderWidth="0px" BorderStyle="solid"  />
            <HeaderTemplate >
		        <asp:Label runat="server" ID="lblImage" Font-Bold="true" ><%#GetSystemText("Image")%></asp:Label>
		    </HeaderTemplate>
            <ItemStyle Width="60" BorderColor="black" BorderWidth="0px" BorderStyle="solid"  />
            <ItemTemplate>
                    <asp:image id="imgDesign" runat="server"></asp:image>
            </ItemTemplate>
        </asp:TemplateColumn>
    </Columns>
</asp:datagrid>


    <!--Columns>
        <asp:TemplateColumn >
            <HeaderStyle Width="50" />
            <HeaderTemplate>
            <table><tr><td>&nbsp;</td></tr></table>
            </HeaderTemplate>
            <ItemStyle Width="50" />
            <ItemTemplate>
              </ItemTemplate>
        </asp:TemplateColumn>
    </Columns -->