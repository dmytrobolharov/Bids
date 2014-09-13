<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Style_Workflow.ascx.vb" Inherits="plmOnCustomControls.Style_Workflow" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="plmOnCustomControls.YSTab" Assembly="plmOnCustomControls" %>
<%@ Register TagPrefix="ycl" Namespace="Yunique.Core.Library" Assembly="Yunique.Core" %>

<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
<script language="javascript">
    function calendar(sTxtBoxName) {
        windowDatePicker = window.open("../System/Control/month_popup.aspx?txtbox=" + sTxtBoxName, "dp", "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=200,height=180,left=375,top=200");
        windowDatePicker.focus();
    }
</script>

<table class="TableHeader" height="27" cellSpacing="0" cellpadding="0" width="100%" border="0">
	<tr valign="middle">
		<td valign="middle" align="center" width="10">
            <asp:image id="Image0" height="15" width="3" ImageUrl="../System/Images/bbTbSCnr.gif" runat="server"></asp:image>
        </td>
		<td id="tblExpand" runat="server" valign="middle" align="left" width="87"><img id="btnExpandAll" runat="server" alt="" onclick="expandall(1)"  />
            <img id="btnCollapseAll" alt="" onclick="expandall(0)" runat="server" style="display: none" />
        </td>
		<td valign="middle" align="left" width="706" >
		    <cc1:confirmedimagebutton Visible="false"  id="BtnGotoHome" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
		    <cc1:confirmedimagebutton id="btnEdit" Message="NONE"  runat="server"></cc1:confirmedimagebutton>
			<cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
			<cc1:bwimagebutton id="btnAddMaterial" runat="server" ></cc1:bwimagebutton>
			<cc1:bwimagebutton id="btnSummary" runat="server" ></cc1:bwimagebutton>
			<cc1:bwimagebutton id="btnPrint" runat="server" ></cc1:bwimagebutton>
			<cc1:confirmedimagebutton id="btnChangeLog" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
			<cc1:confirmedimagebutton id="btnNewTask" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
			<cc1:confirmedimagebutton id="btnTemplate" runat="server" Message="NONE" CausesValidation="False"></cc1:confirmedimagebutton>
			<cc1:confirmedimagebutton id="btnNewIssue" runat="server" Message="NONE" CausesValidation="False"></cc1:confirmedimagebutton>
			<cc1:bwimagebutton id="imgBtnChangeLog" runat="server" CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>
		</td>
		<td class="fontHead" valign="middle" align="center" width="75"><asp:Label runat="server" ID="LblSelSet">Select Set:</asp:Label>&nbsp;</td>
		<td width="40">
            <asp:dropdownlist id="dpStyleSet" runat="server" AutoPostBack="true" DataValueField="ID" DataTextField="Value" CssClass="font"></asp:dropdownlist>
        </td>
		<td><asp:imagebutton id="imgBtnGo" ImageUrl="../System/Icons/icon_go.gif" runat="server"></asp:imagebutton>
		</td>
	</tr>
</table>

<asp:Panel ID="pnlWorkflowDependency" runat="server">
    <table cellSpacing="0" cellpadding="0" width="100%" border="0">
	    <tr>
		    <td valign="top" bgColor="#ffffff">
    		
			    <table height="50" cellSpacing="0" cellpadding="0" width="100%" bgColor="#990000" border="1" borderColor="red">
				    <tr>
					    <td>
                            <table height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
	                            <tr>
		                            <td width="25">
                                        <div align="center">
                                            <asp:image id="Image1" ImageUrl="../System/Icons/icon_lock.gif" runat="server"></asp:image>
                                        </div>
                                    </td>
		                            <td>
                                        <asp:Label ID="lblPerm" runat="server" Text="This style has been locked by workflow dependencies." CssClass="fontHead" ForeColor="White"></asp:Label>
                                    </td>
	                            </tr>
                            </table>
				        </td>
				    </tr>
			    </table>

		    </td>
	    </tr>
    </table>
</asp:Panel>

<br />
<cc2:YSTabView id="YSTabView1" runat="server"></cc2:YSTabView>
<table class="TableHeader" height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
	<tr>
		<td align="center" width="10">
            <asp:image id="Image2" height="15" width="3" ImageUrl="../System/Images/bbTbSCnr.gif" runat="server"></asp:image>
        </td>
		<td class="fontHead" width="25">
			<div align="center">
                <asp:image id="imgWorkStatus" ImageUrl="../System/Icons/icon_ball_gray.gif" runat="server"></asp:image>
            </div>
		</td>
		<td class="fontHead" valign="middle">
            <asp:label id="lblHeader" runat="server"></asp:label>&nbsp;
			<asp:LinkButton id="hl_Status" runat="server"></asp:LinkButton>
        </td>
		<td class="fontHead" valign="middle" align="center" width="25"></td>
	</tr>
</table>
