<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_Material_RequestSubmitSchedule.aspx.vb" Inherits="plmOnApp.Control_Material_RequestSubmitSchedule" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls" Assembly="YSDataCalendar" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//Dtd html 4.0 transitional//EN">
<html>
	<head>
		<title>Material Request Schedule</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/tree.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
		<script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td valign="middle" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="450"><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnSaveClose" runat="server" 
							Message="NONE"></cc1:confirmedimagebutton><cc1:bwimagebutton id="imgAdd" runat="server" ></cc1:bwimagebutton><cc1:confirmedimagebutton id="btnDelete" runat="server"  Message="Are you sure you want to delete it?"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE"
							CausesValidation="False"></cc1:confirmedimagebutton></td>
					<td valign="middle" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td valign="middle" width="140"><asp:label id="lblSortBy" CssClass="font" Runat="server"><b>&nbsp; 
								</b></asp:label><asp:dropdownlist id="ddlSortBy" Runat="server" >
							<asp:ListItem  Value="pMaterialRequestWorkflow.MaterialRequestWorkflow">By Workflow</asp:ListItem>
						</asp:dropdownlist></td>
					<td valign="middle"><cc1:confirmedimagebutton id="btnSort" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:label></td>
				</tr>
			</table>		
			<asp:PlaceHolder ID="plhWorkflowControls" runat="server" ></asp:PlaceHolder>
			<table cellSpacing="1" cellPadding="0" width="100%" border="0">
                <tr>
                    <td class="fontHead"><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
                </tr>
            </table>
			
			<asp:panel id="Panel1" runat="server">

			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
                <tr>
                    <td class="fontHead" height="10"></td>
                </tr>
            </table>
				<cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview>
				<asp:datagrid id="dgWorkflowSet1" runat="server" 
                    DataKeyField="MaterialRequestWorkflowTempItemID" AllowSorting="true">
				    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				    <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
				    <headerStyle Height="25px" CssClass="TableHeader"></headerStyle>
				    <PagerStyle Visible="False"></PagerStyle>
                </asp:datagrid>
			</asp:panel>
			
			</form>
	</body>
</html>
