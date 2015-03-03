<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Style_Workflow.ascx.vb" Inherits="plmOnApp.Style_Workflow" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" debug="True" %>
<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
<link href="../System/CSS/jquery-ui.css" rel="stylesheet" type="text/css" />
<script language="javascript">
	function calendar(sTxtBoxName)
	{
	windowDatePicker = window.open("../System/Control/month_popup.aspx?txtbox=" + sTxtBoxName,"dp","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=200,height=180,left=375,top=200");
	windowDatePicker.focus();
	}
</script>



<table class='<%=GetTableHeaderClass() %>' height="27" cellSpacing="0" cellpadding="0" width="100%" border="0">
	<tr valign="middle">
		<td valign="middle" align="center" width="10"><IMG height="15"  src="../System/Images/bbTbSCnr.gif" width="3"></td>
		<td id="tblExpand" runat="server" valign="middle" align="left" width="80"><img id="btnExpandAll" runat="server" alt="" onclick="expandall(1)"  />
            <img id="btnCollapseAll" alt="" onclick="expandall(0)" runat="server" 
                style="display: none" /></td>
		<td valign="middle" align="left" width="706" >
		    <cc1:confirmedimagebutton Visible="false"  id="BtnGotoHome" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
		    <cc1:confirmedimagebutton id="btnEdit" Message="NONE"  runat="server"></cc1:confirmedimagebutton>
			<cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
			<cc1:bwimagebutton id="btnAddMaterial" runat="server" ></cc1:bwimagebutton>
			<cc1:bwimagebutton id="btnSummary" runat="server" ></cc1:bwimagebutton>
            <cc1:bwimagebutton id="btnDimView" visible="false" runat="server" ></cc1:bwimagebutton>            
			<cc1:bwimagebutton id="btnPrint" runat="server" ></cc1:bwimagebutton>
			<cc1:BWImageButton id="btnNewTask" runat="server"  Message="NONE"></cc1:BWImageButton>
			<cc1:confirmedimagebutton id="btnTemplate" runat="server" Message="NONE" 
				CausesValidation="False"></cc1:confirmedimagebutton>
			<cc1:BWImageButton id="btnNewIssue" runat="server" Message="NONE" 
				CausesValidation="False"></cc1:BWImageButton>
            <cc1:BWImageButton ID="btnCopy" runat="server" Visible="false"></cc1:bwimagebutton>    
            <cc1:ConfirmedImageButton ID="btnReplace" runat="server" Visible="false" Message="NONE" OnClientClick="return ShowSelectionDialog()"></cc1:ConfirmedImageButton>
            <cc1:confirmedimagebutton id="btnLinkWorkflowItem" OnClientClick="return WorkflowLinkPostBack();" runat="server"  Message="NONE" Visible="false"></cc1:confirmedimagebutton>
            <cc1:confirmedimagebutton id="btnUnLinkWorkflowItem" OnClientClick="return MeasUnLinkConfirm();" runat="server"  Message="NONE" Visible="false"></cc1:confirmedimagebutton>
			<cc1:bwimagebutton id="imgBtnChangeLog" runat="server" CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>		             
		</td>
        <td></td>
		<!--<td class="fontHead" valign="middle" align="center" width="75"><asp:Label runat="server" ID="LblSelSet">Select Set:</asp:Label>&nbsp;</td>
		<td width="40"><asp:dropdownlist id="dpStyleSet" runat="server" AutoPostBack="true" DataValueField="ID" DataTextField="Value"
				CssClass="font"></asp:dropdownlist></td>
		<td><asp:imagebutton id="imgBtnGo" ImageUrl="../System/Icons/icon_go.gif" runat="server"></asp:imagebutton>
		</td>-->
	</tr>
</table>
<br />
<table id="tbHeader" runat="server" style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45"
    cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
    <tr>
        <td>
            &nbsp;<asp:Label ID="lblBigHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:Label>
        </td>
    </tr>
</table>
<cc2:YSTabView id="YSTabView1" runat="server"></cc2:YSTabView>
<table class='<%=GetTableHeaderClass() %>' height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
	<tr>
		<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		<td class="fontHead" width="20">
			<div align="center"><asp:image id="imgWorkStatus" ImageUrl="../System/Icons/icon_ball_gray.gif" runat="server"></asp:image></div>
		</td>
		<td class="fontHead" valign="middle"><asp:label id="lblHeader" runat="server"></asp:label>&nbsp;
			<asp:LinkButton id="hl_Status" runat="server"></asp:LinkButton></td>
		<td class="fontHead" valign="middle" align="center" width="25"></td>
	</tr>
</table>
<div id="dialog" style="display:none;">
    <asp:RadioButtonList runat="server" ID="rblWFISeasonYears" DataTextField="SeasonYear" DataValueField="WorkflowItemID">        
    </asp:RadioButtonList>
</div>

<script type="text/javascript" src="../System/Jscript/jquery-1.8.0.js"></script>
<script type="text/javascript" src="../System/Jscript/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript">

    (function ($) {

        window.ShowSelectionDialog = function () {
            $("#dialog").dialog({
                modal: true,
                resizable: false,
                draggable: false,
                appendTo: "#Form1",
                title: '<%= GetSystemText("Replace with previous...") %>',
                buttons: {
                    '<%= GetSystemText("Yes") %>': function() { <%= Page.ClientScript.GetPostBackEventReference(btnReplace, "", False) %>; },
                    '<%= GetSystemText("No") %>': function () { $(this).dialog("close"); } 
                }
            });

            return false;
        };

    })(jQuery)
</script>

<script type="text/javascript" language="javascript">

    function MeasUnLinkConfirm() {

        var $confirmDialog = $("<div></div>");
        $confirmDialog.html('<%= ConfirmHTML %>');
        $confirmDialog.dialog({
            autoOpen: false,
            modal: true,
            resizable: false,
            width: 350,
            title: '<%= GetSystemText("Break Page Link") %>',
            buttons: {
                '<%= GetSystemText("Yes") %>': function () {
                    $(this).dialog("close");
                    <%= Page.ClientScript.GetPostBackEventReference(New PostBackOptions(btnUnLinkWorkflowItem) With {.PerformValidation = False}) %>;
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
</script>   
