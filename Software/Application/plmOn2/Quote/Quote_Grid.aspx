<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Quote_Grid.aspx.vb" Inherits="plmOnApp.Quote_Grid" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Quotation</title>
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>

	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server" defaultbutton="imgBtnSearch">
		    <table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0" runat="server">
			    <tr valign="middle">
				    <td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
                    <td><cc1:confirmedimagebutton id="btnSaveSearch" runat="server" Message="NONE" AutoPostBack="TRUE" ></cc1:confirmedimagebutton></td>
			    </tr>
		    </table>
            <table id="tbHeader" runat="server" style="border-left-style: none; background-color: white" height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
                <tr>
                    <td>
                        &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"><%=GetSystemText("Quote Folder") %>...</asp:Label>
                    </td>
                </tr>
            </table>
			<cc2:YSTabView id="YSTabView1" runat="server"></cc2:YSTabView>
			<table cellSpacing="1" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top"><asp:PlaceHolder id="plhControlsHolder" runat="server"></asp:PlaceHolder>						
					</td>
				</tr>
			</table>
						<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
							<tr>
								<td><asp:placeholder id="plhSearchControl" runat="server"></asp:placeholder></td>
								<td width="100%" valign="top">
                                    <table height="45">
							            <tr>
								            <td>
									            <asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
							            </tr>
						            </table>
                                </td>
							</tr>
						</table>

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

                        <asp:PlaceHolder ID="plhRadGridPlaceholder" runat="server"></asp:PlaceHolder>
                        
                        <asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
		</form>
	</body>
</HTML>
