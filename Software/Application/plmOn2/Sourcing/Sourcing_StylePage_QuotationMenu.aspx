<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_StylePage_QuotationMenu.aspx.vb" Inherits="plmOnApp.Sourcing_StylePage_QuotationMenu" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
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
		<cc1:YSTreeView id="YSTreeView1" runat="server"></cc1:YSTreeView>
        <asp:Label id="LabelEmptyTree" runat="server"></asp:Label>
    </div>
    </form>
</body>
</html>
