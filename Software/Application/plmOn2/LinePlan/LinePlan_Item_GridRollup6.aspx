<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinePlan_Item_GridRollup6.aspx.vb" Inherits="plmOnApp.LinePlan_Item_GridRollup6" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register src="LinePlanningHeader.ascx" tagname="LinePlanningHeader" tagprefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
<body>
    <form id="form1" runat="server">
			<table class="TableHeader" id="Table1" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
                        
                    </td>
					<td class="FontHead" align="right" width="75"></td>
					<td width="40"></td>
					<td></td>
				</tr>
			</table>
			<uc1:LinePlanningHeader ID="LinePlanningHeader1" runat="server" />
			<br>
			<cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview>	
            <table cellSpacing="0" cellPadding="0" border="0" width="100%">
                <tr class="TableHeader">
                    <td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
                    <td align="left"><asp:Panel ID="pnlLinePlanBreadCrumb" runat="server"></asp:Panel></td>
                    <td>&nbsp;</td>
                </tr>
            </table>


            <asp:Panel ID="pnlLinePlanRange" runat="server"></asp:Panel>
            <asp:Panel ID="pnlStyle" runat="server"></asp:Panel>	            
			
    </form>
</body>
</html>
