﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_NBOL_Machinery_List.aspx.vb" Inherits="plmOnApp.Control_NBOL_Machinery_List" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Machinery</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
    <meta content="JavaScript" name="vs_defaultClientScript" />
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/jquery.tablescroll.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />

    <script language="javascript" type="text/javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="../System/Jscript/jquery.tablescroll.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="DataHolder1" runat="server">
        <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                </td>
                <td>
                    <asp:ImageButton ID="Imagebutton1" runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px" />
                    <cc1:ConfirmedImageButton ID="btnNew" runat="server" Message="NONE" CausesValidation="False"></cc1:ConfirmedImageButton>
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
        </table>
        <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45"
            cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
            <tr>
                <td>
                    &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:Label>
                </td>
            </tr>
        </table>
        <table cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr valign="top">
                <td>
                    <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff"
                        border="0">
                        <tr valign="middle">
                            <td valign="middle" align="center" width="10">
                                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                            </td>
                            <td width="20">
                                <asp:ImageButton ID="btnImgFirst" runat="server" CausesValidation="false"></asp:ImageButton>
                            </td>
                            <td width="20">
                                <asp:ImageButton ID="btnImgPrevious" runat="server" CausesValidation="false"></asp:ImageButton>
                            </td>
                            <td nowrap align="center" width="125">
                                <asp:Label ID="lblPageCount" runat="server" CssClass="fontHead"></asp:Label>
                            </td>
                            <td width="20">
                                <asp:ImageButton ID="btnImgNext" runat="server" CausesValidation="false"></asp:ImageButton>
                            </td>
                            <td width="20">
                                <asp:ImageButton ID="btnImgLast" runat="server" CausesValidation="false"></asp:ImageButton>
                            </td>
                            <td width="10">
                                &nbsp;
                            </td>
                            <td nowrap>
                                <asp:Label ID="RecordCount" runat="server" CssClass="fontHead"></asp:Label>
                            </td>
                            <td class="fontHead" align="right" width="110">
                                <asp:Label ID="lblRecordsPerPage" runat="server"></asp:Label>
                            </td>
                            <td width="25">
                                <asp:DropDownList ID="ps" runat="server" CssClass="fontHead">
                                    <asp:ListItem Value="5">5</asp:ListItem>
                                    <asp:ListItem Value="10">10</asp:ListItem>
                                    <asp:ListItem Value="15">15</asp:ListItem>
                                    <asp:ListItem Value="20">20</asp:ListItem>
                                    <asp:ListItem Value="25">25</asp:ListItem>
                                    <asp:ListItem Value="30">30</asp:ListItem>
                                    <asp:ListItem Value="40">40</asp:ListItem>
                                    <asp:ListItem Value="50" Selected="True">50</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td width="10">
                                <asp:Button ID="Button1" OnClick="RePage" runat="server" CssClass="fontHead" CausesValidation="False">
                                </asp:Button>
                            </td>
                        </tr>
                    </table>
                    <table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
                        <tr>
                            <td>
                                <asp:PlaceHolder ID="plhSearchControl" runat="server" EnableViewState="False"></asp:PlaceHolder>
                            </td>
                            <td valign="top" width="100%">
                                <table height="45">
                                    <tr>
                                        <td>
                                            <asp:ImageButton ID="imgBtnSearch" runat="server"></asp:ImageButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <asp:DataGrid ID="DataGrid1" runat="server" AllowSorting="True">
                        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                        <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
                        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                        <PagerStyle Visible="False"></PagerStyle>
                    </asp:DataGrid><asp:Label ID="SortOrder" runat="server" Visible="False"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>

        <script type="text/javascript" src="../System/Jscript/jquery.tablescroll.js"></script>
        <script type="text/javascript">

            $.fn.tableScroll.defaults =
            {
                flush: false, // makes the last thead and tbody column flush with the scrollbar
                width: null, // width of the table (head, body and foot), null defaults to the tables natural width
                height: 100, // height of the scrollable area
                containerClass: 'tablescroll' // the plugin wraps the table in a div with this css class
            };

            jQuery(document).ready(function ($) {

                var table = $('#DataGrid1');
                // Creating <thead> element for the first row
                var head = document.createElement("thead");
                var body = table.find("tbody");
                head.appendChild(table[0].rows[0]);
                body.before(head);
                // Adding the scrollbar
                var tableWidth = table.width();
                var tableHeight = $(window).height() - $("#form1").height() + table.height() - $(head).height() - 25;
                table.tableScroll({ height: tableHeight});

            });
        </script>
</html>
