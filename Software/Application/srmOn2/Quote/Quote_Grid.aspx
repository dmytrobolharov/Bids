<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Quote_Grid.aspx.vb" Inherits="srmOnApp.Quote_Grid" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Quotation</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server" defaultbutton="imgBtnSearch">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
				<tr>
					<td>&nbsp;<asp:Label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Quote Folder...</asp:Label></td>
				</tr>
			</table>
			<cc2:YSTabView id="YSTabView1" runat="server"></cc2:YSTabView>
            <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
                border="0" runat="server">
                <tr valign="middle">
                    <td valign="middle" align="center" width="10">
                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                    </td>
                    <td width="250">
                        <cc1:BWImageButton ID="btnEdit" runat="server" message="NONE" Visible="true"></cc1:BWImageButton>
                        <cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
                        <cc1:confirmedimagebutton id="btnBatchUpdate" runat="server"  Message="NONE" Visible="False"></cc1:confirmedimagebutton>
                    </td>
				    <td>
			            <table width="200" border="0" cellspacing="0" cellpadding="0" >
				            <tr>
				                <td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
					            <td><asp:CheckBox valign="top" align="center" ID="chbBatchUpdate" autopostback="true" runat="server" Text="BatchUpdate" CssClass="fontHead" /></td>
				            </tr>
			            </table>	
				    </td>
                    <td></td>
                </tr>
            </table>
			<table class="TableHeaderYellow" height="25" width="100%" border="0" cellspacing="0" cellpadding="0" >
				<tr valign="middle">
				    <td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
					<td><asp:Label id="LabelEdit" runat="server" Font-Names="Tahoma,Verdana"  ></asp:Label></td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="100%" bgcolor="#EEEB9F" border="0">
				<tr>
					<td><asp:placeholder id="plhEditControlsHolder" runat="server" 
                            EnableViewState="False" ></asp:placeholder></td>					
				</tr>
			</table>
			<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR vAlign="top">
					<TD>
						<TABLE class="TableHeader" width="100%" height="25" border="0" cellPadding="0" cellSpacing="0"
							bgcolor="#ffffff">
							<TR vAlign="middle">
								<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<TD width="16"></TD>
								<TD width="20"><asp:imagebutton id="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:imagebutton></TD>
								<TD width="20"><asp:imagebutton id="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:imagebutton></TD>
								<TD align="center" width="85" nowrap><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
								<TD width="20"><asp:imagebutton id="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:imagebutton></TD>
								<TD width="20"><asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:imagebutton></TD>
								<TD width="10">&nbsp;</TD>
								<TD nowrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></TD>
								<TD width="110" align="right" class="fontHead"><asp:label id="lblRecordsPerPage" runat="server">Records per Page:</asp:label></TD>
								<TD width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
										<asp:ListItem Value="5">5</asp:ListItem>
										<asp:ListItem Value="10">10</asp:ListItem>
										<asp:ListItem Value="15">15</asp:ListItem>
										<asp:ListItem Value="20" Selected="True">20</asp:ListItem>
										<asp:ListItem Value="25">25</asp:ListItem>
										<asp:ListItem Value="30">30</asp:ListItem>
										<asp:ListItem Value="40">40</asp:ListItem>
										<asp:ListItem Value="50">50</asp:ListItem>
									</asp:dropdownlist></TD>
								<TD width="10"><asp:button id="Button1" onclick="RePage" runat="server" CssClass="fontHead" text="GO"></asp:button></TD>
							</TR>
						</TABLE>
						<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
							<tr>
								<td><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>
								<td width="100%" vAlign="middle"><table height="45">
										<tr>
											<td><asp:imagebutton id="imgBtnSearch" runat="server"  /></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						<asp:datagrid id="DataGrid1" runat="server" DataKeyField="StyleQuoteItemID">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
				            <Columns>
				                <asp:TemplateColumn Visible="False">
				                    <HeaderTemplate>
				                        <asp:CheckBox ID="cbSelectAll" OnClick="CheckAll(this);" AutoPostBack="False" runat="server"></asp:CheckBox>
				                    </HeaderTemplate> 
				                    <ItemTemplate>
				                        <asp:CheckBox ID="chbStyleQuoteItem" name="chbStyleQuoteItem" runat="server"></asp:CheckBox>				            
				                    </ItemTemplate>
				                </asp:TemplateColumn>
				            </Columns> 						
						</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label></TD>
				</TR>
			</TABLE>
		</form>

        <script type="text/javascript">
            var frm = document.Form1;
            function CheckAll(checkAllBox) {
                var actVar = checkAllBox.checked;
                for (i = 0; i < frm.length; i++) {
                    e = frm.elements[i];
                    if (e.type == 'checkbox' && e.name.indexOf('chbStyleQuoteItem') != -1) {
                        if (e.disabled != true && e.name != 'chbBatchUpdate') {
                            e.checked = actVar;
                        }
                    }
                }
            }
        </script>

	</body>
</HTML>
