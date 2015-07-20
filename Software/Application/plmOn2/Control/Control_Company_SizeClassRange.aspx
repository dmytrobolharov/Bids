<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_Company_SizeClassRange.aspx.vb" Inherits="plmOnApp.Control_Company_SizeClassRange" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Size Class Library</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
    <style type="text/css">
        .style1
        {
            height: 34px;
        }
        .style2
        {
            height: 27px;
        }
    </style>
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
                    ForeColor="#E0E0E0">Size Class Library</asp:Label>
            </td>
        </tr>
    </table>
     <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <TD width="200" class="style2"><asp:dropdownlist id="dpSizeClass" runat="server"
                        CssClass="fontHead" Width="250px" 
                        OnSelectedIndexChanged="dpSizeClass_SelectedIndexChanged" AutoPostBack="True"></asp:dropdownlist></TD>			
			</tr>
			
			<TR>
				<TD align="center" width="40%" class="style1"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead"><asp:Label ID="lblAvailable" runat="server"></asp:Label></B></FONT></TD>
				<TD width="10%" class="style1"></TD>
				<TD align="center" width="40%" class="style1"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead"><asp:Label ID="lblSelected" runat="server"></asp:Label></B></FONT></TD>
				<TD width="30%" class="style1"></TD>
			</TR>
			<br>
			<TR>
				<TD align="center" width="40%"><asp:listbox id="lstSelect" runat="server" 
                        CssClass="fonthead" Width="250px" Height="350px" SelectionMode="Multiple"
						BorderStyle="Outset"></asp:listbox></TD>
				<TD class="fonthead" align="center" width="10%">(+/-)<br>
					<br>
					<asp:imagebutton id="btnaddall" runat="server" ></asp:imagebutton><BR>
					<asp:imagebutton id="btnadditem" runat="server" ></asp:imagebutton><BR>
					<asp:imagebutton id="btnremoveitem" runat="server"></asp:imagebutton><BR>
					<asp:imagebutton id="btnremoveall" runat="server" ></asp:imagebutton><BR>
				</TD>
				<TD align="center" width="40%"><asp:listbox id="lstSelected" CssClass="fonthead" 
                        Width="250px" Height="350px" SelectionMode="Multiple"
						Runat="server"></asp:listbox></TD>
				<TD width="30%" class="style1"></TD>
			</TR>
        </table>  
    
    </form>

</body>
</html>
