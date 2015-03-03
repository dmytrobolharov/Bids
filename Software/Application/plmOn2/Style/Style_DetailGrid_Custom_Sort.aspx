<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_DetailGrid_Custom_Sort.aspx.vb" Inherits="plmOnApp.Style.DetailGrid.Style_DetailGrid_Custom_Sort" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Sort</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
			<table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%" border="0">
				<TBODY>
					<tr valign="middle">
						<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td valign="middle" align="left" width="400"><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
						<td></td>
					</tr>
				</TBODY>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Sort Size</asp:label></td>
				</tr>
			</table>
			<asp:Panel ID="pnlSort" Runat="server" Visible="true">
				<table cellspacing="0" cellpadding="0" border="0">
					<tr valign="middle">
						<td width="150">
							<asp:label id="lblSortBy" CssClass="font" Runat="server">
								<b>Sort by:</b></asp:label>&nbsp;
							<asp:dropdownlist id="ddlSortBy" Runat="server"></asp:dropdownlist></td>
						<td>
							<cc1:confirmedimagebutton id="btnSort" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
					</tr>
				</table>
			</asp:Panel>
			<asp:datagrid id="DataGrid1" runat="server" Width="300px" BorderColor="#E0E0E0" BorderStyle="Solid"
				BorderWidth="1px" PageSize="100" AutoGenerateColumns="False" DataKeyField="StyleDetailGridID">
				<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<asp:Label id="lblSize" runat="server"><%#GetSystemText("Size")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<%#DataBinder.Eval(Container.DataItem,"StyleDetailCustom1").tostring%>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<asp:Label id="Label2" runat="server"><%#GetSystemText("Sort")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:TextBox Runat=server ID="txtSort" Text='<%#DataBinder.Eval(Container.DataItem,"Sort").tostring%>' Width="40" MaxLength="4">
							</asp:TextBox>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
			</asp:datagrid>
    
    </form>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
