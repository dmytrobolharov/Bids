<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_ConstructionDetail_Edit.aspx.vb" Inherits="plmOnApp.Style.ConstructionDetail.Style_ConstructionDetail_Edit" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow_Edit" Src="Style_Workflow_Edit.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="uc3" TagName="Style_WorkflowItem" Src="Style_WorkFlowItem.ascx" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
	<title>Process Details</title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="Form1" method="post" runat="server">
		<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
			runat="server">
			<tr valign="middle">
				<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>

				<td nowrap="nowrap" width="650">
				<cc1:confirmedimagebutton id="btnProcessDetailGoTo" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
				<cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>&nbsp;
				<cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE"></cc1:confirmedimagebutton>&nbsp;	
                <cc1:BWImageButton ID="btnChangeLog" runat="server" CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:BWImageButton>
				</td>
				<td class="FontHead" align="right" width="75"><!--&nbsp;<%=GetSystemText("Select Set")%>:--></td>
				<td width="40"><!--<asp:dropdownlist id="dpStyleSet" runat="server" CssClass="font" DataTextField="Value" DataValueField="ID"
						AutoPostBack="true"></asp:dropdownlist>--></td>
				<td><!--<asp:imagebutton id="imgBtnGo" runat="server" ImageUrl="../System/Icons/icon_go.gif"></asp:imagebutton>--></td>				
			</tr>
		</table>
		<uc1:style_workflow_edit id="Style_Workflow_Edit1" runat="server"></uc1:style_workflow_edit><asp:panel id="pnlChange" runat="server">
			<uc1:Style_Change_Alert id="Style_Change_Alert1" runat="server"></uc1:Style_Change_Alert>
		</asp:panel><uc2:style_header id="Style_Header1" runat="server">
		</uc2:style_header>
		<table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
			<tr>
				<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
			</tr>
		</table>
		<uc3:Style_WorkflowItem id="Style_WorkflowItem1" runat="server" />
		
    	<table cellspacing="2" cellpadding="0" width="100%" border="0">
			<tr class="fontHead">
				<td><cc1:confirmedimagebutton id="btnUnlink" runat="server" />&nbsp;<cc1:confirmedimagebutton id="btnImageRemove" runat="server"  /></td>
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
        <table cellspacing="2" cellpadding="0" width="100%" border="0">
        <tr>
        <td align="left">
     	    <table cellspacing="2" cellpadding="0" border="0">
			    <tr class="fontHead">
				    <td nowrap="nowrap" width="85">&nbsp;<%=GetSystemText("No. of Row(s)")%>:</td>
				    <td width="35"><asp:dropdownlist id="dpNewRow" runat="server" CssClass="fontHead">
						    <asp:ListItem Value="1" Selected="True">1</asp:ListItem>
						    <asp:ListItem Value="2">2</asp:ListItem>
						    <asp:ListItem Value="3">3</asp:ListItem>
						    <asp:ListItem Value="4">4</asp:ListItem>
						    <asp:ListItem Value="5">5</asp:ListItem>
						    <asp:ListItem Value="10">10</asp:ListItem>
						    <asp:ListItem Value="15">15</asp:ListItem>
						    <asp:ListItem Value="20">20</asp:ListItem>
					    </asp:dropdownlist></td>
				    <td nowrap="nowrap"><cc1:confirmedimagebutton id="btnAdd" runat="server"  Message="NONE" />&nbsp;<cc1:bwimagebutton id="btnLink" runat="server"  />&nbsp;</td>
			    </tr>
		    </table>       
        </td>
        </tr>
        </table>

		<br />
    	<table height="24" cellspacing="0" cellpadding="0" width="100%" border="0">
			<tr valign="middle">
				<td valign="middle" align="center" width="7"><img src="../System/Images/table_bar_left.gif" /></td>
				<td class="TableBar" valign="middle" align="center" width="20"><img src="../System/icons/icon_changeobject.gif"></td>
				<td class="TableBar"><asp:label id="lblCreatedBy" runat="server" CssClass="fontHead" ForeColor="Gray"></asp:label>&nbsp;/
					<asp:label id="lblModifiedBy" runat="server" CssClass="fontHead"></asp:label></td>
				<td valign="middle" align="center" width="7"><img src="../System/Images/table_bar_right.gif" /></td>
			</tr>
		</table>

		<input id="hiddenMethod" type="hidden" value="" runat="server" />
		<input id="hiddenConstructionDetailID" type="hidden" value="" runat="server" />
		<input id="hiddenImageID" type="hidden" value="" runat="server" />
    </form>
	<script type="text/javascript" language="javascript">
	    var frm = document.Form1;
	    function SelectAll(checkAllBox) {
	        var actVar = checkAllBox.checked;
	        for (i = 0; i < frm.length; i++) {
	            e = frm.elements[i];
	            if (e.type == 'checkbox' && e.name.indexOf("chbConstructionDetailID") != -1)
	                e.checked = actVar;
	        }
	    }
	    function RefreshImage() {
	        var theUrl = '<%=m_strReloadPageURL %>';
	        if (theUrl != ''){
	            location.href = theUrl;
	        }
	    }

	    function RelinkItem(ConstructionDetailID, ImageID) {
	        document.getElementById('hiddenMethod').value = 'RelinkItem';
	        document.getElementById('hiddenConstructionDetailID').value = ConstructionDetailID;
	        document.getElementById('hiddenImageID').value = ImageID;
	    }

	    function DeleteImage(ConstructionDetailID, ImageID) {
	        document.getElementById('hiddenMethod').value = 'DeleteImage';
	        document.getElementById('hiddenConstructionDetailID').value = ConstructionDetailID;
	        document.getElementById('hiddenImageID').value = ImageID;
	    }
	</script>    
</body>
</html>