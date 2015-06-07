<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Planning_Folder_Menu.aspx.vb" Inherits="plmOnApp.Planning_Folder_Menu" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title>Production_Menu</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <script src="../System/Jscript/jquery-1.6.2.min.js" type="text/javascript"></script>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td class="fontHead">
						<div align="left">&nbsp;
							<asp:imagebutton id="btnSearch" runat="server" ImageUrl="../System/icons/icon_search.gif"></asp:imagebutton>&nbsp;
							<asp:imagebutton id="btnRefresh" runat="server" ImageUrl="../System/icons/icon_refresh.gif"></asp:imagebutton></div>
					</td>
				</tr>
			</table>
            <asp:Panel ID="pnlSeasonYear"  runat="server" >
                <table class="TableHeaderYellow" cellspacing="0" cellpadding="0" width="100%" height="30"
                    border="0">
                    <tr valign="middle">
                        <td valign="middle" align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/>
                        </td>
                        <td width="20"><img src="../System/Icons/icon_season.gif" /></td>
                        <td width="50" align="left" nowrap="nowrap" style="padding-left:5px;">
                            <asp:Label runat="server" ID="lblSeasonYear" class="fontHead" ><%= GetSystemText("Season")%>:</asp:Label>
                        </td>
                        <td align="left">
                            <asp:DropDownList  ID="ddlStyleSeasonYearID" runat="server" AutoPostBack="false" onchange="SeasonYearChanged(this)"></asp:DropDownList>
                        </td>
                        <td><cc2:BWImageButton id="btnSeasonAdd" runat="server" Visible="true" CausesValidation="false"></cc2:BWImageButton></td>
                    </tr>
                </table>
            </asp:Panel>
			<cc1:YSTreeView id="YSTreeView1" runat="server"></cc1:YSTreeView>
		</form>
        <script type="text/javascript">
            jQuery(document).ready(function ($) {
                var hrefs = document.getElementsByTagName("a");
                for(var i = 0; i < hrefs.length; i++){
                    var ref = hrefs.item(i);
                    if (ref.id.indexOf("nav") != -1){
                        ref.href = ref.href + "&SYID=" + <%= "'" & strSeasonYearID & "'" %>
                        
                    }
                }
            });
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
	</body>
</HTML>
