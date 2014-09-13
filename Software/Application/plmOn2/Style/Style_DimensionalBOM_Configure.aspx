<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_DimensionalBOM_Configure.aspx.vb" Inherits="plmOnApp.Style.DimensionalBOM.Style_DimensionalBOM_Configure" %>
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
            GetRadWindow().BrowserWindow.parent.mainEdit.location.href = GetRadWindow().BrowserWindow.parent.mainEdit.location.href;
            GetRadWindow().close();
        }
    </script>
</head>
<body style="background-color: #ffffff;">
    <form id="Form1" method="post" runat="server">    
    <div id="divConfigs" style="overflow: auto; text-align:center; height:150px; border-bottom: 1px solid gainsboro;">
        <asp:DataGrid ID="DataGrid1" runat="server" AllowSorting="True" DataKeyField="StyleBOMDimensionID" AutoGenerateColumns="false" style="margin-top:30px;">
            <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
            <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
            <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
            <PagerStyle Visible="False"></PagerStyle>
            <Columns>
                <asp:TemplateColumn>
                    <HeaderStyle Width="120" HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" />
                    <HeaderTemplate><asp:Label ID="lblDimBOM" runat="server" ToolTip='<%# GetSystemText("BOM will have dimensional functionality") %>' Text='<%# GetSystemText("Dimensional BOM") %>' ></asp:Label></HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="chkDimBOM" runat="server" Checked='<%# Eval("DimBOM") %>' />
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Width="120" HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" />
                    <HeaderTemplate><asp:Label ID="lblDimBOM" runat="server" ToolTip='<%# GetSystemText("BOM will default to the BOM page. Otherwise default to the Colorway page") %>' Text='<%# GetSystemText("Default BOM Page") %>' ></asp:Label></HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="chkDefaultBOMPage" runat="server" Checked='<%# Eval("DefaultBOMPage") %>' />
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Width="120" HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" />
                    <HeaderTemplate><asp:Label ID="lblDimBOM" runat="server" ToolTip='<%# GetSystemText("Pitch colorways using any colors saved in the Color folder") %>' Text='<%# GetSystemText("Click-to-Fill Colorway") %>' ></asp:Label></HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="chkFillColorway" runat="server" Checked='<%# Eval("FillColorway") %>' />
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Width="120" HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" />
                    <HeaderTemplate><asp:Label ID="lblDimBOM" runat="server" ToolTip='<%# GetSystemText("Defaults Active Color selection") %>' Text='<%# GetSystemText("Default Active Color") %>' ></asp:Label></HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="chkActiveColor" runat="server" Checked='<%# Eval("ActiveColor") %>' />
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Width="120" HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" />
                    <HeaderTemplate><asp:Label ID="lblDimBOM" runat="server" ToolTip='<%# GetSystemText("Enable Dimension Options page") %>' Text='<%# GetSystemText("Dimension Options") %>' ></asp:Label></HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="chkDimensionOptions" runat="server" Checked='<%# Eval("DimensionOptions") %>' />
                    </ItemTemplate>
                </asp:TemplateColumn>
        </Columns>
    </asp:DataGrid>        
    </div>
    <div style="width: 100%; text-align: right;">
        <cc1:ConfirmedButton ID="btnSave" runat="server" />
        <asp:Button ID="btnCancel" runat="server" OnClientClick="return closeWindow();" />
    </div>
    </form>
    <script type="text/javascript">
        $("#btnSave, #btnCancel").button().css("color", "#000000");       
    </script>
</body>
</html>