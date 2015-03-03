<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Planning_Folder_FinancialPlan_SelectSeason.aspx.vb" Inherits="plmOnApp.Planning_Folder_FinancialPlan_SelectSeason" %>

<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Select Season</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
	        height="45" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
	        <tr>
		        <td width="25" height="50">&nbsp;</td>
		        <td>
                    <table cellspacing="0" cellpadding="0" width="100%" border="0">
	                    <tr>
		                    <td width="25" height="50">&nbsp;<img src="../System/icons/icon_season.gif" /></td>
		                    <td><asp:label id="lblHeader" runat="server" CssClass="fontHead">&nbsp;Please Select Season & Year...</asp:label></td>
	                    </tr>
                    </table>
		        </td>
	        </tr>
        </table>
        <table cellspacing="0" cellpadding="0" width="100%" border="0">
	        <tr>
		        <td>
			        <table cellspacing="0" cellpadding="0" width="100%" align="center" bgColor="#ffffff" border="0">
				        <tr>
					        <td width="50" height="25">&nbsp;</td>
					        <td align="center" width="200"><asp:label id="lblAvailSeason" runat="server" CssClass="fontHead" Text="Season Available"></asp:label></td>
					        <td width="50"></td>
					        <td align="center" width="200"><asp:label id="lblSelSeason" runat="server" CssClass="fontHead" Text="Season Selected"></asp:label></td>
					        <td>&nbsp;</td>
					        <td>&nbsp;</td>
				        </tr> 
				        <tr>
					        <td>&nbsp;</td>
					        <td align="center" width="200"><asp:listbox id="lstSelect" BorderStyle="Outset" SelectionMode="Multiple" Height="250px" Width="250px"
							        CssClass="font" runat="server"></asp:listbox></td>
					        <td align="center" width="50"><asp:imagebutton id="btnaddall" runat="server" ></asp:imagebutton><BR>
						        <asp:imagebutton id="btnadditem" runat="server" ></asp:imagebutton><BR>
						        <asp:imagebutton id="btnremoveitem" runat="server" ></asp:imagebutton><BR>
						        <asp:imagebutton id="btnremoveall" runat="server" ></asp:imagebutton><BR>
					        </td>
					        <td align="center" width="200"><asp:listbox id="lstSelected" SelectionMode="Multiple" Height="250px" Width="250px" CssClass="font"
							        Runat="server"></asp:listbox></td>
					        <td align="center" width="50"><asp:imagebutton id="btnColmoveup"  Runat="server"></asp:imagebutton><BR>
						        <asp:imagebutton id="btnColmovedwn"  Runat="server"></asp:imagebutton></td>
					        <td>&nbsp;</td>
				        </tr>
			        </table>
		        </td>
	        </tr>
        </table>
        <table style="BORDER-TOP: gray thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: gainsboro" height="40" cellspacing="0" cellpadding="0" width="100%" bgColor="gainsboro" border="0">
	        <tr>
		        <td align="center" width="50">&nbsp;</td>
		        <td align="center" width="500">
			        <asp:imagebutton id="btnSave" runat="server" ></asp:imagebutton>
			        <asp:imagebutton id="btnClose" runat="server" OnClientClick="return btnClose_Click()" ></asp:imagebutton>
		        </td>
		        <td align="center">&nbsp;</td>
	        </tr>
        </table>
    
    </div>
    </form>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
