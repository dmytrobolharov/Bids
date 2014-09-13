<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Style_SubComponent.ascx.vb" Inherits="plmOnApp.Style_SubComponent" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
            
<!--------------------------------------------------------->
<asp:datagrid id="DataGrid1" runat="server" Width="100%" BorderColor="#cccccc" BorderWidth="1" >
    <AlternatingItemStyle CssClass="ItemTemplate"></AlternatingItemStyle>
    <ItemStyle CssClass="ItemTemplate"></ItemStyle>
    <HeaderStyle width="50px" CssClass="fontHead"></HeaderStyle>
    <Columns>
        <asp:TemplateColumn >
            <HeaderStyle Width="50" />
            <HeaderTemplate>
            <table><tr><td>&nbsp;</td></tr></table>
            </HeaderTemplate>
            <ItemStyle Width="50" />
            <ItemTemplate>
              </ItemTemplate>
        </asp:TemplateColumn>
    </Columns>
    
</asp:datagrid>
	          
<!--------------------------------------------------------->	            

    <!--- Columns>
        <asp:TemplateColumn >
            <HeaderStyle Width="50" />
            <HeaderTemplate>
            <table><tr><td>&nbsp;</td></tr></table>
            </HeaderTemplate>
            <ItemStyle Width="50" />
            <ItemTemplate>
              <cc1:BWImageButton id="imgDesign" runat="server"></cc1:BWImageButton>    
            </ItemTemplate>
        </asp:TemplateColumn>
    </Columns---->
