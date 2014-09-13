<%@ Register TagPrefix="uc1" TagName="Style_Component_Main" Src="Style_Component_Main.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Component.aspx.vb" Inherits="plmOn2Report.Style_Component" enableViewState="False"%>
<%@ Register TagPrefix="uc1" TagName="Style_Component" Src="Style_Component.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie3-2nav3-0">
	<style type="text/css">
BODY { BORDER-RIGHT: 1px; BORDER-TOP: 1px; FONT-SIZE: 11px; MARGIN: 2px; BORDER-LEFT: 1px; BORDER-BOTTOM: 1px; FONT-FAMILY: Tahoma, Geneva, Arial, Helvetica, sans-serif }
</style>
	<body>
		<form id="Form1" method="post" runat="server">
			<table cellSpacing="0" cellPadding="0" border="0" width="780">
				<tr>
					<td vAlign="top">
						<asp:panel id="Panel1" runat="server">
							<uc1:style_component_main id="Style_Component_Main1" runat="server" SN='<%# Request.Querystring("SN") %>' SID='<%# Request.Querystring("SID") %>' SWID='<%# Request.Querystring("SWID") %>' WFIID='<%# Request.Querystring("WFIID") %>' SYSCID='<%# Request.Querystring("SYSCID") %>'></uc1:style_component_main>
						</asp:panel>
					</td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" border="0" width="780">
				<tr>
					<td vAlign="top"><asp:datagrid id="dgComponent" runat="server" AutoGenerateColumns="false" ShowHeader="False" Width="100%"
							GridLines="None" EnableViewState="False">
							<Columns>
								<asp:TemplateColumn>
									<ItemTemplate>
										<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
											<TR class="fontHead">
												<TD width="10"></TD>
												<TD><FONT face="Tahoma" size="1"><asp:label ID="ComponentDescription" runat="server"></asp:label></FONT></TD>
											</TR>
										</TABLE>
										<uc1:Style_Component id="Style_Component1" runat="server" MaterialSource='<%# MaterialDataSource(DataBinder.Eval(Container.DataItem, "ComponentTypeID")) %>' CTID='<%# DataBinder.Eval(Container.DataItem, "ComponentTypeID") %>' SID='<%# Request.Querystring("SID") %>' SN='<%# Request.Querystring("SN") %>' SWID='<%# Request.Querystring("SWID") %>' WFIID='<%# Request.Querystring("WFIID") %>' SYSCID='<%# Request.Querystring("SYSCID") %>'>
										</uc1:Style_Component>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid></td>
				</tr>
			</table>
            <asp:Panel id="Panel2" Visible="false" runat="server">
	            <TABLE borderColor="gold" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffff99" border="1">
            		<TR>
			            <TD><FONT face="Tahoma" size="0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                            <asp:Label ID="lblMaterialNotFound" runat="server"></asp:Label></FONT>
                        </TD>
		            </TR>
	            </TABLE>
            </asp:Panel>
		</form>
	</body>
</html>
