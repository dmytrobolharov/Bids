<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_WorkFlowItems.aspx.vb" Inherits="plmOnApp.Style_WorkFlowItems" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow_Edit" Src="Style_Workflow_Edit.ascx" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
	<title>Work Flow Items</title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/jquery-ui.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
</head>
<body>
<div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="form1" method="post" runat="server">
    <asp:ScriptManager ID="ScriptManager" runat="server" EnablePageMethods="true" />
    <table class="TableHeader" height="27" cellSpacing="0" cellpadding="0" width="100%" border="0">
	    <tr valign="middle">
		    <td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		    <td valign="middle" align="left">
		        <cc1:confirmedimagebutton id="btnEdit" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
		        <cc1:confirmedimagebutton id="btnNewWorkflowItem" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
                <cc1:confirmedimagebutton id="btnLinkWorkflowItem" OnClientClick="return NoMeasLinkPostBack()" runat="server"  Message="NONE" Visible="false"></cc1:confirmedimagebutton>
                <cc1:confirmedimagebutton id="btnUnLinkWorkflowItem" OnClientClick="return MeasUnLinkConfirm();" runat="server"  Message="NONE" Visible="false"></cc1:confirmedimagebutton>
		        <cc1:confirmedimagebutton id="btnNewWorkflowItemExcelImport" runat="server"  Message="NONE" ValidationGroup="false"></cc1:confirmedimagebutton>
		        <cc1:confirmedimagebutton id="btnPageCopy" OnClientClick="return NoPostBack()" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
		        <cc1:confirmedimagebutton id="btnPageLink" OnClientClick="return NoLinkPostBack()" visible="false" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
		        <cc1:confirmedimagebutton id="btnImageRemove" runat="server"  />
		        <cc1:bwimagebutton id="btnImageSort" runat="server" ></cc1:bwimagebutton>
		        <cc1:confirmedimagebutton id="btnBreakLink" visible="false" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
                <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>
		    </td>
		</tr>
	</table>
		<br />
		<uc1:Style_Workflow_Edit ID="Style_Workflow1" runat="server"></uc1:Style_Workflow_Edit>
		<uc2:style_header id="Style_Header1" runat="server">
		</uc2:style_header>
        <br />
        <table cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <td>
                &nbsp;
                </td>
                <td>
                    <asp:datagrid id="DataGrid1" runat="server" AllowSorting="False" DataKeyField="WorkFlowItemID">
                        <AlternatingItemStyle Height="20px" Wrap="true" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                        <ItemStyle Height="20px" Wrap="true" CssClass="ItemTemplate"></ItemStyle>
                        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                        <PagerStyle Visible="False"></PagerStyle>
                        <Columns>
                            <asp:TemplateColumn HeaderStyle-BorderWidth="0" ItemStyle-BorderWidth="0">
                                <HeaderTemplate >
                                    <input type="checkbox" onclick="SelectAll(this)" id="chkSelectAll" />
                                </HeaderTemplate> 
                                <ItemStyle Width="20px" CssClass="SelectCheckBox" />
                                <ItemTemplate>
                                    <asp:CheckBox runat="server" ID="chbWorkFlowItemID" />
                                    <asp:HiddenField runat="server" ID="hdnWFItemInfo" Value='<%# Eval("WorkFlowItemName") & " (" & Eval("ItemTypeLabel") & ")" %>' />
                                    <asp:HiddenField runat="server" ID="hdnSourceStyle" Value='<%# Eval("SourceStyle") %>' />
                                </ItemTemplate>                                
                                                       
                            </asp:TemplateColumn>               
                            <asp:TemplateColumn HeaderStyle-BorderWidth="0" ItemStyle-BorderWidth="0" Visible="false">
                                <HeaderTemplate >
                                    <img alt="" src="../System/Icons/icon_link.gif" />
                                </HeaderTemplate> 
                                <ItemStyle Width="20px" />
                                <ItemTemplate>
                                    <img runat="server" alt="" src="../System/Icons/icon_link.gif" ID="imgWorkFlowItemID" Visible="false" />
                                    <img runat="server" alt="" src="../System/Icons/icon_parent_link.gif" ID="imgParentWorkFlowItemID" Visible="false" />
                                </ItemTemplate>                                
                                                       
                            </asp:TemplateColumn>      
                            <asp:TemplateColumn >
                            <HeaderTemplate >
                                <asp:Label runat="server" ID="lblAction" Text="Action" />
                            </HeaderTemplate>                            
                            <ItemStyle Width="75" />
                            <ItemTemplate>

                                <table cellspacing="0" cellpadding="0" width="75" border="0" >
                                    <tr>
                                        <td>
                                            <table cellspacing="0" cellpadding="0" width="25" border="0">
                                                <tr>
                                                    <td>
