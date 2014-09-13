<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_FileServer_Select.aspx.vb" Inherits="plmOnApp.Style_FileServer_Select" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title runat="server" id="PageTitle"></title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<SCRIPT language="JavaScript" type="text/javascript">
		<!--
		function DoPageLoad() 
		{
			
			var Timer = setTimeout('self.focus();', 1000);
		}
		// -->
		</SCRIPT>
	</head>
	<body onbeforeunload="busyBox.Show();" onload="DoPageLoad();">
		<script language="javascript" src="../system/jscript/ysbusyscript.js" type="text/javascript"></script>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>
                        &nbsp;<asp:ImageButton ID="btnDownload" runat="server" />&nbsp;<asp:ImageButton
                            ID="btnClose" runat="server"  /></td>
				</tr>
			</table>
			<asp:datagrid id="DataGrid1" runat="server" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
				PageSize="100" AutoGenerateColumns="False" Width="100%">
				<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn>
						<HeaderStyle HorizontalAlign="Center" Width="50px"></HeaderStyle>
						<HeaderTemplate>
							<asp:Label runat="server" CssClass="fontHead" ID="label1">&nbsp;<%#GetSystemText("Select")%>&nbsp;</asp:Label>
						</HeaderTemplate>
						<ItemStyle HorizontalAlign="Center"></ItemStyle>
						<ItemTemplate>
							<asp:Label id="lblRadio" runat="server"></asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("Select File Server")%>...</asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:Label id="lblFileServer" runat="server"></asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
			</asp:datagrid>
			<br/>
			<asp:datagrid id="DataGrid2" runat="server" Width="100%" AutoGenerateColumns="False" PageSize="100"
				BorderWidth="1px" BorderStyle="Solid" BorderColor="Silver">
				<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn>
						<HeaderStyle HorizontalAlign="Center" Width="50px"></HeaderStyle>
						<HeaderTemplate>
							<asp:Label runat="server" CssClass="fontHead" ID="label1">&nbsp;<%#GetSystemText("Select")%>&nbsp;</asp:Label>
						</HeaderTemplate>
						<ItemStyle HorizontalAlign="Center"></ItemStyle>
						<ItemTemplate>
							<asp:Label id="lblRadio" runat="server"></asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("Select page to print")%>...</asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:Label id="lblReportPage" runat="server"></asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
			</asp:datagrid><br/>
			<div id="BusyBoxDiv" style="BORDER-RIGHT: gainsboro 0px solid; PADDING-RIGHT: 5px; BORDER-TOP: gainsboro 0px solid; PADDING-LEFT: 5px; PADDING-BOTTOM: 5px; BORDER-LEFT: gainsboro 0px solid; PADDING-TOP: 5px; BORDER-BOTTOM: gainsboro 0px solid; POSITION: absolute; BACKGROUND-COLOR: transparent; TEXT-ALIGN: center">
				<p style="WIDTH: 220px; TEXT-ALIGN: center">
				<table WIDTH="100%" BORDER="0" cellspacing="1" CELLPADDING="1">
					<tr>
						<td height="32" width="50"><img id="BusyBoxImg" src="../system/images/busy_Layer_0.gif" width="32" height="32"></td>
						<td class="fontHead"><asp:label id="lblPleaseWait" runat="server" CssClass="fontHead">Please Wait...</asp:label><br>
							<asp:label id="lblReportLoading" runat="server" CssClass="fontHead">Report Loading</asp:label></td>
					</tr>
				</table>
				</p>
			</div>
			<script language="javascript" type="text/javascript">
				// Instantiate our BusyBox object
				var busyBox = new BusyBox("busyBox", 12, "busy_Layer_", ".gif", 120);
			</script>
			
			
			</form>
	</body>
</html>
