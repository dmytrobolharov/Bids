﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_StyleCategory_Edit.aspx.vb" Inherits="plmOnApp.Control_StyleCategory_Edit" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Control Panel</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <style type="text/css">
    .rightAlign 
    {
    	text-align:right;
    }
    
    </style>
</head>
<body style="background-color: white">
    <form id="form1" runat="server">

    <telerik:RadScriptManager ID="RadScriptManager1" runat="server" >
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js"></asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js"></asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js"></asp:ScriptReference>
        </Scripts>
        <CdnSettings TelerikCdn="Disabled" />
    </telerik:RadScriptManager>
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" Runat="server">
        <StyleSheets>
            <telerik:StyleSheetReference Path="../System/CSS/RadCalendar.YPLM.css" />
            <telerik:StyleSheetReference Path="../System/CSS/RadComboBox.YPLM.css" />
            <telerik:StyleSheetReference Path="../System/CSS/RadGrid.YPLM.css" />
            <telerik:StyleSheetReference Path="../System/CSS/RadInput.YPLM.css" />
        </StyleSheets>
        <CdnSettings TelerikCdn="Disabled" />
    </telerik:RadStyleSheetManager>
    <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1" />

    <div>
        <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                </td>
                <td>
                    <cc1:ConfirmedImageButton ID="btnSaveOnly" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnSaveNew" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnDelete" runat="server"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                </td>
                <td class="FontHead" align="right" width="75">
                </td>
                <td width="40">
                </td>
                <td>
                </td>
            </tr>
        </table>
        <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45"
            cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
            <tr>
            <td width="10">
                    &nbsp;
                </td>
                <td>
                    &nbsp;<asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:Label>
                </td>
            </tr>
        </table>
        <table cellspacing="2" cellpadding="0"  border="0" style="background-color: white">
            <tr>
            <td width="25">
                    &nbsp;
                </td>
                <td>
                    <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
                </td>
            </tr>
        </table>
        <table cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <td valign="top">
                </td>
            </tr>
        </table>
    </div>

              <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
               <tr valign="middle">
                    <td valign="middle" align="center" width="10" height="25">
                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3"><asp:ImageButton ID="ImageButton1"
                            runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px" TabIndex="0" />
                    </td> 
                    <td width="600">
                            <asp:Label ID="lblSubCategory" runat="server" Text=""></asp:Label>
                    </td>
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
				<TD width="50" class="style1"></TD>
			</TR>
        </table>  
    </form>
</body>
</html>