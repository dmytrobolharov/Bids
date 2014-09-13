<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Menu.aspx.vb" Inherits="srmOnApp.Style_Menu" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
    <head>
        <title runat="server" id="PageTitle">Style_Menu</title>
        <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
        <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
        <meta content="JavaScript" name="vs_defaultClientScript" />
        <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
        <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    </head>
    <body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td class="fontHead">
						<div align="left">&nbsp;
							<asp:Label id="lblStyleHeader" runat="server">Label</asp:Label></div>
					</td>
				</tr>
			</table>
            <asp:Panel ID="pnlSeasonYear" runat="server">
                <table class="TableHeaderYellow" cellspacing="0" cellpadding="0" width="100%" height="30" border="0">
                    <tr valign="middle">
                        <td valign="middle" align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                        </td>
                        <td width="20">
                            <img src="../System/Icons/icon_season.gif" alt="" />
                        </td>
                        <td width="75" align="left" nowrap="nowrap" style="padding-left: 5px;">
                            <asp:Label runat="server" ID="lblSeasonYear" class="fontHead">Select Season / Year:</asp:Label>
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddlStyleSeasonYearID" runat="server" AutoPostBack="false" onchange="SeasonYearChanged(this)">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
			<cc1:ystreeview id="YSTreeView2" runat="server"></cc1:ystreeview><br>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td align="center"><cc2:bwimagebutton id="imgDesign" runat="server"></cc2:bwimagebutton></td>
				</tr>
			</table>
            <table cellspacing="0" cellpadding="0" width="100%" border="0">
                <tr>
                    <td align="center">
                        <asp:Label ID="lblStyleNo" runat="server" CssClass="fonthead"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:Label ID="lblStyleDescription" runat="server" CssClass="fonthead"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                </tr>
            </table>

            <script type="text/javascript">
                function SeasonYearChanged(ddl) {
                    var strSeasonYear = document.getElementById(ddl.id).value;
                    var pos;

                    // update menu frame
                    var loc_menu = document.location.href;
                    pos = loc_menu.indexOf('SYID');
                    if (pos != -1) {
                        loc_menu = loc_menu.replace(loc_menu.substr(pos, 41), 'SYID=' + strSeasonYear);
                        document.location.href = loc_menu;
                    }
                    else {
                        document.location.href = document.location.href + '&SYID=' + strSeasonYear;
                    }

                    //update main frame
                    var loc_main = window.parent.main.location.href;
                    pos = loc_main.indexOf('SYID');
                    if (pos != -1) {
                        loc_main = loc_main.replace(loc_main.substr(pos, 41), 'SYID=' + strSeasonYear);
                        window.parent.main.location.href = loc_main;
                    }
                    else {
                        window.parent.main.location.href = window.parent.main.location.href + '&SYID=' + strSeasonYear;
                    }
                }

            </script>

		</form>
	</body>
</html>
