<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Planning_Folder_Material_MaterialReplace.aspx.vb" Inherits="plmOnApp.Planning_Folder_Material_MaterialReplace" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" "http://www.w3.org/TR/REC-html40/loose.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title><%= GetSystemText("Material Replace")%></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/jquery-ui.css" type="text/css" rel="stylesheet"></link>
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
	<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <style type="text/css">
        .material-chip {
            display: block;
            width: 50px;
            height: 50px;
        }
        .material-item {
        	float: left;
        	padding: 2px 10px 2px 2px;
        	border: 1px solid #eee;
        }
        .search-cell .fontHead
        {
            vertical-align: top;
        }
    </style>
</head>
<body>
<div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="form1" runat="server" defaultbutton="imgBtnSearch">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server" EnablePageMethods="true" EnablePartialRendering="true">
            <Scripts>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js"></asp:ScriptReference>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js"></asp:ScriptReference>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js"></asp:ScriptReference>
            </Scripts>
            <CdnSettings TelerikCdn="Disabled" />
        </telerik:RadScriptManager>
        <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server">
            <StyleSheets>
                <telerik:StyleSheetReference Path="../System/CSS/RadCalendar.YPLM.css" />
                <telerik:StyleSheetReference Path="../System/CSS/RadComboBox.YPLM.css" />
                <telerik:StyleSheetReference Path="../System/CSS/RadGrid.YPLM.css" />
                <telerik:StyleSheetReference Path="../System/CSS/RadInput.YPLM.css" />
            </StyleSheets>
            <CdnSettings TelerikCdn="Disabled" />
        </telerik:RadStyleSheetManager>
        <table class="TableHeader" id="Table1" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                </td>
                <td valign="top">
                    <cc1:ConfirmedImageButton id="btnMaterialReplace" runat="server" message="NONE" OnClientClick="return ReplaceButtonClick();"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                </td>
            </tr>
        </table>

		<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
			height="45" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
			<tr>
				<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:label></td>
			</tr>
		</table>
        <table class="TableHeader" style="height: 30px;" id="StyleCountHeader" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                </td>
                <td noWrap><asp:label id="lblStylesCount" runat="server"></asp:label></td> 
            </tr>
        </table>
        <asp:DataList ID="dlMaterials" runat="server" DataKeyField="MaterialID" RepeatLayout="Flow" RepeatDirection="Horizontal" BackColor="White">
            <ItemStyle CssClass="material-item" Height="50px" />
            <ItemTemplate>
                <table cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <label style='<%# String.Format("background-image:url({0})", GetImageStreamPath("50", Eval("MaterialImageVersion").ToString, Eval("MaterialImageID").ToString))%>' class="material-chip">
                            <asp:CheckBox ID="chkSelect" runat="server" /></label>
                        </td>
                        <td style="padding: 2px;"><%# Eval("MaterialNo")%><br /><%# Eval("MaterialName")%></td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:DataList>
		<table cellspacing="0" cellpadding="0" width="100%" border="0">
			<tr valign="top">
				<td>
                <asp:UpdatePanel ID="pnlMaterial" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
					<table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff"
						border="0">
						<tr valign="middle">
							<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
                            <td width="100" runat="server" id="tdThumbnail" visible="true"><asp:CheckBox runat="server" id="chbThumbnail" AutoPostBack="true" /></td>
							<td width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></td>
							<td width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></td>
							<td noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></td>
							<td width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></td>
							<td width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></td>
							<td width="10">&nbsp;</td>
							<td noWrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></td>
							<td class="fontHead" align="right" width="110"><asp:label id="lblRecordsperPage" runat="server">Records per Page:</asp:label></td>
							<td width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
									<asp:ListItem Value="5">5</asp:ListItem>
									<asp:ListItem Value="10">10</asp:ListItem>
									<asp:ListItem Value="15">15</asp:ListItem>
									<asp:ListItem Value="20">20</asp:ListItem>
									<asp:ListItem Value="25">25</asp:ListItem>
									<asp:ListItem Value="30">30</asp:ListItem>
									<asp:ListItem Value="40">40</asp:ListItem>
									<asp:ListItem Value="50" Selected="True">50</asp:ListItem>
								</asp:dropdownlist></td>
							<td width="10"><asp:button id="Button1" onclick="RePage" runat="server" CssClass="fontHead" text="GO"></asp:button></td>
						</tr>
					</table>
					<table height="15" cellspacing="0" cellpadding="0" width="100%" bgColor="white" border="0">
						<tr>
							<td class="search-cell"><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>
							<td vAlign="top" width="100%">
								<table height="45">
									<tr>
										<td><asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
					<asp:datagrid id="DataGrid1" runat="server" AllowSorting="True" AllowPaging="true" DataKeyField="PlanningMaterialID">
						<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
						<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
						<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
						<PagerStyle Visible="False"></PagerStyle>
					</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
                    </ContentTemplate>    
                    </asp:UpdatePanel>
                </td>
			</tr>
		</table>
        <div id="dialog-message" style="display: none;"><p><%= GetSystemText("Please select materials to replace and a replacement material before clicking the replace material button")%></p></div>
        <script type="text/javascript" src="../System/Jscript/jquery-ui-1.10.3.custom.min.js"></script>
        <script type="text/javascript">
            if ($("#dlMaterials [id*='chkSelect']").length == 1)
            {
                $("#dlMaterials [id*='chkSelect']").attr("checked", "checked");
                $("#dlMaterials [id*='chkSelect']").click(function(e) { e.preventDefault(); })
            }

            function ReplaceButtonClick() {
                if ($("#dlMaterials [id*='chkSelect']:checked").length > 0 & $("#DataGrid1 [name*='rdbPlanningMaterialID']:checked").length > 0) {
                    return true;
                }
                else {
                    ShowReplaceMessage();
                    return false;
                }
            }

            function ShowReplaceMessage() {
                $("#dialog-message").dialog({
                    modal: true,
                    resizable: false,
                    buttons: {
                        Ok: function () {
                            $(this).dialog("close");
                        }
                    }
                });
            };

            function RedirectPage(PageName) {
                if (window.opener == null) {
                    window.location.href = PageName;
                    window.top.menu.location.href = window.top.menu.location.href;
                }
                else {
                    window.opener.location.href = PageName;
                    window.opener.top.menu.location.href = window.opener.top.menu.location.href;
                    window.close();
                }
            }
        </script>
    </form>
</body>
</html>
