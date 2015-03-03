<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_DimensionalBOM_Colorway.aspx.vb" Inherits="plmOnApp.Style.DimensionalBOM.Style_DimensionalBOM_Colorway" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Colorway</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid_Y.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>

     <style type="text/css">
            .material-colors {
            	margin-left: 10px;
            }

            .material-colors td {
                padding: 2px;
                overflow: visible;
            }

            .color-details {
                display: none;
                position: absolute;
                top: 100%;
                background-color: #fff;
                padding: 2px;
                border: 1px solid #ccc;
                
                /* show fancy shadows for webkit and other compatible browsers*/                
                -webkit-box-shadow: 5px 5px 10px -2px #000;
                box-shadow: 5px 5px 10px -2px #000;
            }
        </style>
</head>
<body>
<div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="form1" method="post" runat="server">
    <wc1:Color_Wait ID="Color_Wait" runat="server" />
         <telerik:radscriptmanager ID="RadScriptManager1" runat="server" >
            <Scripts>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js"></asp:ScriptReference>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js"></asp:ScriptReference>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js"></asp:ScriptReference>
            </Scripts>
            <CdnSettings TelerikCdn="Disabled" />
        </telerik:radscriptmanager>
        <telerik:radstylesheetmanager ID="RadStyleSheetManager1" Runat="server">
            <StyleSheets>
                <telerik:StyleSheetReference Path="../System/CSS/RadCalendar.YPLM.css" />
                <telerik:StyleSheetReference Path="../System/CSS/RadComboBox.YPLM.css" />
                <telerik:StyleSheetReference Path="../System/CSS/RadGrid.YPLM.css" />
                <telerik:StyleSheetReference Path="../System/CSS/RadInput.YPLM.css" />
            </StyleSheets>
            <CdnSettings TelerikCdn="Disabled" />
        </telerik:radstylesheetmanager>
        <telerik:radajaxmanager runat="server" ID="RadAjaxManager1" />
    <asp:Panel ID="pnlColorMgmt" runat="server">
        <table class="TableHeader" height="20" cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <td valign="middle" align="center" width="10px"><img height="15" alt="" src="../System/Images/bbTbSCnr.gif" width="3"></td>
                <td width="35" style="height: 24px">
                    <asp:dropdownlist id="dpNewRow" runat="server" CssClass="fontHead">
						<asp:ListItem Value="1" Selected="True">1</asp:ListItem>
						<asp:ListItem Value="2">2</asp:ListItem>
						<asp:ListItem Value="3">3</asp:ListItem>
						<asp:ListItem Value="4">4</asp:ListItem>
						<asp:ListItem Value="5">5</asp:ListItem>
						<asp:ListItem Value="10">10</asp:ListItem>
						<asp:ListItem Value="15">15</asp:ListItem>
						<asp:ListItem Value="20">20</asp:ListItem>
					</asp:dropdownlist>                   
                 </td>
                 <td style="height: 24px"> 
                    <cc1:confirmedimagebutton id="imgBtnAdd" runat="server" Message="NONE" /> 
                    <cc1:ConfirmedImageButton ID="btnColorSave" runat="server" Message="NONE" />
                     <cc1:ConfirmedImageButton ID="btnRemove" runat="server" Message="NONE" /> 
                    <cc1:ConfirmedImageButton ID="btnCMAutoColor" runat="server" Message="NONE" />
                     <cc1:BWImageButton ID="btnChangeLog" runat="server" CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:BWImageButton>
                    <cc1:ConfirmedImageButton ID="btnClose" Message="NONE" runat="server" OnClientClick="return btnClose_Click()" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:PlaceHolder ID="PlaceHolderColorMgmt" runat="server"></asp:PlaceHolder>
    <asp:Panel runat="server" ID="pnlPerm" Visible="false">
    <table style="height:50;" cellspacing="0" cellpadding="0" width="100%"  bgColor="#990000" border="1" borderColor="red">
        <tr>
            <td>
                <table style="height:25;" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td width="25"><div align="center"><asp:image id="imgWorkStatus" ImageUrl="../System/Icons/icon_lock.gif" runat="server"></asp:image></div></td>
                        <td>
                              <asp:Label ID="lblPerm" runat="server" 
                            Text="You might not have permission to access this tab using your credentials." 
                            CssClass="fontHead" ForeColor="White"></asp:Label>                         
                        
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Panel>
    <telerik:radscriptblock runat="server">
        <script type="text/javascript">

            function InitColorDetails() {
                // show color details
                $("img[id$=imgColor]").hover(function () {
                    var $this = $(this);
                    var $visibleDivs = $(".color-details:visible");
                    $visibleDivs.hide();
                    $visibleDivs.closest("td").css("z-index", "0");
                    $this.next().css("top", $this.position().top + $this.outerHeight()).show();
                    $this.closest("td").css("z-index", "999");

                });
                $(".color-details").hover(function () { }, function () { $(this).hide(); $(this).closest("td").css("z-index", "0"); });
            }


            // If all the 'Select Auto Color' checkboxes are disabled, 'Select All Auto Color' should be disabled too
            var frm = document.form1;
            var chbSelectAll = document.getElementById("cbSelectAll")
            var disableSelectAll = true;

            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf("chbAutoColor") != -1 && !e.disabled) {
                    disableSelectAll = false;
                    break;
                }
            }
            if (chbSelectAll != undefined) {
                chbSelectAll.disabled = disableSelectAll;
            }

        </script>
    </telerik:radscriptblock>
    </form>
    <script type="text/javascript">

        function CheckAllAutoColor(checkAllBox) {
            var frm = document.form1;
            var actVar = checkAllBox.checked;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];

                if (e.type == 'checkbox' && e.name.indexOf("chbAutoColor") != -1 && !e.disabled) {
                    e.checked = actVar;
                }
            }
        }

        function checkAllColorways(sender) {
            $(sender).closest("table").find("input[id*='chbColorway']").each(function() {$(this)[0].checked = sender.checked;});
        }

    </script>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
