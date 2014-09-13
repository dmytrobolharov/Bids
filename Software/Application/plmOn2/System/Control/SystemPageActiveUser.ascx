<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="SystemPageActiveUser.ascx.vb" Inherits="plmOnApp.SystemPageActiveUser" %>
<%@ OutputCache VaryByParam="None" Duration="1" %>

<asp:ScriptManager ID="ScriptManager1" runat="server">
</asp:ScriptManager>

<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <asp:Timer ID="Timer1" runat="server" Interval="2000"></asp:Timer>
        
        <asp:Panel ID="Panel1" runat="server">
            <div style="padding: 10px; font-size: 1.0em; background-color: Red; color: White; font-weight: bold;">
                <asp:Label ID="lblCurrentUsers" runat="server"></asp:Label>
            </div>
        </asp:Panel>
        
    </ContentTemplate>
</asp:UpdatePanel>
