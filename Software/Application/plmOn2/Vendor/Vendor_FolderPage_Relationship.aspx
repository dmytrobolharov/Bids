<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Vendor_FolderPage_Relationship.aspx.vb" Inherits="plmOnApp.Vendor_FolderPage_Relationship" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="PartnerAccessType" src="Vendor_FolderPage_PartnerAccessType.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Relationship</title> 
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/GoogleMap.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>
    <script type="text/javascript" src="../System/Jscript/GoogleMap.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
            </td>
            <td width="200">
                <cc1:BWImageButton id="btnAdd" runat="server"  Message="NONE"></cc1:BWImageButton>
                <cc1:BWImageButton id="btnRemove" runat="server"  Message="NONE"></cc1:BWImageButton>
                <%--<cc1:bwimagebutton id="btnImageRemove" runat="server" ></cc1:bwimagebutton>--%>          
            </td>
            <td><uc1:PartnerAccessType runat="server" id="ctrlPartnerAccessType" /></td>
            <td width="75">
            </td>
            <td width="40">
            </td>
            <td>
            </td>
        </tr>        
    </table>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="30"
        cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td valign="middle">
                <asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:Label>&nbsp;
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

        <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>

        <br />

    
 <%--<img name="imgMap" id="imgMap"  border="0" src="../System/Icons/icon_tranparent_46.gif" alt="" />--%>
 <%--<div id="divGoogleMap" style="width: 600px; height:512px; display:none;"></div>--%>
        
        
<%--	        <asp:datagrid id="DataGrid1" runat="server" AllowSorting="False" DataKeyField="TradePartnerRelationshipID">
		        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
		        <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
		        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
		        <PagerStyle Visible="False"></PagerStyle>
	        </asp:datagrid>   --%>

    </form>
	
		
</body>
</html>
