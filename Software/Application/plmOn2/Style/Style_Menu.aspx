<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Menu.aspx.vb" Inherits="plmOnApp.Style_Menu" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
	 <title runat="server" id="PageTitle"></title>

		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
        <script type="text/javascript" src="../System/Jscript/jquery-1.8.3.min.js"></script>
        <style>
            #imgContainer
            {
                position:relative;
            }
            #imgContainer div 
            {
                position:absolute;
                left:0;
                background-color: White;
            }
        </style>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td valign="middle" align="left">
						<div><asp:imagebutton id="btnHome" runat="server" ImageUrl="../System/icons/icon_home.gif"></asp:imagebutton>
                            &nbsp;
							<cc2:bwimagebutton id="btnSizeVar" runat="server" ImageUrl="../System/icons/icon_add1.gif"></cc2:bwimagebutton>
                            &nbsp;
							<asp:imagebutton id="btnSearch" runat="server" ImageUrl="../System/icons/icon_search.gif"></asp:imagebutton>
                            &nbsp;
							<asp:imagebutton id="btnTask" runat="server" ImageUrl="../System/icons/icon_task.gif"></asp:imagebutton>
                            &nbsp;
							<asp:imagebutton id="btnRefresh" runat="server" ImageUrl="../System/icons/icon_refresh.gif"></asp:imagebutton></div>
					</td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="100%" border="0" bgcolor="#ffffff">
				<tr>
					<td align="center"><asp:Label id="lbDevNo" runat="server" Font-Size="Medium"></asp:Label></td>
				</tr>
			</table>
			<table class="TableHeaderGreen" height="24" cellSpacing="0" cellpadding="0" width="100%"
				border="0">
				<tr>
					<td valign="middle" align="center" width="10"><asp:imagebutton id="btnVariationDown" runat="server" ImageUrl="../System/icons/icon_paneldown.gif"></asp:imagebutton></td>
					<td class="fontHead">
						<div align="left"><asp:label id="lblVariation" runat="server">Variation ?</asp:label></div>
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
                        <td width="75" align="left" nowrap="nowrap" style="padding-left:5px;">
                            <asp:Label runat="server" ID="lblSeasonYear" class="fontHead" >Select Season / Year:</asp:Label>
                        </td>
                        <td align="left">
                            <asp:DropDownList  ID="ddlStyleSeasonYearID" runat="server" AutoPostBack="false" onchange="SeasonYearChanged(this)"></asp:DropDownList>
                             &nbsp;
							<cc2:bwimagebutton id="btnSeason" runat="server" ImageUrl="../System/icons/icon_add.gif"></cc2:bwimagebutton>
                        </td>
                    </tr>
                </table>
            </asp:Panel>

			<cc1:ystreeview id="YSTreeView2" runat="server"></cc1:ystreeview><br>
			<table cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td align="center">
                        <div id="imgContainer" align="center">
                            <div id="imgDesignBackContainer">
                                <cc2:bwimagebutton id="imgDesignBack" runat="server"></cc2:bwimagebutton>
                            </div>
                            <div id="imgDesignContainer">
                                <cc2:bwimagebutton id="imgDesign" runat="server"></cc2:bwimagebutton>
                            </div>
                        </div>
                    </td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td align="center"><asp:label id="lblStyleNo" runat="server" CssClass="fonthead"></asp:label></td>
				</tr>
				<tr>
					<td align="center"><asp:label id="lblStyleDescription" runat="server" CssClass="fonthead"></asp:label></td>
				</tr>
				<tr>
					<td></td>
				</tr>
			</table>
			<asp:literal id="ltVariation" runat="server"></asp:literal>
			<br>
			<asp:Panel ID="pnlTechpack" Runat ="server" > 
				<table class="TableHeaderOver" id="tbTechPack" height="24" cellSpacing="0" cellpadding="0"
					width="100%" border="0" runat="server">
					<tr>
						<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td class="fontHead">
							<DIV align="center">
                                <asp:Label ID="lblTechPackH" runat="server" ></asp:Label></DIV>
						</td>
					</tr>
				</table>
				<cc1:ystreeview id="Ystreeview5" runat="server"></cc1:ystreeview>
				<br>
			</asp:Panel>
			
			<table class="TableHeaderOver" height="24" cellSpacing="0" cellpadding="0" width="100%"
				border="0" id="tblQuotationH" runat="server">
				<tr>
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td class="fontHead">
						<DIV align="center">
                            <asp:Label ID="lblQuotationH" runat="server" ></asp:Label></DIV>
					</td>
				</tr>
			</table>
			<cc1:ystreeview id="YSTreeView3" runat="server"></cc1:ystreeview>
			<BR>
			<table class="TableHeaderOver" id="tblSampleHeader" runat="server" height="24" cellSpacing="0" cellpadding="0"
				width="100%" border="0">
				<tr>
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td class="fontHead">
						<DIV align="center">
                            <asp:Label ID="lblSampleH" runat="server" ></asp:Label></DIV>
					</td>
				</tr>
			</table>
			<cc1:ystreeview id="Ystreeview4" runat="server"></cc1:ystreeview><br>
            <table class="TableHeaderOver" id="tblSourcingHeader" runat="server" height="24" cellSpacing="0" cellpadding="0"
				width="100%" border="0">
				<tr>
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td class="fontHead">
						<DIV align="center">
                            <asp:Label ID="lblSourcingH" runat="server" ></asp:Label></DIV>
					</td>
				</tr>
			</table>
			<cc1:ystreeview id="YSTreeViewSourcing" runat="server"></cc1:ystreeview><br>
            <table class="TableHeaderOver" id="Table2" height="24" cellSpacing="0" cellpadding="0"
				width="100%" border="0">
				<tr>
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td class="fontHead">
						<DIV align="center">
                            <asp:Label ID="lblLineListH" runat="server" ></asp:Label></DIV>
					</td>
				</tr>
			</table>
            <cc1:ystreeview id="YSTreeViewLine" runat="server"></cc1:ystreeview><br>
			<br>
           <table class="TableHeaderOver" id="Table1" height="24" cellSpacing="0" cellpadding="0"
				width="100%" border="0">
				<tr>
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td class="fontHead">
						<DIV align="center">
                            <asp:Label ID="lblPlanningH" runat="server" ></asp:Label></DIV>
					</td>
				</tr>
			</table>
            <cc1:ystreeview id="YSTreePlanning" runat="server"></cc1:ystreeview><br>
			<br>
		</form>

        <script type="text/javascript">
            var hasDesignBack = false;

            $(window).load(function () {
                hasDesignBack = $("#imgDesignBack").attr("src").indexOf("00000000-0000-0000-0000-000000000000") == -1;

                var height = 0;
                var width = 0;

                if (hasDesignBack) {
                    height = ($("#imgDesign").height() > $("#imgDesignBack").height() ? $("#imgDesign").height() : $("#imgDesignBack").height());
                    width = ($("#imgDesign").width() > $("#imgDesignBack").width() ? $("#imgDesign").width() : $("#imgDesignBack").width());
                }
                else {
                    height = $("#imgDesign").height();
                    width = $("#imgDesign").width();
                    $("#imgDesignBack").css("display", "none");
                }

                $("#imgContainer").css({
                    "width": width,
                    "height": height
                });

                $("#imgDesignContainer").css({
                    "width": width,
                    "height": height
                });

                $("#imgDesignBackContainer").css({
                    "width": width,
                    "height": height
                });
            });

            var intervalHandler;

            $("#imgContainer")
            .mouseover(function () {
                if (hasDesignBack){
                    $("#imgDesignContainer").fadeOut();
                    clearInterval(intervalHandler)
                    intervalHandler = setInterval(function () {
                        $("#imgDesignContainer").fadeToggle()
                    }, 1200)
                }
            })
            .mouseleave(function () {
                if (hasDesignBack){
                    clearInterval(intervalHandler)
                    $("#imgDesignContainer").fadeIn();
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
</html>
