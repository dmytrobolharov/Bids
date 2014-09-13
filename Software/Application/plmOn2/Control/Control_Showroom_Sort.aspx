<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_Showroom_Sort.aspx.vb" Inherits="plmOnApp.Control_Showroom_Sort" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
		<title>Add User</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
</head>
<body>
    <form id="form1" runat="server">
    
			<TABLE class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TBODY>
					<TR vAlign="middle">
						<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
						<TD vAlign="middle" align="left" width="400"><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="Confirmedimagebutton1" runat="server" 
								Message="NONE"></cc1:confirmedimagebutton></TD>
						<TD></TD>
					</TR>
				</TBODY>
			</TABLE>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:label></td>
				</tr>
			</table>
			<table border="0">
				<tr>
					<td width="100">&nbsp;</td>
					<td>
						<table border="0">
							<tr vAlign="middle">
								<td align="right">
									<table>
										<tr vAlign="middle">
											<td><asp:label id="lblSortBy" CssClass="fontHead" Runat="server"></asp:label></td>
											<td><asp:dropdownlist id="ddlSortBy" Runat="server">
													<asp:ListItem Value="Workflow">By Name</asp:ListItem>
												</asp:dropdownlist></td>
											<td><cc1:confirmedimagebutton id="btnSort" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td><asp:datagrid id="datagrid1" runat="server" EnableViewState="true" AutoGenerateColumns="False"
										BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" DataKeyField="ShowroomID">
										<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
										<ItemStyle CssClass="ItemTemplate"></ItemStyle>
										<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
										<Columns>
											<asp:TemplateColumn>
												<ItemStyle Width="200px"></ItemStyle>
												<HeaderTemplate>
													<asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("Name")%></asp:Label>
												</HeaderTemplate>
												<ItemTemplate>
													<asp:Label runat="server" ID="lblCustomName"></asp:Label>
												</ItemTemplate>
											</asp:TemplateColumn>
											<asp:TemplateColumn>
												<ItemStyle Width="40px"></ItemStyle>
												<HeaderTemplate>
													<asp:Label runat="server" CssClass="fontHead" ID="Label2"><%#GetSystemText("Sort")%></asp:Label>
												</HeaderTemplate>
												<ItemTemplate>
													<asp:TextBox Runat="server" ID="txtSort" Width="40" MaxLength="5"></asp:TextBox>
												</ItemTemplate>
											</asp:TemplateColumn>
										</Columns>
									</asp:datagrid></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
    
    
        
    </form>
</body>
</html>
