<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Sourcing_Page_SampleRequests.aspx.vb" Inherits="plmOnApp.Sourcing_Page_SampleRequests" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls" Assembly="YSDataCalendar" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle"></title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
	</HEAD>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server" defaultbutton="imgBtnSearch">
        <wc1:Color_Wait ID="Color_Wait" runat="server" />
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3" border="0"></td>
					<td>
					    <cc1:BWImageButton id="btnNew" runat="server" Message="NONE"></cc1:BWImageButton>
                        <cc1:BWImageButton id="btnNewQuick" runat="server" Message="NONE"></cc1:BWImageButton>
					</td>
					<td class="FontHead" align="right" width="75"></td>
					<td width="40">&nbsp;</td>
					<td></td>
				</tr>
			</table>
			<table cellSpacing="2" cellPadding="0" width="100%" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top"></td>
				</tr>
			</table>
           	 <table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
				<tr>
					<td>
                        <asp:placeholder id="plhControlSearchHolder" runat="server" EnableViewState="False"></asp:placeholder>
                    </td>
					<td width="100%">
                        <asp:ImageButton id="imgBtnSearch" runat="server"></asp:ImageButton>
					</td>
				</tr>
			</table>

            <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff"
            border="0">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                </td>
                <td width="20">
                    <asp:ImageButton ID="btnImgFirst" runat="server"></asp:ImageButton>
                </td>
                <td width="20">
                    <asp:ImageButton ID="btnImgPrevious" runat="server"></asp:ImageButton>
                </td>
                <td nowrap align="center" width="125">
                    <asp:Label ID="lblPageCount" runat="server" CssClass="fontHead"></asp:Label>
                </td>
                <td width="20">
                    <asp:ImageButton ID="btnImgNext" runat="server"></asp:ImageButton>
                </td>
                <td width="20">
                    <asp:ImageButton ID="btnImgLast" runat="server" ToolTip="Last"></asp:ImageButton>
                </td>
                <td width="10">
                    &nbsp;
                </td>
                <td nowrap>
                    <asp:Label ID="RecordCount" runat="server" CssClass="fontHead"></asp:Label>
                </td>
                <td class="fontHead" align="right" width="110">
                    <asp:Label ID="lblRecordsPerPage" runat="server"></asp:Label>
                </td>
                <td width="25">
                    <asp:DropDownList ID="ps" runat="server" CssClass="fontHead">
                        <asp:ListItem Value="5">5</asp:ListItem>
                        <asp:ListItem Value="10">10</asp:ListItem>
                        <asp:ListItem Value="15">15</asp:ListItem>
                        <asp:ListItem Value="20">20</asp:ListItem>
                        <asp:ListItem Value="25">25</asp:ListItem>
                        <asp:ListItem Value="30">30</asp:ListItem>
                        <asp:ListItem Value="40">40</asp:ListItem>
                        <asp:ListItem Value="50" Selected="True">50</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td width="10">
                    <asp:button id="btnGo" runat="server" CssClass="fontHead" text="GO"></asp:button>
                </td>
            </tr>
        </table>

		<asp:datagrid id="dgSampleBOMRequest" runat="server" BorderStyle="NotSet" AllowSorting="true"
                AutoGenerateColumns="false" AllowPaging="true"
                BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" 
                CellSpacing="0" DataKeyField="SampleRequestTradeID">
		    <AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
		    <ItemStyle Height="20px" CssClass="font"></ItemStyle>
		    <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
            <PagerStyle Visible="false" />
		    <Columns>
                <asp:TemplateColumn >
                    <HeaderStyle CssClass="TableHeader" />
                    <ItemTemplate>
                        <cc1:BWImageButton runat="server" ID="imgBOMRedirect" ImageUrl="../System/icons/icon_search.gif" />
                        </ItemTemplate>
                </asp:TemplateColumn>

		    </Columns>
	    </asp:datagrid>

        <asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
		</form>
	</body>
</HTML>
