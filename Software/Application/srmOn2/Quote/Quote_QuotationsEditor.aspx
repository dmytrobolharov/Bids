<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Quote_QuotationsEditor.aspx.vb" Inherits="srmOnApp.Quote_QuotationsEditor" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
	<title runat="server" id="pgTitle">Quote Editor</title>
	<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
	<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
	<meta content="JavaScript" name="vs_defaultClientScript">
	<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/jquery.tablescroll.css" type="text/css" rel="stylesheet">
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</HEAD>
<body MS_POSITIONING="GridLayout">
<form id="Form1" method="post" runat="server">

<script type="text/javascript">
    var frm = document.Form1;
    function CheckAll(checkAllBox, dgName) {
        var actVar = checkAllBox.checked;        
        for (i = 0; i < frm.length; i++) {
            e = frm.elements[i];
            if (e.type == 'checkbox' && e.id.indexOf('chbItem') != -1 && e.id.indexOf(dgName) != -1) {
                if (e.disabled != true) {
                    e.checked = actVar;
                }
            }
        }
    }
</script>
<div>
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
        <tr>
            <td valign="middle" align="center" width="10">
                <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
            </td>
            <td width="100%">
                <cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" CausesValidation="true"></cc1:confirmedimagebutton>
                <cc1:confirmedimagebutton id="btnBatchUpdate" runat="server" Message="NONE" CausesValidation="true" ValidationGroup="batch"></cc1:confirmedimagebutton>
                <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" CausesValidation="false"></cc1:confirmedimagebutton>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td valign="top" bgcolor="#ffffff">
                <table height="100%" cellspacing="0" cellpadding="0" width="100%"  style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="25" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
                    <tr>
                        <td valign="top" colspan="2" height="30">
                            <asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:Label>&nbsp;
                        </td>
                        <td valign="top" height="30">
                        </td>
                    </tr>
                </table>

            </td>
        </tr>
    </table>
    <table border="0" cellpadding="0" cellspacing="0" style="width:100%">
    <tr>
        <td align="left" valign="top">
            <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
                <tr valign="middle">
                    <td valign="middle" align="center" width="10">
                        <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
                    </td>
                    <td width="100%">
                       <asp:Label id="lblBOM" runat="server">&nbsp;</asp:Label>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</div>
<div id="FloatDG" runat="server" style="width:695px; z-index:500; position: absolute; left:0px; cursor:pointer;" >
    <div style="float:left; background-color:White; width:675px; height:100%;"><asp:PlaceHolder ID="plhQuoteGrid" runat="server" EnableViewState="False"></asp:PlaceHolder></div>
    <div id="FloatDGControl" style="float:right; width:20px; background-color:#6699FF; height:100%;"><span id="SliderHead" runat="server" style="-moz-transform: rotate(90deg); -webkit-transform: rotate(90deg); -o-transform: rotate(90deg); writing-mode: tb-rl; white-space:nowrap; padding: 4px 4px 0px 3px; font-size:12px; font-family:Arial; font-weight:bold; color:White; display:block;"></span></div>
</div>
<div id="DimBOMEdit" style="padding-left:20px;"><asp:PlaceHolder ID="plhEdit" runat="server" EnableViewState="False"></asp:PlaceHolder></div>
</form>
<script type="text/javascript">
    function resizeGrid() {

        var colorwayGrid = $("#DimBOMEdit");
        var windowHeight = $(window).height();
        var formHeight = $("#Form1").height();
        var minHeight = 100;

        // Calculating, how much free space we have on the window for grid area
        var diff = windowHeight - (formHeight - colorwayGrid.height());

        if (diff > minHeight) {
            colorwayGrid.height(diff);
        } else {
            colorwayGrid.height(minHeight);
        }
    }

    resizeGrid();
    $("#FloatDG").height($("#DimBOMEdit").height());

    $("#FloatDGControl").click(function () {
        if ($("#FloatDG").offset().left == 0) { $("#FloatDG").animate({ left: $("#FloatDGControl").width() - $("#FloatDG").width() }, 200); }
        else { $("#FloatDG").animate({ left: 0 }, 200); }
    })
</script>

</body>
</html>
