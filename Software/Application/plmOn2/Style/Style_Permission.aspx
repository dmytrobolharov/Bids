<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Permission.aspx.vb" Inherits="plmOnApp.Style_Permission" %>
<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="Style_Header.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Access Denied</title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8">
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</head>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" height="27" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td width="100%">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>

			<table height="90%" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="top" bgColor="#ffffff">
						<table height="50" cellSpacing="0" cellpadding="0" width="100%" 
                            bgColor="#990000" border="1" borderColor="red">
							<tr>
								<td>
			                        <table height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
				                        <tr>
					                        <td width="25"><div align="center"><asp:image id="imgWorkStatus" ImageUrl="../System/Icons/icon_lock.gif" runat="server"></asp:image></div></td>
					                        <td><asp:Label ID="lblPerm" runat="server" 
                                                Text="You might not have permission to view this style using your credentials." 
                                                CssClass="fontHead" ForeColor="White"></asp:Label></td>
				                        </tr>
			                        </table>
								   </td>
							    </td>
							</tr>
						</table>
			            <table height="25" cellSpacing="0" cellpadding="0" width="100%" bgColor="#cddeee" border="0">
				            <tr>
					            <td>&nbsp;</td>
					            <td>&nbsp;</td>
				            </tr>
			            </table>						
						<br />
						<uc1:style_header id="Style_Header1" runat="server"></uc1:style_header><BR>
						
						<table height="100" cellSpacing="0" cellpadding="0" width="100%" background="../System/Images/MiddleFill.jpg"
							border="0">
							<tr valign="top">
								<td></td>
							</tr>
						</table>
					</td>
					<td width="200" bgColor="#f5f5f5">&nbsp;</td>
				</tr>
			</table>
            <asp:Panel ID="Panel1" runat="server" Visible="False">
                        <table cellSpacing="1" cellpadding="0" width="100%" border="0">
							<tr>
								<td width="20" height="20">&nbsp;</td>
								<td class="fontHead" height="20"><asp:Label ID="lblReq" runat="server" Text="Request Access To:"></asp:Label></td>
							</tr>
						</table>
						<table cellSpacing="1" cellpadding="0" width="100%" border="0">
							<tr bgColor="#ffffff">
								<td width="40" height="20">&nbsp;</td>
								<td><asp:datalist id="dlTeam" runat="server" RepeatColumns="2" Datakeyfield="TeamID" Width="800px"
										ShowFooter="False" BorderWidth="0" BorderStyle="None" CellSpacing="1" CellPadding="0" BorderColor="#E0E0E0"
										GridLines="Both">
										<AlternatingItemStyle Height="20px" CssClass="font" BackColor="White"></AlternatingItemStyle>
										<ItemStyle Height="20px" CssClass="font" BackColor="AliceBlue"></ItemStyle>
										<ItemTemplate>
											<asp:CheckBox id="chkTeam" runat="server"></asp:CheckBox>&nbsp;<%# DataBinder.Eval(Container.DataItem, "FirstName")%>&nbsp;<%# DataBinder.Eval(Container.DataItem, "LastName")%>&nbsp;(<%# DataBinder.Eval(Container.DataItem, "Email")%>)
											<asp:TextBox id="txtEmail" runat="server" Visible="False" Text='<%# DataBinder.Eval(Container.DataItem, "Email")%>'>
											</asp:TextBox>
											<INPUT id=Mail type=hidden value='<%# Container.DataItem("Email")%>' name=Mail runat="server">
											<INPUT id=To type=hidden value='<%#Container.DataItem("FirstName") &amp; " " &amp; Container.DataItem("LastName")%>' name=To runat="server">
										</ItemTemplate>
										<HeaderStyle Height="24px" CssClass="Header_small"></HeaderStyle>
									</asp:datalist></td>
							</tr>
						</table>
						<table cellSpacing="1" cellpadding="0" width="100%" border="0">
							<tr>
								<td width="20" height="20">&nbsp;</td>
								<td class="fontHead" style="FONT-WEIGHT: bold; COLOR: crimson"><FONT color="#000000">
								<asp:Label ID="lblDesc" runat="server" Text="Description, Reason, Purpose of Access:"></asp:Label></FONT>
								</td>
							</tr>
						</table>
						<table cellSpacing="0" cellpadding="0" width="100%" border="0">
							<tr bgColor="#ffffff">
								<td width="20" height="20">&nbsp;</td>
								<td valign="top" align="right" width="400">
									<table cellSpacing="1" cellpadding="0" width="100%" border="0">
										<tr>
											<td width="20" height="20">&nbsp;</td>
											<td><asp:textbox id="txtRequestMessage" runat="server" TextMode="MultiLine" MaxLength="4000" ToolTip="Enter description, reason or purpose of..."
													Columns="50" Rows="10" Width="600px"></asp:textbox></td>
										</tr>
										<tr>
											<td width="20" height="20"></td>
											<td class="fontHead" align="right"><FONT color="red"> <asp:label id="lblMailMessage" runat="server"></asp:label></FONT><asp:imagebutton id="btnSend" runat="server" ></asp:imagebutton></td>
										</tr>
										<tr bgColor="#ffffff">
											<td width="20" height="20">&nbsp;</td>
											<td>&nbsp;
											</td>
										</tr>
									</table>
								</td>
								<td valign="top"></td>
							</tr>
						</table>        
            </asp:Panel>
			
			
			
		</form>
	</body>
</html>
