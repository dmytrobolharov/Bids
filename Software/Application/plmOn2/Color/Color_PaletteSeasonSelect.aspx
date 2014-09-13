<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Color_PaletteSeasonSelect.aspx.vb" Inherits="plmOnApp.Color_PaletteSeasonSelect" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title runat="server" id="PageTitle">Select Season</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
	        height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
	        <tr>
		        <td width="25" height="50">&nbsp;</td>
		        <td>
                    <table cellSpacing="0" cellPadding="0" width="100%" border="0">
	                    <tr>
		                    <td width="25" height="50">&nbsp;<img src="../System/icons/icon_season.gif" /></td>
		                    <td><span class="fontHead">&nbsp;<asp:Label ID="lblHeader" runat="server" Text="Please Select Season & Year..."></asp:Label></span></td>
	                    </tr>
                    </table>
		        </td>
	        </tr>
        </table>
        <table cellSpacing="0" cellPadding="0" width="100%" border="0">
	        <tr>
		        <td>
			        <table cellSpacing="0" cellPadding="0" width="100%" align="center" bgColor="#ffffff" border="0">
				        <tr>
					        <td width="50" height="25">&nbsp;</td>
					        <td align="center" width="200"><span class="fontHead"><asp:Label ID="lblSeasonAvailable" runat="server" Text="Season Available"></asp:Label></span></td>
					        <td width="50"></td>
					        <td align="center" width="200"><span class="fontHead"><asp:Label ID="lblSeasonSelected" runat="server" Text="Season Selected"></asp:Label></span>
					        </td>
					        <td>&nbsp;</td>
					        <td>&nbsp;</td>
				        </tr> 
				        <tr>
					        <td>&nbsp;</td>
					        <td align="center" width="200"><asp:listbox id="lstSelect" BorderStyle="Outset" SelectionMode="Multiple" Height="250px" Width="250px"
							        CssClass="font" runat="server"></asp:listbox></td>
					        <td align="center" width="50"><asp:imagebutton id="btnaddall" runat="server"></asp:imagebutton><BR>
						        <asp:imagebutton id="btnadditem" runat="server" ></asp:imagebutton><BR>
						        <asp:imagebutton id="btnremoveitem" runat="server" ></asp:imagebutton><BR>
						        <asp:imagebutton id="btnremoveall" runat="server" ></asp:imagebutton><BR>
					        </td>
					        <td align="center" width="200"><asp:listbox id="lstSelected" SelectionMode="Multiple" Height="250px" Width="250px" CssClass="font"
							        Runat="server"></asp:listbox></td>
					        <td align="center" width="50"><asp:imagebutton id="btnColmoveup"  Runat="server"></asp:imagebutton><BR>
						        <asp:imagebutton id="btnColmovedwn" Runat="server"></asp:imagebutton></td>
					        <td>&nbsp;</td>
				        </tr>
			        </table>
		        </td>
	        </tr>
        </table>
        <table style="BORDER-TOP: gray thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: gainsboro" height="40" cellSpacing="0" cellPadding="0" width="100%" bgColor="gainsboro" border="0">
	        <tr>
		        <td align="center" width="50">&nbsp;</td>
		        <td align="center" width="500">
			        <asp:imagebutton id="btnSave" runat="server" ></asp:imagebutton>
			        <asp:imagebutton id="btnClose" runat="server" ></asp:imagebutton>
		        </td>
		        <td align="center">&nbsp;</td>
	        </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
