﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_Group_BatchQueue.aspx.vb" Inherits="plmOnApp.Control_Group_BatchQueue" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>Batch Queue Access</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
		<meta content="JavaScript" name="vs_defaultClientScript" />
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
		<form onkeypress="if(event.keyCode==13) {document.getElementById('btnSave').click(); return false}"
			id="Form1" method="post" runat="server">
			<asp:ScriptManager ID="scriptMgr" runat="server" EnablePartialRendering="true"/>
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10">
					    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
					    <asp:imagebutton id="btnInvSearch" tabIndex="0" runat="server" Height="0px" Width="0px" ImageUrl="../System/icons/1x1.gif"></asp:imagebutton>
					</td>
					<td>
					    <cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						<cc1:BWImageButton id="btnLockFolder" runat="server" ></cc1:BWImageButton>
						<cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton>
					</td>
					<td class="fontHead" align="right" width="75"></td>
					<td width="40"></td>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td align="right" width="40">
						<asp:Image id="iconLock" runat="server" ImageUrl="../System/Icons/icon_lock32.gif"></asp:Image>
					</td>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Batch Queue</asp:label></td>
				</tr>
			</table>
			<asp:UpdatePanel ID="updatePnl" runat="server">
            <ContentTemplate>
			<asp:datalist id="dlType" runat="server" Width="100%" BorderColor="Silver" BorderStyle="Solid"
				BorderWidth="1px">
				<AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
				<FooterTemplate>
				</FooterTemplate>
				<ItemStyle BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray" BackColor="White"></ItemStyle>
				<ItemTemplate>
					<table width="100%">
						<tr>
							<td width="20">
								<asp:Image id="iconStatus" runat="server"></asp:Image></td>
							<td class="fontHead" width="200"><%#Container.DataItem("BatchQueueTypeDescription")%></td>
							<td width="125">
								<asp:RadioButtonList id="rbAccess" runat="server" Width="200px" OnSelectedIndexChanged="SelectedIndexChanged"
									RepeatDirection="Horizontal" AutoPostBack="True" CssClass="fontHead">
								</asp:RadioButtonList></td>
							<td>
								<asp:Panel id="pnlPartial" runat="server">
									<asp:CheckBox id="cbAccessView" runat="server" OnCheckedChanged="SelectedIndexChanged" AutoPostBack="True"
										CssClass="fontHead" Text='<%#GetSystemText("View") %>'></asp:CheckBox>
									<asp:CheckBox id="cbAccessCreate" runat="server" CssClass="fontHead" Text='<%#GetSystemText("Create") %>'></asp:CheckBox>
									<asp:CheckBox id="cbAccessModify" runat="server" CssClass="fontHead" Text='<%#GetSystemText("Modify") %>'></asp:CheckBox>
									<asp:CheckBox id="cbAccessDelete" runat="server" CssClass="fontHead" Text='<%#GetSystemText("Delete") %>' ForeColor="Red"></asp:CheckBox>
									<asp:CheckBox id="cbAccessPrint" runat="server" CssClass="fontHead" Text='<%#GetSystemText("Print") %>'></asp:CheckBox>
								</asp:Panel></td>
						</tr>
					</table>
				</ItemTemplate>
			</asp:datalist>
			</ContentTemplate>
        </asp:UpdatePanel>
			</form>
		<asp:Label id="lblWarning" runat="server" CssClass="fontHead"></asp:Label>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</html>
