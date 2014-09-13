<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Line_List_FlashEdit_Search.aspx.vb" Inherits="plmOnApp.Line_List_FlashEdit_Search" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Line_List_Header" Src="Line_List_Header.ascx"%>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>
<html>
	<head>
		<title>Flash Edit</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>		
        <style type="text/css">
            .RightAlign 
            {
            	text-align: right;
            }
            .RightAlign input
            {
            	text-align: right;
            }
        </style>
	</head>
	<body>
		<form id="Form1" method="post" runat="server" defaultbutton="imgBtnSearch">
        <wc1:Color_Wait ID="Color_Wait" runat="server" />
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
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
					<td width="300">
					    <asp:imagebutton id="btnInvSearch" runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px" />					
						<cc1:confirmedimagebutton id="btnsave" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
						<cc1:bwimagebutton id="btnDrop" runat="server" ></cc1:bwimagebutton>
                        <cc1:confirmedimagebutton id="btnBatchUpdate" runat="server"  Message="NONE" Visible="False"></cc1:confirmedimagebutton>						
						<cc1:confirmedimagebutton id="btnClose" runat="server" visible="true" Message="NONE"></cc1:confirmedimagebutton>
                    </td>     
					<td>
			            <table width="200" border="0" cellspacing="0" cellpadding="0" >
				            <tr>
				                <td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
					            <td><asp:CheckBox valign="top" align="center" ID="chbBatchUpdate" autopostback="true" runat="server" Text="BatchUpdate" CssClass="fontHead" /></td>
				            </tr>
			            </table>	
					</td>
                    <td></td>
					
				</tr>
			</table>
			<table width="100%"  style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
				<tr>
					<td>&nbsp;<asp:Label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:Label></td>
				</tr>
			</table>
            
            <uc1:Line_List_Header ID="Line_List_Header" runat="server" />
            	
			<table class="TableHeaderBlue" height="25" width="100%" border="0" cellspacing="0" cellpadding="0" >
				<tr valign="middle">
				    <td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
					<td><asp:Label id="LabelSearch" runat="server" Font-Names="Tahoma,Verdana" ></asp:Label></td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder><br /></td>
					<td width="100%" valign="top">
						<table>
							<tr>
								 <td valign="top" width="100%">
                                            <table id="Table3" height="45">
                                                <tr>
                                                    <td>
                                                        <asp:ImageButton ID="imgBtnSearch" runat="server"></asp:ImageButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			
			<table class="TableHeaderYellow" height="25" width="100%" border="0" cellspacing="0" cellpadding="0" >
				<tr valign="middle">
				    <td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
					<td><asp:Label id="LabelEdit" runat="server" Font-Names="Tahoma,Verdana"  ></asp:Label></td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="100%" bgcolor="#EEEB9F" border="0">
				<tr>
					<td><asp:placeholder id="plhEditControlsHolder" runat="server" 
                            EnableViewState="False" ></asp:placeholder></td>					
				</tr>
			</table>
			<asp:PlaceHolder id="phStyle" runat="server" EnableViewState="False"></asp:PlaceHolder>
			<asp:PlaceHolder id="phStyleGrid" runat="server" EnableViewState="False"></asp:PlaceHolder>		
			<input id="hiddenBatchUpdate" type="hidden" value="0" name="hiddenBatchUpdate" runat="server" />&nbsp;&nbsp;	
    </form>

</body>

<script language='javascript'>
    var frm = document.Form1;
    function SelectAll(checkAllBox) {
        var actVar = checkAllBox.checked;
        for (i = 0; i < frm.length; i++) {
            e = frm.elements[i];
            if (e.type == 'checkbox' && e.name.indexOf('chbSelectItem') != -1)
                e.checked = actVar;
        }
    }
    </script>
</html>
