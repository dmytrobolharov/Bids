<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Planning_Folder_LineList.aspx.vb" Inherits="plmOnApp.Planning_Folder_LineList" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register Src="Planning_Header.ascx" TagName="Planning_Header" TagPrefix="hc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Line</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
    <meta content="JavaScript" name="vs_defaultClientScript" />
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/toastr.min.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/jquery-ui-1.10.3.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
        <style type="text/css">
            .search-cell td {
            	vertical-align: top !important;
            }
            
            .alert {
            	margin: 5px;
            }
            
            #line-lists-list  {
            	margin: 0 0 0 15px;
            	padding: 2px;
            }
            
            #line-lists-list li {
            	list-style-type: none;            
            }  
            
            #remove-dialog {
            	display: none;
            }
        </style>
        <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
</head>
<body>
<div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="Form1" method="post" runat="server" defaultbutton="imgBtnSearch">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server" EnablePageMethods="true">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js"></asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js"></asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js"></asp:ScriptReference>
        </Scripts>
        <CdnSettings TelerikCdn="Disabled" />
    </telerik:RadScriptManager>
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server">
        <StyleSheets>
            <telerik:StyleSheetReference Path="../System/CSS/RadCalendar.YPLM.css" />
            <telerik:StyleSheetReference Path="../System/CSS/RadComboBox.YPLM.css" />
            <telerik:StyleSheetReference Path="../System/CSS/RadGrid.YPLM.css" />
            <telerik:StyleSheetReference Path="../System/CSS/RadInput.YPLM.css" />
        </StyleSheets>
        <CdnSettings TelerikCdn="Disabled" />
    </telerik:RadStyleSheetManager>
    <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1" />

    <asp:Panel runat="server" ID="pnlPerm" Visible="false">
        <table style="height: 50;" cellspacing="0" cellpadding="0" width="100%" bgcolor="#990000" border="1"
            bordercolor="red">
            <tr>
                <td>
                    <table style="height: 25;" cellspacing="0" cellpadding="0" width="100%" border="0">
                        <tr>
                            <td width="25">
                                <div align="center">
                                    <asp:Image ID="imgWorkStatus" ImageUrl="../System/Icons/icon_lock.gif" runat="server"></asp:Image></div>
                            </td>
                            <td>
                                <asp:Label ID="lblPerm" runat="server" Text="You might not have permission to access user groups using your credentials."
                                    CssClass="fontHead" ForeColor="White"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel runat="server" ID="pnlMain">
        <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                </td>
                <td>                    
                    <cc1:BWImageButton ID="btnAddNew" runat="server" CausesValidation="False"></cc1:BWImageButton>
                    <cc1:BWImageButton ID="btnAddExisting" runat="server" CausesValidation="False"></cc1:BWImageButton>
                    <cc1:ConfirmedImageButton ID="btnEdit" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                    <asp:ImageButton ID="btnRemove" runat="server" CausesValidation="False" OnClientClick="return removeConfirm()" />
                    <asp:ImageButton ID="btnDelete" runat="server" CausesValidation="False" OnClientClick="return deleteConfirm()" />
                    <cc1:ConfirmedImageButton ID="btnAutoAllocate" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                    <cc1:BWImageButton id="btnConfigure" runat="server" Message="NONE" ></cc1:BWImageButton>
                    <cc1:BWImageButton ID="btnChangeLog" runat="server" CausesValidation="False"></cc1:BWImageButton>
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
        </table>        
        <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45"
            cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
            <tr>
                <td>
                    &nbsp;<asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Line Folder</asp:Label>
                </td>
            </tr>
        </table>
        <hc1:Planning_Header ID="PlanningHeader" runat="server" />
        <br />
        <table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
            <tr colspan="2">
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="search-cell">
                    <asp:PlaceHolder ID="plhSearchControl" runat="server" EnableViewState="False"></asp:PlaceHolder>
                </td>
                <td valign="top" width="100%">
                    <table height="45">
                        <tr>
                            <td>
                                <asp:ImageButton ID="imgBtnSearch" runat="server"></asp:ImageButton>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr valign="top">
                <td>
                    <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff"
                        border="0">
                        <tr valign="middle">
                            <td valign="middle" align="center" width="10">
                                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                            </td>
                            <td width="20">
                                <asp:ImageButton ID="btnImgFirst" runat="server"></asp:ImageButton>
                            </td>
                            <td width="20">
                                <asp:ImageButton ID="btnImgPrevious" runat="server"></asp:ImageButton>
                            </td>
                            <td nowrap align="center" width="125">
                                <asp:Label ID="lblPageCount" runat="server" CssClass="fontHead"></asp:Label>
                            </td>
                            <td width="20">
                                <asp:ImageButton ID="btnImgNext" runat="server"></asp:ImageButton>
                            </td>
                            <td width="20">
                                <asp:ImageButton ID="btnImgLast" runat="server" ToolTip="Last"></asp:ImageButton>
                            </td>
                            <td width="10">
                                &nbsp;
                            </td>
                            <td nowrap height="25">
                                <div align="left">
                                    <b>
                                        <asp:Label ID="lblRecordCount" Visible="true" runat="server"></asp:Label>&nbsp;
                                        <asp:Label ID="lblRecordFound" runat="server" />
                                    </b>
                                </div>
                            </td>
                            <td width="110" align="right">
                                <asp:Label ID="lblRecordPerPage" runat="server" CssClass="fontHead"></asp:Label>
                            </td>
                            <td width="25">
                                <asp:DropDownList ID="ps" runat="server" CssClass="fontHead">
                                    <asp:ListItem Value="5">5</asp:ListItem>
                                    <asp:ListItem Value="10">10</asp:ListItem>
                                    <asp:ListItem Value="15">15</asp:ListItem>
                                    <asp:ListItem Value="20">20</asp:ListItem>
                                    <asp:ListItem Value="25">25</asp:ListItem>
                                    <asp:ListItem Value="30">30</asp:ListItem>
                                    <asp:ListItem Value="40">40</asp:ListItem>
                                    <asp:ListItem Value="50" Selected="True">50</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td width="10">
                                <asp:Button ID="Button1" OnClick="RePage" runat="server" CssClass="fontHead" Text="GO"></asp:Button>
                            </td>
                        </tr>
                    </table>
                    <asp:DataGrid ID="DataGrid1" runat="server" AllowSorting="True" DataKeyField="LineFolderID">
                        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                        <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
                        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                        <PagerStyle Visible="False"></PagerStyle>
                        <Columns>
                            <asp:TemplateColumn>
                                <HeaderTemplate>
                                    <input type="checkbox" id="checkAll" onclick="CheckAll(this);" runat="server" name="checkAll" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkSelected" runat="server"></asp:CheckBox>
                                    <asp:HiddenField ID="hdnLineFolderID" runat="server" Value='<%# Eval("LineFolderID").ToString %>' />
                                    <asp:HiddenField ID="hdnLineFolderDescription" runat="server" Value='<%# Eval("LineFolderDescription") %>' />
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn ItemStyle-BorderColor="Gainsboro" ItemStyle-BorderWidth="1">
                                <ItemTemplate>
                                    <asp:label ID="labelGoTo" runat="server"></asp:label>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                        </Columns>
                    </asp:DataGrid><asp:Label ID="SortOrder" runat="server" Visible="False"></asp:Label>
                </td>
            </tr>
        </table>
        <div id="remove-dialog">
            <p class="message"></p>
            <ul id="line-lists-list"></ul>
            <p class="bot-message"></p>
        </div>
        <asp:HiddenField ID="hdnXmlFiles" runat="server" />
        <input id="hiddenCurrentPage" type="hidden" value="0" name="hiddenCurrentPage" runat="server" alt="" />&nbsp;&nbsp;</asp:Panel>    
    
    <script type="text/javascript">
        var frm = document.forms['Form1'];
        function CheckAll(checkAllBox) {
            var actVar = checkAllBox.checked;
            for (var i = 0; i < frm.length; i++) {
                var e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf("chkSelected") != -1)
                    e.checked = actVar;
            }
        }

        $("#DataGrid1 :checkbox").click(function(e) { e.stopPropagation(); });        

        $('.js-gotoLineList').click(function(event){
            var newWin = window.open('../Line/Line_List_Folder.aspx?LFID='+$(this).attr('data-id'), 'JSSite', 'width=10,height=10,toolbar=yes,location=yes,directories=yes,status=yes,menubar=yes,scrollbars=yes,resizable=yes');
            event.stopPropagation();
        })

    </script>
    
    <script type="text/javascript" src="../System/Jscript/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="../System/Jscript/jquery-ui-1.10.3.custom.min.js"></script>
    <script type="text/javascript" src="../System/Jscript/toastr.min.js"></script>

    <script type="text/javascript">

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

        function confirmDialog(params) {
            var listItems = [],
                lineFolderIDs = [];

            $("[id$='chkSelected']:checked").each(function () {
                var td = $(this).closest("td");
                listItems.push('<li><span>' + td.find("[id$='hdnLineFolderDescription']").val() + '</span></li>');
                lineFolderIDs.push(td.find("[id$='hdnLineFolderID']").val())
            });

            $("#line-lists-list").html(listItems.join(''));

            PageMethods.GetLineFolderItemsCount("<%= _PlanningID %>", lineFolderIDs, function(planningItemsCount) {                  
                $("#remove-dialog .message").text(String.format(params.msg, planningItemsCount));
                $("#remove-dialog .bot-message").text(params.botMsg);
                $("#remove-dialog").dialog({
                    title: params.title,
                    modal: true,       
                    width: 380,
                    buttons: params.buttons
                });
            });            

            return false;
        }

        function removeConfirm() {
            confirmDialog({
                title: '<%= GetSystemText("Remove Line Lists") %>',
                msg: '<%= GetSystemText("You are about to remove the following Line Lists containing a total of {0} styles:")%>',
                botMsg: '<%= GetSystemText("If you wish to proceed with removing Line Lists, would you like to keep or remove the styles that are in them from the Line Plan?")%>',
                buttons: {
                    '<%= GetSystemText("Keep Styles") %>': function () { <%= ClientScript.GetPostBackEventReference(btnRemove, "0") %>; },
                    '<%= GetSystemText("Remove Styles") %>': function () { <%= ClientScript.GetPostBackEventReference(btnRemove, "1") %>; },
                    '<%= GetSystemText("Cancel") %>': function () { $(this).dialog('close'); }
                }
            });

            return false;
        }

        function deleteConfirm() {
            confirmDialog({
                title: '<%= GetSystemText("Delete Line Lists") %>',
                msg: '<%= GetSystemText("You are about to delete the following Line Lists containing a total of {0} styles:")%>',
                botMsg: '<%= GetSystemText("If you wish to proceed with deleting Line Lists, would you like to keep or remove the styles that are in them from the Line Plan?")%>',
                buttons: {
                    '<%= GetSystemText("Keep Styles") %>': function () { <%= ClientScript.GetPostBackEventReference(btnDelete, "0") %>; },
                    '<%= GetSystemText("Remove Styles") %>': function () { <%= ClientScript.GetPostBackEventReference(btnDelete, "1") %>; },
                    '<%= GetSystemText("Cancel") %>': function () { $(this).dialog('close'); }
                }
            });

            return false;            
        }

    </script>
    </form>
</body>
</html>
