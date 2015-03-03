<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_DataDictionary_List.aspx.vb" Inherits="YuniFace.Control_DataDictionary_List" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
    <head>
        <title runat="server" id="PageTitle">Data Dictionary</title>
        <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    </head>
    <body ms_positioning="GridLayout">
        <form id="Form1" method="post" runat="server">
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

            <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
                <tr valign="middle">
                    <td valign="middle" align="center" width="10">
                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
                    </td>
                    <td>
                        <asp:ImageButton ID="btnInvSearch" runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px" />
                        <cc1:ConfirmedImageButton ID="btnNew" runat="server" ImageUrl="" Message="NONE"></cc1:ConfirmedImageButton>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>

            <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
                <tr>
                    <td>
                        &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:Label>
                    </td>
                </tr>
            </table>

			<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td>
					    <asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder>
					</td>
					<td vAlign="top" width="100%">
						<table height="45">
							<tr>
								<td>
								    <asp:imagebutton id="imgBtnSearch" runat="server" ImageUrl=""></asp:imagebutton>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>

            <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
        </form>
    </body>
</html>
