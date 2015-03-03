<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_Workflow_Sample_Add.aspx.vb" Inherits="plmOnApp.Control_Workflow_Sample_Add" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Add</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>
					<cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE" CausesValidation="False"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" CausesValidation="False" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton>
					</td>
					<td class="FontHead" align="right" width="75"></td>
					<td width="40"></td>
					<td></td>
				</tr>
			</table>
			<br>
			<br>
			<TABLE width="100%" align="center">
				<!--TR>
					<TD align="center" width="40%"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><asp:label id="Label1" runat="server" CssClass="fontHead">Filter by name:</asp:label><asp:textbox id="txtFilter" onkeyup="doFilter(this);" Runat="server"></asp:textbox></FONT></TD>
					<TD width="10%"></TD>
					<TD width="40%">&nbsp;</TD>
				</TR-->
				<TR>
					<TD align="center" width="40%"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead"> <asp:Label ID="lblAvailable" runat="server"></asp:Label>
							</B></FONT>
					</TD>
					<TD width="10%"></TD>
					<TD align="center" width="40%"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead"><asp:Label ID="lblSelected" runat="server" ></asp:Label>
							</B></FONT>
					</TD>
                    <TD width="10%"></TD>
				</TR>
				<TR>
					<TD align="center" width="40%"><asp:listbox id="lstSelect" runat="server" CssClass="fonthead" Width="250px" Height="250px" SelectionMode="Multiple"
							BorderStyle="Outset"></asp:listbox></TD>
					<TD class="fonthead" align="center" width="10%">(+/-)<br>
						<br>
						<asp:imagebutton id="btnaddall" runat="server" ></asp:imagebutton><BR>
						<asp:imagebutton id="btnadditem" runat="server" ></asp:imagebutton><BR>
						<asp:imagebutton id="btnremoveitem" runat="server"></asp:imagebutton><BR>
						<asp:imagebutton id="btnremoveall" runat="server"></asp:imagebutton><BR>
					</TD>
					<TD align="center" width="40%"><asp:listbox id="lstSelected" CssClass="fonthead" Width="250px" Height="250px" SelectionMode="Multiple"
							Runat="server"></asp:listbox></TD>
                    <TD align="center" width="10%" class="fonthead">
                        <asp:Label ID="lblSortHeader" runat="server"></asp:Label><br />
						<br/>
						<asp:imagebutton id="btnColmoveup" Runat="server"  /><BR>
						<asp:imagebutton id="btnColmovedwn" Runat="server" />
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
