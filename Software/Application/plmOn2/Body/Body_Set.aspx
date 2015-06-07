<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Body_Set.aspx.vb" Inherits="plmOnApp.Body_Set" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Body Set</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server">

			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD><cc1:confirmedimagebutton id="btnSaveSet" runat="server" Message="NONE"	></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></TD>
				</TR>
			</TABLE>
			<TABLE height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<TR>
					<TD>&nbsp;</TD>
					<TD>&nbsp;</TD>
				</TR>
			</TABLE>
			<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0" bgColor="#ffffff">
				<TR>
					<TD>
						<DIV align="left"><asp:label id="lblBodyHeaderNew" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
								ForeColor="#E0E0E0">Edit Body Set...</asp:label></DIV>
					</TD>
				</TR>
			</TABLE>
			<br>
			<table cellSpacing="1" cellPadding="1" width="100%" border="0">
				<tr>
					<td width="50">&nbsp;</td>
					<td width="75"><asp:label id="Set1" runat="server" CssClass="fontHead"></asp:label></td>
					<td>&nbsp;
						<asp:textbox id="txtSet1" runat="server" CssClass="fontHead"></asp:textbox></td>
				</tr>
				<tr>
					<td width="50">&nbsp;</td>
					<td width="75"><asp:label id="Set2" runat="server" CssClass="fontHead"></asp:label></td>
					<td>&nbsp;
						<asp:textbox id="txtSet2" runat="server" CssClass="fontHead"></asp:textbox></td>
				</tr>
				<tr>
					<td width="50">&nbsp;</td>
					<td width="75"><asp:label id="Set3" runat="server" CssClass="fontHead"></asp:label></td>
					<td>&nbsp;
						<asp:textbox id="txtSet3" runat="server" CssClass="fontHead"></asp:textbox></td>
				</tr>
				<tr>
					<td width="50">&nbsp;</td>
					<td width="75"><asp:label id="Set4" runat="server" CssClass="fontHead"></asp:label></td>
					<td>&nbsp;
						<asp:textbox id="txtSet4" runat="server" CssClass="fontHead"></asp:textbox></td>
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
