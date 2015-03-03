<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_DevelopmentSpec_Template.aspx.vb" Inherits="plmOnApp.Style.DevelopmentSpec.Style_DevelopmentSpec_Template"   %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Style Development Spec</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	</head>
	<body onload="self.focus()">
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><asp:imagebutton id="btnInvSearch" runat="server" Height="0px" Width="0px" ImageUrl="../System/icons/1x1.gif"></asp:imagebutton><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
							ForeColor="#E0E0E0">Select POM Template</asp:label></td>
				</tr>
			</table>
			<table cellspacing="1" cellpadding="1" width="100%" border="0">
				<tr>
					<td width="800" bgColor="#ffffff"></td>
				</tr>
			</table>
			<table cellspacing="0" cellpadding="0" width="100%" align="center" bgColor="#ffffff" border="0">
				<tr>
					<td>
						<table id="Table2" cellspacing="0" cellpadding="0" width="100%" border="0">
							<tr valign="top">
								<td>
									<table class="TableHeader" id="Table3" height="25" cellspacing="0" cellpadding="0" width="100%"
										bgColor="#ffffff" border="0">
										<tr valign="middle">
											<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
											<td width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></td>
											<td width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></td>
											<td noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></td>
											<td width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></td>
											<td width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></td>
											<td width="10">&nbsp;</td>
											<td noWrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></td>
											<td class="fontHead" align="right" width="110"><asp:label id="lblRecordsperPage" runat="server">Records per Page:</asp:label></td>
											<td width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
													<asp:ListItem Value="5">5</asp:ListItem>
													<asp:ListItem Value="10">10</asp:ListItem>
													<asp:ListItem Value="15">15</asp:ListItem>
													<asp:ListItem Value="20">20</asp:ListItem>
													<asp:ListItem Value="25">25</asp:ListItem>
													<asp:ListItem Value="30">30</asp:ListItem>
													<asp:ListItem Value="40">40</asp:ListItem>
													<asp:ListItem Value="50" Selected="True">50</asp:ListItem>
												</asp:dropdownlist></td>
											<td width="10"><asp:button id="Button1" onclick="RePage" runat="server" CssClass="fontHead" text="GO"></asp:button></td>
										</tr>
									</table>
									<table id="Table5" height="15" cellspacing="0" cellpadding="0" width="100%" bgColor="white"
										border="0">
										<tr>
											<td valign="top" width="100%">
												<table id="Table6" height="45">
													<tr>
														<td class="fontHead" width="50">
															<DIV align="right"><asp:label id="lblSearch" runat="server">Search:</asp:label></DIV>
														</td>
														<td width="75"><asp:textbox id="txtSearch" runat="server" CssClass="font"></asp:textbox></td>
														<td width="10"><asp:imagebutton id="btnImgSearch" runat="server" ImageUrl="../System/Icons/icon_search.gif"></asp:imagebutton></td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
									<asp:datagrid id="DataGrid1" runat="server" DataKeyField="POMTempItemID" AllowSorting="True" PageSize="50">
										<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
										<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
										<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
										<PagerStyle Visible="False"></PagerStyle>
									</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td>&nbsp;
					</td>
				</tr>
			</table>
			<table id="Table4" style="BORDER-TOP: gray thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: gainsboro"
				height="35" cellspacing="0" cellpadding="0" width="100%" bgColor="gainsboro" border="0">
				<tr>
					<td align="center" width="50">&nbsp;</td>
					<td align="center" width="500"></td>
					<td align="center">&nbsp;</td>
				</tr>
			</table>
			
			<SCRIPT language="javascript">
			    var frm = document.Form1 ;
			    function CheckAll( checkAllBox ){
			        var actVar = checkAllBox.checked ;
			        for(i=0;i< frm.length;i++) {
				        e=frm.elements[i];
				        if (e.type == 'checkbox' && e.name.indexOf("chbPOMTempItemID") != -1)
				        e.checked= actVar ;
			        }
			    }
		    </SCRIPT>
			<script language="javascript">
	            function btnClose_Click() {
		            <%= strExitScript %>
                    return false;
                }
            </script>
			
		</form>
	</body>
</html>
