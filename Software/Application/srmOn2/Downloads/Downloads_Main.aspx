<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Downloads_Main.aspx.vb" Inherits="srmOnApp.Downloads_Main" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Compliance</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<meta http-equiv="content-type" content="text/html; charset=utf-8">
        <script language="javascript" type="text/javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			    <asp:Panel runat="server" ID="pnlMain">
                    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
                        <tr valign="middle">
                            <td valign="middle" align="center" width="10">
                                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                            </td>
                            <td>
                                <cc1:ConfirmedImageButton ID="btnSaveSearch" runat="server" Message="NONE" />
                                <cc1:ConfirmedImageButton ID="btnDownload" runat="server" Message="NONE" />
                            </td>
                            <td>
                                <asp:CheckBox ID="chbDownloadTechPacks" runat="server" Checked="true"/>
                                <asp:CheckBox ID="chbDownloadAttachments" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
                        <tr>
                            <td>
                                &nbsp;<asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:Label>
                            </td>
                        </tr>
                    </table>        
                    <table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
                        <tr colspan="2"><td>&nbsp;</td></tr>
                        <tr>
                            <td><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>
                            <td vAlign="top" width="100%">
                                <table height="45">
                                    <tr><td><asp:imagebutton id="imgBtnSearch" runat="server"></asp:imagebutton></td></tr>
                                </table>
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
                                <asp:button id="btnGo" onclick="RePage" runat="server" CssClass="fontHead" text="GO"></asp:button>
                            </td>
                        </tr>
                    </table>
                    <asp:DataGrid ID="dgTechPacks" runat="server" EnableViewState="true" AutoGenerateColumns="False" BorderColor="#E0E0E0"
                        BorderStyle="Solid" BorderWidth="1px" DataKeyField="TechPackID" AllowSorting="true">
                        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                        <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
                        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                        <PagerStyle Visible="False"></PagerStyle>
                        <Columns>
                            <asp:TemplateColumn>
                                <HeaderTemplate>
                                    <input type="checkbox" id="chbSelectAll" onclick="selectAllTechpacks();" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chbSelectTechPack" runat="server" />
                                    <asp:HiddenField ID="hdnStyleId" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "StyleId") %>' />
                                    <asp:HiddenField ID="hdnStyleNo" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "StyleNo") %>' />
                                    <asp:HiddenField ID="hdnTechPackNo" runat="server" Value='<%# Eval("TechPackNo") %>' />
                                    <asp:HiddenField ID="hdnHasAttachments" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "HasAttachments") %>' />
                                </ItemTemplate>
                            </asp:TemplateColumn>
                        </Columns>
                    </asp:DataGrid><asp:Label ID="SortOrder" runat="server" Visible="False"></asp:Label>
                </asp:Panel>
		</form>
	</body>
    <script type="text/javascript">
        function selectAllTechpacks() {
            var frm = document.Form1;
            var actVar = document.getElementById("chbSelectAll").checked;

            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf("chbSelectTechPack") != -1)
                    e.checked = actVar;
            }

        }
    </script>
</HTML>
