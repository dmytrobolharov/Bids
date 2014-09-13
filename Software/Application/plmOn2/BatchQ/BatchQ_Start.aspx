<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="BatchQ_Start.aspx.vb" Inherits="plmOnApp.BatchQ_Start" %>
<%@ Register assembly="YSWebControls" namespace="Yunique.WebControls" tagprefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
   <title runat="server" id="PageTitle">Batch Queue</title>
   <link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="Form1" method="post" runat="server">
    <div>
			<table width="100%" height="27" border="0" cellpadding="0" cellspacing="0" class="TableHeader">
				<tr>
					<td width="100%">
                        <cc1:ConfirmedImageButton ID="btnNew" runat="server" />
                    </td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="#cddeee">
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table width="100%" height="90%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td valign="top" bgcolor="#ffffff"><table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><div align="right">
										<asp:Label id="lblHeader" runat="server" Font-Size="XX-Large" ForeColor="Silver"></asp:Label></div>
								</td>
							</tr>
						</table>
                        <asp:placeholder id="phNav" runat="server"></asp:placeholder>
						<table width="100%" height="50%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="33%">&nbsp;</td>
								<td width="33%">&nbsp;</td>
								<td width="33%">&nbsp;</td>
							</tr>
						</table>
						<table width="100%" height="100" border="0" cellpadding="0" cellspacing="0" background="../System/Images/MiddleFill.jpg">
							<tr valign="top">
								<td width="33%">&nbsp;</td>
								<td width="33%">&nbsp;</td>
								<td width="33%">&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>    
    </div>
    </form>
</body>
</html>




