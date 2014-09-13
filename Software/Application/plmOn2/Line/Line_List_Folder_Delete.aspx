<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Line_List_Folder_Delete.aspx.vb" Inherits="plmOnApp.Line_List_Folder_Delete" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Delete</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body bgcolor="#ffffff">
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnDelete" runat="server"  Message=""></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE"
							></cc1:confirmedimagebutton></td>
					<td>&nbsp;</td>
				</tr>
			</TABLE>
			<TABLE cellSpacing="1" cellPadding="1" width="100%" border="0" height="35" bgcolor="#ffffff">
				<TR>					
					<TD><asp:CheckBox id="cbDeleteAll" runat="server" CssClass="fontRed" Visible="false"></asp:CheckBox></TD>
				</TR>
			</TABLE>
			<asp:datagrid id="DataGrid1" runat="server" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
				PageSize="100" AutoGenerateColumns="False" Width="470px">
				<AlternatingItemStyle Height="20px" BackColor="AliceBlue" VerticalAlign="Middle" HorizontalAlign="Center"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font" BackColor="White" HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="TableHeader" HorizontalAlign="Center" VerticalAlign="Middle"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<input type="checkbox" id="checkAll" onClick="CheckAll(this);" runat="server" name="checkAll">
						</HeaderTemplate>
						<ItemTemplate>
							<asp:CheckBox ID="chkDelete" runat="server"></asp:CheckBox>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Image">
						<ItemTemplate>
							<asp:Image id="imgFile"  runat="server">
							</asp:Image>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Style No">
						<ItemTemplate>
							<asp:Label ID='txtStyleNo' runat="Server" Text='<%# DataBinder.Eval(Container.DataItem, "StyleNo")%>' Font-Bold="true" Font-Size="12">
							</asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Desctiption">
						<ItemTemplate>
							<asp:Label ID="txtDescription" runat="Server" Text='<%# DataBinder.Eval(Container.DataItem, "Description")%>' Font-Bold="true" Font-Size="12">
							</asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
			</asp:datagrid>
		</form>
		<SCRIPT language="javascript">
		var frm = document.Form1 ;
		function CheckAll( checkAllBox )
		{
		var actVar = checkAllBox.checked ;
		for(i=0;i< frm.length;i++)
		{
			e=frm.elements[i];
			if ( e.type=='checkbox' && e.name.indexOf("chkDelete") != -1 )
			e.checked= actVar ;
		}
		}
		</SCRIPT>
	</body>
</HTML>
