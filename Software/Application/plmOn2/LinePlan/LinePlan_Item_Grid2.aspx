<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinePlan_Item_Grid2.aspx.vb" Inherits="plmOnApp.LinePlan_Item_Grid2" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register src="LinePlanningHeader.ascx" tagname="LinePlanningHeader" tagprefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
</head>
<body>
    <form id="form1" runat="server">
			<table class="TableHeader" id="Table1" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>
					    <cc1:ConfirmedImageButton id="btnSave" runat="server" Message="NONE" />
                        <cc1:BWImageButton id="btnEdit" runat="server" />
                        <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>
					</td>
					<td class="FontHead" align="right" width="75"></td>
					<td width="40"></td>
					<td></td>
				</tr>
			</table>
        <uc1:LinePlanningHeader ID="LinePlanningHeader1" runat="server" />
	    <br/>
			<cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview>		
        <asp:Repeater ID="Repeater1" runat="server" >
            <ItemTemplate>
                <asp:HiddenField ID="hdnLinePlanAttributeId1" runat="server" />
                <asp:HiddenField ID="hdnLinePlanAttributeId2" runat="server" />
                <asp:HiddenField ID="hdnLinePlanAttributeId3" runat="server" />
                <asp:HiddenField ID="hdnLinePlanAttributeId4" runat="server" />
              <table cellSpacing="0" cellPadding="0" border="0" width="100%">
                <tr class="TableHeader">
                    <td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
                    <td align="left"><asp:Panel ID="pnlLinePlanBreadCrumb" runat="server"></asp:Panel></td>
                    <td>&nbsp;</td>
                </tr>
               </table>
               <table>
                <tr>
                    <td>
			            <table cellSpacing="0" cellPadding="0" border="0">
				            <tr>
					            <td>
                                    
					            <asp:datagrid id="DataGrid1" runat="server" PageSize="1000" OnItemDataBound="dataGrid1_ItemDataBound"
							            DataKeyField="LinePlanBusinessID" ShowFooter="False" CellPadding="0" CellSpacing="2" BorderWidth="0" CssClass="fontHead" BackColor="#DFDFDF">
							            <ItemStyle BorderStyle="Solid" BorderWidth="1" BorderColor="Black" BackColor="White" Height="20"></ItemStyle>
							            <HeaderStyle CssClass="fontHead"></HeaderStyle>
							            <Columns>
								            <asp:TemplateColumn>
									            <HeaderTemplate>
					                                </td>
					                                    <td align="center" height="20px">&nbsp;</td>
					                                    <td runat="server" id="tdLastYear" class="TableHeaderYellow" align="center" height="20px"><%#GetSystemText("Last Year")%></td>
					                                    <td runat="server" id="tdPlanning" class="TableHeaderGreen" colspan="4" align="center" height="20px"><%#GetSystemText("Planning")%></td>
					                                    <td runat="server" id="tdInProgress" class="TableHeaderRed" colspan="4" align="center" height="20px"><%#GetSystemText("W I P")%></td>
					                                    <td runat="server" id="tdActual" class="TableHeaderBlue" colspan="4" align="center" height="20px"><%#GetSystemText("Actual")%></td>
				                                    </tr>
				                                    <td height="18px">&nbsp;</td>
				                                </HeaderTemplate>
				                                <ItemTemplate>
                                                    <asp:HiddenField ID="hdDataType" runat="server" />
                                                    <asp:HiddenField ID="hdDataFormat" runat="server" />
                                                </ItemTemplate>
				                                <FooterTemplate>
				                                <tr>
				                                     <td height="50" bgcolor="White"></td>   
				                                     <td colspan="14" bgcolor="White">&nbsp;123</td></tr>
				                                    
				                                </FooterTemplate>
				                            </asp:TemplateColumn>
				                        </columns> 
				                </asp:datagrid>
				            </TD></TR>
			            </table>
                    </td>
                </tr>
                </table>
            </ItemTemplate>
        </asp:Repeater> 
            
    </form>
</body>
</html>
