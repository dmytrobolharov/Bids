<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Material_AGVendor_Add.aspx.vb" Inherits="plmOnApp.Material_AGVendor_Add" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    
	    <table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
		    runat="server">
		    <tr vAlign="middle">
			    <td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
			    <td><cc1:confirmedimagebutton 
			        id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
			        id="btnClose" runat="server" Message="NONE" CausesValidation="False" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton>
			    </td>
		    </tr>
	    </table>
		<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
			height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
			<tr>
				<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" 
                    Font-Size="X-Large" ForeColor="#999999">Header</asp:label></td>
			</tr>
		</table>
		
        <table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
	        <tr>
		        <td><asp:placeholder id="plhSearchControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
		        <td width="100%" valign="top">
			        <table height="45">
				        <tr>
					        <td>
						        <asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
				        </tr>
			        </table>
		        </td>
	        </tr>
        </table> 		
        
		<table width="700" align="left">
		    <tr>
				<td align="center" width="300"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead"><asp:Label ID="lblAvailableAttribute" runat="server"></asp:Label>
							</B></FONT></TD>
				<td width="50"></TD>
				<td align="center" width="300"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead"><asp:Label ID="lblSelectedAttribute" runat="server"></asp:Label>
							</B></FONT>
				</td>
			</tr>
			<tr>
				<td align="center"><asp:listbox id="lstSelect" runat="server" CssClass="fonthead" Width="250px" Height="550px" 
				        SelectionMode="Multiple" DataTextField="VendorName" DataValueField = "TradePartnerVendorID"
						BorderStyle="Outset"></asp:listbox></td>
				<td class="fonthead" align="center">(+/-)<br/>
					<br/>
					<asp:imagebutton id="btnaddall" runat="server"></asp:imagebutton><br/>
					<asp:imagebutton id="btnadditem" runat="server"></asp:imagebutton><br/>
					<asp:imagebutton id="btnremoveitem" runat="server"></asp:imagebutton><br/>
					<asp:imagebutton id="btnremoveall" runat="server"></asp:imagebutton><br/>
				</td>
				<td align="center"><asp:listbox id="lstSelected" CssClass="fonthead" Width="250px" Height="550px" 
				    SelectionMode="Multiple" DataTextField="VendorName" DataValueField = "TradePartnerVendorID"
						Runat="server"></asp:listbox></td>
			    <td class="fonthead" align="center"></br>
			        </br>
			        <asp:imagebutton id="btnColmoveup" Runat="server"></asp:imagebutton></br>
					<asp:imagebutton id="btnColmovedwn" Runat="server"></asp:imagebutton>
				</td>
			</td>
			</tr>
		</table>	    
		
    </form>
        <script  language="javascript" type="text/javascript">
                    function btnClose_Click() {
                        <%= strExitScript %>
                        return false;
                    }
        </script>
</body>
</html>
