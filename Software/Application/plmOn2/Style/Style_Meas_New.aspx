<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Meas_New.aspx.vb" Inherits="plmOnApp.Style.Measurements.Style_Meas_New" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow_Edit" Src="Style_Workflow_Edit.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title runat="server" id="PageTitle"></title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="400"><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
					<td class="FontHead" align="right" width="100">&nbsp;
					<asp:label id="lblSelectSet" align="right"  runat="server">Select Set</asp:label>
					</td>
					<td width="40"><asp:dropdownlist id="dpStyleSet" runat="server" CssClass="font" DataTextField="Value" DataValueField="ID"
							AutoPostBack="true"></asp:dropdownlist></td>
					<td><asp:imagebutton id="imgBtnGo" runat="server" ImageUrl="../System/Icons/icon_go.gif"></asp:imagebutton></td>
				</tr>
			</table>
			<uc1:style_workflow_edit id="Style_Workflow_Edit1" runat="server"></uc1:style_workflow_edit>
			<asp:panel id="pnlChange" runat="server">
			    <uc1:Style_Change_Alert id="Style_Change_Alert1" runat="server"></uc1:Style_Change_Alert>
			</asp:panel>
			<uc2:style_header id=Style_Header1 runat="server" StyleID='<%Request("SID")%>'>
			</uc2:style_header>
			<table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
				</tr>
			</table>
			<table borderColor="whitesmoke" cellspacing="0" cellpadding="0" width="100%" border="1">
				<tr>
					<td valign="top" width="100%" bgColor="#ffffff">					    
							<table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
								<tr>
									<td valign="middle" align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
									<td><asp:label id="lblMeasHeader" runat="server">Worksheet Information</asp:label></td>
								</tr>
							</table>							
							<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder>						
					</td>
				</tr>
				<tr>
					<td valign="top" width="100%" bgColor="#ffffff">
					    <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">	
					        <tr>
								<td valign="middle" align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td><asp:label id="lblSelection" runat="server">Selection Options</asp:label></td>
							</tr>
						</table>	
						<asp:CheckBox ID="ChbPrimaryKeys" runat="server" CssClass="FontHead" Text="Primary Key Measurements only" checked="false" />                        						                		    									                
		            </td>						
				</tr>
			</table>						
			<table id="Table5" height="24" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_left.gif"></td>
					<td class="TableBar" valign="middle" align="center" width="20"><IMG src="../System/icons/icon_changeobject.gif"></td>
					<td class="TableBar"><asp:label id="lblCreatedBy" runat="server" CssClass="fontHead" ForeColor="Gray"></asp:label>&nbsp;/
						<asp:label id="lblModifiedBy" runat="server" CssClass="fontHead"></asp:label></td>
					<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_right.gif"></td>
				</tr>
			</table>
		</form>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</html>
