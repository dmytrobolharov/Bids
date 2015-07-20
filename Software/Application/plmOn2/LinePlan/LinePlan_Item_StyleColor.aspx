<!-- 
LinePlan_Item_StyleColor_Default.xml
LinePlan_Item_StyleColor_Search.xml
-->

<%@ Page Language="vb" AutoEventWireup="false" Codebehind="LinePlan_Item_StyleColor.aspx.vb" Inherits="plmOnApp.LinePlan_Item_StyleColor" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
	<HEAD>
		<title>Color</title>
        <LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	    <LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
        <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
		<script language="JavaScript">
			<!--

			if (window.screen) {
				var aw = screen.availWidth;
				var ah = screen.availHeight;
				window.moveTo(0, 0);
				window.resizeTo(aw, ah);
			}

			if (self != top) top.location.replace(self.location);	

			self.focus();

			//-->
		</script>        
	    </HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
		
		
			<table class="tableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><asp:imagebutton 
					    id="btnInvSearch" runat="server" Height="0px" Width="0px" ImageUrl="../System/icons/1x1.gif"></asp:imagebutton>
					    <asp:ImageButton    id="btnSaveStyle" runat="server" ></asp:ImageButton>
					    <asp:ImageButton id="btnClose" runat="server"  CausesValidation="False" OnClientClick="return btnClose_Click()"></asp:ImageButton>
					    <cc1:bwimagebutton id="btnApplyAll" Visible = "true" runat="server" Message="NONE" ></cc1:bwimagebutton>
					    <cc1:ConfirmedImageButton id="btnUnlockFields"  Message="Do you want to continue?" runat="server" /></td>
				</tr>
			</table>		
			
			<br /><br />
			<table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhSearchControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td width="100%" valign="top">
						<table height="45">
							<tr>
								<td>
									<asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>            			
			<br />
			<table  border="0" width ="100%">
			    <tr><td align="center"><asp:Label ID="lbMsg" runat="server" CssClass="fontRed" ></asp:Label></td>
			</table>
			<br />
            <table  class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff"
	            border="0">
	            <tr valign="middle">
		            <td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		            <td class="fonthead" width="10">&nbsp;</td>
		            <td width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></td>
		            <td width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></td>
		            <td nowrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fonthead"></asp:label></td>
		            <td width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></td>
		            <td width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></td>
		            <td width="10">&nbsp;</td>
		            <td width="150"><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></td>				
		            <TD align="right" width="110"><asp:label id="RecordPerPage" runat="server" CssClass="font"></asp:label></TD>
		            <td width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fonthead">
				            <asp:ListItem Value="5">5</asp:ListItem>
				            <asp:ListItem Value="10">10</asp:ListItem>
				            <asp:ListItem Value="15">15</asp:ListItem>
				            <asp:ListItem Value="20">20</asp:ListItem>
				            <asp:ListItem Value="25" Selected="true">25</asp:ListItem>
			            </asp:dropdownlist></td>
		            <td width="10"><asp:button id="Button1" runat="server" CssClass="fonthead" text="GO"></asp:button></td>
		            <td>&nbsp;</td>
	            </tr>
            </table>
        		
        	<asp:datagrid id="dgColorway" runat="server" DataKeyField="StyleColorwaySeasonYearID" AutoGenerateColumns="False" 
                 BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" Visible="true">
				<PagerStyle />
				<AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
				<PagerStyle Visible="False"></PagerStyle>
				<Columns>
				    <asp:TemplateColumn>
				        <ItemTemplate>
				            <span>&nbsp;</span>
				        </ItemTemplate>
				    </asp:TemplateColumn>
				    <asp:TemplateColumn  HeaderText="unlock">
				    	<ItemTemplate>
				            <asp:CheckBox  runat="server" ID="chkSelect" />
				        </ItemTemplate>
				    </asp:TemplateColumn>
				</Columns>
			</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>				
			<asp:HiddenField runat="server" ID="hdnSql" />
						
		</form>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</HTML>
