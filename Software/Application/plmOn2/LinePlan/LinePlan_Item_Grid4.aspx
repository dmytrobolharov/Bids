<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinePlan_Item_Grid4.aspx.vb" Inherits="plmOnApp.LinePlan_Item_Grid4" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register src="LinePlanningHeader.ascx" tagname="LinePlanningHeader" tagprefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Line Planning</title>
    <LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
</head>
<body>
    <form id="form1" runat="server">
			<table class="TableHeader" id="Table1" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><asp:imagebutton id="btnInvSearch" runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px"
							Height="0px"></asp:imagebutton><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE" Visible="false"></cc1:confirmedimagebutton>
                        <cc1:bwimagebutton id="btnCosting" runat="server" ></cc1:bwimagebutton>
                        <cc1:bwimagebutton id="btnColorway" runat="server" ></cc1:bwimagebutton>
                        <cc1:bwimagebutton id="btnRemove" runat="server"  Visible ="true"></cc1:bwimagebutton>
                        <cc1:bwimagebutton id="btnLinkStyles" runat="server" Visible ="true"></cc1:bwimagebutton>
                        <cc1:bwimagebutton id="btnChangeLog" runat="server" CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>
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
           
           
            <br />
            

            <table cellSpacing="0" cellPadding="0" border="0" width="100%" height="25">
            <tr class="TableHeaderOver">
                <td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
                <td align="left"><asp:Label ID="lblAct" runat="server" Text="Actual Styles:"></asp:Label></td>
                <td>&nbsp;</td>
            </tr>
           </table>
            <asp:datagrid id="DataGrid2" runat="server" ShowFooter="False" 
            DataKeyField="LinePlanRangeID" CellPadding="0" CellSpacing="2" BorderWidth="0" CssClass="fontHead" BackColor="#DFDFDF">
            <ItemStyle BorderStyle="Solid" BorderWidth="1" BorderColor="Black" BackColor="White"></ItemStyle>
            <HeaderStyle CssClass="fontHead"></HeaderStyle>
            <Columns>
                <asp:TemplateColumn>
                    <HeaderTemplate>
                        </td>
                            <td align="center" height="20px">&nbsp;</td>
                            <td runat="server" id="tdDel1" class="TableHeaderBlue" colspan="4" align="center" height="20px"><%#GetSystemText("Delivery 1")%></td>
                            <td runat="server" id="tdDel2" class="TableHeaderGreen" colspan="4" align="center" height="20px">><%#GetSystemText("Delivery 2")%></td>
                            <td runat="server" id="tdDel3" class="TableHeaderYellow" colspan="4" align="center" height="20px">><%#GetSystemText("Delivery 3")%></td>
                            <td runat="server" id="tdDel4" class="TableHeaderRed" colspan="4" align="center" height="20px">><%#GetSystemText("Delivery 4")%></td>
                            <td runat="server" id="tdDel5" class="TableHeaderBlue" colspan="4" align="center" height="20px">><%#GetSystemText("Delivery 4")%></td>
                            <td runat="server" id="tdDel6" class="TableHeaderGreen" colspan="4" align="center" height="20px">><%#GetSystemText("Delivery 4")%></td>
                            <td runat="server" id="tdDel7" class="TableHeaderYellow" colspan="4" align="center" height="20px">><%#GetSystemText("Delivery 4")%></td>
                            <td runat="server" id="tdDel8" class="TableHeaderRed" colspan="4" align="center" height="20px">><%#GetSystemText("Delivery 4")%></td>
                            <td runat="server" id="tdDel9" class="TableHeaderBlue" colspan="4" align="center" height="20px">><%#GetSystemText("Delivery 4")%></td>
                            <td runat="server" id="tdDel10" class="TableHeaderGreen" colspan="4" align="center" height="20px">><%#GetSystemText("Delivery 4")%></td>
                            <td runat="server" id="tdDel11" class="TableHeaderYellow" colspan="4" align="center" height="20px">><%#GetSystemText("Delivery 4")%></td>
                            <td runat="server" id="tdDel12" class="TableHeaderRed" colspan="4" align="center" height="20px">><%#GetSystemText("Delivery 4")%></td>
                            
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
                         <td colspan="14" bgcolor="White">&nbsp;123</td>
                    </tr>  
                    </FooterTemplate>
                </asp:TemplateColumn>
            </Columns> 
            </asp:datagrid>        
            <br /><br />
                        
            
            <table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
            <tr vAlign="middle">
			    <td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>  
			</tr>
            </table>
            
			 <br /><br />           
           	 <table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhSearchControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td width="100%" vAlign="top">
						<TABLE id="Table3" height="45">
							<TR>
								<TD>
									<asp:imagebutton id="imgBtnSearch" runat="server"></asp:imagebutton></TD>
							</TR>
						</TABLE>
					</td>
				</tr>
			</table>
			<br />
            <table class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" border="0">
                <tr>
                    <td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
                    <td width="300px">
                        <asp:RadioButtonList ID="rbRangeType" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" Height="20px">
                        </asp:RadioButtonList>
                    </td>  
                    <td>
                        <asp:RadioButtonList ID="rbViewer" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" Height="20px">
                            <asp:ListItem Value="ListView" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="ThumbView"></asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
            </table>	
            

			            
			<asp:Panel ID="pnlStyle" runat="server"></asp:Panel>   
            
    </form>
</body>
</html>
