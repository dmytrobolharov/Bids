<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_User_LdapResync.aspx.vb" Inherits="plmOnApp.Control_User_LdapResync" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>LDAP Resync</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
		<meta content="JavaScript" name="vs_defaultClientScript" />
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	</head>
	<body onbeforeunload="busyBox.Show();">
        <script language="javascript" src="../system/jscript/ysbusyscript.js" type="text/javascript"></script>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>
					    <cc1:confirmedimagebutton id="btnBatchUpdate" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
    					<cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" CausesValidation="False" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton>
					</td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:label></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="650" border="0">
				<tr>
					<td colSpan="4">
						<table cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr class="TableHeader">
								<td class="TableHeader" width="10" height="25"></td>
								<td class="TableHeader" width="200"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead">
								    <asp:Label ID="lblAvailableUsers" runat="server" Text="Available User(s)"></asp:Label></B></FONT></td>
								<td class="TableHeader" width="10"></td>
								<td class="TableHeader" width="200"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead">
								    <asp:Label ID="lblSelectedUsers" runat="server" Text="Selected User(s)"></asp:Label>&nbsp;</B></FONT>
								</td>
							</tr>
							<tr>
								<td vAlign="top" width="10"></td>
								<td width="200">
									<table cellSpacing="0" cellPadding="0"border="0">
                                        <tr>
                                            <td>
                                                <asp:DropDownList ID="ddlUserGroups" runat="server" CssClass="fontHead">
                                                    <asp:ListItem Value="5">5</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
										<tr>
                                            <td>
                                                <asp:textbox id="txtSearch" runat="server" Width="200px"></asp:textbox>
                                                <asp:imagebutton id="btnSearch" runat="server" ></asp:imagebutton>
                                            </td>
										</tr>
										<tr>
                                            <td>
												<asp:listbox id="lstUserSelect" runat="server" Height="250px" SelectionMode="Multiple" BorderStyle="Outset" CssClass="fonthead" Width="300px"></asp:listbox>
                                            </td>
										</tr>
									</table>
								</td>
								<td align="center" width="10">
								    <asp:imagebutton id="btnaddUserall" runat="server" ></asp:imagebutton><BR>
									<asp:imagebutton id="btnaddUserItem" runat="server"></asp:imagebutton><BR>
									<asp:imagebutton id="btnRemoveUserItem" runat="server" ></asp:imagebutton><BR>
									<asp:imagebutton id="btnRemoveUserAll" runat="server" ></asp:imagebutton><BR>
								</td>
								<td width="200"><asp:listbox id="lstUserSelected" Height="270px" SelectionMode="Multiple" CssClass="fonthead"
										Width="300px" Runat="server"></asp:listbox></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			
			<div id="BusyBoxDiv" style="BORDER-RIGHT: gainsboro 0px solid; PADDING-RIGHT: 5px; BORDER-TOP: gainsboro 0px solid; PADDING-LEFT: 5px; PADDING-BOTTOM: 5px; BORDER-LEFT: gainsboro 0px solid; PADDING-TOP: 5px; BORDER-BOTTOM: gainsboro 0px solid; POSITION: absolute; BACKGROUND-COLOR: transparent; TEXT-ALIGN: center">
				<p style="WIDTH: 220px; TEXT-ALIGN: center">
					<table cellSpacing="1" cellPadding="1" width="100%" border="0">
						<tr>
							<td width="50" height="32">
							    <img id="BusyBoxImg" height="32" src="../system/images/busy_Layer_0.gif" width="32">
							</td>
							<td class="fontHead">
							    <asp:Label ID="lblPleaseWait" runat="server" Text="Please Wait..."></asp:Label>
                                <br />
								<asp:Label ID="lblUpdateInProgress" runat="server" Text="Update in progress"></asp:Label>
							</td>
						</tr>
					</table>
				</p>
			</div>

			<script language="javascript" type="text/javascript">
			    // Instantiate our BusyBox object
			    var busyBox = new BusyBox("busyBox", 12, "busy_Layer_", ".gif", 120);
			</script>

		</form>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</html>
