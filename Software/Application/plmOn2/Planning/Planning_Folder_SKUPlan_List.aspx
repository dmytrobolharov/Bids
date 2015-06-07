<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Planning_Folder_SKUPlan_List.aspx.vb" Inherits="plmOnApp.Planning_Folder_SKUPlan_List" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register Src="Planning_Header.ascx" TagName="Planning_Header" TagPrefix="hc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/jquery-ui-1.10.3.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
    <style type="text/css">
        .confirm-dialog {
        	display: none;        	
        }
        
        .confirm-dialog p {
        	font-size: 14px;
        }
    </style>
    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
</head>
<script language="javascript">
    function RefreshMenu() {
        try {
            parent.window.menu.location.href = parent.window.menu.location.href
        } catch (e) { }
    }
</script>
<body>
<div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="form1" runat="server">
    <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td valign="middle" align="left">
                <cc1:confirmedimagebutton id="btnEdit" runat="server" message="NONE" CausesValidation="false"></cc1:confirmedimagebutton>
                <cc1:confirmedimagebutton id="btnNew" runat="server" message="NONE" CausesValidation="false"></cc1:confirmedimagebutton>                
                <cc1:confirmedimagebutton id="btnCopy" OnClientClick="return ShowCopyDialog()" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                <cc1:ConfirmedImageButton ID="btnRemove" runat="server" OnClientClick="return ShowRemoveDialog()" Message="NONE" />
                <cc1:ConfirmedImageButton ID="btnDelete" runat="server" OnClientClick="return ShowDeleteDialog()" Message="NONE" />                
                <cc1:bwimagebutton id="btnChangeLog" runat="server" causesvalidation="false" onclientclick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>
            </td>
        </tr>
    </table>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45"
        cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:Label>
            </td>
        </tr>
    </table>
    <hc1:planning_header id="PlanningHeader" runat="server" />
    <br />
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                <asp:DataGrid ID="DataGrid1" runat="server" AllowSorting="False" DataKeyField="PlanningSKUHeaderID">
                    <AlternatingItemStyle Height="20px" Wrap="true" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                    <ItemStyle Height="20px" Wrap="true" CssClass="ItemTemplate"></ItemStyle>
                    <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                    <PagerStyle Visible="False"></PagerStyle>
                    <Columns>
                        <asp:TemplateColumn HeaderStyle-BorderWidth="0" ItemStyle-BorderWidth="0">
                            <HeaderTemplate>
                                <input type="checkbox" onclick="SelectAll(this)" id="chkSelectAll" />
                            </HeaderTemplate>
                            <ItemStyle Width="20px" CssClass="SelectCheckBox" />
                            <ItemTemplate>
                                <asp:CheckBox runat="server" ID="chbSelect" />                                
                            </ItemTemplate>
                        </asp:TemplateColumn>          
                    </Columns>
                </asp:DataGrid>
            </td>
        </tr>
    </table>

    <div id="dlgCopy" style="display:none;"><asp:PlaceHolder runat="server" ID="plhCopy"></asp:PlaceHolder></div>
    <div id="dlgConfirm" class="confirm-dialog">
        <table cellpadding="0" cellspacing="0">
            <tr>
                <td style="width:40px;"><img class="warn-icon" alt="" src="../System/Icons/icon_block.gif" align="middle" /></td>
                <td><span class="confirm-msg"></span>:<br /><span class="selected-items"></span></td>
            </tr>
        </table> 
        <p><%= GetSystemText("Are you sure you want to continue?")%></p>
    </div>    

    <script type="text/javascript" src="../System/Jscript/jquery-ui-1.10.3.custom.min.js"></script>    
    </form>

    <script type="text/javascript">
        function SelectAll(chb) {
            $("[name$='chbSelect']:enabled").each(function(){ this.checked = chb.checked });
        }

        $("#dlgCopy .fontHead").removeAttr("width")
        function GetCheckedItems() {
            var items = [];

            $("#DataGrid1 [name$='chbSelect']:checked").each(function () {
                items.push($(this).closest("tr").find("[id$='lblPlanningSKUHeaderName']").text());
            });

            return items;
        }

        function ShowCopyDialog() {
            $("#dlgCopy").dialog({
                modal: true,
                resizable: false,
                draggable: false,
                width: 400,
                appendTo: "#form1",
                title: '<%= GetSystemText("Copy SKU Plan Item") %>',
                buttons: {
                    '<%= GetSystemText("Yes") %>': function() { <%= Page.ClientScript.GetPostBackEventReference(btnCopy, "", False) %>; },
                    '<%= GetSystemText("No") %>': function () { $(this).dialog("close"); } 
                }
            });

            return false;
        }

        function ShowRemoveDialog() {
            var items = GetCheckedItems();

            $("#dlgConfirm").dialog({
                modal: true,
                resizable: false,
                draggable: false,
                width: 400,
                appendTo: "#form1",
                title: '<%= GetSystemText("Remove SKU Plan Item") %>',
                open: function () {
                    $(this).find(".confirm-msg").text('<%= GetSystemText("You are about to remove SKU Plan Item(s)")%>').end()
                        .find(".warn-icon").attr("src", "../System/Icons/icon_block.gif").end()
                        .find(".selected-items").text(items.join(", "))
                },
                buttons: {
                    '<%= GetSystemText("Yes") %>': function() { <%= Page.ClientScript.GetPostBackEventReference(btnRemove, "", False) %>; },
                    '<%= GetSystemText("No") %>': function () { $(this).dialog("close"); }
                }
            });

            return false;
        }

        function ShowDeleteDialog() {
            var items = GetCheckedItems();

            $("#dlgConfirm").dialog({
                modal: true,
                resizable: false,
                draggable: false,
                width: 400,
                appendTo: "#form1",
                title: '<%= GetSystemText("Delete SKU Plan Item") %>',
                open: function () {
                    $(this).find(".confirm-msg").text('<%= GetSystemText("You are about to delete SKU Plan Item(s)")%>').end()
                        .find(".warn-icon").attr("src", "../System/Icons/icon_delete.gif").end()
                        .find(".selected-items").text(items.join(", "))
                },
                buttons: {
                    '<%= GetSystemText("Yes") %>': function() { <%= Page.ClientScript.GetPostBackEventReference(btnDelete, "", False) %>; },
                    '<%= GetSystemText("No") %>': function () { $(this).dialog("close"); }
                }
            });

            return false;
        }
    </script>
</body>
</html>
