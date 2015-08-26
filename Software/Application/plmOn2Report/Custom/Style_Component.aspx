<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Component.aspx.vb" Inherits="plmOn2Report.Style_Component" enableViewState="False"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie3-2nav3-0">
	<style type="text/css">
        BODY 
        {
            BORDER-RIGHT: 1px;
            BORDER-TOP: 1px;
            FONT-SIZE: 11px;
            MARGIN: 2px;
            BORDER-LEFT: 1px;
            BORDER-BOTTOM: 1px;
            FONT-FAMILY: Tahoma, Geneva, Arial, Helvetica, sans-serif;
        }
    </style>
	<body>
		<form id="Form1" method="post" runat="server">
            <table cellSpacing="0" cellPadding="0" width="100%" border="0">
                <tr><td>
                    <font face="Tahoma" size="1"><asp:label ID="lblComments" visible="False" runat ="server" ></asp:label></font>
                </td></tr>
            </table>
            <asp:HiddenField id="hdnCommentSortOrder" value="MDate DESC" runat="server" />
            <asp:datagrid id="dgComments" PageSize="200" AutoGenerateColumns="False" GridLines="Horizontal" runat="server" EnableViewState="False" Width="100%">
	            <AlternatingItemStyle Font-Size="6pt" Font-Names="Tahoma" BorderStyle="Solid" BorderColor="Black"></AlternatingItemStyle>
	            <ItemStyle Font-Size="6pt" Font-Names="Tahoma" BorderWidth="0px" BorderStyle="Solid" BorderColor="Black"></ItemStyle>
	            <HeaderStyle Font-Size="6pt" Font-Names="Tahoma" Font-Bold="True" ForeColor="Black" CssClass="fontHead" BackColor="WhiteSmoke"></HeaderStyle>
            </asp:datagrid>

            <asp:Panel id="pnlMainMaterial" runat="server">
	            <table borderColor="gold" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffff99" border="1">
		            <tr><td>
                        <font face="Tahoma" size="0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblMainMaterialNotFound" runat="server"></asp:Label></font>
                    </td></tr>
	            </table>
            </asp:Panel>
            <asp:Panel id="pnlMainMaterialGrid" runat="server">
                <table cellSpacing="0" cellPadding="0" width="100%" border="0">
	                <tr>
		                <td><font face="Tahoma" size="1"><b><asp:label ID="lblMainMaterial"  runat ="server" ></asp:label></b></font></td>
	                </tr>
                </table>
                <asp:HiddenField id="hdnMainMaterialSortOrder" value="ComponentOrder, MaterialSort, MaterialNo, MaterialName, StyleMaterialId" runat="server" />
       			<table cellSpacing="0" cellPadding="0" border="0" width="100%">
				    <tr><td vAlign="top">
                        <asp:datagrid id="dgMainComponent" runat="server" AutoGenerateColumns="false" ShowHeader="False" Width="100%" GridLines="None" EnableViewState="False" style="border: 3px solid black;">
							<Columns>
								<asp:TemplateColumn>
									<ItemTemplate>
										<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
											<TR class="fontHead">
												<TD width="10"></TD>
												<TD><FONT face="Tahoma" size="1"><asp:label ID="MainComponentDescription" runat="server"></asp:label></FONT></TD>
											</TR>
										</TABLE>
	                                    <asp:datagrid id="dgMainMaterial" runat="server" EnableViewState="False" AutoGenerateColumns="False" GridLines="Horizontal" Width="100%" DataKeyField = "StyleMaterialID">
		                                    <FooterStyle ForeColor="#000066"></FooterStyle>
		                                    <SelectedItemStyle Font-Bold="True" ForeColor="White" BackColor="#669999"></SelectedItemStyle>
		                                    <AlternatingItemStyle Font-Size="6pt" Font-Names="Tahoma"></AlternatingItemStyle>
		                                    <ItemStyle Font-Size="6pt" Font-Names="Tahoma"></ItemStyle>
		                                    <HeaderStyle Font-Size="6pt" Font-Names="Tahoma" Font-Bold="True" ForeColor="Black" CssClass="fontHead" BackColor="WhiteSmoke"></HeaderStyle>
	                                    </asp:datagrid>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid>
                    </td></tr>
			    </table>
            </asp:Panel>

            <asp:HiddenField id="hdnMaterialSortOrder" value="ComponentOrder, MaterialSort, MaterialNo, MaterialName, StyleMaterialId" runat="server" />
            <asp:Panel id="pnlMaterial" Visible="false" runat="server">
	            <table borderColor="gold" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffff99" border="1">
		            <tr><td>
                        <font face="Tahoma" size="0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblMaterialNotFound" runat="server"></asp:Label></font>
                    </td></tr>
	            </table>
            </asp:Panel>
			<table cellSpacing="0" cellPadding="0" border="0" width="100%">
				<tr><td vAlign="top">
                    <asp:datagrid id="dgComponent" runat="server" AutoGenerateColumns="false" ShowHeader="False" Width="100%" GridLines="None" EnableViewState="False">
						<Columns>
							<asp:TemplateColumn>
								<ItemTemplate>
									<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
										<TR class="fontHead">
											<TD width="10"></TD>
											<TD><FONT face="Tahoma" size="1"><asp:label ID="ComponentDescription" runat="server"></asp:label></FONT></TD>
										</TR>
									</TABLE>
                                    <asp:datagrid id="dgMaterial" PageSize="200" AutoGenerateColumns="False" GridLines="Horizontal" runat="server" EnableViewState="False" Width="100%" DataKeyField="StyleMaterialID">
	                                    <AlternatingItemStyle Font-Size="6pt" Font-Names="Tahoma" BorderStyle="Solid" BorderColor="Black"></AlternatingItemStyle>
	                                    <ItemStyle Font-Size="6pt" Font-Names="Tahoma" BorderWidth="0px" BorderStyle="Solid" BorderColor="Black"></ItemStyle>
	                                    <HeaderStyle Font-Size="6pt" Font-Names="Tahoma" Font-Bold="True" ForeColor="Black" CssClass="fontHead" BackColor="WhiteSmoke"></HeaderStyle>
                                    </asp:datagrid>
								</ItemTemplate>
							</asp:TemplateColumn>
						</Columns>
					</asp:datagrid>
                </td></tr>
			</table>
		</form>
	</body>
</html>
