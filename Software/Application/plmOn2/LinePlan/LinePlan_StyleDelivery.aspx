<!-- 
LinePlan_StyleColor_Default.xml
LinePlan_StyleColor_Search.xml
-->

<%@ Page Language="vb" AutoEventWireup="false" Codebehind="LinePlan_StyleDelivery.aspx.vb" Inherits="plmOnApp.LinePlan_StyleDelivery" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<HTML>
	<HEAD>
		<title>Delivery</title>
        <LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	    <LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
        <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>	
	    </HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
				    <td vAlign="middle" align="center" width="10"><asp:imagebutton id="btnInvSearch" runat="server" Height="0px" Width="0px" 
					ImageUrl="../System/icons/1x1.gif"></asp:imagebutton><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>
						<asp:ImageButton id="btnSaveStyle" runat="server" ></asp:ImageButton>
						<cc1:bwimagebutton id="btnApplyAll" Visible = "true" runat="server" Message="NONE" ></cc1:bwimagebutton>
						<cc1:ConfirmedImageButton 	id="btnUnlockFields"  Message="Do you want to continue?" runat="server" /></td>
				</tr>
			</table>			
            
            
            <br /><br />

		
            <table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="top" bgColor="#ffffff">
                        <table height="100" cellspacing="0" cellpadding="0" width="100%" border="0">
						    <tr valign="top">
							    <td width="10">&nbsp;</td>
							    <td>
						            <asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder>
						    </tr>
					    </table>					
					</td>
					<td width="10%" bgColor="#f5f5f5">&nbsp;</td>
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
            
            <asp:Panel runat="server" ID="pnlSeasonYear" >
                <br />
                <asp:placeholder id="plhSeasonYearHeader" runat="server"></asp:placeholder>
                <br />
            </asp:Panel>
            
            
            

			<cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview>				
			<table cellSpacing="0" cellPadding="0" width="100%" border="0" bgcolor="White">
			<tr>
			    <td width="800" style="text-align: right">
                </td>
			    <td>&nbsp;</td>
			</tr>
			<tr><td align="center"><asp:Label ID="lblMessage" runat="server" CssClass="fontRed" ></asp:Label></td>
			</tr>
			<tr>
			    <td>
			        <br />
			        <table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
				        <tr>
					        <td><asp:placeholder id="plhSearchControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					        <td width="100%" valign="top">
						        <table height="45">
							        <tr>
								        <td>
									        <asp:imagebutton id="imgBtnSearch" runat="server"></asp:imagebutton></td>
							        </tr>
						        </table>
					        </td>
				        </tr>
			        </table>            			
			        <br />
			    </td>
						
			</tr>
			<tr>
	    	<td width="800">
        	    <asp:datagrid id="dgColorway" runat="server" DataKeyField="StyleColorwaySeasonYearID" AutoGenerateColumns="False" 
                     BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" Visible="true">
				    <PagerStyle />
				    <AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
				    <ItemStyle Height="20px" CssClass="font"></ItemStyle>
				    <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
			    </asp:datagrid>	

            </td>
			<td>&nbsp;</td></tr>
		</table>
        <br />

		</form>
	</body>
</HTML>
