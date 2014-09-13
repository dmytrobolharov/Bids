<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Vendor_FolderPage_Compliance.aspx.vb" Inherits="srmOnApp.Vendor_FolderPage_Compliance" %>
<%@ Register TagPrefix="uc1" TagName="Vendor_Header" Src="Vendor_Folder_Header.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
	<HEAD>
		<title runat="server" id="PageTitle">Compliance</title>
        <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
         <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Grid_Y.css" type="text/css" rel="stylesheet" />
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server" defaultbutton="imgBtnSearch">
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

			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10">
					    <IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3">
					</td>
					<td vAlign="middle">									    
					    <cc1:confirmedimagebutton id="btnNew" Message="NONE" runat="server"  />					    
					    <cc1:confirmedimagebutton id="btnDelete" Visible="false" runat="server"  />
					</td>

					<td valign="middle" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>					
				</tr>
			</table>			
			<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
				<tr>
					<td>
						<table id="Table1" style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
							height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
							<tr>
								<td>&nbsp;
									<asp:label id="lblHeader" runat="server" ForeColor="Silver" 
                                        Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			
			<table cellSpacing="0" cellPadding="0" width="100%" border="0" height="25">
				<tr class="TableHeader">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="20"><asp:imagebutton id="imbBtnExpand" ImageUrl="../System/Icons/icon_Next.gif" runat="server"></asp:imagebutton><asp:imagebutton id="imgBtnCollapse" ImageUrl="../System/Icons/icon_Down.gif" runat="server"></asp:imagebutton></td>
					<td class="fontHead">&nbsp;
						<asp:Label id="lblVendor" runat="server"></asp:Label></td>
				</tr>
			</table>
			<asp:panel id="Panel1" runat="server" BorderWidth="0" CssClass="font" Width="100%" BackColor="#ffffff">
				<table id="Table2" cellSpacing="1" cellPadding="1" width="100%" bgColor="#ffffff" border="0">
					<tr>
						<td width="900">
							<uc1:Vendor_Header id="Vendor_Header1" runat="server"></uc1:Vendor_Header></td>
						<td></td>
					</tr>
				</table>
			    <table style="BORDER-BOTTOM: silver thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
							height="1" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				    <tr>
					    <td></td>
				    </tr>
			    </table>
			    <br />
			</asp:panel>	
			<table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhSearchControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
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
            <asp:PlaceHolder ID="plhData" runat="server"></asp:PlaceHolder>
            <asp:label id="SortOrder" runat="server" Visible="False"></asp:label>                      
		</form>
		<script language="javascript" type="text/javascript"  >
		var frm = document.Form1 ;
		function SelectAll(checkAllBox) {
		    var actVar = checkAllBox.checked ;
		    for(i=0;i< frm.length;i++) {
			    e=frm.elements[i];
			    if (e.type == 'checkbox' && e.name.indexOf("chkSelected") != -1)
			        e.checked= actVar ;
		    }
		}
		</script>
	</body>
</html>
