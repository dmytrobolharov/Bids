<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Planning_SKUPlan_New.aspx.vb" Inherits="plmOnApp.Planning_SKUPlan_New" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>New Workflow Item</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../System/Jscript/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="../System/Jscript/underscore-min.js"></script>
</head>
<body>
<div id="Div1"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="A1"></a></div>
    <div id="fixed_icons">
        <a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank"
            id="yHelp"></a>
    </div>
    <form id="form1" runat="server">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
            </td>
            <td nowrap="nowrap">
                <cc1:confirmedimagebutton id="btnSave" runat="server" message="NONE"></cc1:confirmedimagebutton>
                <cc1:confirmedimagebutton id="btnClose" runat="server" message="NONE" causesvalidation="False" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton>
            </td>
        </tr>
    </table>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45"
        cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                &nbsp;<asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">New</asp:Label>
            </td>
        </tr>
    </table>
    <br />
    <asp:Panel runat="server" ID="pnlWarning" Visible="false">
        <div style="background-color:#a00; padding:10px;">
            <asp:Label ID="lblPerm" runat="server" Text="Planning should have styles with asoosiated Bill of Material that have at least one dimension selected"
                CssClass="fontHead" ForeColor="White"></asp:Label>
        </div>
    </asp:Panel>
    <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
    <script type="text/javascript">
        // supports 
        $(".one-source").filter(function () { return this.value == ""; }).closest("tr").not(":first").hide();

        var dataSource = {}, drls = {};
        $("select.one-source:first option").each(function (i, elem) {
            if (elem.value != '') { dataSource[elem.value] = { owner: null, value: elem.text }; }
        });

        $("select.one-source:gt(" + (_.keys(dataSource).length - 1) + ")").closest("tr").remove()

        function findOwned(v, i) { return v.owner == this.id; }

        function rebindDropdowns() {
            $("select.one-source").each(function (i, elem) {
                var $self = $(this);

                _.each(dataSource, function (v, i) {
                    if (this.val() != i) {
                        this.find("option[value='" + i + "']")[0].disabled = !(v.owner == null || v.owner == this.attr('id'));
                    }
                }, $self);
            });
        }

        $("select.one-source").each(function (i, elem) {
            $(elem).change(function () {
                var prevValue = _.find(dataSource, findOwned, this);
                if (prevValue) { prevValue.owner = null; }

                if (dataSource[this.value]) {
                    dataSource[this.value].owner = this.id;
                    $(this).closest('tr').next(':has(.one-source)').show()
                } else {
                    $(this).closest('tr').nextAll(':has(.one-source)').hide().find('.one-source').val('').trigger('change');
                }

                rebindDropdowns()
            });
        });
    </script>
    </form>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
