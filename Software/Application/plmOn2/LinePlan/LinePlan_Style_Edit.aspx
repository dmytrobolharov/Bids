<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinePlan_Style_Edit.aspx.vb" Inherits="plmOnApp.LinePlan_Style_Edit" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />    
	<script language="javascript" src="../System/Jscript/System.js"></script>
	<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	    
</head>
<body>
    <form id="form1" runat="server">
    
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD><cc1:confirmedimagebutton 
					    id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton></TD>
				</TR>
			</TABLE>
			<asp:placeholder id="phStyleHeader" runat="server"></asp:placeholder>
			
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
			<tr valign="top">
			    <td>
			        <TABLE class="TableHeaderOver" cellSpacing="0" cellPadding="0" width="100%" border="0">
					    <TR vAlign="middle">
					        <TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
						    <TD><asp:Label ID="lblStyle" runat="server" Text="Style Image"></asp:Label></TD>
					    </TR>
					    <tr align="center"><td colspan ="2">
					        <br />
					        <cc1:bwimagebutton id="imgDesign" runat="server"></cc1:bwimagebutton>    
					    </td></tr>
					</TABLE>
					<br/>
					
					
			    </td>
					<td vAlign="top">
						<TABLE class="TableHeaderOver" id="Table2" height="24" cellSpacing="0" cellPadding="0"
							width="100%" border="0" runat="server">
							<TR vAlign="middle">
								<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<TD><asp:Label ID="lblLine" runat="server" Text="Line Item Property"></asp:Label></TD>
							</TR>
						</TABLE>
						<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder>
				</td>
			</tr>
			</table>
			    
    
    </form>
</body>
</html>
