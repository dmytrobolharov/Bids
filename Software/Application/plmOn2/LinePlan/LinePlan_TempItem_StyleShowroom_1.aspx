<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinePlan_TempItem_StyleShowroom_1.aspx.vb" Inherits="plmOnApp.LinePlan_TempItem_StyleShowroom_1" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Showroom</title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
	<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
</head>
<body>
    <form id="form1" runat="server">

			<table class="TableHeader" id="Table1" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnNext" runat="server" Message="NONE" style="height: 24px"></cc1:confirmedimagebutton></td>
					<td class="FontHead" align="right" width="75"></td>
				</tr>
			</table>
			
	    <table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0" >
			<TR>
				<TD>&nbsp;
					<asp:label id="lbHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Select Vendor</asp:label></TD>
			</TR>
			<tr>
			<td>
			    <asp:datagrid id="DataGrid1" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
    				AutoGenerateColumns="false"  DataKeyField="TradePartnerVendorID"  AllowSorting="true">
			        <AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
			        <HeaderStyle CssClass="TableHeader" Height="25px"></HeaderStyle>
			        <PagerStyle Visible="False"></PagerStyle>
			        <Columns>
                        <asp:TemplateColumn >
                            <HeaderStyle CssClass="TableHeader" BorderColor="Gainsboro"  BorderWidth="1"  />
                            <ItemStyle Width ="10" HorizontalAlign="Center"  BorderColor="Gainsboro"  BorderWidth="1" />
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblRBVendor" ></asp:Label>
                             </ItemTemplate>
                        </asp:TemplateColumn>
        			
			        </Columns>
			    </asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
			</td>
			</tr>
			
		</table>


		
		

    </form>
</body>
</html>
