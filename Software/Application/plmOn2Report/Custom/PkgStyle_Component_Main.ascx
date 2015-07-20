<%@ Control Language="vb" AutoEventWireup="false" Codebehind="PkgStyle_Component_Main.ascx.vb" Inherits="plmOn2Report.PkgStyle_Component_Main" targetSchema="http://schemas.microsoft.com/intellisense/ie3-2nav3-0" enableViewState="False" %>
<asp:Panel id="Panel2" runat="server">
    <TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
	    <TR>
		    <TD width="10" bgColor="white"></TD>
		    <TD bgColor="white"><FONT face="Tahoma" size="1"><asp:label ID="lblMainMaterial"  runat ="server" ></asp:label> </FONT></TD>
	    </TR>
    </TABLE>	
	<asp:datagrid id="dgMainMaterial" runat="server" EnableViewState="False" AutoGenerateColumns="False"
		GridLines="Horizontal" CellPadding="1" BackColor="White" BorderWidth="1px" BorderStyle="Solid"
		BorderColor="#CCCCCC" Width="100%">
		<FooterStyle ForeColor="#000066" BackColor="White"></FooterStyle>
		<SelectedItemStyle Font-Bold="True" ForeColor="White" BackColor="#669999"></SelectedItemStyle>
		<AlternatingItemStyle Font-Size="6pt" Font-Names="Tahoma" BorderStyle="Solid" BorderColor="Black"></AlternatingItemStyle>
		<ItemStyle Font-Size="6pt" Font-Names="Tahoma" BorderStyle="Solid" BorderColor="Black"></ItemStyle>
		<HeaderStyle Font-Size="6pt" Font-Names="Tahoma" Font-Bold="True" ForeColor="Black" CssClass="fontHead"
			BackColor="WhiteSmoke"></HeaderStyle>
	</asp:datagrid>
</asp:Panel>
<asp:Panel id="Panel1" runat="server">
	<TABLE borderColor="gold" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffff99"
		border="1">
		<TR>
			<TD><FONT face="Tahoma" size="0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                <asp:Label ID="lblMaterialNotFound" runat="server" ></asp:Label>
					</FONT></TD>
		</TR>
	</TABLE>
</asp:Panel>
