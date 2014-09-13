<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_PanelType.aspx.vb" Inherits="plmOnApp.Control_PanelType" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Control Panel</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
</head>
<body>
   <form id="Form1" method="post" runat="server" onkeypress="if(event.keyCode==13) {document.getElementById('btnImgSearch').click(); return false}">
   <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3"><asp:ImageButton ID="btnInvSearch"
                    runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px" TabIndex="0" />
            </td>  
            <td><cc1:ConfirmedImageButton ID="btmSave" runat="server" 
                    Message="NONE" CausesValidation="False"></cc1:ConfirmedImageButton>                
            </td>         
            <td class="FontHead" align="right" width="75"></td>
            <td width="40"></td>
            <td></td>
        </tr>
    </table>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
        height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td valign="middle">
                &nbsp;<asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
                    ForeColor="Silver"></asp:Label>
            </td>
        </tr>
    </table>
    
    
    
          <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
               <tr valign="middle">
                    <td valign="middle" align="center" width="10" height="25">
                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3"><asp:ImageButton ID="ImageButton1"
                            runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px" TabIndex="0" />
                    </td> 
                    <td width="600">
                            <asp:Label ID="lblControlPanelType" runat="server" Text=""></asp:Label>
                            <asp:dropdownlist id="ddlControlPanelType" runat="server"
                            CssClass="fontHead" Width="250px" 
                            OnSelectedIndexChanged="dpSizeClass_SelectedIndexChanged" 
                            AutoPostBack="True"></asp:dropdownlist></td>
                    <td></td>         			
			    </tr> 
			    
        </table>
		<table >	
			<TR>
				<TD align="center" width="300"><asp:Label ID="lblAvailable" runat="server" CssClass="fontHead"></asp:Label></TD>
				<TD width="50"></TD>
				<TD align="center" width="300"><asp:Label ID="lblSelected" runat="server" CssClass="fontHead"></asp:Label></TD>
				<TD width="50"></TD>
			</TR>
			<br>
			<TR>
				<TD align="center" width="300"><asp:listbox id="lstSelect" runat="server" 
                        CssClass="fonthead" Width="250px" Height="350px" SelectionMode="Multiple"
						BorderStyle="Outset"></asp:listbox></TD>
				<TD class="fontHead" align="center" width="50">(+/-)<br>
					<br>
					<asp:imagebutton id="btnaddall" runat="server" ></asp:imagebutton><BR>
					<asp:imagebutton id="btnadditem" runat="server" ></asp:imagebutton><BR>
					<asp:imagebutton id="btnremoveitem" runat="server" ></asp:imagebutton><BR>
					<asp:imagebutton id="btnremoveall" runat="server" ></asp:imagebutton><BR>
				</TD>
				<TD align="center" width="300"><asp:listbox id="lstSelected" CssClass="fonthead" 
                        Width="250px" Height="350px" SelectionMode="Multiple"
						Runat="server"></asp:listbox></TD>
				<TD width="50" align="center">
                    <asp:imagebutton id="btnmoveup" runat="server"></asp:imagebutton><br />
                    <asp:imagebutton id="btnmovedown" runat="server"></asp:imagebutton>
                </TD>
			</TR>
        </table>  
    
    </form>

</body>
</html>
