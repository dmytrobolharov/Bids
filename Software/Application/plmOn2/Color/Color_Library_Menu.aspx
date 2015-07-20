<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Color_Library_Menu.aspx.vb" Inherits="plmOnApp.Color_Library_Menu" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
</head>
<body>
    <form id="form1" runat="server">
    <div>
		<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr>
				<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
				<td class="fontHead">
					<div align="center">
						<asp:Label id="lblColor" runat="server">Color</asp:Label></div>
				</td>
			</tr>
		</table>
		<cc1:YSTreeView id="YSTreeView1" runat="server"></cc1:YSTreeView>
		<br />
		<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr>
				<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
				<td class="fontHead">
					<div align="center">
						<asp:Label id="lblColorMatch" runat="server">Color</asp:Label></div>
				</td>
			</tr>
		</table>
		<table height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr class="TableHeader" >
				<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
				<td>&nbsp;<span class="fontHead"><asp:Label id="lblSaturation" runat="server">Saturation:</asp:Label></span>&nbsp;</td>
				<td><asp:dropdownlist EnableViewState="true" id="DropDownList2" runat="server" AutoPostBack="True" Height="18px" Width="75px" >
						<asp:ListItem Value="100%">100%</asp:ListItem>
						<asp:ListItem Value="90%">90%</asp:ListItem>
						<asp:ListItem Value="80%">80%</asp:ListItem>
						<asp:ListItem Value="70%">70%</asp:ListItem>
						<asp:ListItem Value="60%">60%</asp:ListItem>
						<asp:ListItem Value="50%" Selected="True">50%</asp:ListItem>
						<asp:ListItem Value="40%">40%</asp:ListItem>
						<asp:ListItem Value="30%">30%</asp:ListItem>
						<asp:ListItem Value="20%">20%</asp:ListItem>
						<asp:ListItem Value="10%">10%</asp:ListItem>
						<asp:ListItem Value="0%">0%</asp:ListItem>
					</asp:dropdownlist>
					<%--<input id="hiddenVal" type="hidden" value="0" name="hiddenVal" runat="server" />--%>
					</td>
			</tr>
		</table>
		 
		<TABLE id="Table1" borderColor="#000000" cellSpacing="1" cellPadding="1" border="0" runat="server" >
		</TABLE>
    </div>
    <asp:DataList ID="dlPantone" runat="server" RepeatColumns="7" 
        RepeatDirection="Horizontal" RepeatLayout="Table">
        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" 
            Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Left" 
            VerticalAlign="Top" />
        <ItemTemplate>
            <table id="tblPantone" cellpadding="0" cellspacing="0" runat="server" >
                <tr>
                    <td width="24" height="20">
                        <asp:Label ID="lblColorImage" runat="server"></asp:Label></td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList>
    
    
    
    </form>
</body>
</html>
