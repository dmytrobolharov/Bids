<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_WorkFlowItemsEdit.aspx.vb" Inherits="plmOnApp.Style_WorkFlowItemsEdit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow_Edit" Src="Style_Workflow_Edit.ascx" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
	<title>Workflow Items Edit</title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
<body>
<div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="form1" method="post" runat="server">
    <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%" border="0">
	    <tr valign="middle">
		    <td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		    <td valign="middle" align="left" width="706" >
		        <cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
                <cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" CausesValidation="False" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton>
		    </td>
		</tr>
	</table>

        <br />
        <table cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <td>
                &nbsp;
                </td>
                <td>
                    <asp:datagrid id="DataGrid1" runat="server" AllowSorting="False" DataKeyField="WorkFlowItemID">
                        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                        <ItemStyle Height="20px" Wrap="false" CssClass="ItemTemplate"></ItemStyle>
                        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                        <PagerStyle Visible="False"></PagerStyle>
                    <Columns>
                    <asp:TemplateColumn HeaderStyle-BorderWidth="0" ItemStyle-BorderWidth="0" Visible="false">
                        <ItemTemplate>
                            <asp:HiddenField runat="server" ID="hdnWFItemInfo" Value='<%# Eval("WorkFlowItemName") & " (" & Eval("ItemTypeLabel") & ")" %>' />
                        </ItemTemplate>               
                    </asp:TemplateColumn>
                    </Columns>
                    </asp:datagrid>  
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
	
		
    </form>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