<%--                                                        <cc1:confirmedimagebutton id="btnView" runat="server" OnCommand="ViewItemPage"  Message="NONE" Visible="true" />
                                                    </td>
                                                    <td>&nbsp;&nbsp;</td>
                                                    <td>
						                                <cc1:confirmedimagebutton id="btnEdit" runat="server" OnCommand="EditItemPage"  Message="NONE" Visible="true" />--%>
						                                <asp:DropDownList ID="dpAction"  OnSelectedIndexChanged="DoAction" runat="server" CssClass="font" DataTextField="Value" DataValueField="ID"  AutoPostBack="true" />
						                            </td>	                                                    
                                                    
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>                  

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
    <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-ui-1.10.3.custom.min.js"></script>
    <script type="text/javascript" language="javascript">
        function SelectAll(checkAllBox) {
            $("input[id$='chbWorkFlowItemID']").each(function () { this.checked = checkAllBox.checked });
	    }
        	    
        function MeasUnLinkConfirm() {
            var strDialog = '';
            var $checkboxList = $("span.is-linked>input[id$='chbWorkFlowItemID']:checked");

            if ($checkboxList.size() == 0) {
                return false;
            }

            $checkboxList.each(function () {
                var $currentRow = $(this).closest("tr");
                var strMeasSource = $currentRow.find("span[id$='lblSourceStyle']").text();
                var strMeasName = $currentRow.find("span[id$='lblWorkFlowItemName']").text();

                strDialog += '<p style="padding: 0 5 0 5;"><table cellspacing="0" cellpadding="0" border="0">' +
                             '   <tr><td width="50px"><%= GetSystemText("Name") %>:</td><td style="white-space:nowrap;">' + strMeasName + '</td></tr>' +
                             '   <tr><td width="50px"><%= GetSystemText("Source") %>:</td><td style="white-space:nowrap;">' + strMeasSource + '</td></tr>' +
                             '</table></p>'
            });

            var $confirmDialog = $("<div></div>");
            $confirmDialog.html('<p> <%= GetSystemText("You are about to break the page link for the following measurement workflow:") %> </p>' +
                                strDialog +
                                '<p> <%= GetSystemText("Are you sure you want to continue?") %> </p>');
            $confirmDialog.dialog({
                autoOpen: false,
                modal: true,
                resizable: false,
                width: 350,
                title: '<%= GetSystemText("Break Page Link") %>',
                buttons: {
                    '<%= GetSystemText("Yes") %>': function () {
                        $(this).dialog("close");
                        <%= ClientScript.GetPostBackEventReference(New PostBackOptions(btnUnLinkWorkflowItem) With {.PerformValidation = False}) %>;
                        return true;
                    },
                    '<%= GetSystemText("No") %>': function () {
                        $(this).dialog("close");
                        return false;
                    }
                }
            });

            $confirmDialog.dialog('open');
            return false;
        }

        function jsMeasWhereUsed(WorkflowItemID, StyleID, StyleSet, ShowParent) {

            PageMethods.MeasWhereUsed(WorkflowItemID, StyleID, StyleSet, ShowParent, function(strHTML){
                
                var $confirmDialog = $("<div></div>");
                    $confirmDialog.html(strHTML);
                    $confirmDialog.dialog({
                        autoOpen: false,
                        modal: true,
                        resizable: false,
                        title: '<%= GetSystemText("Page Where Used") %>',
                        buttons: { '<%= GetSystemText("Close") %>': function () { $(this).dialog("close"); } }
                    });
                    
                    $confirmDialog.dialog('open');
            }, function() { console.log(arguments) });
        }	    
	</script>   
</body>
</html>
