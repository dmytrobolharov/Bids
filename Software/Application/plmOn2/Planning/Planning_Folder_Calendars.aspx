<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Planning_Folder_Calendars.aspx.vb" Inherits="plmOnApp.Planning_Folder_Calendars" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register Src="Planning_Header.ascx" TagName="Planning_Header" TagPrefix="hc1" %>
<!DOCTYPE html "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
<head id="Head1" runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/toastr.min.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/jquery-ui-1.10.3.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <style type="text/css">
        .confirm-dialog {
        	display: none;        	
        }
        
        .confirm-dialog p {
        	font-size: 14px;
        }
        
        .confirm-dialog ul {
        	list-style-type: none;
        }
    </style>
</head>
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
                <cc1:bwimagebutton id="btnAddNew" runat="server" message="NONE" CausesValidation="false"></cc1:bwimagebutton>                
                <cc1:confirmedimagebutton id="btnAdd" runat="server" message="NONE" CausesValidation="false"></cc1:confirmedimagebutton> 
                <cc1:confirmedimagebutton id="btnCopy" OnClientClick="return ShowCopyDialog()" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                <cc1:ConfirmedImageButton ID="btnRemove" runat="server" OnClientClick="return ShowRemoveDialog()" Message="NONE" />
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
                <asp:DataGrid ID="DataGrid1" runat="server" AllowSorting="False" DataKeyField="PlanningTACalendarID">
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
                                <asp:HiddenField ID="hdnChangeLogText" runat="server" Value='<%# Eval("TACalTemplateName") %>' />                           
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
        <p><%= GetSystemText("Are you sure you wish to continue?")%></p>
    </div>    

    <script type="text/javascript" src="../System/Jscript/jquery-ui-1.10.3.custom.min.js"></script>  
    <script type="text/javascript" src="../System/Jscript/toastr.min.js"></script>
    <script type="text/javascript">
        $("td:has(:checkbox)").click(function(e) { e.stopPropagation(); });

        toastr.options = {
            "closeButton": true,
            "debug": false,
            "positionClass": "toast-bottom-right",
            "showDuration": "300",
            "hideDuration": "1000",
            "timeOut": "0",
            "extendedTimeOut": "0",
            "showEasing": "swing",
            "hideEasing": "linear",
            "showMethod": "fadeIn",
            "hideMethod": "fadeOut"
        }

        function SelectAll(chb) {
            $("[name$='chbSelect']:enabled").each(function(){ this.checked = chb.checked });
        }

        $("#dlgCopy .fontHead").removeAttr("width")
        function GetCheckedItems() {
            var items = [];

            $("#DataGrid1 [name$='chbSelect']:checked").each(function () {
                items.push($(this).closest("tr").find("[id$='lblTACalTemplateName']").text());
            });

            return items;
        }

        function ArrayToUL(list) {
            return list.length > 0 ? "<ul><li>" + list.join("</li><li>") + "</li></ul>" : "";            
        }

        function ShowRemoveDialog() {
            var items = GetCheckedItems();

            $("#dlgConfirm").dialog({
                modal: true,
                resizable: false,
                draggable: false,
                width: 400,
                appendTo: "#form1",
                title: '<%= GetSystemText("Remove Calendars") %>',
                open: function () {
                    $(this).find(".confirm-msg").text('<%= GetSystemText("You are about to remove the following Calendars from this Line Plan")%>').end()
                        .find(".warn-icon").attr("src", "../System/Icons/icon_block.gif").end()
                        .find(".selected-items").html(ArrayToUL(items))
                },
                buttons: {
                    '<%= GetSystemText("Yes") %>': function() { <%= Page.ClientScript.GetPostBackEventReference(btnRemove, "", False) %>; },
                    '<%= GetSystemText("No") %>': function () { $(this).dialog("close"); }
                }
            });

            return false;
        }
    </script>  
    </form>

   
</body>
</html>
