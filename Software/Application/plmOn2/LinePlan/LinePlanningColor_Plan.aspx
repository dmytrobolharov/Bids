<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinePlanningColor_Plan.aspx.vb" Inherits="plmOnApp.LinePlanningColor_Plan" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register src="LinePlanningHeader.ascx" tagname="LinePlanningHeader" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">    
</head>
<body>
    <form id="form1" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD><asp:imagebutton id="btnInvSearch" runat="server" Height="0px" Width="0px" ImageUrl="../System/icons/1x1.gif"></asp:imagebutton>
                        <cc1:confirmedimagebutton id="btnColorAdd" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                        <cc1:confirmedimagebutton id="btnColorAllocationAdd" runat="server" 
                             Message="NONE"></cc1:confirmedimagebutton></TD>
					<td>&nbsp;</td>
				</TR>
			</TABLE>
			<uc1:LinePlanningHeader ID="LinePlanningHeader1" runat="server" />
			<br>
			<cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview>		
            <asp:Repeater ID="Repeater1" runat="server" >
                <ItemTemplate>
                <table cellSpacing="0" cellPadding="0" border="0" width="100%">
                <tr class="ToolbarBlue">
                    <td height="30">&nbsp;<font style="color: #FFFFFF" class="fontHead">
                        <%#Container.DataItem("LinePlanAttributeText1")%>&gt;
                        <%#Container.DataItem("LinePlanAttributeText2")%>&gt;
                        <%#Container.DataItem("LinePlanAttributeText3")%>&gt;
                        <%#Container.DataItem("LinePlanAttributeText4")%>&gt;</font></td>
                </tr>
                </table>  
                    <asp:Panel ID="pnlStyle" runat="server"></asp:Panel>   
                    <asp:Repeater ID="rptRangeType" runat="server" OnItemDataBound="rptRangeType_ItemDataBound">
                    <ItemTemplate>
                        <table cellSpacing="0" cellPadding="0" border="0" width="100%">
                            <tr class="TableHeader">
                                <td height="100" width="200">&nbsp;<asp:Label ID="lblRangeType" runat="server" Text='<%#GetSystemText("Label")%>'></asp:Label>
                            </tr>
                        </table>
                        <asp:Panel ID="pnlStyle" runat="server"></asp:Panel>
                    </ItemTemplate>
                    </asp:Repeater>
                </ItemTemplate>
            </asp:Repeater> 
			
    </form>
</body>
</html>
