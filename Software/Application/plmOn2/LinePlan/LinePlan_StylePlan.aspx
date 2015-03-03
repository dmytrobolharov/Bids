<%@ Page Language="vb" AutoEventWireup="false" Codebehind="LinePlan_StylePlan.aspx.vb" Inherits="plmOnApp.LinePlan_StylePlan" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register src="../Style/Style_Header.ascx" tagname="Style_Header" tagprefix="uc1" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">
<HTML>
	<HEAD>
		<title>Planning</title>
        <LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	    <LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
        <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="tableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>
						<asp:ImageButton id="btnSaveStyle" runat="server"></asp:ImageButton>
						<cc1:BWImageButton  id="btnMove" runat="server" Message="NONE" CausesValidation="False" />
						<cc1:BWImageButton  id="btnGotoLinePlan" runat="server" Message="NONE"  CausesValidation="False" />
						<cc1:confirmedimagebutton id="btnUnlink"  Message="Are you sure you want to continue?" runat="server"  />
						</td>
				</tr>
			</table>			
			<table height="100" cellSpacing="0" cellPadding="0" border="0" width="100%" bgcolor="White">
				<tr vAlign="top">
				    <td width="10">&nbsp;</td>
					<td width="900">
                        <uc1:Style_Header ID="Style_Header5" runat="server" />
                    </td>
					<td>&nbsp;</td>
				</tr>
			</table>
			
            <br />			
            
            <table class="TableHeaderYellow" cellspacing="0" cellpadding="0" width="100%" height="30"
                border="0">
                <tr valign="middle">
                    <td valign="middle" align="center" width="10">
                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                    </td>
                    <td width="20"><img src="../System/Icons/icon_season.gif" /></td>
                    <td width="125" align="right" nowrap="nowrap">
                        <asp:Label runat="server" ID="lblStyleSeasonYear" class="fontHead" >Select Season / Year:</asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList  ID="ddlStyleSeasonYearID" runat="server" AutoPostBack="true" ></asp:DropDownList>
                    </td>
                </tr>
            </table>
            <br />			
			
			

			
			<cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview>	
            <asp:datagrid id="DataGrid1" runat="server" PageSize="1000" OnItemDataBound="dataGrid1_ItemDataBound"
		            DataKeyField="LinePlanFinancialID" ShowFooter="False" CellPadding="0" CellSpacing="2" BorderWidth="0" CssClass="fontHead" BackColor="#DFDFDF">
		            <ItemStyle BorderStyle="Solid" BorderWidth="1" BorderColor="Black" BackColor="White"></ItemStyle>
		            <HeaderStyle CssClass="fontHead"></HeaderStyle>
		            <columns>
			            <asp:TemplateColumn>
				            <HeaderTemplate>
                                </td>
                                    <td align="center" height="20px">&nbsp;</td>
                                    <td runat="server" id="tdLastYear" class="TableHeaderYellow" align="center" height="20px"><%#GetSystemText("Last Year")%> </td>
                                    <td runat="server" id="tdPlanning" class="TableHeaderGreen" colspan="4" align="center" height="20px"><%#GetSystemText("Planning")%></td>
                                    <td runat="server" id="tdInProgress" class="TableHeaderRed" colspan="4" align="center" height="20px">W I P</td>
                                    <td runat="server" id="tdActual" class="TableHeaderBlue" colspan="4" align="center" height="20px"><%#GetSystemText("Actual")%></td>
                                </tr>
                                <td height="18px">&nbsp;</td>
                            </HeaderTemplate>
                            <ItemStyle  Height="20" />
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

		</form>
	</body>
</HTML>
