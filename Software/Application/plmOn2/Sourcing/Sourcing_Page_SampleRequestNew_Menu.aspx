<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_Page_SampleRequestNew_Menu.aspx.vb" Inherits="plmOnApp.Sourcing_Page_SampleRequestNew_Menu" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
		<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr>
				<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
				<td class="fontHead">
						<asp:Label id="lblstyle" runat="server">Style</asp:Label>
				</td>
			</tr>
		</table>
		<cc1:YSTreeView id="YSTreeView1" Visible="false" runat="server"></cc1:YSTreeView>
        <asp:Label id="LabelEmptyTree" runat="server"></asp:Label>

		<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
			<tr>
				<td><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>
				<td vAlign="middle" width="100%">
					<table height="45">
						<tr>
							<td><asp:imagebutton id="imgBtnSearch" runat="server"></asp:imagebutton></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<asp:datagrid id="DataGrid1" runat="server" AllowSorting="false" width="100%">
			<AlternatingItemStyle Height="20px" CssClass="ItemTemplate"></AlternatingItemStyle>
			<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
			<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
			<PagerStyle Visible="False"></PagerStyle>
		</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>

    </div>
    </form>
</body>
</html>
