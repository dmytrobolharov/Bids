<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Vendor_FolderPage_InfrastructureEdit.aspx.vb" Inherits="plmOnApp.Vendor_FolderPage_InfrastructureEdit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="InfrastructureHeader" Src="Vendor_FolderPage_InfrastructureHeader.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title runat="server" id="pgTitle">Infrastructure</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid_Y.css" type="text/css" rel="stylesheet" />
    <link rel="stylesheet" href="../System/CSS/jquery.ui.core.css" />
	<link rel="stylesheet" href="../System/CSS/jquery.ui.theme.css" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script src="../System/Jscript/jquery-1.8.0.js"></script>
	<script src="../System/Jscript/jquery.ui.core.js"></script>
	<script src="../System/Jscript/jquery.ui.widget.js"></script>
	<script src="../System/Jscript/jquery.ui.mouse.js"></script>
	<script src="../System/Jscript/jquery.ui.sortable.js"></script>
    <link href="../System/CSS/jquery-sortable.css" rel="stylesheet" />
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
    <style>
	    li {cursor:url(../System/Cursor/openhand.cur), pointer} 
	    #sortable { list-style-type: none; margin: 0; padding: 0; }
	    #sortable li { margin: 3px 3px 3px 0; padding: 1px; float: left; width: auto; height: auto; text-align: center; vertical-align:top; }
	</style>
	
	<script>

	    $(window).load(function () {
	        $('.ui-state-default').mousedown(function () { $(this).css('cursor', 'url(../System/Cursor/closedhand.cur)'); });

	        $('.ui-state-default').mouseup(function () { $(this).css('cursor', 'url(../System/Cursor/openhand.cur)'); });
	    });

	    $(function () {
	        $("#sortable").sortable({
	            stop: function (event, ui) {
	                var s = /\[\]/g;
	                var sE = /=/g;
	                document.getElementById("hdnSortOrder").value = $(this).sortable('serialize').replace(/&/g, ',').replace(s, '').replace(sE, '_');
	                document.getElementById("hdnChanged").value = '1';
	            }
	        });
	        $("#sortable").disableSelection();


	    });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%"
        border="0">
        <tr>
            <td valign="middle" align="center" width="10">
                <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
            </td>
            <td width="100%">
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:BWImageButton ID="btnAttachMultipleFile" runat="server" Message="NONE" CausesValidation="False"></cc1:BWImageButton>
                <cc1:BWImageButton ID="btnImageSelect" runat="server"></cc1:BWImageButton>
                <cc1:BWImageButton ID="btnImageRemove" runat="server"></cc1:BWImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" CausesValidation="False" OnClientClick="return btnClose_Click()"></cc1:ConfirmedImageButton>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        </table>
        <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td valign="top" bgcolor="#ffffff">
                <table height="100%" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td valign="top" colspan="2" height="50">
                            <asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
                                ForeColor="#E0E0E0"></asp:Label>&nbsp;
                        </td>
                        <td valign="top" height="50">
                        </td>
                    </tr>
                </table>
                <uc1:InfrastructureHeader runat="server" id="ctrInfrastructureHeader" />
                <table id="Table2" cellspacing="2" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td>
                            <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
                        </td>
                    </tr>
                </table>
                <br />
            </td>
        </tr>
        </table>
            <asp:Repeater runat="server" id="repeater1">
                <HeaderTemplate>
                    <div class="normal">
                        <ul  id="sortable">
                </HeaderTemplate> 
                <ItemTemplate>
                </ItemTemplate>
                <FooterTemplate>
                        </ul>
                        </div>
                 </FooterTemplate>
            </asp:Repeater>
            <input type="hidden" id="hdnChanged" name="hdnChanged" value="0" />
            <input type="hidden" id="hdnSortOrder" name="hdnSortOrder" />
    </form>
</body>
    <script type="text/javascript" language='javascript'>

        function ReloadForm() {
            window.location.reload();
        }
    </script>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</html>
