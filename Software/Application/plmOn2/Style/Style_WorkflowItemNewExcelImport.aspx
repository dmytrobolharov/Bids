<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_WorkflowItemNewExcelImport.aspx.vb" Inherits="plmOnApp.Style_WorkflowItemNewExcelImport" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
	<title>New Workflow Item</title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
	<style type="text/css">
	    .errorMessage
	    {
	        color: Red;
	        font-weight: bold;
	        font-size: medium;
	    }
	    .inputFieldDDList
	    {
	        width: 221px;
	    }
	    .inputFieldTextBox
	    {
	        width: 215px;
	    }
  </style>

</head>
<body>
    <form id="form1" runat="server">
		<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
			runat="server">
			<tr valign="middle">
				<td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" /></td>

				<td nowrap="nowrap" width="650">
				    <cc1:confirmedimagebutton id="btnUpload" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
				    <cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" CausesValidation="False" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton>
				</td>

			</tr>
		</table>
		<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white; height:45px"
			cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
			<tr>
				<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">New</asp:label></td>
			</tr>
		</table>
		<br />
        <asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder>
        
        <asp:Panel ID="pnlUploadExcelFile" runat="server">
            <asp:Label ID="lblErrorMessage" runat="server" Text="" class="errorMessage"></asp:Label>
            <table bgcolor='#FFFFFF' width='100%' border='0' cellspacing='1' cellpadding='0'>
	            <tr valign='top'>
		            <td width='33%'>
			            <table width='100%' border='0' cellspacing='0' cellpadding='0'>
                            <tr>
	                            <td width="125" height="23" class="fontHead" nowrap="nowrap"><span id="lblWorkflowItemTypeId">Workflow Item Type</span></td>
	                            <td class="font">
                                    <asp:DropDownList ID="ddlWorkflowItemTypeId" runat="server" 
                                        class="inputFieldDDList" AutoPostBack="True">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rfvWorkflowItemTypeId" runat="server" ErrorMessage="*" 
                                        ControlToValidate="ddlWorkflowItemTypeId"></asp:RequiredFieldValidator>
	                            </td>
                            </tr>
                            <tr>
	                            <td width="125" height="23" class="fontHead" nowrap="nowrap"><span id="lblWorkFlowItemName">Item Name</span></td>
	                            <td class="font">
                                    <asp:TextBox ID="txtWorkFlowItemName" runat="server" class="inputFieldTextBox"></asp:TextBox>
	                                <asp:RequiredFieldValidator ID="rfvWorkFlowItemName" runat="server" ErrorMessage="*" 
                                        ControlToValidate="txtWorkFlowItemName"></asp:RequiredFieldValidator>
	                            </td>
                            </tr>
                            <tr>
                                <td width="125" height="23" class="fontHead" nowrap="nowrap">
                                    <span id="Span1">Measurements Template</span>
                                </td>
                                <td class="font">
                                    <asp:DropDownList ID="ddlMeasTemplate" runat="server" class="inputFieldDDList" AutoPostBack="true">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rfvMeasTemplate" runat="server" ErrorMessage="*" ControlToValidate="ddlWorkflowItemTypeId"></asp:RequiredFieldValidator>
                                </td>
                            </tr>                            
                            <tr>
	                            <td width="125" height="23" class="fontHead" nowrap="nowrap"><span id="lblSampleSize">Sample Size</span></td>
	                            <td class="font">
                                    <asp:DropDownList ID="ddlSampleSize" runat="server" class="inputFieldDDList">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rfvSampleSize" runat="server" ErrorMessage="*" 
                                        ControlToValidate="ddlSampleSize"></asp:RequiredFieldValidator>
	                            </td>
                            </tr>                            
                            <tr>
	                            <td width="125" height="23" class="fontHead" nowrap="nowrap"><span id="lblfileUpload">POM Excel File</span></td>
	                            <td class="font"><asp:FileUpload ID="fileUpload" Width="288px" Height="19px" runat="server" /></td>
                            </tr>
			            </table>
		            </td>
	            </tr>
		    </table>
        </asp:Panel>
	    
    </form>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
