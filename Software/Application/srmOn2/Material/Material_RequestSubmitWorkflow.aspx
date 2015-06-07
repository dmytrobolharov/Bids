<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Material_RequestSubmitWorkflow.aspx.vb" Inherits="srmOnApp.Material_RequestSubmitWorkflow" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title runat="server" id="PageTitle">Material Request</title>
	<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server">
			<TABLE class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR vAlign="middle" height="25">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD>
                        <cc1:BWImageButton ID="btnNew" Visible="false" runat="server" />
                    </TD>
				</TR>
			</TABLE>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Material Request</asp:label></td>
				</tr>
			</table>
			<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhSearchControl" runat="server"></asp:placeholder></td>
					<td vAlign="top" width="100%">
						<table height="45">
							<tr>
								<td><asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
            <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff"
                border="0">
                <tr valign="middle">
                    <td valign="middle" align="center" width="10">
                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                    </td>                    
                    <td width="20">
                        <asp:ImageButton ID="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:ImageButton>
                    </td>
                    <td width="20">
                         <asp:ImageButton ID="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:ImageButton>
                    </td>
                    <td nowrap align="center" width="125">
                        <asp:Label ID="lblPageCount" runat="server" CssClass="fontHead"></asp:Label>
                    </td>
                    <td width="20">
                        <asp:ImageButton ID="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:ImageButton>
                    </td>
                    <td width="20">
                        <asp:ImageButton ID="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:ImageButton>
                    </td>
                    <td width="10">
                        &nbsp;
                    </td>
                    <td nowrap>
                        <asp:Label ID="RecordCount" runat="server" CssClass="font"></asp:Label>
                    </td>
                    <td class="fontHead" align="right" width="110">
                        <asp:Label ID="lblRecordsPerPage" runat="server">Records per Page:</asp:Label>
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
                        <asp:Button ID="Button1" OnClick="RePage" runat="server" CssClass="fontHead" Text="GO"></asp:Button>
                    </td>
                </tr>
            </table>    
            <asp:datagrid id="dgMaterialRequest" runat="server" AllowSorting="true"
                DataKeyField="MaterialTradePartnerColorID" AutoGenerateColumns="false" BackColor="White" AllowPaging="true">
				<PagerStyle Visible="false" />
				<AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
			    <Columns > 
                    <asp:TemplateColumn >
                        <HeaderStyle CssClass="TableHeader" />
                        <ItemTemplate>
                            <cc1:BWImageButton runat="server" ID="imgRedirect" ImageUrl="../System/icons/icon_search.gif" />
                         </ItemTemplate>
                    </asp:TemplateColumn>
                </Columns>
			</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>



    </form>
</body>
</html>
