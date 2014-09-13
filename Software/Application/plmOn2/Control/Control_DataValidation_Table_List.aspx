﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_DataValidation_Table_List.aspx.vb" Inherits="plmOnApp.Control_DataValidation_Table_List" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title runat="server" id="PageTitle">Lookup Table</title>
        <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/RadGrid.YPLM.css" type="text/css" rel="stylesheet" />
    </head>
    <body ms_positioning="GridLayout">
        <form id="Form1" method="post" runat="server">
            <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
                border="0" runat="server">
                <tr valign="middle">
                    <td valign="middle" align="center" width="10">
                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
                    </td>
                    <td>
                        <asp:ImageButton ID="btnInvSearch" runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px" />
                        <cc1:ConfirmedImageButton ID="btnNew" runat="server" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_new.gif" Message="NONE"></cc1:ConfirmedImageButton>
                        <cc1:ConfirmedImageButton ID="btnDelete" runat="server" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_delete.gif" Message="NONE"></cc1:ConfirmedImageButton>
                        <cc1:ConfirmedImageButton ID="btnClose" runat="server" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_close.gif" Message="NONE"></cc1:ConfirmedImageButton>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>

            <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
                height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
                <tr>
                    <td>
                        &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large"
                            Font-Names="Tahoma,Verdana"></asp:Label>
                    </td>
                </tr>
            </table>

			<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td vAlign="top" width="100%">
						<table height="45">
							<tr>
								<td><asp:imagebutton id="imgBtnSearch" runat="server" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_search_small.gif"></asp:imagebutton></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>

            <telerik:RadScriptManager ID="RadScriptManager1" runat="server" />
            <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" />

            <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
        </form>
    </body>
</html>
