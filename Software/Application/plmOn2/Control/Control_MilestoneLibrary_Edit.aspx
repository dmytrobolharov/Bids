<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_MilestoneLibrary_Edit.aspx.vb" Inherits="plmOnApp.Control_MilestoneLibrary_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Design Template</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
    <meta content="JavaScript" name="vs_defaultClientScript" />
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <script src="../System/Jscript/underscore-min.js" type="text/javascript"></script>
    <script src="../System/Jscript/YSCalendarFunctions.js" type="text/javascript"></script>
    <style type="text/css">
        .TableHeader td {
        	white-space: nowrap;
        }
    </style>
</head>
<body ms_positioning="GridLayout">
    <form id="Form1" method="post" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
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
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE" OnClientClick="return validation();">
                </cc1:ConfirmedImageButton><cc1:BWImageButton ID="btnAddTask" runat="server" Message="NONE">
                </cc1:BWImageButton><cc1:ConfirmedImageButton ID="btmImgDelete" CausesValidation="false" runat="server">
                </cc1:ConfirmedImageButton><cc1:BWImageButton ID="btnSort" runat="server" WindowHeight="400px" WindowWidth="400px"></cc1:BWImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" CausesValidation="false">
                </cc1:ConfirmedImageButton>
            </td>
            <td class="FontHead" align="right" width="75">
            </td>
            <td width="40">
            </td>
            <td>
            </td>
        </tr>
    </table>
    <table cellspacing="2" cellpadding="0" width="100%" border="0" bgcolor="#ffffff">
        <tr>
            <td width="900">
                <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
            </td>
            <td>
            </td>
        </tr>
    </table>
    <cc1:ConfirmedImageButton ID="btnRemoveItems" runat="server" CausesValidation="false"></cc1:ConfirmedImageButton>
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td valign="top" width="300">
                <asp:DataGrid ID="DataGrid1" runat="server" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px">
                    <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
                    <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
                    <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                    <Columns>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <input type="checkbox" id="checkAll" onclick="CheckAll(this);" runat="server" name="checkAll" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkDelete" runat="server"></asp:CheckBox>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                    </Columns>
                </asp:DataGrid>
                <table cellspacing="2" cellpadding="0" border="0">
                    <tr class="fontHead">
                        <td>
                            &nbsp;
                        </td>
                        <td nowrap width="85">
                            <asp:Label ID="lblNofRow" runat="server"></asp:Label>
                        </td>
                        <td width="35">
                            <asp:DropDownList ID="dpNewRow" runat="server" CssClass="fontHead">
                                <asp:ListItem Value="1" Selected="True">1</asp:ListItem>
                                <asp:ListItem Value="2">2</asp:ListItem>
                                <asp:ListItem Value="3">3</asp:ListItem>
                                <asp:ListItem Value="4">4</asp:ListItem>
                                <asp:ListItem Value="5">5</asp:ListItem>
                                <asp:ListItem Value="10">10</asp:ListItem>
                                <asp:ListItem Value="15">15</asp:ListItem>
                                <asp:ListItem Value="20">20</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td width="100">
                            <cc1:ConfirmedImageButton ID="imgBtnAdd" runat="server" Message="NONE" CausesValidation="false"></cc1:ConfirmedImageButton>
                        </td>
                    </tr>
                </table>
            </td>
            <td valign="top">
            </td>
        </tr>
    </table>
    </form>
    <script type="text/javascript">
        var frm = document.Form1;
        function CheckAll(checkAllBox) {
            var actVar = checkAllBox.checked, i, e;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf("chkDelete") != -1)
                    e.checked = actVar;
            }
        }

        function validation() {
            function groupValidatorsEnable(g, enable) {
                _.each(g, function (vs) {
                    _.each(vs, function (v) { ValidatorEnable(v, enable); });
                });
            };
            var groups = {};
            $("#DataGrid1 :text, #DataGrid1 select").each(function () {
                if (this.Validators != null && this.Validators.length > 0) {
                    if (this.disabled) {
                        _.each(this.Validators, function (v) { ValidatorEnable(v, false); });

                        return;
                    }

                    var id = this.id.match(/(DataGrid1_ctl\d+)/)[1];
                    if (!groups[id]) {
                        groups[id] = [];
                    }

                    groups[id].push(this.Validators);
                }
            });

            _.each(groups, function (g) { groupValidatorsEnable(g, true); });

            Page_ClientValidate();

            _.each(groups, function (g) {
                var allvalid = _.reduce(g, function (acc, vs) {
                    return acc || _.reduce(vs, function (acc1, v) { return acc1 && v.isvalid }, true);
                }, false);

                groupValidatorsEnable(g, allvalid);
            });

            return Page_ClientValidate();
        }

        function RCBValidate(source, args) {
            var combo = $find(source.controltovalidate);
            args.IsValid = combo.get_checkedItems().length > 0;
        }

        Sys.Application.add_load(function () {
            $("[id$='drlDependentWorkflowTypeID']").each(function () {
                var $dependents = $(this).closest('tr').find("[id$='drlMilestoneItemStatus'], [id$='txtDueDate']")
                if (this.value != '<%= Guid.empty.ToString %>') {
                    $dependents.attr('disabled', 'disabled');
                    $(this).closest('tr').find("[id$='rcbWorkflows'], [id$='rcbWorkflowStatuses']").each(function () {
                        $find(this.id).get_inputDomElement().disabled = false;
                        $find(this.id).enable();
                    });
                } else {
                    $dependents.removeAttr('disabled');
                    $(this).closest('tr').find("[id$='rcbWorkflows'], [id$='rcbWorkflowStatuses']").each(function () {
                        $find(this.id).get_inputDomElement().disabled = true;
                        $find(this.id).disable();
                    });
                }
            })
        });
    </script>
</body>
</html>