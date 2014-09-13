<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinePlan_Item_FinancialPlan_FrameTop.aspx.vb" Inherits="plmOnApp.LinePlan_Item_FinancialPlan_FrameTop" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register Src="LinePlanningHeader.ascx" TagName="LinePlanningHeader" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head id="Head1" runat="server">
        <title runat="server" id="PageTitle">Financial Plan</title>
        <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/RadComboBox.YPLM.css" type="text/css" rel="stylesheet" />
	    <link href="../System/CSS/RadGrid.YPLM.css" type="text/css" rel="stylesheet" />
    </head>
    <body>
        <form id="form1" runat="server">
            <table class="TableHeader" id="Table1" cellspacing="0" cellpadding="0" width="100%"
                border="0" runat="server">
                <tr valign="middle">
                    <td valign="middle" align="center" width="10">
                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                    </td>
                    <td>
                        <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE" />
                        <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>
                        <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" />
                    </td>
                    <td class="FontHead" align="right" width="75">
                    </td>
                    <td width="40">
                    </td>
                    <td>
                    </td>
                </tr>
            </table>
            <uc1:LinePlanningHeader ID="LinePlanningHeader1" runat="server" />
            <br />
            <cc2:YSTabView ID="YSTabView1" runat="server"></cc2:YSTabView>
        </form>
    </body>
</html>
