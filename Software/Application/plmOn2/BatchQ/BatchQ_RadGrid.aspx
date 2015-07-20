<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="BatchQ_RadGrid.aspx.vb" Inherits="plmOnApp.BatchQ_RadGrid" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/tr/xhtml11/DTD/xhtml11.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head id="Head1" runat="server">
        <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
    </head>

    <body style="margin:0;padding:0">

		<form id="Form1" method="post" runat="server">


			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white" height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
				</tr>
			</table>

			<table cellspacing="0" cellpadding="0" width="800" bgcolor="#ffffff" border="0">
			    <tr>
			        <td>
			        
			            <table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server">
				            <tr vAlign="middle">
					            <TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					            <TD>
						            <asp:imagebutton id="btnInvSearch" runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px" />
						            <cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					            </TD>
					            <td>&nbsp;</td>
				            </tr>
			            </table>



			            <table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
				            <tr>
					            <td><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>
					            <td vAlign="top" width="100%">
						            <table height="45">
							            <tr>
								            <td><asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
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
                        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />
                        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" 
                            DefaultLoadingPanelID="RadAjaxLoadingPanel1">
                        </telerik:RadAjaxManager>

			            <table cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
			                <tr>
			                    <td>&nbsp;</td>
			                </tr>
				            <tr>
					            <td><asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder></td>
				            </tr>
			            </table>			        
			        
			        </td>
			    </tr>
			</table>
            <asp:placeholder id="phNav" runat="server"></asp:placeholder>

            <br />
            
		</form>

    </body>
</html>
