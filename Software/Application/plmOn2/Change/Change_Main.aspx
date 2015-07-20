<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Change_Main.aspx.vb" Inherits="plmOnApp.Change_Main" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title runat="server" id="PageTitle"></title>		
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid_Y.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	<style type="text/css">
	    .notify-selected td, .notify-selected td.rgSorted,
	    .RadGrid_YPLM .notify-selected td, .RadGrid_YPLM .notify-selected td.rgSorted {
	    	color: #fff !important;
	    	background-color: #a00;
	    }
	    
	    .RadGrid_YPLM td a {
	    	display: block;
	    	width: 100%;
	    	height: 100%;
	    	font-weight: bold;
	    }
	    
	    .notify-selected td a:link,
	    .notify-selected td a:hover,
	    .notify-selected td a:visited,
	    .notify-processing td a:link,
	    .notify-processing td a:hover,
	    .notify-processing td a:visited {
	    	color: #fff;
	    }
	    
	    .RadGrid_YPLM .notify-processing td, .RadGrid_YPLM .notify-processing td.rgSorted,
	    .notify-processing td, .notify-processing td.rgSorted {
	    	background-color: #777;
	    }
	    
	    .view-notification .rgRowYPLM td, .view-notification .rgAltRowYPLM td {	    	
	    	background-color: #fdf;
	    }
	    
	    .rgRowYPLM td, .rgAltRowYPLM td {	    	
	    	white-space: normal !important;
	    }
	    
        th.rgHeaderYPLM, th.rgHeader {
            padding: 0 0px !important;
        }	    
        
        #RadGridChangeLog .rgMasterTable td {
            border-color: #ddd !important;
        }
	    
	</style>
</head>
<body> 
	<form id="Form1" method="post" runat="server" defaultbutton="imgBtnSearch" defaultfocus="Form1">	    
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
        <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                </td>
                <td>
                    <asp:ImageButton ID="btnInvSearch" runat="server" Height="0px" Width="0px" ImageUrl="../System/icons/1x1.gif">
                    </asp:ImageButton><cc1:ConfirmedImageButton ID="btnSendTo" runat="server" Message="NONE" OnClientClick="return emailPopup();">
                    </cc1:ConfirmedImageButton><cc1:ConfirmedImageButton ID="btnClearSelection" runat="server" Message="NONE">
                    </cc1:ConfirmedImageButton><cc1:ConfirmedImageButton ID="btnSelectAll" runat="server" Message="NONE" OnClientClick="return selectAll();">
                    </cc1:ConfirmedImageButton><cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()">
                    </cc1:ConfirmedImageButton>
                </td>
                <td width="75">
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
        </table>
		<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
			height="45" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
			<tr>
				<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#999999" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label>
				</td>
			</tr>
		</table>		
        <table cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr valign="top">
                <td>
                    <table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
                        <tr>
                            <td>
                                <asp:PlaceHolder ID="plhSearchControl" runat="server" EnableViewState="False"></asp:PlaceHolder>
                            </td>
                            <td valign="top" width="100%">
                                <table height="45">
                                    <tr>
                                        <td>
                                            <asp:ImageButton ID="imgBtnSearch" runat="server">
                                            </asp:ImageButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:PlaceHolder runat="server" ID="plhChangeLogGrid"></asp:PlaceHolder>
                </td>
            </tr>
        </table>
	</form>
	
	<telerik:RadCodeBlock runat="server" ID="RadCodeBlock1">
	    <script type="text/javascript">
	        var inProgress = {};

	        function RowClicked(sender, eventArgs) {
	            checkNotify(eventArgs.get_item());
            }

            /** Resizing Colorway Grid to take all the free height on the screen **/
            function resizeGrid() {

                var changeGrid = $("#RadGridChangeLog");
                var windowHeight = $(window).height();
                var formHeight = $("#Form1").height();
                var minHeight = 600;

                // Calculating, how much free space we have on the window for grid area
                var diff = windowHeight - (formHeight - changeGrid.height());

                if (diff > minHeight) {
                    changeGrid.height(diff);
                } else {
                    changeGrid.height(minHeight);
                }
            }

	        function checkNotify(item) {
	            var changeLogItemID = item.getDataKeyValue("ChangeLogItemID");

	            if (inProgress[changeLogItemID] != null) {
	                return;
	            }

	            function onSuccess(result) {
	                item.removeCssClass("notify-processing");
	                delete inProgress[changeLogItemID];
	                if (result.added) {
	                    item.addCssClass("notify-selected");
	                } else {
	                    item.removeCssClass("notify-selected");
	                }

                    var btnSendTo = document.getElementById('<%= btnSendTo.ClientID %>'),
                        btnClearSelection = document.getElementById('<%= btnClearSelection.ClientID %>');
	                if (result.count > 0) {
	                    btnSendTo.style.display = btnClearSelection.style.display = '';
	                } else {
	                    btnSendTo.style.display = btnClearSelection.style.display = 'none';
                    }
	            };

	            function onError(error) {
	                item.removeCssClass("notify-processing");
	                delete inProgress[changeLogItemID];
	                if (error != null) {
	                    alert(error.get_message());
	                }
	            };

	            item.addCssClass("notify-processing");
	            inProgress[changeLogItemID] = true;
	            PageMethods.SaveNotificationChanges(changeLogItemID, onSuccess, onError);
	        }

	        function selectAll() {
	            $.each($find('RadGridChangeLog').get_masterTableView().get_dataItems(), function (i, item) {
	                if (!$(item.get_element()).is('.notify-selected')) {
	                    checkNotify(item);
	                }
	            });

	            return false;
            }

	        function emailPopup() {
	            var popup = window.open(
	                '../Change/Change_SendEmail_Popup.aspx?CLTID=<%=Request.QueryString("CLTID")%>&CTPKID=<%=Request.QueryString("CTPKID")%>&CTTPKID=<%=Request.QueryString("CTTPKID")%>&SID=<%=Request.QueryString("SID")%>&SN=<%=Request.QueryString("SN")%>',
	                'ChangeLogNotificationSendTo',
	                'toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=1,resizable=1,width=960,height=640,left=50,top=50'
	            );
	            popup.focus();
	            
	            return false;
	        }

	        /*if ($('.rgDataDiv').height() < $('.rgDataDiv').children().eq(0).height()) {
	            $('.rgDataDiv').css({ 'overflow-x': 'hidden', paddingRight: 16 });
	        }*/

	        resizeGrid();

        </script>
	</telerik:RadCodeBlock>	
	</body>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</html>

