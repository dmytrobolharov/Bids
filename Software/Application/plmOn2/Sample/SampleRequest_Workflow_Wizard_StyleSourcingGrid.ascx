<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="../Style/Style_Header.ascx" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Wizard_StyleSourcingGrid.ascx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Wizard_StyleSourcingGrid" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
<table id="Table6" style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
	height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
	<tr>
		<td width="50" height="50">&nbsp;</td>
		<td>
			<P><FONT color="lightgrey">&nbsp;</FONT><FONT color="darkgray" size="5"><asp:Label ID="lblHeader"
                    runat="server" ></asp:Label>
					</FONT></P>
		</td>
	</tr>
</table>
<table id="Table7" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
	<tr>
		<td width="800"><uc1:style_header id="Style_Header1" runat="server"></uc1:style_header></td>
		<td></td>
	</tr>
</table>
<table id="Table8" cellSpacing="0" cellPadding="0" width="100%" border="0">
	<tr>
		<td vAlign="top">
			<asp:datagrid id="dgSourcing" runat="server" AllowSorting="True" AutoGenerateColumns=False>
				<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
				<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
				<PagerStyle Visible="False"></PagerStyle>
				<Columns>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<input type="checkbox" onclick="checkAll(this)">
						</HeaderTemplate>
						<ItemTemplate>
							<asp:CheckBox ID="chkSourcingItem" Runat="server"></asp:CheckBox>
							<input runat=server type="hidden" id="txtStyleColorID" name="txtStyleColorID"  value ='<%# Databinder.Eval( Container.DataItem , "StyleColorID") %>' >
							<input runat=server type="hidden" id="txtTradePartnerID" name="txtTradePartnerID"  value ='<%# Databinder.Eval( Container.DataItem , "TradePartnerID") %>' >
							<input runat=server type="hidden" id="txtTradePartnerVendorID" name="txtTradePartnerVendorID"  value ='<%# Databinder.Eval( Container.DataItem , "TradePartnerVendorID") %>' >
							<input runat=server type="hidden" id="txtStyleSourcingID" name="txtStyleSourcingID"  value ='<%# Databinder.Eval( Container.DataItem , "StyleSourcingID") %>' >
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<asp:Label Runat="server" ID="lbHeaderPartner"><%#GetSystemText("Trade Partner")%></asp:Label>
						</HeaderTemplate>
						<ItemStyle Width="150" > </ItemStyle>
						<ItemTemplate>
							<asp:Label Runat="server" ID="lblPartner" Text='<%# Databinder.Eval( Container.DataItem , "TradePartnerName") %>'>
							</asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<asp:Label Runat="server" ID="lblHeaderVendor"><%#GetSystemText("Vendor")%></asp:Label>
						</HeaderTemplate>
						<ItemStyle Width="150" > </ItemStyle>
						<ItemTemplate>
							<asp:Label Runat="server" ID="lblVendor" Text='<%# Databinder.Eval( Container.DataItem , "VendorName") %>' >
							</asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<asp:Label Runat="server" ID="lblHeaderColorway" Text='<%# GetSystemText(strColorway) %>'>
							</asp:Label>
						</HeaderTemplate>
						<ItemStyle Width="150" > </ItemStyle>
						<ItemTemplate>
							<asp:Label Runat="server" ID="lblColorway" Text='<%# Databinder.Eval( Container.DataItem , "MainColor") %>' >
							</asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
			</asp:datagrid>
		</td>
	</tr>
</table>
<TABLE id="Table4" style="BORDER-TOP: gray thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: gainsboro"
	height="35" cellSpacing="0" cellPadding="0" width="100%" bgColor="gainsboro" border="0">
	<TR>
		<TD align="center" width="50">&nbsp;</TD>
		<TD align="center" width="500"><asp:imagebutton id="btnBack" runat="server" ></asp:imagebutton><asp:imagebutton id="btnSave" runat="server" ></asp:imagebutton><asp:imagebutton id="btnNext" runat="server" ></asp:imagebutton></TD>
		<TD align="center">&nbsp;</TD>
	</TR>
</TABLE>
<script language="javascript">
	var frm = document.Form1 ;
	
	function checkAll( obj ) {
		var actVar = obj.checked ;
		for(i=0;i< frm.length;i++){
			e=frm.elements[i];
			if ( e.type=='checkbox' && e.name.indexOf("chkSourcingItem") != -1 )
				e.checked= actVar ;
		}
	}		
</script>
