<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow_Edit" Src="Style_Workflow_Edit.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Colorway_Edit.aspx.vb" Inherits="plmOnApp.Style.Colorway.Style_Colorway_Edit" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
	<head>
		<title>Style</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
         <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
		<script language="javascript">
			function jsColor(sTxtBoxName)
			{
			windowColorPicker = window.open("../System/Control/month_popup.aspx?txtbox=" + sTxtBoxName,"ColorSelect","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=320,height=700,left=10,top=10");
			windowColorPicker.focus();
			}
		</script>
	</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table id="Table1" class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton 
					    id="btnSave" runat="server"  Message="NONE" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_save.gif" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
					    id="btnSummary" runat="server" Message="NONE" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_summary.gif"></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
					    id="btnAutoColor" runat="server"  Message="NONE" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_colorway_auto.gif"></cc1:confirmedimagebutton><cc1:BWImageButton
					    id="btnAddColor" runat="server" Message="NONE" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_LinePlan_Color_Alloc_Add.gif"></cc1:BWImageButton><cc1:BWImageButton
					    id="btnAddMainMaterialColor" runat="server" Message="NONE" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_add_mainmaterial_color.gif"></cc1:BWImageButton><cc1:confirmedimagebutton 
					    id="btnClose" runat="server" Message="NONE"  ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_close.gif" ></cc1:confirmedimagebutton>
					    <cc1:BWImageButton ID="btnChangeLog" runat="server" CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"/></td>
					<td class="FontHead" align="right">&nbsp;</td>
					<td></td>
				</tr>
			</table>
			<uc1:style_workflow_edit id="Style_Workflow_Edit1" runat="server"></uc1:style_workflow_edit><asp:panel id="pnlChange" runat="server">
				<uc1:Style_Change_Alert id="Style_Change_Alert1" runat="server"></uc1:Style_Change_Alert>
			</asp:panel><uc2:style_header id=Style_Header1 runat="server" StyleID='<%Request("SID")%>'>
			</uc2:style_header>
			<table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
				</tr>
			</table>
<%--           <asp:Panel ID="pnlSeasonYear"  runat="server"  >
                <table class="TableHeaderYellow" cellspacing="0" cellpadding="0" width="100%" height="30"
                    border="0">
                    <tr valign="middle">
                        <td valign="middle" align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                        </td>
                        <td width="20"><img src="../System/Icons/icon_season.gif" /></td>
                        <td width="125" align="right" nowrap="nowrap">
                            <asp:Label runat="server" ID="Label1" class="fontHead" >Select Season / Year:</asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList  ID="ddlStyleSeasonYearID" runat="server" AutoPostBack="true" ></asp:DropDownList>
                        </td>
                    </tr>
                </table>
           </asp:Panel>--%> 

			<asp:PlaceHolder runat="server" id="phDataGrids" > 
			</asp:PlaceHolder>
			
			<P>&nbsp;</P>
			<table height="24" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server" ID="Table2">
				<tr valign="middle">
					<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_left.gif"></td>
					<td class="TableBar" valign="middle" align="center" width="20"><IMG src="../System/icons/icon_changeobject.gif"></td>
					<td class="TableBar"><asp:label id="lblCreatedBy" runat="server" CssClass="fontHead" ForeColor="Gray"></asp:label>&nbsp;/
						<asp:label id="lblModifiedBy" runat="server" CssClass="fontHead"></asp:label></td>
					<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_right.gif"></td>
				</tr>
			</table>
		</form>
	</body>
</html>
