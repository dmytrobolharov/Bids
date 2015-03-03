<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_User_ProductAttributeEdit.aspx.vb" Inherits="plmOnApp.Control_User_ProductAttributeEdit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title></title>
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" CausesValidation="False" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton>
					</td>
					<td class="FontHead" align="right" width="75"></td>
					<td width="40"></td>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" 
                        Font-Size="X-Large" ForeColor="#999999"></asp:label></td>
				</tr>
			</table>
			<TABLE width="700" align="left">
				</TR-->
				<TR>
					<TD align="center" width="300"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead"><asp:Label ID="lblAvailableUsers" runat="server"></asp:Label>
								</B></FONT></TD>
					<TD width="50"></TD>
					<TD align="center" width="300"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead"><asp:Label ID="lblSelectedUsers" runat="server"></asp:Label>
								</B></FONT>
					</TD>
				</TR>
				<TR>
					<TD align="center"><asp:listbox id="lstSelect" runat="server" CssClass="fonthead" Width="250px" Height="550px" SelectionMode="Multiple"
							BorderStyle="Outset"></asp:listbox></TD>
					<TD class="fonthead" align="center">(+/-)<br>
						<br>
						<asp:imagebutton id="btnaddall" runat="server"></asp:imagebutton><BR>
						<asp:imagebutton id="btnadditem" runat="server"></asp:imagebutton><BR>
						<asp:imagebutton id="btnremoveitem" runat="server"></asp:imagebutton><BR>
						<asp:imagebutton id="btnremoveall" runat="server"></asp:imagebutton><BR>
					</TD>
					<TD align="center"><asp:listbox id="lstSelected" CssClass="fonthead" Width="250px" Height="550px" SelectionMode="Multiple"
							Runat="server"></asp:listbox></TD>

				    <td class="fonthead" align="center"></br>
				        </br>
				        <asp:imagebutton id="btnColmoveup" Runat="server"></asp:imagebutton></br>
						<asp:imagebutton id="btnColmovedwn" Runat="server"></asp:imagebutton>
					</td>
							
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
