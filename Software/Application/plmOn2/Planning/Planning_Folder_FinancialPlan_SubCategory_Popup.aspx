<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Planning_Folder_FinancialPlan_SubCategory_Popup.aspx.vb" Inherits="plmOnApp.Planning_Folder_FinancialPlan_SubCategory_Popup" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head id="Head1" runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/BOMColorway.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script language="javascript" src="../system/jscript/ysbusyscript.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-1.8.0.js"></script>
    <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-ui-1.10.3.custom.min.js"></script>
    <script type="text/javascript">
        function GetRadWindow() {
            var oWindow = null; if (window.radWindow)
                oWindow = window.radWindow; else if (window.frameElement.radWindow)
                oWindow = window.frameElement.radWindow; return oWindow;
        }

        function closeWindow() {
            GetRadWindow().close();
            return false;
        }

        function refreshAndCloseWindow() {
            GetRadWindow().BrowserWindow.parent.menu.location.href = GetRadWindow().BrowserWindow.parent.menu.location.href;
            GetRadWindow().BrowserWindow.parent.main.location.href = GetRadWindow().BrowserWindow.parent.main.location.href;
            GetRadWindow().close();
        }
    </script>
</head>
<body style="background-color: #ffffff;">
    <form id="Form1" method="post" runat="server">    
		<table class="TableHeader" id="TableHeader" cellSpacing="0" cellPadding="0" width="100%"
			border="0" runat="server">
			<tr vAlign="middle">
				<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
				<td>
                    <cc1:confirmedimagebutton id="btnSave" runat="server" ToolTip="Save..." Message="NONE"></cc1:confirmedimagebutton>
                    <cc1:confirmedimagebutton id="btnClose" runat="server" ToolTip="" Message="NONE" OnClientClick="return closeWindow();"></cc1:confirmedimagebutton>
                </td>
			</tr>
		</table>
    <div id="divConfigs" style="overflow: auto; text-align:center;">
        <asp:DataGrid ID="DataGrid1" runat="server" AllowSorting="True" DataKeyField="SubCategoryId" AutoGenerateColumns="false" style="margin-top:30px;">
            <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
            <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
            <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
            <PagerStyle Visible="False"></PagerStyle>
            <Columns>
                <asp:TemplateColumn>
                    <HeaderStyle Width="120" HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Left" />
                    <HeaderTemplate>
                        <asp:Label ID="lblSubCategoryName" runat="server" Text='<%# GetSystemText("Sub category") %>' ></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblSubCategoryName" runat="server" Text='<%# Eval("SubCategory")  %>' style="padding-left:10px;" />
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Width="50" HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" />
                    <HeaderTemplate>
                        <asp:Label ID="lblSubCategoryId" runat="server"></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="chkSubCategory" runat="server" Checked='<%# Eval("IsSet") %>' />
                    </ItemTemplate>
                </asp:TemplateColumn>
        </Columns>
    </asp:DataGrid>        
    </div>
    </form>
</body>
</html>