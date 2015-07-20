<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_ShareAgentAdd.aspx.vb" Inherits="plmOnApp.Style_ShareAgentAdd" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>Add Agent</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server" defaultbutton="btnSearchGrid">
			<table class="TableHeader" height="27" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<TBODY>
					<tr valign="middle">
						<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td valign="middle" align="left" width="400"><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
						<td></td>
					</tr>
				</TBODY>
			</table>
			<table height="10" cellSpacing="0" cellpadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Share Style With...</asp:label></td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="650" border="0">
				<tr>
					<td colSpan="4">
						<table cellSpacing="0" cellpadding="0" width="100%" border="0">
							<tr class="TableHeader">
								<td class="TableHeader" width="10" height="25"></td>
								<td class="TableHeader" width="200"><asp:label id="lblAvailableSize" runat="server" CssClass="fontHead">Available Size</asp:label></td>
								<td class="TableHeader" width="10"></td>
								<td class="TableHeader" width="200"><asp:label id="lblSelectedSize" runat="server" CssClass="fontHead">Selected Size</asp:label></td>
								<td class="TableHeader" width="10"></td>
							</tr>
							<tr>
								<td valign="top" width="10"></td>
								<td align="center" width="200"><asp:listbox id="lstStyleSelect" runat="server" Height="100px" SelectionMode="Multiple" BorderStyle="Outset"
										CssClass="fonthead" Width="250px"></asp:listbox></td>
								<td align="center" width="10"><asp:imagebutton id="btnaddall" runat="server" ></asp:imagebutton><BR>
									<asp:imagebutton id="btnadditem" runat="server" ></asp:imagebutton><BR>
									<asp:imagebutton id="btnremoveitem" runat="server" ></asp:imagebutton><BR>
									<asp:imagebutton id="btnremoveall" runat="server" ></asp:imagebutton><BR>
								</td>
								<td width="200"><asp:listbox id="lstStyleSelected" Height="100px" SelectionMode="Multiple" CssClass="fonthead"
										Width="250px" Runat="server"></asp:listbox></td>
								<td align="center" width="10"><asp:imagebutton id="btnColmoveup"  Runat="server"></asp:imagebutton><BR>
									<asp:imagebutton id="btnColmovedwn"  Runat="server"></asp:imagebutton></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td colSpan="4">
                        <asp:Panel ID="pnlPartnersList" runat="server">
						    <table cellSpacing="0" cellpadding="0" width="100%" border="0">
							    <tr class="TableHeader">
								    <td class="TableHeader" width="10" height="25"></td>
								    <td class="TableHeader" width="200"><asp:label id="lblAvailableAgent" runat="server" CssClass="fontHead">Available Agent</asp:label></td>
								    <td class="TableHeader" width="10"></td>
								    <td class="TableHeader" width="200"><asp:label id="lblSelectedAgent" runat="server" CssClass="fontHead">Selected Agent</asp:label></td>
								    <td class="TableHeader" width="10"></td>
							    </tr>
							    <tr>
								    <td valign="top" width="10"></td>
								    <td align="center" width="200"><asp:listbox id="lstUserSelect" runat="server" Height="250px" SelectionMode="Multiple" BorderStyle="Outset"
										    CssClass="fonthead" Width="250px"></asp:listbox></td>
								    <td align="center" width="10"><asp:imagebutton id="btnaddUserall" runat="server" ></asp:imagebutton><BR>
									    <asp:imagebutton id="btnaddUserItem" runat="server" ></asp:imagebutton><BR>
									    <asp:imagebutton id="btnRemoveUserItem" runat="server" ></asp:imagebutton><BR>
									    <asp:imagebutton id="btnRemoveUserAll" runat="server" ></asp:imagebutton><BR>
								    </td>
								    <td width="200"><asp:listbox id="lstUserSelected" Height="250px" SelectionMode="Multiple" CssClass="fonthead"
										    Width="250px" Runat="server"></asp:listbox></td>
								    <td align="center" width="10"><asp:imagebutton id="btnColUserMoveup"  Runat="server"></asp:imagebutton><BR>
									    <asp:imagebutton id="btnColUserMoveDwn"  Runat="server"></asp:imagebutton></td>
							    </tr>
						    </table>
                        </asp:Panel>
                        <asp:Panel ID="pnlPartnersGrid" runat="server">
                            <table cellpadding="0" cellspacing="0" style="margin-top:15px; margin-left:15px;" width="90%">
                                <tr>
                                    <td>
                                        <table cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <asp:PlaceHolder ID="plhSearchControlsHolder" runat="server"></asp:PlaceHolder>
                                                </td>
                                                <td align="left">
                                                    <asp:ImageButton ID="btnSearchGrid" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <TABLE class="TableHeader" id="Table3" height="25" cellSpacing="0" cellPadding="0" width="100%"
							            bgColor="#ffffff" border="0">
							            <TR vAlign="middle">
								            <TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								            <TD width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></TD>
								            <TD width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></TD>
								            <TD noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
								            <TD width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></TD>
								            <TD width="20"><asp:imagebutton id="btnImgLast" runat="server"></asp:imagebutton></TD>
								            <TD width="10">&nbsp;</TD>
								            <TD noWrap><asp:label id="RecordCount" runat="server" CssClass="fontHead"></asp:label></TD>
								            <TD class="fontHead" align="right" width="110"><asp:Label ID="lblRecordsperPage" runat="server" Visible="true" Text="Records per Page:"></asp:Label></TD>
								            <TD width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
										            <asp:ListItem Value="5">5</asp:ListItem>
										            <asp:ListItem Value="10">10</asp:ListItem>
										            <asp:ListItem Value="15">15</asp:ListItem>
										            <asp:ListItem Value="20">20</asp:ListItem>
										            <asp:ListItem Value="25">25</asp:ListItem>
										            <asp:ListItem Value="30">30</asp:ListItem>
										            <asp:ListItem Value="40">40</asp:ListItem>
										            <asp:ListItem Value="50" Selected="True">50</asp:ListItem>
									            </asp:dropdownlist></TD>
								            <TD width="10"><asp:button id="Button1" onclick="RePage" runat="server" CssClass="fontHead" Text="GO"></asp:button></TD>
							            </TR>
						            </TABLE>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                         <asp:datagrid id="DataGrid1" runat="server" PageSize="50" AllowSorting="True" DataKeyField="TradePartnerId">
							                <AlternatingItemStyle Font-Size="11px" Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							                <ItemStyle Font-Size="11px" Height="20px" CssClass="ItemTemplate"></ItemStyle>
							                <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							                <PagerStyle Visible="False"></PagerStyle>
                                            <Columns> 
                                                <asp:TemplateColumn>
                                                    <ItemTemplate>
                                                        <asp:CheckBox runat="server" ID="chkSelect" />
                                                        <asp:HiddenField runat="server" ID="hdnTradePartnerRelationshipLevelID" />
                                                        <asp:HiddenField runat="server" ID="hdnTradePartnerIDChain" />
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                            </Columns>
						                </asp:datagrid>
						                <asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
					</td>
				</tr>
			</table>
		</form>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</html>
