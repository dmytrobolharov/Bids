<%@ Register TagPrefix="uc1" TagName="PkgStyle_Component_Main" Src="PkgStyle_Component_Main.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PkgStyle_Component.aspx.vb" Inherits="plmOn2Report.PkgStyle_Component" enableViewState="False" %>
<%@ Register TagPrefix="uc1" TagName="PkgStyle_Component" Src="PkgStyle_Component.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie3-2nav3-0"/>
	<style type="text/css">
BODY { BORDER-RIGHT: 0px; BORDER-TOP: 0px; FONT-SIZE: 11px; MARGIN: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px; FONT-FAMILY: Tahoma, Geneva, Arial, Helvetica, sans-serif }
</style>
	<body>
		<form id="Form1" method="post" runat="server">
			<asp:panel id="Panel1" runat="server">
				<uc1:pkgstyle_component_main id="Style_Component_Main1" runat="server" SID='<%# Request.Querystring("SID") %>' SN='<%# Request.Querystring("SN") %>' SYSCID='<%# Request.Querystring("SYSCID") %>'>
				</uc1:pkgstyle_component_main>
			</asp:panel>
			<table cellSpacing="0" cellPadding="0" border="0" width="100%">
				<tr>
					<td vAlign="top"><asp:datagrid id="dgComponent" runat="server" AutoGenerateColumns="false" ShowHeader="False" Width="100%"
							PageSize="100" GridLines="None" EnableViewState="False">
							<Columns>
								<asp:TemplateColumn>
									<ItemTemplate>
										<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
											<TR class="fontHead">
												<TD width="10"></TD>
												<TD><FONT face="Tahoma" size="1"><%# DataBinder.Eval(Container.DataItem, "ComponentDescription") %></FONT></TD>
											</TR>
										</TABLE>
										<uc1:PkgStyle_Component id="Style_Component1" runat="server" MaterialSource='<%# MaterialDataSource(DataBinder.Eval(Container.DataItem, "ComponentTypeID")) %>' CTID='<%# DataBinder.Eval(Container.DataItem, "ComponentTypeID") %>' SID='<%# Request.Querystring("SID") %>' SN='<%# Request.Querystring("SN") %>' SYSCID='<%# Request.Querystring("SYSCID") %>'>
										</uc1:PkgStyle_Component>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid></td>
				</tr>
			</table>
		</form>
	</body>
</html>
