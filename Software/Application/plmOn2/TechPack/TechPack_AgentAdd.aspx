<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TechPack_AgentAdd.aspx.vb" Inherits="plmOnApp.TechPack_AgentAdd" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
	<HEAD>
		<title>Add Agent</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server" defaultbutton="btnSearchGrid">
			<TABLE class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TBODY>
					<TR vAlign="middle">
						<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
						<TD vAlign="middle" align="left" width="400"><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                        <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" CausesValidation="false" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></TD>
						<TD></TD>
					</TR>
				</TBODY>
			</TABLE>
			<table height="10" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Share Tech Pack...</asp:label></td>
				</tr>
			</table>
			<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR>
					<TD colSpan="4">
                        <asp:Panel ID="pnlPartnersList" runat="server">
						<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
							<TR class="TableHeader">
								<TD class="TableHeader" width="10" height="25"></TD>
								<TD class="TableHeader" width="200"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead">
								    <asp:Label ID="lblAvailable" runat="server" Text="Available Agent"></asp:Label></B></FONT></TD>
								<TD class="TableHeader" width="10"></TD>
								<TD class="TableHeader" width="200"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead"><asp:Label 
                                        ID="lblSelected" runat="server" Text="Selected Agent"></asp:Label>
                                &nbsp;</B></FONT></TD>
								<TD class="TableHeader" width="10"></TD>
							</TR>
							<TR>                                
								<TD vAlign="top" width="10"></TD>
								<TD width="200">
									<TABLE cellSpacing="0" cellPadding="0" width="200" border="0">
										<TR>
											<TD><asp:textbox id="txtSearch" runat="server" Width="150px"></asp:textbox></TD>
											<TD><asp:imagebutton id="btnSearch" runat="server" ></asp:imagebutton></TD>
											<TD><asp:checkbox id="cbViewAll" runat="server" ForeColor="Red" CssClass="fontHead" Width="75px" Text="Show All"
													AutoPostBack="True" Checked="True"></asp:checkbox></TD>
										</TR>
									</TABLE>
									<asp:listbox id="lstUserSelect" runat="server" Height="250px" SelectionMode="Multiple" BorderStyle="Outset"
										CssClass="fonthead" Width="300px"></asp:listbox></TD>
								<TD align="center" width="10"><asp:imagebutton id="btnaddUserall" runat="server" ></asp:imagebutton><BR>
									<asp:imagebutton id="btnaddUserItem" runat="server" ></asp:imagebutton><BR>
									<asp:imagebutton id="btnRemoveUserItem" runat="server" ></asp:imagebutton><BR>
									<asp:imagebutton id="btnRemoveUserAll" runat="server" ></asp:imagebutton><BR>
								</TD>
								<TD width="200"><asp:listbox id="lstUserSelected" Height="270px" SelectionMode="Multiple" CssClass="fonthead"
										Width="300px" Runat="server"></asp:listbox></TD>
								<TD align="center" width="10"><asp:imagebutton id="btnColUserMoveup" Runat="server"></asp:imagebutton><BR>
									<asp:imagebutton id="btnColUserMoveDwn" Runat="server"></asp:imagebutton></TD>                                
							</TR>
						</TABLE>
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
                                        <td>
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
							                <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							                <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
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
					</TD>
				</TR>
			</TABLE>
		</form>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</HTML>
