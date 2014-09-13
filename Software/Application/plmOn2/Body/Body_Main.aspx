<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Body_Main.aspx.vb" Inherits="plmOnApp.Body_Main" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Body</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />		
</head>
<body>
    <form id="form1" runat="server">

			<table class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<td width="100%">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>

			<table height="10" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="XX-Large" Font-Names="Tahoma,Verdana">Body Folder...</asp:label></td>
				</tr>
			</table>			
            <br/>
            <br/>
            
            <table width="50" cellSpacing="0" cellPadding="0" border="0">
            <tr><td>
                <TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
	                <TR height="100">
		                <TD class="font" >
			                <DIV align="center"><asp:Image id="imgDesign" runat="server" ImageAlign="Middle"></asp:Image></DIV>
		                </TD>
	                </TR>
	                <TR>
		                <TD class="font">
			                <DIV align="center">
				                <asp:Label id="lbBodyName" runat="server"></asp:Label></DIV>
		                </TD>
	                </TR>
                </TABLE>

                <asp:datalist id="DataList1" BorderColor="Silver" BorderWidth="0px" EnableViewState="True" RepeatDirection="Vertical"
	                runat="server" Width="100%">
	                <ItemTemplate>
		                <TABLE id="TABLE1" class="TableHeaderBlue" height="25" cellSpacing="0" cellPadding="0" width="100%"
			                border="0" runat="server">
			                <TR vAlign="middle">
				                <TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
				                <TD>
					                <asp:Label id="lblSizeClass" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "SizeClass") %>'>
					                </asp:Label></TD>
			                </TR>
		                </TABLE>
	                </ItemTemplate>
                </asp:datalist>
            </td></tr>
            </table>    
    </form>
</body>
</html>
