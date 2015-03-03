<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_Treatment_Select.aspx.vb" Inherits="plmOnApp.Material_Treatment_Select"   %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title><%= GetSystemText("Material Treatment")%></title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<script language="javascript">
			function SelectColor(sColor,sTxtBox) 
			{
			opener.document.Form1[sTxtBox].value = sColor;
			self.close();
			}
		</script>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"
							></cc1:confirmedimagebutton></td>
					<td class="FontHead" align="right" width="75"></td>
					<td width="40"></td>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="Medium" Font-Names="Tahoma,Verdana"> Select</asp:label></td>
				</tr>
			</table>
			<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR vAlign="top">
					<TD>
						<TABLE id="NavBar" height="30" cellSpacing="1" cellPadding="1" width="100%" bgColor="ghostwhite"
							border="0" runat="server">
							<TR vAlign="middle">
								<TD class="fontHead" width="50">
									<DIV align="right"><asp:Label ID="lblSearch" runat="server" Text="Search:"></asp:Label></DIV>
								</TD>
								<TD width="75"><asp:textbox id="txtSearch" runat="server" CssClass="font"></asp:textbox></TD>
								<TD width="10"><asp:imagebutton id="btnImgSearch" runat="server" ImageUrl="../System/Icons/icon_search.gif"></asp:imagebutton></TD>
								<TD width="75">&nbsp;
									<asp:checkbox id="cbViewAll" runat="server" CssClass="fontHead" Text="View All" Visible="False"></asp:checkbox></TD>
								<TD align="right"><asp:label id="Label1" runat="server" CssClass="fontHead">Rec per Page:</asp:label></TD>
								<TD><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
										<asp:ListItem Value="5">5</asp:ListItem>
										<asp:ListItem Value="10">10</asp:ListItem>
										<asp:ListItem Value="15">15</asp:ListItem>
										<asp:ListItem Value="20">20</asp:ListItem>
										<asp:ListItem Value="25">25</asp:ListItem>
										<asp:ListItem Value="30">30</asp:ListItem>
										<asp:ListItem Value="40">40</asp:ListItem>
										<asp:ListItem Value="50" Selected="True">50</asp:ListItem>
										<asp:ListItem Value="75">75</asp:ListItem>
										<asp:ListItem Value="100">100</asp:ListItem>
									</asp:dropdownlist><asp:button id="Button1" onclick="RePage" runat="server" CssClass="fontHead" text="GO"></asp:button></TD>
								<TD></TD>
								<TD>&nbsp;</TD>
							</TR>
						</TABLE>
						<table>
							<tr>
								<TD width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></TD>
								<TD width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></TD>
								<TD noWrap align="center" width="75"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
								<TD width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></TD>
								<TD width="20"><asp:imagebutton id="btnImgLast" runat="server"></asp:imagebutton></TD>
								<TD width="10">&nbsp;</TD>
								<TD noWrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></TD>
								<TD>&nbsp;</TD>
							</tr>
						</table>
						
						
						<table cellspacing="0" cellpadding="0"  border="0" >
						<tr><td>
						    <asp:datagrid id="DataGrid1" runat="server" DataKeyField="Custom" AutoGenerateColumns="False"  Width="200px">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn >
									<HeaderTemplate>
										<input id="checkAll" onclick="CheckAll(this);" type="checkbox" name="checkAll" runat="server" />
									</HeaderTemplate>
									<ItemStyle Width="25px" />
									<ItemTemplate>
										<asp:CheckBox id="chkSelect" runat="server" ></asp:CheckBox>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
							<PagerStyle Visible="False"></PagerStyle>
						</asp:datagrid>
						</td></tr>
						</table>
                        <asp:label id="SortOrder" runat="server" Visible="False"></asp:label></TD>
						
						
				</TR>
			</TABLE>
		</form>
		<SCRIPT language="javascript">
		var frm = document.Form1 ;
		function CheckAll( checkAllBox )
		{
		var actVar = checkAllBox.checked ;
		for(i=0;i< frm.length;i++)
		{
			e=frm.elements[i];
			if ( e.type=='checkbox' && e.name.indexOf("chkSelect") != -1 )
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
	</body>
</HTML>
